package daangnmungcat.controller;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import daangnmungcat.dto.Member;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.service.MemberService;

@RestController
@Controller
public class SignUpControllor {
	private static final Log log = LogFactory.getLog(SignUpControllor.class);

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

	@PostMapping("/submit")
	public ResponseEntity<Object> newMember(@RequestBody Member member) {
		try {
			return ResponseEntity.ok(service.registerMember(member));
		} catch (DuplicateMemberException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}

	}

	@GetMapping("/idCheck/{id}")
	public int reIdConfirm(@PathVariable String id) {
		int res = service.idCheck(id);
		return res;
	}

	@GetMapping("/emailCheck/{email}/")
	public int emailCheck(@PathVariable String email) {
		int res = service.emailCheck(email);
		return res;
	}

	@GetMapping("/phoneCheck/{phone}/")
	public int phoneCheck(@PathVariable String phone) {
		int res = service.phoneCheck(phone);
		return res;
	}

	
}
