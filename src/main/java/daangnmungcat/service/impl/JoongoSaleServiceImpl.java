  
package daangnmungcat.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
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
	public int insertJoongoSale(Sale sale, MultipartFile[] fileList,
			HttpServletRequest request) throws Exception {
		
		ListMapper.insertJoongoSale(sale);

		String uploadFolder = getFolder(request);
		System.out.println("uploadPath:" + uploadFolder);
		
		File uploadPath = new File(uploadFolder, getFolder(request));
		
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		//UUID uuid = UUID.randomUUID();
		int num = ListMapper.nextID();
		int cnt = 1;
		// 상세 이미지 추가
			for (MultipartFile multipartFile : fileList) {
				
				String uploadFileName = multipartFile.getOriginalFilename();
				//글 id 붙이기
				uploadFileName = num + "_" + cnt + "_" + uploadFileName;
				File saveFile = new File(uploadFolder, uploadFileName);
				//System.out.println("uploadFileName >> " + uploadFileName);
				//파일 db저장 
				FileForm fileForm = new FileForm();
				fileForm.setSale(sale);
				fileForm.setFileName("upload/joongosale/"+uploadFileName);
				FileMapper.insertSaleFile(fileForm);
				//System.out.println("fileForm >> " + fileForm);
				try {
					multipartFile.transferTo(saveFile);
					cnt++;
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		return 0;
	}

	private String getFolder(HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("resources\\upload\\joongosale");
		return path;
	}

	@Override
	public List<FileForm> selectImgPath(int id) {
		List<FileForm> fileForm= FileMapper.selectImgPath(id);
		System.out.println(fileForm);
		return fileForm;
	}

}