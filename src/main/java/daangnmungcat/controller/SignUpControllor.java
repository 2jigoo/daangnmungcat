package daangnmungcat.controller;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import daangnmungcat.dto.Member;
import daangnmungcat.mapper.MemberMapper;

@RestController
public class SignUpControllor {
	private static final Log log = LogFactory.getLog(SignUpControllor.class);
	
	@Autowired
	private MemberMapper mapper;
	
	@GetMapping("/dongne1")
	public ResponseEntity<Object> dongne1(){
		return ResponseEntity.ok(mapper.Dongne1List());
		
	}
	
	@GetMapping("/dongne2/{dongne1}")
	public ResponseEntity<Object> dongne2(@PathVariable int dongne1){
		return ResponseEntity.ok(mapper.Dongne2List(dongne1));
	}
	
	
	@PostMapping("/submit")
	public ResponseEntity<Object> newMember(@RequestBody Member member){
		System.out.println("newMember");
		return ResponseEntity.ok(mapper.insertMember(member));
		
	}
	
	
	
}
