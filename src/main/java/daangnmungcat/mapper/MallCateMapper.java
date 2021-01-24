package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.MallCate;

public interface MallCateMapper {
	List<MallCate> selectByAllDogCate();
	List<MallCate> selectByAllCatCate();
	
	MallCate selectByIdDogCate(int id);
	MallCate selectByIdCatCate(int id);
	
	int insertMallDogCate(MallCate dogCate);
	int insertMallCatCate(MallCate catCate);
	
	int updateMallDogCate(MallCate dogCate);
	int updateMallCatCate(MallCate catCate);
}
