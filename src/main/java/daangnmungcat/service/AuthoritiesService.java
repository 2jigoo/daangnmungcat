package daangnmungcat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Authority;
import daangnmungcat.mapper.AuthoritiesMapper;

@Service
public class AuthoritiesService {

	@Autowired
	private AuthoritiesMapper authoritiesMapper;
	
	public List<Authority> getAuthorityByUsername(String username) {
		return authoritiesMapper.selectAuthorityByUsername(username);
	}
	
	public int registerAuthorityIntoMember(Authority authority) {
		return authoritiesMapper.insertAuthorityIntoUserName(authority);
	}
}
