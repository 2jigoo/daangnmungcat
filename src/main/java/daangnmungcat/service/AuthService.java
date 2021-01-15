package daangnmungcat.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Member;
import daangnmungcat.exception.WrongIdPasswordException;
import daangnmungcat.mapper.MemberMapper;

@Component
public class AuthService {
	
	@Autowired
	private MemberMapper mapper;
	
	public AuthInfo authenicate(String id, String pwd) {
		Member member = mapper.selectMembetById(id);
		if(member == null) {
			throw new WrongIdPasswordException();
		}
		
		if(!member.matchPassword(pwd)) {
			throw new WrongIdPasswordException();
		}
		
		// 아이디/닉넴/프로필사진  생성자를 만들어서
		return new AuthInfo(member.getId(), member.getNickname(), member.getProfilePic());
	}
}
