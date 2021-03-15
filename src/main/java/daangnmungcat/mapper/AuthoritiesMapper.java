package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Authority;

public interface AuthoritiesMapper {

	List<Authority> selectAuthorityByUsername(String username);

	int insertAuthorityIntoUserName(Authority authority);
	
}
