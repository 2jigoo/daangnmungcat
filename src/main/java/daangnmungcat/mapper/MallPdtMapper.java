package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.MallCate;
import daangnmungcat.dto.MallProduct;

public interface MallPdtMapper {
	int insertMallProduct(MallProduct product);
	List<MallProduct> selectProductByAll();
	List<MallProduct> selectDogByAll();
	List<MallProduct> selectCatByAll();
	
	List<MallCate> dogCateList();
	List<MallCate> catCateList();
	
	List<MallProduct> dogProductListByCate(int cate);
	List<MallProduct> catProductListByCate(int cate);
	
	MallProduct getProductById(int id);
	
	int deleteDogCateProduct(int id);
	int deleteCatCateProduct(int id);


}
