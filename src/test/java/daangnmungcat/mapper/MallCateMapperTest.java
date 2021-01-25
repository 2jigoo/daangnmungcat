package daangnmungcat.mapper;

import static org.junit.Assert.fail;

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
import daangnmungcat.dto.MallCate;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class MallCateMapperTest {
	private static final Log log = LogFactory.getLog(MallCateMapperTest.class);
	
	@Autowired
	private MallCateMapper mapper;

	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	

	/*@Test
	public void testInsertMallDogCate() {
		System.out.println("멍 카테고리 추가");
		
		MallCate dogCate = new MallCate();
		dogCate.setName("산책용품");
		
		mapper.insertMallDogCate(dogCate);
	}

	@Test
	public void testInsertMallCatCate() {
		fail("Not yet implemented");
	}
	*/
	
	@Test
	public void testSelectByAllDogCate() {
		System.out.println("강아지 카테고리 리스트");
		
		List<MallCate> list = mapper.selectByAllDogCate();
		list.stream().forEach(System.out::println);
	}
	
	@Test
	public void testSelectByAllCatCate() {
		System.out.println("고양이 카테고리 리스트");
		
		List<MallCate> list = mapper.selectByAllCatCate();
		list.stream().forEach(System.out::println);
	}
	
	@Test
	public void testSelectByIdDogCate() {
		System.out.println("강아지 아이디 찾기");
		
		MallCate list = mapper.selectByIdDogCate(1);
		System.out.println(list);
	}

}
