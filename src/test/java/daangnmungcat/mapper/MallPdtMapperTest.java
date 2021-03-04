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
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.MallProduct;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class MallPdtMapperTest {
	
	@Autowired
	private MallPdtMapper mapper;

	@After
	public void tearDown() throws Exception {
		System.out.println();
	}
/*
	@Test
	public void testInsertMallProduct() {
		System.out.println("상품 등록");
		MallCate cate = new MallCate();
		cate.setId(1);
		
		MallProduct product = new MallProduct();
		product.setDogCate(cate);
		product.setName("네츄럴");
		product.setPrice(15000);
		product.setContent("네츄럴 사료입니다.");
		product.setSaleYn("y");
		product.setStock(500);
		product.setDeliveryKind("무료배송");
		
		System.out.println(product);
		
		mapper.insertMallProduct(product);
	}

	
	@Test
	public void testUpdateDogProduct() {
		System.out.println("카테고리 수정");
		mapper.deleteDogCateProduct(2);
	}
	*/
	
	@Test
	public void testSelectProductBySearch() {
		MallProduct product = new MallProduct();
		product.setSaleYn("Y");
		
		List<MallProduct> list = mapper.selectProductBySearch(product, new Criteria());
		list.stream().forEach(System.out::println);
	}
}
