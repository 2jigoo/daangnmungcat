package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;

public interface JoongoSaleMapper {
	
	List<Sale> selectJoongoSaleByAll();
	
	List<Sale>  selectJoonSaleById(@Param("id")int id);

	List<Sale> selectJoongoSalesByMemId(String memId);
	
	//조회수
	void JSaleHits(@Param("id")int id);

	//하트수
	int heartCount(int id);
	
	//채팅수
	int chatCount(int id);
	
	
	//게시글 관리
	
	int updateJoongoSale(Sale sale);
	
	int deleteJoongoSale(int id);
	
}
