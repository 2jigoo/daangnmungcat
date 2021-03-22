package daangnmungcat.config;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.DelegatingPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.Pbkdf2PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.security.crypto.scrypt.SCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import daangnmungcat.dto.Member;
import daangnmungcat.service.MemberService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
public class SecurityTest {
	
	@Autowired
	private MemberService memberService;
	
	private PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
	
	@Test
	public void testNewBcryptEncode() {
		
		String password = "1234";
		String enPw = passwordEncoder.encode(password);
		
		System.out.println("enPw: " + enPw);
		System.out.println("matchResult: " + passwordEncoder.matches(password, enPw));
	}
	
	
//	@Test
	public void testDeliegatingPasswordEncoder() {
		Map encoders = new HashMap<>();
		
		String idForEncode = "bcrypt";
		encoders.put(idForEncode, new BCryptPasswordEncoder());
		encoders.put("noop", NoOpPasswordEncoder.getInstance());
		encoders.put("pbkdf2", new Pbkdf2PasswordEncoder());
		encoders.put("scrypt", new SCryptPasswordEncoder());
		encoders.put("sha256", new StandardPasswordEncoder());
		
		PasswordEncoder passwordEncoder =
			    new DelegatingPasswordEncoder(idForEncode, encoders);
		
		System.out.println(passwordEncoder.encode("password")); // bcrypt로 나옴
		System.out.println(passwordEncoder.matches("password", "{bcrypt}$2a$10$7ELeUG5rUnOD.6GAY4Ivlud0MyFhFW.HsaCgcL5uW3xQERlMhUtqe"));
	}
	
//	@Test
	public void updatePasswordEncoded() {
		Map encoders = new HashMap<>();
		
		String idForEncode = "bcrypt";
		
		encoders.put(idForEncode, new BCryptPasswordEncoder());
		encoders.put("noop", NoOpPasswordEncoder.getInstance());
		encoders.put("pbkdf2", new Pbkdf2PasswordEncoder());
		encoders.put("scrypt", new SCryptPasswordEncoder());
		encoders.put("sha256", new StandardPasswordEncoder());
		
		PasswordEncoder passwordEncoder = new DelegatingPasswordEncoder(idForEncode, encoders);
		
		int res = 0;
		
		List<Member> list = memberService.selectMemberByAll();
		for(Member m : list) {
			String password = passwordEncoder.encode(m.getPwd());
			System.out.println(m.getPwd() + " -> " + password);
			m.setPwd(password);
			res += memberService.updatePwd(m);
		}
		
		System.out.println("res: " + res + ", list.size(): " + list.size());
		
	}
}
