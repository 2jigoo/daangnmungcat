package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Sale;

public interface JoongoListMapper {
	List<Sale> selectJoongoByAll();
	
	List<Sale> selectJoongoByAllPage(Criteria cri);
	
	List<Sale> selectJoongoByDongne1(@Param("dongne1") String dongne1, @Param("cri") Criteria cri);
	
	List<Sale> selectJoongoByDongne2(@Param("dongne1") String dongne1, @Param("dongne2") String dongne2, @Param("cri") Criteria cri);
	

	int listCount();
	int listCount1(@Param("dongne1") String dongne1);
	int listCount2(@Param("dongne1") String dongne1, @Param("dongne2") String dongne2);
	
	int insertJoongoSale(Sale sale);
}
