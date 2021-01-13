package daangnmungcat.mapper;

import static org.junit.Assert.fail;

import java.util.HashMap;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.junit.After;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import daangnmungcat.config.ContextRoot;
import daangnmungcat.dto.Heart;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JoongoHeartMapperTest {
	
	private static final Log log = LogFactory.getLog(JoongoHeartMapperTest.class); 

	@Autowired
	private JoongoHeartMapper mapper;
	
    @Autowired
    protected SqlSessionTemplate sqlSession;


	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	
	@Test
	public void testSelectJoongoHeartById() {
		fail("Not yet implemented");
	}

	@Test
	public void testInsertHeart() {
		fail("Not yet implemented");
	}

	@Test
	public void testDeleteHeart() {
		fail("Not yet implemented");
	}

	@Test
	public void testCountHeart() {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memId", "chattest1");
		map.put("id", 3);
		System.out.println(map);
		
		System.out.println(mapper.countHeart(map));
	}

}
