package daangnmungcat.service.impl;

import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.SaleReview;
import daangnmungcat.mapper.JoongoSaleReviewMapper;
import daangnmungcat.service.JoongoSaleReviewService;

@Service
public class JoongoSaleReviewServiceImpl implements JoongoSaleReviewService {

	protected static final Log log = LogFactory.getLog(JoongoSaleReviewServiceImpl.class);
	
	@Autowired
	private JoongoSaleReviewMapper mapper;

	@Override
	public List<SaleReview> getAllList() {
		return mapper.selectJoongoReviewByAll();
	}

	// 내가 쓴 리뷰들(판매/구매 모두)
	@Override
	public List<SaleReview> getReviewListWrittenBy(String memId) {
		return mapper.selectJoongoReviewByWriter(memId);
	}

	// 나에 대한 리뷰(판매/구매 모두 남들이 써준 거)
	@Override
	public List<SaleReview> getReviewListOnMe(String memId) {
		return mapper.selectJoongoReviewOnMemId(memId);
	}
	
	// 내 판매글에 대한 리뷰
	@Override
	public List<SaleReview> getBuyersReviewOnMe(String memId) {
		return mapper.selectJoongoReviewBySaleMemId(memId);
	}

	// 내가 구매한 거래에 대한 리뷰
	@Override
	public List<SaleReview> getSellersReviewOnMe(String memId) {
		return mapper.selectJoongoReviewByBuyMemId(memId);
	}
	
	// 해당 판매글에 대한 리뷰... 는 두 갠데
	@Override
	public SaleReview getReviewBySaleId(int saleId, String memId) {
		return mapper.selectJoongoReviewBySaleId(saleId, memId);
	}

	// 해당 리뷰
	@Override
	public SaleReview getReviewByReviewId(int id) {
		return mapper.selectJoongoReviewById(id);
	}

	
	/* 쓰기, 수정, 삭제 */
	@Override
	public int writeReview(SaleReview review) {
		return mapper.insertJoongoSaleReview(review);
	}

	@Override
	public int modifyReview(SaleReview review) {
		return mapper.updateJoongoSaleReview(review);
	}
	
	@Override
	public int deleteReview(int id) {
		return mapper.deleteJoongoSaleReview(id);
	}

	
	/* count */
	@Override
	public int countReviewListOfMySales(String memId) {
		return mapper.countSaleMemId(memId);
	}

	@Override
	public int countReviewListOfMyPurchase(String memId) {
		return mapper.countBuyMemId(memId);
	}

}
