package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.junit.After;
import org.junit.Assert;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import daangnmungcat.config.ContextRoot;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Dongne1;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;
import daangnmungcat.dto.SaleState;
import daangnmungcat.service.JoongoSaleService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JoongoListMapperTest {
	private static final Log log = LogFactory.getLog(JoongoListMapperTest.class); 
	
	@Autowired
	private JoongoListMapper mapper;

	@Autowired
	private JoongoSaleService service;
	
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	/*
	
	@Test
	public void testInsertJoongoSale() {
		Sale sale = new Sale();
		Member member = new Member();
		member.setId("chattest1");
		sale.setMember(member);
		sale.setDogCate("y");
		sale.setCatCate("n");
		sale.setTitle("제목입니다.");
		sale.setContent("내용입니다.");
		sale.setPrice(100);
		Dongne1 dongne1 = new Dongne1(3, "부산광역시");
		Dongne2 dongne2 = new Dongne2(48, new Dongne1(3), "수성구");
		sale.setDongne1(dongne1);
		sale.setDongne2(dongne2);
//		sale.setSaleState(1);
		sale.setSaleState(SaleState.ON_SALE);
		int res = mapper.insertJoongoSale(sale);
		Assert.assertEquals(1, res);
		System.out.println(sale);
	}

	@Test
	public void testSelectJoongoSaleAll() {
		mapper.selectJoongoByAll().forEach(s -> log.debug(s.toString()));
	}*/
	
	@Test
	public void testSelectJoongoSearch() {
		Criteria cri = new Criteria();
		Sale sale = new Sale();
		sale.setDongne1(new Dongne1(0, "서울특별시"));
		sale.setDongne2(new Dongne2(0, null, "종로구"));
		List<Sale> list = service.getListsSearchedBy(sale, cri);
//		List<Sale> list = mapper.selectJoongoBySearch(sale, cri);
		list.stream().forEach(System.out::println);
	}
	
	@Test
	public void test중고서치2() {
		Criteria cri = new Criteria();
		Sale sale = new Sale();
		sale.setMember(new Member("chattest1"));
		List<Sale> list = service.getListsSearchedBy(sale, cri);
//		List<Sale> list = mapper.selectJoongoBySearch(sale, cri);
		list.stream().forEach(System.out::println);
	}
}
