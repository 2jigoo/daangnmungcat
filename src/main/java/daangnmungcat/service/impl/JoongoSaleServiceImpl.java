  
package daangnmungcat.service.impl;

import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Sale;
import daangnmungcat.mapper.FileFormMapper;
import daangnmungcat.mapper.JoongoListMapper;
import daangnmungcat.mapper.JoongoSaleMapper;
import daangnmungcat.service.JoongoSaleService;

@Service
public class JoongoSaleServiceImpl implements JoongoSaleService {
	
	protected static final Log log = LogFactory.getLog(JoongoSaleServiceImpl.class);
	
	@Autowired
	private JoongoSaleMapper mapper;
	
	@Autowired
	private JoongoListMapper listMapper;
	
	private FileFormMapper FileMapper;
	
	
	@Override
	public List<Sale> getLists() {
		List<Sale> list = mapper.selectJoongoSaleByAll();
		log.debug("service - getLists() >>>>" + list.size());
		return list;
	}

	@Override
	public List<Sale> getListsById(int id) {
		List<Sale> list = mapper.selectJoonSaleById(id);
		JSHits(id);
		return list;
	}

	@Override
	public List<Sale> getListByMemID(String memId) {
		List<Sale> mlist = mapper.selectJoongoSalesByMemId(memId);
		return mlist;
	}

	@Override
	public void JSHits(int id) {
		mapper.JSaleHits(id);
	}


	@Override
	public int insertJoongoSale(Sale sale) throws Exception {
		listMapper.insertJoongoSale(sale);
		return 1;
	}
	
	
	@Override
	public List<Sale> getHeartedList(String memberId, Criteria criteria) {
		List<Sale> list = listMapper.selectHeartedJoongoByMemberIdWithPaging(memberId, criteria);
		return list;
	}
	
}