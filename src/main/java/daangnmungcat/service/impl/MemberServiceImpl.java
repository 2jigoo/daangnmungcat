package daangnmungcat.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Address;
import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Dongne1;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;
import daangnmungcat.mapper.MemberMapper;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.MileageService;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;
	
	
	@Autowired
	private MileageService mService;
	
	@Override
	public List<Member> selectMemberByAll() {
		return mapper.selectMemberByAll();
	}

	@Override
	public List<Member> getList(Member member, Criteria criteria) {
		return mapper.selectMemberByConditionWithPaging(member, criteria);
	}
	
	@Override
	public Member selectMemberById(String id) {
		return mapper.selectMemberById(id);
	}
	
	@Override
	public int deleteMember(String id) {
		return mapper.deleteMember(id);
	}


	@Override
	public int registerMember(Member member) {
		Mileage mile = new Mileage();
		mile.setMileage(1000);
		mile.setOrder(null);
		mile.setContent("회원가입");
		mile.setMember(member);
		mService.insertMilegeInfo(mile);
		return mapper.insertMember(member);
	}

	@Override
	public Integer checkPwd(String id, String pwd) {
		return mapper.checkPwd(id, pwd);
	}

	@Override
	public int idCheck(String id) {
		int res = mapper.idCheck(id); 
		return res;
	}

	@Override
	public int emailCheck(String email) {
		int res =  mapper.emailCheck(email);
		return res;
	}
	
	@Override
	public int phoneCheck(String phone) {
		int res = mapper.phoneCheck(phone);
		return res;
	}
	
	
	@Override
	public List<Dongne1> Dongne1List() {
		return mapper.Dongne1List();
	}

	@Override
	public List<Dongne2> Dongne2List(int dongne1) {
		return mapper.Dongne2List(dongne1);
	}
	
	@Override
	public void certifiedPhoneNumber(String phoneNumber, String cerNum) {

        String api_key = "NCSEEVJOI1LJEMQC";
        String api_secret = "0DGQ4GKFFZIVZEOVXWIVQTTU3JONGQZS";
        Message coolsms = new Message(api_key, api_secret);

        // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("to", phoneNumber);    // 수신전화번호
        params.put("from", "01056156004");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
        params.put("type", "SMS");
        params.put("text", "당근멍캣 휴대폰인증 테스트 메시지 : 인증번호는" + "["+cerNum+"]" + "입니다.");
 
        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
	}

	
	@Override
	public int deleteProfilePic( HttpServletRequest request, HttpSession session) {		
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		Member member = selectMemberById(loginUser.getId());
		
		File dir = new File(session.getServletContext().getRealPath("resources\\upload\\profile"));
		System.out.println("delete할 Path:" + dir);
		
		File files[] = dir.listFiles();
		//파일리스트에서 이름 찾아서 지우기
		for(int i=0; i<files.length; i++) {
			File file = files[i];
			String fileName = file.getName();
			int idx = fileName.lastIndexOf(".");
			String onlyName = fileName.substring(0, idx);
		
			System.out.println("파일목록:" + onlyName);
			if(onlyName.equals(member.getId())) {
				file.delete();
			}
		}
		File deletePic = new File(dir, member.getProfilePic());
		deletePic.delete();
		String def = "images/default_user_image.png";
		member.setProfilePic(def);
		
		return mapper.updateProfilePic(member);
	}
	
	@Override
	public int updateProfilePic(MultipartFile[] uploadFile, HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member member = selectMemberById(info.getId());
		
		String uploadFolder = getFolder(request);
		System.out.println("uploadPath:" + uploadFolder);
		
		File uploadPath = new File(uploadFolder, getFolder(request));
		
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			
			System.out.println("Upload File Name: " + multipartFile.getOriginalFilename());
			System.out.println("Upload File Size: " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			System.out.println("only file name: " + uploadFileName);
			
			//확장자 구하기
			String exc = uploadFileName.substring(uploadFileName.lastIndexOf(".")+1, uploadFileName.length());
			
			//아이디로 파일이름 변경
			uploadFileName = member.getId() + "." + exc;
			
			//랜덤이름
			//UUID uuid = UUID.randomUUID();
			//uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			File saveFile = new File(uploadFolder, uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);
			} catch(Exception e) {
				e.getMessage();
			}
			
			String path = "upload/profile/"+ member.getId() + "." + exc;
			member.setProfilePic(path);
		}
		
		return mapper.updateProfilePic(member);
	}
	
	
	private String getFolder(HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("resources\\upload\\profile");
		return path;
	}

	@Override
	public int updateProfileText(Member member) {
		return mapper.updateProfileText(member);
	}

	@Override
	public int updatePhone(Member member) {
		return mapper.updatePhone(member);
	}
	
	@Override
	public int updatePwd(Member member) {
		return mapper.updatePwd(member);
	}
	
	@Override
	public int updateInfo(Member member) {
		return mapper.updateInfo(member);
	}

	
	@Override
	public int dongneUpdate(String id, Dongne1 dongne1, Dongne2 dongne2) {
		return mapper.dongneUpdate(id, dongne1, dongne2);
	}

	@Override
	public List<Address> myAddress(String id) {
		return mapper.selectAddressById(id);
	}

	@Override
	public int insertAddress(Address address) {
		return mapper.insertAddress(address);
	}

	@Override
	public int updateMyAddress(Member member) {
		return mapper.updateMyAddress(member);
	}

	@Override
	public int updateShippingAddress(Address address) {
		return mapper.updateAddress(address);
	}

	@Override
	public Address getAddress(String id) {
		return mapper.getAddress(id);
	}

	@Override
	public int deleteShippingAddress(String id) {
		return mapper.deleteAddress(id);
	}


}
