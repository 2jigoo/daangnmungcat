package daangnmungcat.mapper;

import static org.junit.Assert.fail;

import org.junit.After;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import daangnmungcat.config.ContextRoot;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class MileageMapperTest {
	
	@Autowired
	private MileageMapper mapper;
	
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	
	@Test
	public void test02UpdateMemberMileage() {
	}

	@Test
	public void test01GetMileage() {
		System.out.println(mapper.getMileage("chattest1"));
	}

	@Test
	public void testSelectMileageInfoById() {
		fail("Not yet implemented");
	}

	@Test
	public void testInsertMilegeInfo() {
		String usedMile = "50";
		Mileage mile = new Mileage();
		mile.setMember(new Member("chattest2"));
		mile.setOrder(null);
		mile.setMileage(Integer.parseInt("-"+usedMile));
		mile.setContent("상품 구매 사용");
		mapper.insertMilegeInfo(mile);
		System.out.println(mile);
	} 

}
