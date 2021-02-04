package daangnmungcat.mapper;

import daangnmungcat.dto.SaleReview;

public interface JoongoSaleReviewMapper {
	
	SaleReview selectJoongoReviewBySaleId(int saleId);
	
	int insertJoongoSaleReview(SaleReview review);
}
