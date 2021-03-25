package daangnmungcat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import daangnmungcat.dto.Member;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.service.MemberService;

@RestController
public class SignUpControllor {

	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	private MemberService service;
	
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

	
}
