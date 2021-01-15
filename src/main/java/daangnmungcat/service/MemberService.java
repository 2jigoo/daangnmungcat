package daangnmungcat.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Dongne1;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Member;

@Service
public interface MemberService {
	List<Member> selectMemberByAll();
	Member selectMembetById(@Param("id")String id);
	Integer checkPwd(@Param("id")String id, @Param("pwd")String pwd);
	
	List<Dongne1> Dongne1List();
	List<Dongne2> Dongne2List(@Param("dongne1Id")int dongne1);
	
	int registerMember(Member member);
	int idCheck(String id);
	int emailCheck(String email);
	int phoneCheck(String phone);
	
	//휴대폰인증
	void certifiedPhoneNumber(String phoneNumber, String cerNum);
}