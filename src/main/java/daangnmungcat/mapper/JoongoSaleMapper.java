package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;

public interface JoongoSaleMapper {
	
	List<Sale> selectJoongoSaleByAll();
	List<Sale> selectJoongoSalesByMemId(String memId);

	Sale selectJoongoSaleById(int id);
	
	//조회수
	void JSaleHits(int id);

	//하트수
	int heartCount(int id);
	void inserthearCount(int id);
	void deletehearCount(int id);
	
	//채팅수
	int chatCount(int id);
	
	//게시글 관리
	int updateJoongoSale(Sale sale);
	
	
	
}
