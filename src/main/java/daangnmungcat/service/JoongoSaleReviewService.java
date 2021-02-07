package daangnmungcat.service;

import daangnmungcat.dto.SaleReview;

public interface JoongoSaleReviewService {
	
	SaleReview selectJoongoReviewBySaleId(int saleId);
	
	int insertJoongoSaleReview(SaleReview review);
}
