package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.MallCate;
import daangnmungcat.dto.MallProduct;

public interface MallPdtMapper {
	int insertMallProduct(MallProduct product);
	List<MallProduct> selectProductByAll();
	List<MallProduct> selectDogByAll(Criteria cri);
	List<MallProduct> selectCatByAll(Criteria cri);
	
	List<MallCate> dogCateList();
	List<MallCate> catCateList();
	
	List<MallProduct> dogProductListByCate(@Param("cateId") int cateId, @Param("cri") Criteria cri);
	List<MallProduct> catProductListByCate(@Param("cateId") int cateId, @Param("cri") Criteria cri);
	
	MallProduct getProductById(int id);
	
	int deleteDogCateProduct(int id);
	int deleteCatCateProduct(int id);
	
	int deleteMallProduct(int id);
	
	List<MallProduct> selectProductByAllPage(Criteria cri);
	
	int productCount();
	int productDogCount();
	int productDogCateCount(int cateId);
	int productCatCount();
	int productCatCateCount(int cateId);
	
	int updateMallProduct(MallProduct product);


}
