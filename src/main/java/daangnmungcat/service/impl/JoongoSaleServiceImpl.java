package daangnmungcat.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Criteria;
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
	private JoongoListMapper joongoListMapper;
	
	@Autowired
	private JoongoListMapper listMapper;
	
	@Autowired
	private FileFormMapper fileMapper;
	
	
	@Override
	public List<Sale> getLists() {
		List<Sale> list = mapper.selectJoongoSaleByAll();
		log.debug("service - getLists() >>>>" + list.size());
		return list;
	}

	@Override
	@Transactional
	public Sale getSaleById(int id) {
		JSHits(id);
		Sale sale = mapper.selectJoongoSaleById(id);
		//이미지들 구해와서 set
		return sale;
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
		
		int res = listMapper.insertJoongoSale(sale);

		String uploadFolder = getFolder(request);
		System.out.println("uploadPath:" + uploadFolder);
		
		File uploadPath = new File(uploadFolder, getFolder(request));
		
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		//UUID uuid = UUID.randomUUID();
		int num = listMapper.nextID() -1;
		int cnt = 1;
		
		// 상세 이미지 추가
		for (MultipartFile multipartFile : fileList) {
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = cnt + "_" + num;
				
			String thumFileName = "1_"+num;
			File saveFile = new File(uploadFolder, uploadFileName);

			//파일 db저장 
			FileForm fileForm = new FileForm();
			fileForm.setSale(sale);
			fileForm.setFileName("upload/joongosale/"+uploadFileName);
			
			//첫번째 등록사진이라면
			if(uploadFileName.equals(thumFileName) == true) { 
				fileForm.setThumName("upload/joongosale/"+thumFileName);
			}
			
			res += fileMapper.insertSaleFile(fileForm);
			
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
		
		if(res != (fileList.length + 1)) {
			throw new RuntimeException(); // 업로드 갯수 불일치
		}
		
		return res;
	}

	private String getFolder(HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("resources\\upload\\joongosale");
		return path;
	}

		
	public List<FileForm> selectImgPath(int id) {
		List<FileForm> fileForm = fileMapper.selectImgPath(id);
		System.out.println(fileForm);
		return fileForm;
	}
	
	
	@Override
	public List<Sale> getHeartedList(String memberId, Criteria criteria) {
		List<Sale> list = listMapper.selectHeartedJoongoByMemberIdWithPaging(memberId, criteria);
		return list;
	}

	@Override
	public List<Sale> selectJoongoByAllPage(Criteria cri) {
		return joongoListMapper.selectJoongoByAllPage(cri);
	}

	@Override
	public int listCount() {
		return joongoListMapper.listCount();
	}

	@Override
	public List<Sale> selectJoongoBySearch(Sale sale, Criteria cri) {
		return joongoListMapper.selectJoongoBySearch(sale, cri);
	}

	@Override
	public int deleteSaleFile(String fileName) {
		return fileMapper.deleteSaleFile(fileName);
	}

	@Override
	public int updateJoongoSale(Sale sale, MultipartFile[] fileList, HttpServletRequest request) throws Exception {
		int res = listMapper.updateJoongoSale(sale);

		String uploadFolder = getFolder(request);
		System.out.println("uploadPath:" + uploadFolder);
		
		File uploadPath = new File(uploadFolder, getFolder(request));
		
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		//UUID uuid = UUID.randomUUID();
		List<FileForm> list = fileMapper.selectImgPath(sale.getId());
		int num = list.size() + 1;
		int cnt = 1;
		
		// 상세 이미지 추가
		for (MultipartFile multipartFile : fileList) {
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = num + "_" + sale.getId();
				
			
			//파일 이름이 같으면...
			for(int i=1; i<list.size()+1; i++) {
				if(uploadFileName.equals(list.get(i).getFileName())) {
					num++;
				}
			}
			
			File saveFile = new File(uploadFolder, uploadFileName);

			//파일 db저장 
			FileForm fileForm = new FileForm();
			fileForm.setSale(sale);
			fileForm.setFileName("upload/joongosale/"+uploadFileName);
			
			res += fileMapper.insertSaleFile(fileForm);
			
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
		
		if(res != (fileList.length + 1)) {
			throw new RuntimeException(); // 업로드 갯수 불일치
		}
		
		return res;
	}

	@Override
	public int deleteSaleFileBySaleId(int id) {
		return fileMapper.deleteSaleFileBySaleId(id);
	}


}