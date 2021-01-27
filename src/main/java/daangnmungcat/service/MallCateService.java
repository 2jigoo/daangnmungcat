package daangnmungcat.service;

import java.util.List;

import org.springframework.stereotype.Service;

import daangnmungcat.dto.MallCate;

@Service
public interface MallCateService {
	List<MallCate> selectByAllDogCate();
	List<MallCate> selectByAllCatCate();
	
	MallCate selectByIdCate(String cateName, int id);
	
	int insertMallCate(String cateName, MallCate mallCate);
	
	int updateMallCate(String cateName, MallCate mallCate);
	
	int deleteMallCate(String cateName, int id);
}
