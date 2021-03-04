package daangnmungcat.mapper;

import java.util.List;

import org.junit.After;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import daangnmungcat.config.ContextRoot;
import daangnmungcat.dto.Sale;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JoongoSaleMapperTest {
	
	@Autowired
	private JoongoSaleMapper mapper;
	
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	
	@Test
	public void test01SelectJoongoSaleByAll() {
		List<Sale> list = mapper.selectJoongoSaleByAll();
		list.stream().forEach(System.out::println);
	}

	@Test
	public void test02SelectJoonSaleById() {
		int id = 2;
		Sale sale = mapper.selectJoongoSaleById(id);
		System.out.println(sale);
	}

	@Test
	public void test03SelectJoongoSalesByMemId() {
		String memId = "chattest1";
		List<Sale> sale = mapper.selectJoongoSalesByMemId(memId);
		sale.stream().forEach(System.out::println);
	}

	@Test
	public void testJSaleHits() {
		int id = 2;
		mapper.JSaleHits(id);
//		System.out.println(hits);
	}

}
