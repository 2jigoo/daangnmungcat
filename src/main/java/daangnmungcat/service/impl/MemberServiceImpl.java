package daangnmungcat.service.impl;

import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Dongne1;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Member;
import daangnmungcat.mapper.MemberMapper;
import daangnmungcat.service.MemberService;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

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
	public int emailCheck(String email) {
		int res =  mapper.emailCheck(email);
		return res;
	}
	
	@Override
	public int phoneCheck(String phone) {
		int res = mapper.phoneCheck(phone);
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
	
	@Override
	public void certifiedPhoneNumber(String phoneNumber, String cerNum) {

        String api_key = "NCSEEVJOI1LJEMQC";
        String api_secret = "0DGQ4GKFFZIVZEOVXWIVQTTU3JONGQZS";
        Message coolsms = new Message(api_key, api_secret);

        // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("to", phoneNumber);    // 수신전화번호
        params.put("from", "01056156004");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
        params.put("type", "SMS");
        params.put("text", "당근멍캣 휴대폰인증 테스트 메시지 : 인증번호는" + "["+cerNum+"]" + "입니다.");
 
        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
	}


	@Override
	public int updateProfilePic(Member member) {
		return mapper.updateProfilePic(member);
	}

	

}
