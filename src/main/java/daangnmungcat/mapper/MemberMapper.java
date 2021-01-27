package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Address;
import daangnmungcat.dto.Dongne1;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Member;

public interface MemberMapper {
	List<Member> selectMemberByAll();
	Member selectMemberById(String id);
	int deleteMember(String id);
	int insertMember(Member member);
	
	Integer checkPwd(@Param("id")String id, @Param("pwd")String pwd);
	
	int idCheck(String id);
	int emailCheck(String email);
	int phoneCheck(String phone);
	
	List<Dongne1> Dongne1List();
	List<Dongne2> Dongne2List(@Param("dongne1Id")int dongne1);
	
	int updateProfilePic(Member member);
	int updateProfileText(Member member);
	int updatePhone(Member member);
	int updatePwd(Member member);
	int updateInfo(Member member);

	int dongneUpdate(@Param("id") String id, @Param("dongne1") Dongne1 dongne1, @Param("dongne2") Dongne2 dongne2);
	
	Dongne2 selectDongneByDongne2(Dongne2 dongne2);
	
	//주소
	List<Address> selectAddressById(String id);
	Address getAddress(String id);
	int insertAddress(Address address);
	int updateMyAddress(Member member);
	int updateAddress(Address address);
	int deleteAddress(String id);
	
}