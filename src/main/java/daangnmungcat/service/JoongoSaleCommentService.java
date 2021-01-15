package daangnmungcat.service;

import java.util.List;

import org.springframework.stereotype.Service;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.SaleComment;

@Service
public interface JoongoSaleCommentService {

	// 댓글
	int insertJoongoSaleComment(SaleComment saleComment);
	
	List<SaleComment> selectJoongoCommentByAllPage(Criteria cri);
}
