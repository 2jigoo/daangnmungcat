package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;

public interface JoongoSaleMapper {
	
	List<Sale> selectJoongoSaleByAll();
	
	List<Sale>  selectJoonSaleById(@Param("id")int id);
	
	List<Sale> selectJoongoSalesByMemId(String memId);
}
