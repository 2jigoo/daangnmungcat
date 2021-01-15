package daangnmungcat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.SaleComment;
import daangnmungcat.mapper.JoongoSaleCommentMapper;
import daangnmungcat.service.JoongoSaleCommentService;

@Service
public class JoongoSaleCommentServiceImpl implements JoongoSaleCommentService {
	
	@Autowired
	JoongoSaleCommentMapper mapper;

	@Override
	public int insertJoongoSaleComment(SaleComment saleComment) {
		int res = mapper.insertJoongoSaleComment(saleComment);
		return res;
	}

	@Override
	public List<SaleComment> selectJoongoCommentByAllPage(Criteria cri) {
		return mapper.selectJoongoCommentByAllPage(cri);
	}

}
