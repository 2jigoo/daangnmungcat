package daangnmungcat.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.FileForm;
import daangnmungcat.dto.Sale;

@Service
public interface JoongoSaleService {
	List<Sale> getLists();
	
	List<Sale> getListsById(@Param("id")int id);
	
	List<Sale> getListByMemID(@Param("memId")String memId);
	
	void JSHits(int id);
	
	int insertJoongoSale(Sale sale) throws Exception;	
}
