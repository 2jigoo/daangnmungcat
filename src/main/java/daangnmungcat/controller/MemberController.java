package daangnmungcat.controller;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import daangnmungcat.dto.Member;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.service.MemberService;

@Controller
public class MemberController {
	private static final Log log = LogFactory.getLog(MemberController.class);
	
	@Autowired
	private MemberService service;
	
	@PostMapping("/dongneUpdate")
	@ResponseBody
	public ResponseEntity<Object> dongneUpdate(@RequestBody Member member){
		System.out.println("왔다리");
		try {
			return ResponseEntity.ok(service.dongneUpdate(member.getId(), member.getDongne1(), member.getDongne2()));
		} catch (DuplicateMemberException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	@GetMapping("/dongneUpdate")
	public void test() {
		System.out.println("테스트 왔다리");
	}
}
