package daangnmungcat.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.MallCate;
import daangnmungcat.dto.MallProduct;

@Service
public interface MallPdtService {
	int insertMallProduct(MallProduct product, MultipartFile thumbFile, List<MultipartFile> fileList, HttpServletRequest request);
	
	List<MallProduct> selectProductByAll();
	List<MallProduct> selectDogByAll(Criteria cri);
	List<MallProduct> selectCatByAll(Criteria cri);

	List<MallCate> dogCateList();
	List<MallCate> catCateList();

	List<MallProduct> dogProductListByCate(@Param("cateId") int cateId, @Param("cri") Criteria cri);
	List<MallProduct> catProductListByCate(@Param("cateId") int cateId, @Param("cri") Criteria cri);

	MallProduct getProductById(int id);
	
	int deleteMallProduct(int id);
	
	List<MallProduct> selectProductByAllPage(Criteria cri);

	int productCount();
	int productDogCount();
	int productDogCateCount(int cateId);
	int productCatCount();
	int productCatCateCount(int cateId);
	
	int updateMallProduct(MallProduct product, MultipartFile thumbFile, List<MultipartFile> fileList, HttpServletRequest request);

	List<MallProduct> selectProductBySearch(@Param("product") MallProduct product, @Param("cri") Criteria cri);

	int calculateStock(MallProduct product, int orderQuantity);
}
