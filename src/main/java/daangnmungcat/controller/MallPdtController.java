package daangnmungcat.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.MallCate;
import daangnmungcat.dto.MallDelivery;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.service.MallCateService;
import daangnmungcat.service.MallDeliveryService;
import daangnmungcat.service.MallPdtService;

@Controller
public class MallPdtController {
	
	@Autowired
	private MallCateService cateService;
	
	@Autowired
	private MallDeliveryService deliveryService;
	
	@Autowired
	private MallPdtService service;
	
	@GetMapping("/mall/product/write")
	public String insertViewProduct(Model model) {
		List<MallCate> dogCate = cateService.selectByAllDogCate();
		List<MallCate> catCate = cateService.selectByAllCatCate();
		List<MallDelivery> deliveryList = deliveryService.selectDeliveryByAll();
		
		model.addAttribute("dogCate", dogCate);
		model.addAttribute("catCate", catCate);
		model.addAttribute("deliveryList", deliveryList);
		
		return "/admin/product/product_write";
	}
	
	@PostMapping("/mall/product/write")
	public String insertWriteProduct(HttpSession session, MallProduct product, @RequestParam("thumbFile") MultipartFile thumbFile, @RequestParam("file") List<MultipartFile> file) throws UnsupportedEncodingException {
		service.insertMallProduct(product, thumbFile, file, getRealPath(session));

		return "redirect:/admin/product/list";
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
	/*@GetMapping("/mall/product/list/all")
	public ModelAndView allProduct() {
		ModelAndView view = new ModelAndView();
		//view.setViewName("/mall/mall_dog_list");
		
		List<MallProduct> list = service.selectProductByAll();
		view.addObject("list", list);
		return view;
	}*/
	
	@GetMapping("/mall/product/list/{cate}")
	public ModelAndView catProduct(@PathVariable String cate, Criteria cri) {
		ModelAndView view = new ModelAndView();
		List<MallProduct> list = null;
		String name = null; 
		String parameter = null;
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		if(cate.equals("cat")) {
			list = service.selectCatByAll(cri);
			name = "고양이";
			parameter = "cat";
			pageMaker.setTotalCount(service.productCatCount());
		}else if(cate.equals("dog")) {
			list = service.selectDogByAll(cri);
			name = "강아지";
			parameter = "dog";
			pageMaker.setTotalCount(service.productDogCount());
		}else if(cate.equals("all")) {
			list = service.selectProductByAll();
		}
		
		view.addObject("name", name);
		view.addObject("kind", parameter);
		view.setViewName("/mall/mall_list");
		view.addObject("list", list);
		view.addObject("pageMaker", pageMaker);
		return view;
	}
	
	@GetMapping("/mall/product/list/{cate}/{id}")
	public ModelAndView catProductById(@PathVariable int id, @PathVariable String cate, Criteria cri) {
		ModelAndView view = new ModelAndView();
		view.setViewName("/mall/mall_list");
		List<MallProduct> list = null;
		String name = null; 
		String parameter = null;

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		if(cate.equals("cat")) {
			list = service.catProductListByCate(id, cri);
			name = "고양이";
			parameter = "cat";
			pageMaker.setTotalCount(service.productCatCateCount(id));
		}else if(cate.equals("dog")) {
			list = service.dogProductListByCate(id, cri);
			name = "강아지";
			parameter = "dog";
			pageMaker.setTotalCount(service.productDogCateCount(id));
		}
		view.addObject("name", name);
		view.addObject("kind", parameter);
		view.addObject("cateId", id);
		view.addObject("list", list);
		view.addObject("pageMaker", pageMaker);
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
	
	private static File getRealPath(HttpSession session) {
		File realPath = new File(session.getServletContext().getRealPath("resources" + File.separator + "upload" + File.separator + "product"));
		
		if(!realPath.exists()) {
			realPath.mkdirs();
		}
		
		return realPath; 
	}
	
}
