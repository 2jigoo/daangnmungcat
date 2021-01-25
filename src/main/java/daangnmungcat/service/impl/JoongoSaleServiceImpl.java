  
package daangnmungcat.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.FileForm;
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
	private FileFormMapper FileMapper;
	
	@Autowired
	private JoongoListMapper ListMapper;
	
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
		ListMapper.insertJoongoSale(sale);
		return 1;
	}
	
}