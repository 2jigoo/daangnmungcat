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
import daangnmungcat.dto.SaleReview;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JoongoSaleReviewMapperTest {
	
	@Autowired
	private JoongoSaleReviewMapper mapper;
	
	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
	
	@Test
	public void testSelectJoongoReviewBySaleId() {
		System.out.println("중고 상품 아이디 검색");
		SaleReview review = mapper.selectJoongoReviewBySaleId(5);
		System.out.println(review);
	}
	
	@Test
	public void testSelectJoongoReviewByAll() {
		System.out.println("중고 리뷰 리스트");
		List<SaleReview> list = mapper.selectJoongoReviewByAll();
		list.forEach(System.out::println);
	}

	/*@Test
	public void testInsertJoongoSaleReview() {
		System.out.println("중고 리뷰 추가");
		SaleReview review = new SaleReview();
		Sale sale = new Sale();
		sale.setId(1);
		review.setSale(sale);
		review.setBuyMember(new Member("chattest1"));
		review.setRating(4.5);
		review.setContent("중고 리뷰 추가");
		
		mapper.insertJoongoSaleReview(review);
	}*/

}
