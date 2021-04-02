package daangnmungcat.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.Mail;
import daangnmungcat.dto.Member;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.service.EmailService;
import daangnmungcat.service.MemberService;

@RestController
public class SignUpControllor {

	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private EmailService emailService;
	
	@GetMapping("/dongne1")
	public ResponseEntity<Object> dongne1() {
		return ResponseEntity.ok(service.Dongne1List());
	}

	@GetMapping("/dongne2/{dongne1}")
	public ResponseEntity<Object> dongne2(@PathVariable int dongne1) {
		return ResponseEntity.ok(service.Dongne2List(dongne1));
	}

	@PostMapping("/sign-up")
	public ResponseEntity<Object> newMember(@RequestBody Member member) {
		try {
			String password = passwordEncoder.encode(member.getPwd());
			member.setPwd(password);
			return ResponseEntity.ok(service.registerMember(member));
		} catch (DuplicateMemberException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}

	}
	
	@PostMapping("/id-check/post")
	public int reIdConfirm(@RequestBody String id) {
		int res = service.idCheck(id);
		return res;
	}
	
	@PostMapping("/email/post")
	public int emailCheck(@RequestBody String json) {
		int res = service.emailCheck(json);
		System.out.println(json);
		return res;
	}

	@GetMapping("/phone/post/{phone}")
	public int phoneCheck(@PathVariable String phone) {
		int res = service.phoneCheck(phone);
		return res;
	}
	
	@PostMapping("/find")
	public int findId(@RequestBody Map<String, String> map, Model model) {
		
		String id = null;
		
		if(map.get("id") != null) {
			id = map.get("id");
		}
		
		String name = map.get("name");
		String email = map.get("email");
		
		int res = service.findMember(id, name, email);
		
		if(res == 1) {
			Map<String, String> certi = emailService.sendEmail(email);
			String key = certi.get("certiKey");
			String mail = certi.get("email");
			System.out.println("certiKey -> " + key);
			
			return Integer.parseInt(key); 
		}
		
		return res;
	}
	
	@PostMapping("/find/certi")
	public int findNum(@RequestBody Map<String, String> map, HttpServletRequest request) {
		String inputKey = map.get("key");
		System.out.println("입력한 key:" + inputKey);
		int res = 0;
		
		if(inputKey.equals(map.get("key"))) {
			res = 1;
		}
		System.out.println("res :" + res);
		return res;
	}
	
	//아이디 찾기
	@PostMapping("/find/confirm")
	public String findConfirm(@RequestBody Map<String, String> map) {
		String name = map.get("name");
		String email = map.get("email");
		String id = null;
		if(map.get("id") != null) {
			id = map.get("id");
		}
		
		String memId = service.selectIdByCondition(id, name, email);
		return memId;
	}
	
	//비밀번호 찾기 - 변경
	@PostMapping("/find/confirm/pwd")
	public ResponseEntity<Object> pwdConfirm(@RequestBody Map<String, String> map) {
		try {
			String id = map.get("id");
			String newPwd =  map.get("new_pwd");

			Member member = service.selectMemberById(id);			
			member.setPwd(passwordEncoder.encode(newPwd));
			return ResponseEntity.ok(service.updatePwd(member));
			
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	
	
		
	
}
