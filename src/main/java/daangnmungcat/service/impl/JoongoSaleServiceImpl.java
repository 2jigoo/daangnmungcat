package daangnmungcat.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.FileForm;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;
import daangnmungcat.dto.SaleState;
import daangnmungcat.exception.AlreadySoldOut;
import daangnmungcat.mapper.FileFormMapper;
import daangnmungcat.mapper.JoongoListMapper;
import daangnmungcat.mapper.JoongoSaleMapper;
import daangnmungcat.service.ChatService;
import daangnmungcat.service.JoongoSaleService;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class JoongoSaleServiceImpl implements JoongoSaleService {
	
	protected static final Log log = LogFactory.getLog(JoongoSaleServiceImpl.class);
	
	@Autowired
	private JoongoSaleMapper mapper;
	
	@Autowired
	private JoongoListMapper joongoListMapper;
	
	@Autowired
	private FileFormMapper fileMapper;
	
	@Autowired
	private ChatService chatService;
	

	/* 중고상품 리스트 구하는 메서드 */
	
	/**
	 * 조건 없이 DB에 저장된 모든 중고상품 리스트 반환.
	 */
	@Override
	public List<Sale> getLists() {
		List<Sale> list = mapper.selectJoongoSaleByAll();
		setChatCount(list);
		
		return list;
	}
	
	/**
	 * dongne1에 해당하는 중고상품 리스트 반환. (페이징 포함)
	 */
	@Override
	public List<Sale> getLists(String dongne1, Criteria cri) {
		List<Sale> list = joongoListMapper.selectJoongoByDongne1(dongne1, cri);
		setChatCount(list);
		return list;
		
	}
	
	/**
	 * dongne2에 해당하는 중고상품 리스트 반환. (페이징 포함)
	 */
	@Override
	public List<Sale> getLists(String dongne1, String dongne2, Criteria cri) {
		List<Sale> list = joongoListMapper.selectJoongoByDongne2(dongne1, dongne2, cri);
		setChatCount(list);
		return list;
	}

	@Override
	@Transactional
	public Sale getSaleById(int id) {
		JSHits(id);
		Sale sale = mapper.selectJoongoSaleById(id);
		sale.setChatCount(chatService.getChatCounts(id)); // 채팅수 set
		//이미지들 구해와서 set
		return sale;
	}

	@Override
	public List<Sale> getListByMemID(String memId) {
		List<Sale> mlist = mapper.selectJoongoSalesByMemId(memId);
		setChatCount(mlist);
		return mlist;
	}

	@Override
	public void JSHits(int id) {
		mapper.JSaleHits(id);
	}

	@Override
	public int insertJoongoSale(Sale sale, MultipartFile[] fileList, MultipartFile file,
			HttpServletRequest request) throws Exception {
		
		int res = joongoListMapper.insertJoongoSale(sale);

		String uploadFolder = getFolder(request);
		System.out.println("uploadPath:" + uploadFolder);
		
		File uploadPath = new File(uploadFolder, getFolder(request));
		
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		/*	
		 * 
		  	파일명에 글 id 붙이기
			int num = listMapper.nextID() -1;
		*/
		int cnt = 2;
		
		//썸네일 이미지 추가
			try {
				String thumFileName = "1_" + file.getOriginalFilename().trim();
				FileForm thumFileForm = new FileForm();
				thumFileForm.setSale(sale);
				thumFileForm.setFileName("upload/joongosale/"+thumFileName);
				thumFileForm.setThumName("upload/joongosale/"+thumFileName);
				fileMapper.insertSaleFile(thumFileForm);
				file.transferTo(new File(uploadFolder, thumFileName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
		// 상세 이미지 추가
		for (MultipartFile multipartFile : fileList) {
			
			if(multipartFile.isEmpty() == false) {
				String uploadFileName = multipartFile.getOriginalFilename();
				uploadFileName = cnt + "_" + uploadFileName.trim();
				
				File saveFile = new File(uploadFolder, uploadFileName);
				
				//db저장
				FileForm fileForm = new FileForm();
				fileForm.setSale(sale);
				fileForm.setFileName("upload/joongosale/"+uploadFileName);
				res += fileMapper.insertSaleFile(fileForm);
				
				try {
					multipartFile.transferTo(saveFile);
					cnt++;
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return res;
	}

	private String getFolder(HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("resources\\upload\\joongosale");
		return path;
	}

		
	public List<FileForm> selectImgPath(int id) {
		List<FileForm> fileForm = fileMapper.selectImgPath(id);
		return fileForm;
	}
	
	
	@Override
	public int deleteSaleFile(String fileName) {
		return fileMapper.deleteSaleFile(fileName);
	}

	@Override
	public int updateJoongoSale(Sale sale, MultipartFile[] fileList, MultipartFile  file, HttpServletRequest request) throws Exception {
		int res = joongoListMapper.updateJoongoSale(sale);

		String uploadFolder = getFolder(request);
		
		//UUID uuid = UUID.randomUUID();
		List<FileForm> list = fileMapper.selectImgPath(sale.getId());
		
		
		//썸네일 이미지 정정 
		if(file.getSize() != 0) {
			try {
				String thumFileName = "1_" + file.getOriginalFilename().trim();
				FileForm thumFileForm = new FileForm();
				thumFileForm.setSale(sale);
				thumFileForm.setFileName("upload/joongosale/" + thumFileName);
				thumFileForm.setThumName("upload/joongosale/" + thumFileName);
				fileMapper.insertSaleFile(thumFileForm);
				file.transferTo(new File(uploadFolder, thumFileName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		
		
		// 상세 이미지 추가
		for (MultipartFile multipartFile : fileList) {
			if(multipartFile.isEmpty() == false) {
				String uploadFileName = multipartFile.getOriginalFilename().trim();
				int num = list.size() + 1;
				uploadFileName = num + "_" + uploadFileName;
					
				File saveFile = new File(uploadFolder, uploadFileName);
	
				//파일 db저장 
				FileForm fileForm = new FileForm();
				fileForm.setSale(sale);
				fileForm.setFileName("upload/joongosale/"+uploadFileName);
				
				res += fileMapper.insertSaleFile(fileForm);
				
				try {
					multipartFile.transferTo(saveFile);
					num++;
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return res;
	}
	
	@Override
	public FileForm selectThumImgPath(int id) {
		return fileMapper.selectThumImgPath(id);
	}

	@Override
	public int deleteSaleFileBySaleId(int id) {
		return fileMapper.deleteSaleFileBySaleId(id);
	}
	
	@Override
	public int getHeartedCounts(String memberId) {
		int count = joongoListMapper.selectHeartedJoongoCountsByMemberId(memberId);
		return count;
	}
	
	@Override
	public List<Sale> getHeartedList(String memberId, Criteria criteria) {
		List<Sale> list = joongoListMapper.selectHeartedJoongoByMemberIdWithPaging(memberId, criteria);
		setChatCount(list);
		return list;
	}

	/**
	 * 전체 중고상품 리스트 반환. (페이징 포함)
	 */
	@Override
	public List<Sale> getLists(Criteria cri) {
		List<Sale> list = joongoListMapper.selectJoongoByAllPage(cri);
		setChatCount(list);
		return list;
	}

	/* -- PageMaker 사용시 해당 리스트 count -- */
	
	@Override
	public int listCount() {
		return joongoListMapper.listCount();
	}
	
	@Override
	public int listCountByDongne1(String dongne1) {
		return joongoListMapper.listCount1(dongne1);
	}
	
	@Override
	public int listCountByDongne2(String dongne1, String dongne2) {
		return joongoListMapper.listCount2(dongne1, dongne2);
	}
	
	/* -- end of count methods -- */
	
	
	/**
	 * 판매완료 처리
	 */
	@Override
	public int soldOut(Member buyMember, Sale sale) {
		if(sale.getSaleState() == SaleState.SOLD_OUT) {
			throw new AlreadySoldOut("이미 거래가 완료된 중고판매글입니다.");
		}
		sale.setBuyMember(buyMember);
		int res = joongoListMapper.updateSold(sale);
		return res == 1 ? sale.getId() : 0;
	}
	
	@Override
	public int changeSaleState(Sale sale) {
		int res = joongoListMapper.updateSold(sale);
		return res;
	}
	
	
	/**
	 * 검색 조건에 부합하는 중고상품 목록 반환. (페이징 포함)
	 */
	@Override
	public List<Sale> getListsSearchedBy(Sale sale, Criteria cri) {
		List<Sale> list = joongoListMapper.selectJoongoBySearch(sale, cri);
		setChatCount(list);
		return list;
	}

	
	/**
	 *  받은 List에 setChatCount 처리. (해당 상품글에 대해 개설된 채팅방 수)
	 */
	public void setChatCount(List<Sale> list) {
		System.out.println(list);
		list.forEach(sale -> sale.setChatCount(chatService.getChatCounts(sale.getId())));
		list.forEach(sale -> log.debug(sale.getId() + ": " + sale.getChatCount()));
	}

	@Override
	public int deleteJoongoSale(int id) {
		fileMapper.deleteSaleFileBySaleId(id);
		return joongoListMapper.deleteJoongoSale(id);
	}

	@Override
	public int listSearchCount(Sale sale) {
		return joongoListMapper.listSearchCount(sale);
	}

	
}