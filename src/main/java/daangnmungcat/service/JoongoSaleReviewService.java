package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.SaleReview;

public interface JoongoSaleReviewService {
	List<SaleReview> selectJoongoReviewByAll();
	
	List<SaleReview> selectJoongoReviewBySaleMemId(String memId);
	
	SaleReview selectJoongoReviewBySaleId(int saleId);
	
	SaleReview selectJoongoReviewById(int id);
	
	int insertJoongoSaleReview(SaleReview review);
	
	int updateJoongoSaleReview(SaleReview review);
	
	int deleteJoongoSaleReview(int id);
	
	int countMemId(String memId);
}
