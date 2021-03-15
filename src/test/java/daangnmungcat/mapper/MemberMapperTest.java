package daangnmungcat.mapper;

import org.junit.After;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import daangnmungcat.config.ContextRoot;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Member;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@Log4j2
public class MemberMapperTest {
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired 
	private OrderMapper orderMapper;
	
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}

	/*@Test
	public void selectMemberByAll() {
		List<Member> list = mapper.selectMemberByAll();
		list.stream().forEach(System.out::println);
		
	}
	
	@Test
	public void selectMemberByNo() {
		Member member = mapper.selectMemberById("admin");
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

	
	@Test
	public void emailCheck() {
		int res = mapper.emailCheck("admin@admin.co.kr");
		System.out.println(res);
	}*/
	
	//@Test
	public void dongne() {
		Dongne2 dongne2 = mapper.selectDongneByDongne2(new Dongne2(10));
		log.debug(dongne2.toString());
	}
	
	//@Test
	public void selectMember() {
		Member member = mapper.selectMemberById("chattest1");
		System.out.println(member);
	}
	
	@Test 
	public void order() {
		
	}
}
