package daangnmungcat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import daangnmungcat.dto.MallCate;
import daangnmungcat.mapper.MallCateMapper;
import daangnmungcat.mapper.MallPdtMapper;
import daangnmungcat.service.MallCateService;

@Service
public class MallCateServiceImpl implements MallCateService {
	
	@Autowired
	private MallCateMapper mapper;
	
	@Autowired
	private MallPdtMapper pdtMapper;

	@Override
	public List<MallCate> selectByAllDogCate() {
		return mapper.selectByAllDogCate();
	}

	@Override
	public List<MallCate> selectByAllCatCate() {
		return mapper.selectByAllCatCate();
	}

	@Override
	public MallCate selectByIdCate(String cateName, int id) {
		MallCate list;
		if (cateName.equals("멍")) {
			list = mapper.selectByIdDogCate(id);
		} else {
			list = mapper.selectByIdCatCate(id);
		}
		return list;
	}

	@Override
	public int insertMallCate(String cateName, MallCate mallCate) {
		int res = 0;
		
		if (cateName.equals("멍")) {
			mapper.insertMallDogCate(mallCate);
		} else {
			mapper.insertMallCatCate(mallCate);
		}
		
		return res;
	}

	@Override
	public int updateMallCate(String cateName, MallCate mallCate) {
		int res = 0;
		
		if (cateName.equals("멍")) {
			mapper.updateMallDogCate(mallCate);
		} else {
			mapper.updateMallCatCate(mallCate);
		}
		
		return res;
	}

	@Transactional
	@Override
	public int deleteMallCate(String cateName, int id) {
		int res = 0;
		
		if (cateName.equals("멍")) {
			pdtMapper.deleteDogCateProduct(id);
			mapper.deleteMallDogCate(id);
		} else {
			pdtMapper.deleteCatCateProduct(id);
			mapper.deleteMallCatCate(id);
		}
		return res;
	}

}
