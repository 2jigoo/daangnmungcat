package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.SaleComment;

public interface JoongoSaleCommentMapper {

	// 댓글
	int insertJoongoSaleComment(SaleComment saleComment);
	
	List<SaleComment> selectJoongoCommentByAllPage(@Param("saleId") int saleId, @Param("cri") Criteria cri);
	
	List<SaleComment> selectJoongoCommentByAllPage2(Criteria cri);
	
	int commentCount(int saleId);
	int commentCount2();
	
	int deleteComment(int commentId);
	
	int updateComment(SaleComment saleComment);
}
