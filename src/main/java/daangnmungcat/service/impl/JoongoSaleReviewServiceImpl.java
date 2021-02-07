package daangnmungcat.service.impl;

import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.SaleReview;
import daangnmungcat.mapper.JoongoSaleReviewMapper;

@Service
public class JoongoSaleReviewServiceImpl implements daangnmungcat.service.JoongoSaleReviewService {

	protected static final Log log = LogFactory.getLog(JoongoSaleReviewServiceImpl.class);
	
	@Autowired
	private JoongoSaleReviewMapper mapper;

	@Override
	public List<SaleReview> selectJoongoReviewByAll() {
		return mapper.selectJoongoReviewByAll();
	}

	@Override
	public List<SaleReview> selectJoongoReviewBySaleMemId(String memId) {
		return mapper.selectJoongoReviewBySaleMemId(memId);
	}

	@Override
	public int insertJoongoSaleReview(SaleReview review) {
		return mapper.insertJoongoSaleReview(review);
	}

	@Override
	public SaleReview selectJoongoReviewBySaleId(int saleId) {
		return mapper.selectJoongoReviewBySaleId(saleId);
	}

	@Override
	public int countMemId(String memId) {
		return mapper.countMemId(memId);
	}

	@Override
	public SaleReview selectJoongoReviewById(int id) {
		return mapper.selectJoongoReviewById(id);
	}

	@Override
	public int updateJoongoSaleReview(SaleReview review) {
		return mapper.updateJoongoSaleReview(review);
	}

	@Override
	public int deleteJoongoSaleReview(int id) {
		return mapper.deleteJoongoSaleReview(id);
	}

}
