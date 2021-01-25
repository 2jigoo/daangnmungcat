package daangnmungcat.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

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
		List<MallCate> dogCate = service.dogCateList();
		List<MallCate> catCate = service.catCateList();
		
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
	
	//카테고리
	@GetMapping("/dog_cate")
	public ResponseEntity<Object> dogCate() {
		return ResponseEntity.ok(service.dogCateList());
	}
	
	@GetMapping("/cat_cate")
	public ResponseEntity<Object> catCate() {
		return ResponseEntity.ok(service.catCateList());
	}
	
	//리스트
	@GetMapping("/mall/product/list/all")
	public ModelAndView allProduct() {
		ModelAndView view = new ModelAndView();
		//view.setViewName("/mall/mall_dog_list");
		
		List<MallProduct> list = service.selectProductByAll();
		view.addObject("list", list);
		return view;
	}
	
	@GetMapping("/mall/product/list/{cate}")
	public ModelAndView catProduct(@PathVariable String cate) {
		ModelAndView view = new ModelAndView();
		List<MallProduct> list = null;
		String name = null; 
		String parameter = null;
		System.out.println(cate);
		
		if(cate.equals("cat")) {
			list = service.selectCatByAll();
			name = "고양이";
			parameter = "cat";
		}else if(cate.equals("dog")) {
			list = service.selectDogByAll();
			name = "강아지";
			parameter = "dog";
		}else if(cate.equals("all")) {
			list = service.selectProductByAll();
		}
		
		view.addObject("name", name);
		view.addObject("kind", parameter);
		view.setViewName("/mall/mall_list");
		view.addObject("list", list);
		return view;
	}
	
	@GetMapping("/mall/product/list/{cate}/{id}")
	public ModelAndView catProductById(@PathVariable int id, @PathVariable String cate) {
		ModelAndView view = new ModelAndView();
		view.setViewName("/mall/mall_list");
		List<MallProduct> list = null;
		String name = null; 
		String parameter = null;
		if(cate.equals("cat")) {
			list = service.catProductListByCate(id);
			name = "고양이";
			parameter = "cat";
		}else if(cate.equals("dog")) {
			list = service.dogProductListByCate(id);
			name = "강아지";
			parameter = "dog";
		}
		view.addObject("name", name);
		view.addObject("kind", parameter);
		view.addObject("list", list);
		return view;
	}
	
	@GetMapping("/mall/product/{id}")
	public ModelAndView catProductById(@PathVariable int id) {
		ModelAndView view = new ModelAndView();
		MallProduct pdt = service.getProductById(id);
		System.out.println(pdt);
		view.addObject("pdt", pdt);
		view.setViewName("/mall/mall_detail");
		return view;
	}
	
}
