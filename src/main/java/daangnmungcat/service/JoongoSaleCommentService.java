package daangnmungcat.service;

import org.springframework.stereotype.Service;

import daangnmungcat.dto.SaleComment;

@Service
public interface JoongoSaleCommentService {

	// 댓글
	int insertJoongoSaleComment(SaleComment saleComment);
}
