package daangnmungcat.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.MallCate;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.mapper.MallPdtMapper;
import daangnmungcat.service.MallPdtService;

@Service
public class MallPdtServiceImpl implements MallPdtService {
	
	@Autowired
	private MallPdtMapper mapper;

	@Override
	public int insertMallProduct(MallProduct product, MultipartFile thumbFile, List<MultipartFile> fileList, HttpServletRequest request) {
		
		String uploadFolder = getFolder(request);
		
		File uploadPath = new File(uploadFolder, getFolder(request));
		
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		UUID uuid = UUID.randomUUID();
		String savedName = null;
		
		// 썸네일 이미지 추가
		if (!thumbFile.isEmpty()) {
			try {
				savedName = uuid.toString() +"_"+ thumbFile.getOriginalFilename();
				product.setImage1("/upload/product/"+ savedName);
				thumbFile.transferTo(new File(uploadFolder, savedName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		
		// 상세 이미지 추가
		if (!fileList.get(0).isEmpty()) {
		int num = 1;
			for (MultipartFile multipartFile : fileList) {
				savedName = uuid.toString() +"_"+ multipartFile.getOriginalFilename();
				if (num == 1) {
					product.setImage2("/upload/product/"+ savedName);
				} else {
					product.setImage3("/upload/product/"+ savedName);
				}
				File saveFile = new File(uploadFolder, savedName);
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
		
		int res = mapper.insertMallProduct(product);
		
		return res;
	}
	
	private String getFolder(HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("resources\\upload\\product");
		return path;
	}

	@Override
	public List<MallProduct> selectProductByAll() {
		return mapper.selectProductByAll();
	}

	@Override
	public List<MallProduct> selectDogByAll() {
		return mapper.selectDogByAll();
	}

	@Override
	public List<MallProduct> selectCatByAll() {
		return mapper.selectCatByAll();
	}

	@Override
	public List<MallCate> dogCateList() {
		return mapper.dogCateList();
	}

	@Override
	public List<MallCate> catCateList() {
		return mapper.catCateList();
	}

	@Override
	public List<MallProduct> dogProductListByCate(int cate) {
		return mapper.dogProductListByCate(cate);
	}

	@Override
	public List<MallProduct> catProductListByCate(int cate) {
		return mapper.catProductListByCate(cate);
	}

	@Override
	public MallProduct getProductById(int id) {
		return mapper.getProductById(id);
	}

	@Override
	public int deleteMallProduct(int id) {
		return mapper.deleteMallProduct(id);
	}

	@Override
	public List<MallProduct> selectProductByAllPage(Criteria cri) {
		List<MallProduct> list = mapper.selectProductByAllPage(cri);
		return list;
	}

	@Override
	public int productCount() {
		return mapper.productCount();
	}

	@Override
	public int updateMallProduct(MallProduct product, MultipartFile thumbFile, List<MultipartFile> fileList, HttpServletRequest request) {
		
		String uploadFolder = getFolder(request);
		
		File uploadPath = new File(uploadFolder, getFolder(request));
		
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		UUID uuid = UUID.randomUUID();
		String savedName = null;
		
		// 썸네일 이미지 추가
		if (!thumbFile.isEmpty()) {
			try {
				savedName = uuid.toString() +"_"+ thumbFile.getOriginalFilename();
				product.setImage1("/upload/product/"+ savedName);
				thumbFile.transferTo(new File(uploadFolder, savedName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		
		// 상세 이미지 추가
		if (!fileList.get(0).isEmpty()) {
		int num = 1;
			for (MultipartFile multipartFile : fileList) {
				savedName = uuid.toString() +"_"+ multipartFile.getOriginalFilename();
				if (num == 1) {
					product.setImage2("/upload/product/"+ savedName);
				} else {
					product.setImage3("/upload/product/"+ savedName);
				}
				File saveFile = new File(uploadFolder, savedName);
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
		
		int res = mapper.updateMallProduct(product);
		
		return res;
	}

}
