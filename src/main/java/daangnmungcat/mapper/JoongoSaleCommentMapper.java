package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.SaleComment;

public interface JoongoSaleCommentMapper {

	// 댓글
	int insertJoongoSaleComment(SaleComment saleComment);
	
	List<SaleComment> selectJoongoCommentByAllPage(Criteria cri);
}
