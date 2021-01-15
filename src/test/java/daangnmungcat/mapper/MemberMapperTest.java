package daangnmungcat.mapper;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.junit.After;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import daangnmungcat.config.ContextRoot;
import daangnmungcat.dto.Dongne1;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Member;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class MemberMapperTest {
	private static final Log log = LogFactory.getLog(MemberMapperTest.class); 
	
	@Autowired
	private MemberMapper mapper;
	
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}

	@Test
	public void selectMemberByAll() {
		List<Member> list = mapper.selectMemberByAll();
		list.stream().forEach(System.out::println);
		
	}
	
	@Test
	public void selectMemberByNo() {
		Member member = mapper.selectMembetById("admin");
		System.out.println(member);
	}
	
	@Test
	public void checkPwd() {
		int res = mapper.checkPwd("admin", "1234");
		System.out.println(res);
		
	}
	
	@Test
	public void selectDong1() {
		List<Dongne1> list1 = mapper.Dongne1List();
		List<Dongne2> list2 = mapper.Dongne2List(1);
	}
	
	//@Test
	public void insertMember() {
		//Member member = new Member("test2", "1234", "이름", "닉", "test@djfklsdf", "010-5641-5414", "1", 1, 1, "", "");
		//mapper.insertMember(member);
	}
	
	@Test
	public void emailCheck() {
		int res = mapper.emailCheck("admin@admin.co.kr");
		System.out.println(res);
	}
}
