package daangnmungcat.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

<<<<<<< HEAD
import daangnmungcat.dto.Criteria;
=======
import daangnmungcat.dto.FileForm;
>>>>>>> branch 'master' of https://github.com/ssuktteok/daangnmungcat
import daangnmungcat.dto.Sale;

@Service
public interface JoongoSaleService {
	List<Sale> getLists();
	
	List<Sale> getListsById(@Param("id")int id);
	
	List<Sale> getListByMemID(@Param("memId")String memId);
	
	void JSHits(int id);

	int insertJoongoSale(Sale sale) throws Exception;	
	
	
	// 해당 회원의 페이징된 찜 목록
	List<Sale> getHeartedList(String memberId, Criteria criteria);
	
}
