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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Member;
import daangnmungcat.service.MemberService;

@Controller
@RestController
public class MypageController {
	private static final Log log = LogFactory.getLog(MypageController.class);
	
	@Autowired
	private MemberService service;
	
	
	@PostMapping("/uploadProfile")
	public void uploadAjaxPost(MultipartFile[] uploadFile, HttpSession session, HttpServletRequest request) {
		System.out.println("오나");
		int res = 0;
		String uploadFolder = request.getSession().getServletContext().getRealPath("resources\\upload\\profile");
		//테스트 경로-> /daangnmungcat/resources/upload/2021-01-13/파일이름.jpg
		System.out.println("uploadPath:" + uploadFolder);
		
		
//		// 폴더만들기
//		File uploadPath = new File(uploadFolder, getFolder());
//		System.out.println("uploadPath: " + uploadPath);
//		
//		if(!uploadPath.exists()) {
//			uploadPath.mkdirs();
//		}

		session = request.getSession();
		Member loginUser = (Member) session.getAttribute("loginUser");
		
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
	
	@ResponseBody
	@GetMapping("/myProfilePic")
	public Map<String, String> profilePic(HttpSession session, HttpServletRequest request) throws ParseException {
		System.out.println("프로필업로드");
		System.out.println();
		session = request.getSession();
		Member loginUser = (Member) session.getAttribute("loginUser");
		System.out.println(loginUser);
		Member member = service.selectMemberById(loginUser.getId());
		String path = member.getProfilePic();
		System.out.println("주소:"+ path);
		Map<String, String> map = new HashMap<>();
		map.put("path", path);
		return map;
		
	}
}
