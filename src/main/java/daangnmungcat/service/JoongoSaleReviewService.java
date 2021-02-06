package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.SaleReview;

public interface JoongoSaleReviewService {
	List<SaleReview> selectJoongoReviewByAll();
	
	List<SaleReview> selectJoongoReviewBySaleMemId(String memId);
	
	SaleReview selectJoongoReviewBySaleId(int saleId);
	
	int insertJoongoSaleReview(SaleReview review);
	
	int countMemId(String memId);
}
