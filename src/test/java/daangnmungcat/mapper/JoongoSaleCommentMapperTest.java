package daangnmungcat.mapper;

import static org.junit.Assert.*;

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
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;
import daangnmungcat.dto.SaleComment;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ContextRoot.class} )
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JoongoSaleCommentMapperTest {
	private static final Log log = LogFactory.getLog(JoongoListMapperTest.class); 
	
	@Autowired
	private JoongoSaleCommentMapper mapper;

	@After
	public void tearDown() throws Exception {
		System.out.println();
	}

	@Test
	public void testInsertJoongoSaleComment() {
		System.out.println("중고 댓글");
		SaleComment saleComment = new SaleComment();
		Sale sale = new Sale();
		Member member = new Member();
		
		sale.setId(1);
		member.setId("chattest1");
		
		saleComment.setSale(sale);
		saleComment.setMember(member);
		saleComment.setContent("테스트로 올리는 글입니다");
		
		
		mapper.insertJoongoSaleComment(saleComment);
	}

}
