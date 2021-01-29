package daangnmungcat.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.FileForm;
import daangnmungcat.dto.Sale;

@Service
public interface JoongoSaleService {
	List<Sale> getLists();
	List<Sale> getListByMemID(String memId);
	
	Sale getSaleById(int id);
	
	void JSHits(int id);
	
	int insertJoongoSale(Sale sale, MultipartFile[] fileList, HttpServletRequest request ) throws Exception;	

	List<FileForm> selectImgPath(int id);
	
	// 해당 회원의 페이징된 찜 목록
	List<Sale> getHeartedList(String memberId, Criteria criteria);
	
	List<Sale> selectJoongoByAllPage(Criteria cri);
	int listCount();
	
	int updateJoongoSale(Sale sale);
	

}
