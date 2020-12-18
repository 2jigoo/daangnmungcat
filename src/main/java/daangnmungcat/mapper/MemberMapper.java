package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Member;

public interface MemberMapper {
	List<Member> selectMemberByAll();
	int insertMember(Member member);
}