package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.SaleReview;

public interface JoongoSaleReviewService {
	List<SaleReview> getAllList();
	
	List<SaleReview> getReviewListWrittenBy(String memId);
	
	List<SaleReview> getReviewListOnMe(String memId);
	
	List<SaleReview> getBuyersReviewOnMe(String memId);
	
	List<SaleReview> getSellersReviewOnMe(String memId);
	
	SaleReview getReviewBySaleId(int saleId, String memId);
	
	SaleReview getReviewByReviewId(int id);
	
	int writeReview(SaleReview review);
	
	int modifyReview(SaleReview review);
	
	int deleteReview(int id);
	
	int countReviewListOfMySales(String memId);;
	
	int countReviewListOfMyPurchase(String memId);
}
