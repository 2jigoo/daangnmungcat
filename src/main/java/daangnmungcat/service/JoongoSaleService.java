package daangnmungcat.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.FileForm;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;

@Service
public interface JoongoSaleService {
	
	List<Sale> getLists();
	List<Sale> getLists(Criteria cri);
	List<Sale> getLists(String dongne1, Criteria cri);
	List<Sale> getLists(String dongne1, String dongne2, Criteria cri);
	List<Sale> getListByMemID(String memId);
	
	
	Sale getSaleById(int id);
	void JSHits(int id); // 게시물 조회시 조회수 증가


	int insertJoongoSale(Sale sale, MultipartFile[] fileList, MultipartFile file, HttpServletRequest request) throws Exception;
	int updateJoongoSale(Sale sale, MultipartFile[] fileList,   MultipartFile file, HttpServletRequest request) throws Exception;

	List<FileForm> selectImgPath(int id);
	FileForm selectThumImgPath(int id);

	// 해당 회원의 페이징된 찜 목록
	List<Sale> getHeartedList(String memberId, Criteria criteria);
	
	
	// 판매완료 처리
	int soldOut(Member buyMember, Sale sale);
	int changeSaleState(Sale sale);
	
	// 검색 조건에 따른 리스트
	List<Sale> getListsSearchedBy(Sale sale, Criteria cri);
	
	//상세보기 - 수정에서 사진 db삭제
	int deleteSaleFile(String fileName);
	int deleteSaleFileBySaleId(int id);
	
	
	int listCount();
	int listCountByDongne1(String dongne1);
	int listCountByDongne2(String dongne1, String dongne2);
}
