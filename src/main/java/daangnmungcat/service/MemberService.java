package daangnmungcat.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Address;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Dongne1;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Member;

@Service
public interface MemberService {
	List<Member> selectMemberByAll();
	List<Member> getList(Member member, Criteria criteria);
	Member selectMemberById(@Param("id")String id);
	Integer checkPwd(@Param("id")String id, @Param("pwd")String pwd);
	
	List<Dongne1> Dongne1List();
	List<Dongne2> Dongne2List(@Param("dongne1Id")int dongne1);
	
	int deleteMember(String id);
	int registerMember(Member member);
	int idCheck(String id);
	int emailCheck(String email);
	int phoneCheck(String phone);
	

	int deleteProfilePic(HttpServletRequest request, HttpSession session);
	int updateProfilePic(MultipartFile[] uploadFile, HttpSession session, HttpServletRequest request);
	int updateProfileText(Member member);
	int updatePhone(Member member);
	int updatePwd(Member member);
	int updateInfo(Member member);
	
	
	//휴대폰인증
	void certifiedPhoneNumber(String phoneNumber, String cerNum);
	
	int dongneUpdate(@Param("id") String id, @Param("dongne1") Dongne1 dongne1, @Param("dongne2") Dongne2 dongne2);
	
	//주소
	List<Address> myAddress(String id);
	int insertAddress(Address address);
	int updateMyAddress(Member member);
	Address getAddress(String id);
	int updateShippingAddress(Address address);
	int deleteShippingAddress(String id);
	

}