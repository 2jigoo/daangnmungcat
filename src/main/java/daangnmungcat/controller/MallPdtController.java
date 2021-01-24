package daangnmungcat.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import daangnmungcat.dto.MallCate;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.service.MallCateService;
import daangnmungcat.service.MallPdtService;

@Controller
public class MallPdtController {
	
	@Autowired
	private MallCateService cateService;
	
	@Autowired
	private MallPdtService service;
	
	@GetMapping("/mall/product/write")
	public String insertViewProduct(Model model) {
		List<MallCate> dogCate = cateService.selectByAllDogCate();
		List<MallCate> catCate = cateService.selectByAllCatCate();
		
		model.addAttribute("dogCate", dogCate);
		model.addAttribute("catCate", catCate);
		
		return "/mall/mall_pdt_add";
	}
	
	@PostMapping("/mall/product/write")
	public String insertWriteProduct(MultipartHttpServletRequest mtfRequest, HttpServletRequest request) throws UnsupportedEncodingException {
		
		// 썸네일 이미지
		MultipartFile thumbFile = mtfRequest.getFile("thumb_file");
		// 상세 이미지
		List<MultipartFile> fileList = mtfRequest.getFiles("file");
		
		MallProduct product = new MallProduct();
		
		/*String uploadFolder = getFolder(request);
		System.out.println("uploadPath : "+ uploadFolder);
		
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
		}*/

		product.setDogCate(new MallCate(Integer.parseInt(mtfRequest.getParameter("dogCate")), null));
		product.setCatCate(new MallCate(Integer.parseInt(mtfRequest.getParameter("catCate")), null));
		product.setName(new String(mtfRequest.getParameter("name").getBytes("8859_1"), "utf-8"));
		product.setPrice(Integer.parseInt(mtfRequest.getParameter("price")));
		product.setContent(new String(mtfRequest.getParameter("content").getBytes("8859_1"), "utf-8"));
		product.setSaleYn(mtfRequest.getParameter("saleYn"));
		product.setStock(Integer.parseInt(mtfRequest.getParameter("stock")));
		product.setImage1(thumbFile.getOriginalFilename());
		product.setImage2(fileList.get(0).getOriginalFilename());
		product.setImage3(fileList.get(1).getOriginalFilename());
		product.setDeliveryKind(new String(mtfRequest.getParameter("deliveryKind").getBytes("8859_1"), "utf-8"));
		product.setDeliveryCondition(Integer.parseInt(mtfRequest.getParameter("deliveryCondition")));
		product.setDeliveryPrice(Integer.parseInt(mtfRequest.getParameter("deliveryPrice")));
		
		
		service.insertMallProduct(product, thumbFile, fileList, request);
		
		return "/mall/mall_pdt_add";
	}
	
	private String getFolder(HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("resources\\upload\\product");
		return path;
	}
}
