package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Sale;

public interface JoongoListMapper {
	List<Sale> selectJoongoByAll();
	
	List<Sale> selectJoongoByDongne1(String dongne1);

	List<Sale> selectJoongoByDongne2(@Param("dongne1") String dongne1, @Param("dongne2") String dongne2);
	
	int insertJoongoSale(Sale sale);

}
