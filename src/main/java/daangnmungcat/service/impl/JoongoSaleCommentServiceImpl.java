package daangnmungcat.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.SaleComment;
import daangnmungcat.mapper.JoongoSaleCommentMapper;
import daangnmungcat.service.JoongoSaleCommentService;

@Service
public class JoongoSaleCommentServiceImpl implements JoongoSaleCommentService {
	
	@Autowired
	JoongoSaleCommentMapper mapper;

	@Override
	public int insertJoongoSaleComment(SaleComment saleComment) {
		System.out.println("impl : "+ saleComment);
		int res = mapper.insertJoongoSaleComment(saleComment);
		System.out.println(res);
		return 0;
	}

}
