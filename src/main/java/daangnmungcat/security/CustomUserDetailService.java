package daangnmungcat.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Authority;
import daangnmungcat.dto.Member;
import daangnmungcat.exception.WrongIdPasswordException;
import daangnmungcat.service.AuthoritiesService;
import daangnmungcat.service.MemberService;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class CustomUserDetailService implements UserDetailsService {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AuthoritiesService authoritiesService;
	
	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		Member member = memberService.selectMemberById(id);
		
		if(member == null) {
			throw new WrongIdPasswordException();
		}
		
		AuthInfo authInfo = new AuthInfo(member.getId(), member.getPwd(), member.getNickname(), member.getDongne1(), member.getDongne2(), member.getProfilePic(), member.getGrade());
		
		authInfo.setAuthorities(getAuthorities(id));
		authInfo.setEnabled(member.getUseYn().equalsIgnoreCase("y") ? true : false);
		authInfo.setAccountNonExpired(true);
		authInfo.setAccountNonLocked(true);
		authInfo.setCredentialsNonExpired(true);

		return authInfo;
	}
	
	 public Collection<GrantedAuthority> getAuthorities(String id) {
	        List<Authority> authList = authoritiesService.getAuthorityByUsername(id);
	        List<GrantedAuthority> authorities = new ArrayList<>();
	        for (Authority authority : authList) {
	            authorities.add(new SimpleGrantedAuthority("ROLE_" + authority.getAuthority()));
	        }
	        return authorities;
	    }

}
