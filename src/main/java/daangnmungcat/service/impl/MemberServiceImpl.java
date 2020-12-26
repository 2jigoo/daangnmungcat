package daangnmungcat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Dongne1;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Member;
import daangnmungcat.mapper.MemberMapper;
import daangnmungcat.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public List<Member> selectMemberByAll() {
		return mapper.selectMemberByAll();
	}

	@Override
	public Member selectMembetById(String id) {
		return mapper.selectMembetById(id);
	}

	@Override
	public int registerMember(Member member) {
		return mapper.insertMember(member);
	}

	@Override
	public Integer checkPwd(String id, String pwd) {
		return mapper.checkPwd(id, pwd);
	}

	@Override
	public int idCheck(String id) {
		int res = mapper.idCheck(id); 
		return res;
	}

	@Override
	public List<Dongne1> Dongne1List() {
		return mapper.Dongne1List();
	}

	@Override
	public List<Dongne2> Dongne2List(int dongne1) {
		return mapper.Dongne2List(dongne1);
	}

}
