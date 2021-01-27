package daangnmungcat.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.FileForm;
import daangnmungcat.dto.Sale;

@Service
public interface JoongoSaleService {
	List<Sale> getLists();
	
	List<Sale> getListsById(@Param("id")int id);
	
	List<Sale> getListByMemID(@Param("memId")String memId);
	
	void JSHits(int id);
	
	int insertJoongoSale(Sale sale, MultipartFile[] fileList, HttpServletRequest request ) throws Exception;	

	List<FileForm> selectImgPath(@Param("id")int id);
}
