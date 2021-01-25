package daangnmungcat.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
		
		try {
			thumbFile.transferTo(new File(uploadFolder, thumbFile.getOriginalFilename()));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 상세 이미지 추가
		for (MultipartFile multipartFile : fileList) {
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
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

}
