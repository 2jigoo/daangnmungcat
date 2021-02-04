package daangnmungcat.service.impl;

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
	public int insertJoongoSaleReview(SaleReview review) {
		return mapper.insertJoongoSaleReview(review);
	}

	@Override
	public SaleReview selectJoongoReviewBySaleId(int saleId) {
		return mapper.selectJoongoReviewBySaleId(saleId);
	}

}
