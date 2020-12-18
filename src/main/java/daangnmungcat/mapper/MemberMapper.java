package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Member;

public interface MemberMapper {
	List<Member> selectMemberByAll();
	Member selectMembetById(String id);
	int insertMember(Member member);
	int checkPwd(@Param("id")String id, @Param("pwd")String pwd);
}