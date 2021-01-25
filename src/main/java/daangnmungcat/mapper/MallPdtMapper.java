package daangnmungcat.mapper;

import java.util.List;

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


}
