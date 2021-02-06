package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.SaleReview;

public interface JoongoSaleReviewMapper {
	List<SaleReview> selectJoongoReviewByAll();
	
	List<SaleReview> selectJoongoReviewBySaleMemId(String memId);
	
	SaleReview selectJoongoReviewBySaleId(int saleId);
	
	int insertJoongoSaleReview(SaleReview review);
	
	int countMemId(String memId);
}
