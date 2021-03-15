package daangnmungcat.config;

import static org.junit.Assert.fail;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.After;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { ContextRoot.class })
@Log4j2
public class ContextSqlSessionTest {
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}

	
	@Autowired
	private SqlSessionFactory sessionFactory;

	//@Test
	public void testSqlSessionFactoryBean() {
		fail("Not yet implemented");
	}

	@Test
	public void testSqlSession() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName() + "()");
        SqlSession session = sessionFactory.openSession();
        log.debug("session " + session);
        Assert.assertNotNull(session);
	}

}
