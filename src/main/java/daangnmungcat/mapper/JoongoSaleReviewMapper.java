package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.SaleReview;

public interface JoongoSaleReviewMapper {
	List<SaleReview> selectJoongoReviewByAll();
	
	List<SaleReview> selectJoongoReviewOnMemId(String memId);
	List<SaleReview> selectJoongoReviewByWriter(String memId);
	List<SaleReview> selectJoongoReviewBySaleMemId(String memId);
	List<SaleReview> selectJoongoReviewByBuyMemId(String memId);
	
	SaleReview selectJoongoReviewBySaleId(@Param("saleId") int saleId, @Param("memId") String memId);
	SaleReview selectJoongoReviewById(int id);
	
	int insertJoongoSaleReview(SaleReview review);
	int updateJoongoSaleReview(SaleReview review);
	int deleteJoongoSaleReview(int id);
	
	int countOnMemId(String memId);
	int countWriterId(String memId);
	int countSaleMemId(String memId);
	int countBuyMemId(String memId);
}
