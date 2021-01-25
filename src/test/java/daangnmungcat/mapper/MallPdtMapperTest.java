package daangnmungcat.mapper;

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
import daangnmungcat.dto.MallProduct;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class MallPdtMapperTest {
	private static final Log log = LogFactory.getLog(MallPdtMapperTest.class);
	
	@Autowired
	private MallPdtMapper mapper;

	@After
	public void tearDown() throws Exception {
		System.out.println();
	}

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

}
