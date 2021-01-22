  
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
	public List<FileForm> getSaleFileInfo(Sale sale) throws Exception {
		 List<MultipartFile> files = sale.getFiles();
		 List<FileForm> saleFileList = new ArrayList<FileForm>();
		 FileForm fileForm  = new FileForm();
		
		 int saleId = sale.getId();
		 String fileName = null;
		 String fileExt = null;
		 String fileNameKey = null;
		 String filePath = "resources\\upload\\profile";
		 
		 if(files != null && files.size() > 0) {
			 File file = new File(filePath);
			 
			 //디렉토리가 없으면 생성
			 if(file.exists() == false) {
				 file.mkdir();
			 }
			 
			 for(MultipartFile multipartFile : files) {
				 fileName = multipartFile.getOriginalFilename();
				 fileExt = fileName.substring(fileName.lastIndexOf("."));
				  // 파일명 변경(uuid로 암호화) + 확장자
	             // fileNameKey = getRandomString() + fileExt;
				 fileNameKey = fileName + fileExt;
				 
				 //설정한  path에 파일 저장
				 file = new File(filePath + "/" + fileNameKey);
				 
				 multipartFile.transferTo(file);
				 
				 fileForm = new FileForm();
				 fileForm.setSale(sale);
				 fileForm.setFileName(fileName);
				 fileForm.setFileNameKey(fileNameKey);
				 fileForm.setFilePath(filePath);
				 saleFileList.add(fileForm);
			 }
		 }
		 
		return saleFileList;
	}

	@Override
	public int insertJoongoSale(Sale sale) throws Exception {

		ListMapper.insertJoongoSale(sale);
		
		List<FileForm> filList = getSaleFileInfo(sale);
		for(FileForm fileForm : filList) {
			FileMapper.insertSaleFile(fileForm);
		}
		return 1;
	}

}