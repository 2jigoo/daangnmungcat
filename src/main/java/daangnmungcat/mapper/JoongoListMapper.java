package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Sale;

public interface JoongoListMapper {
	List<Sale> selectJoongoByAll();
	
	List<Sale> selectJoongoByDongne1();
}
