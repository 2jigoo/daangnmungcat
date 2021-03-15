package daangnmungcat.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
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
	public List<SaleComment> selectJoongoCommentByAllPage(@Param("saleId") int saleId, @Param("cri") Criteria cri) {
		return mapper.selectJoongoCommentByAllPage(saleId, cri);
	}

	@Override
	public int commentCount(int saleId) {
		return mapper.commentCount(saleId);
	}

	@Override
	public int deleteComment(int commentId) {
		return mapper.deleteComment(commentId);
	}

	@Override
	public int updateComment(SaleComment saleComment) {
		return mapper.updateComment(saleComment);
	}

	@Override
	public List<SaleComment> selectJoongoCommentByAllPage2(Criteria cri) {
		return mapper.selectJoongoCommentByAllPage2(cri);
	}

	@Override
	public int commentCount2() {
		return mapper.commentCount2();
	}

	@Override
	public List<SaleComment> selectJoongoCommentSearchByAllPage(SaleComment saleComment, Criteria cri) {
		return mapper.selectJoongoCommentSearchByAllPage(saleComment, cri);
	}

	@Override
	public int commentSearchCount(SaleComment saleComment) {
		return mapper.commentSearchCount(saleComment);
	}

}
