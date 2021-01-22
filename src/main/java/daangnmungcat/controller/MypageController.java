package daangnmungcat.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Member;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.service.MemberService;

@Controller
@RestController
public class MypageController {
	private static final Log log = LogFactory.getLog(MypageController.class);
	
	@Autowired
	private MemberService service;
	
	@GetMapping("/deleteProfile")
	public int deleteAjaxPost(HttpServletRequest request, HttpSession session) {
		session = request.getSession();
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		Member member = service.selectMemberById(loginUser.getId());
		String id = member.getId();
		
		File dir = new File(request.getSession().getServletContext().getRealPath("resources\\upload\\profile"));
		System.out.println("delete할 Path:" + dir);
		File files[] = dir.listFiles();
		
		for(int i=0; i<files.length; i++) {
			File file = files[i];
			String fileName = file.getName();
			int idx = fileName.lastIndexOf(".");
			String onlyName = fileName.substring(0, idx);

			System.out.println("파일목록:" + onlyName);
			if(onlyName.equals(id)) {
				file.delete();
			}
		}

		int res = 0;
		String def = "images/default_user_image.png";
		member.setProfilePic(def);
		res = service.updateProfilePic(member);
		
		System.out.println(res);
		return res;
	}
	
	
	@PostMapping("/uploadProfile")
	public void uploadAjaxPost(MultipartFile[] uploadFile, HttpSession session, HttpServletRequest request) {
		System.out.println("upload profile");
		int res = 0;
		
		//String uploadFolder = request.getSession().getServletContext().getRealPath("resources\\upload\\profile");
		//테스트 경로-> /daangnmungcat/resources/upload/2021-01-13/파일이름.jpg
		String uploadFolder = getFolder(request);
		System.out.println("uploadPath:" + uploadFolder);
		
//		// 폴더만들기
		File uploadPath = new File(uploadFolder, getFolder(request));
		
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}

		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		for(MultipartFile multipartFile : uploadFile) {
			
			System.out.println("--------------------");
			System.out.println("Upload File Name: " + multipartFile.getOriginalFilename());
			System.out.println("Upload File Size: " + multipartFile.getSize());
			
			System.out.println("loginUser:" + loginUser);
			
			String uploadFileName = multipartFile.getOriginalFilename();
			System.out.println("only file name: " + uploadFileName);
			
			//확장자 구하기
			String exc = uploadFileName.substring(uploadFileName.lastIndexOf(".")+1, uploadFileName.length());
			uploadFileName = loginUser.getId() + "." + exc;
			
			//UUID uuid = UUID.randomUUID();
			//uploadFileName = uuid.toString() + "_" + uploadFileName;
			System.out.println("uploadFileName: " + uploadFileName);
			
			File saveFile = new File(uploadFolder, uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
			
			String path = "upload/profile/"+ loginUser.getId() + "." + exc;
			System.out.println("DB에 넣을 주소: " + path);
			loginUser.setProfilePic(path);
			res = service.updateProfilePic(loginUser);
			System.out.println("프로필 변경 결과:" + res);
			System.out.println("프로필주소변경후:"+ loginUser.getProfilePic());		
		}
	}
	
	private String getFolder(HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("resources\\upload\\profile");
		return path;
	}


	@PostMapping("/updateProfileText")
	public int updateProfileText(@RequestBody String json, HttpSession session, HttpServletRequest request) throws ParseException {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		String text = json.toString();
		loginUser.setProfileText(text);
		int res = service.updateProfileText(loginUser);
		System.out.println("프로필텍스트 변경:" + res);
		return res;
	}
	
	//프로필사진만 가져오기
	@GetMapping("/myProfilePic")
	public Map<String, String> profilePic(HttpSession session, HttpServletRequest request) throws ParseException {
		session = request.getSession();
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		Member member = service.selectMemberById(loginUser.getId());
		String path = member.getProfilePic();
		Map<String, String> map = new HashMap<>();
		map.put("path", path);
		return map;
		
	}
	
	@GetMapping("/memberInfo")
	public  Map<String, Object> memberInfo(HttpSession session, HttpServletRequest request) throws ParseException {
		session = request.getSession();
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		Member member = service.selectMemberById(loginUser.getId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member", member);
		return map;
	}
	
	@PostMapping("/updateInfo")
	public ResponseEntity<Object> updateMember(@RequestBody Member member) {
		System.out.println("update member");
		try {
			return ResponseEntity.ok(service.updateInfo(member));
		} catch (DuplicateMemberException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}

	}
	
	@PostMapping("/updatePhone")
	public int updatePhone(@RequestBody String json, HttpSession session, HttpServletRequest request) throws ParseException {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		String phone = json.toString();
		loginUser.setPhone(phone);
		int res = service.updatePhone(loginUser);
		System.out.println("폰번호변경:" + res);
		return res;
	}
	
	@PostMapping("/updatePwd")
	public int updatePwd(@RequestBody String json, HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		String pwd = json.toString();
		loginUser.setPwd(pwd);
		int res = service.updatePwd(loginUser);
		System.out.println("비번변경:" + res);
		return res;
	}
}
