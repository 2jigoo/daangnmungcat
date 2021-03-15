package daangnmungcat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Member;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@PostMapping("/dongneUpdate")
	@ResponseBody
	public ResponseEntity<Object> dongneUpdate(@RequestBody Member member, AuthInfo loginUser){
		try {
			loginUser.setDongne1(member.getDongne1());
			loginUser.setDongne2(member.getDongne2());
			
			return ResponseEntity.ok(service.dongneUpdate(member.getId(), member.getDongne1(), member.getDongne2()));
		} catch (DuplicateMemberException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
}
