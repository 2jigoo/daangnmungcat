package daangnmungcat.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Member;
import daangnmungcat.exception.WrongIdPasswordException;

@Component
public class AuthService {
	
	@Autowired
	private MemberService service;
	
	public AuthInfo authenicate(String id, String pwd) {
		Member member = service.selectMemberById(id);
		if(member == null) {
			throw new WrongIdPasswordException();
		}
		
		if(!member.matchPassword(pwd)) {
			throw new WrongIdPasswordException();
		}
		
		// 아이디/닉넴/프로필사진  생성자를 만들어서
//		return new AuthInfo(member.getId(), member.getNickname(), member.getDongne1(), member.getDongne2(), member.getProfilePic(), member.getGrade());
		return null;
	}
	
}