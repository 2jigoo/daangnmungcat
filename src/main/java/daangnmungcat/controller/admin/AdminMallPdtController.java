package daangnmungcat.controller.admin;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import antlr.debug.NewLineEvent;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.MallCate;
import daangnmungcat.dto.MallDelivery;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.service.MallCateService;
import daangnmungcat.service.MallDeliveryService;
import daangnmungcat.service.MallPdtService;

@Controller
public class AdminMallPdtController {
	
	@Autowired
	private MallCateService cateService;
	
	@Autowired
	private MallDeliveryService deliveryService;
	
	@Autowired
	private MallPdtService service;

	@GetMapping("/admin/product/list")
	public String list(Model model, Criteria cri, @RequestParam @Nullable String name, @RequestParam @Nullable String category, @RequestParam @Nullable String saleYn) {
		List<MallProduct> list = new ArrayList<MallProduct>();
		
		if (name != null || category != null || saleYn != null) {
			MallProduct product = new MallProduct();
			if (name != null) {
				product.setName(name);
			}
			if (category != null) {
				product.setDogCate(new MallCate(0, category));
				product.setCatCate(new MallCate(0, category));
			}
			if (saleYn != null) {
				product.setSaleYn(saleYn);
			}
			list = service.selectProductBySearch(product, cri);
		} else {
			list = service.selectProductByAllPage(cri);
		}
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.productCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/product/product_list";
	}
	
	@GetMapping("/admin/product/write")
	public String insertViewProduct(Model model) {
		List<MallCate> dogCate = cateService.selectByAllDogCate();
		List<MallCate> catCate = cateService.selectByAllCatCate();
		List<MallDelivery> deliveryList = deliveryService.selectDeliveryByAll();
		
		model.addAttribute("dogCate", dogCate);
		model.addAttribute("catCate", catCate);
		model.addAttribute("deliveryList", deliveryList);
		
		return "/admin/product/product_write";
	}
	
	@PostMapping("/admin/product/write")
	public String insertWriteProduct(HttpServletRequest request, MallProduct product, @RequestParam("thumbFile") MultipartFile thumbFile, @RequestParam("file") List<MultipartFile> file) throws UnsupportedEncodingException {
		service.insertMallProduct(product, thumbFile, file, request);

		return "redirect:/admin/product/list";
	}
	
	@GetMapping("/admin/product/update")
	public String updateViewProduct(Model model, @RequestParam int id) {
		MallProduct pdt = service.getProductById(id);
		model.addAttribute("pdt", pdt);

		List<MallCate> dogCate = cateService.selectByAllDogCate();
		List<MallCate> catCate = cateService.selectByAllCatCate();
		List<MallDelivery> deliveryList = deliveryService.selectDeliveryByAll();
		
		model.addAttribute("dogCate", dogCate);
		model.addAttribute("catCate", catCate);
		model.addAttribute("deliveryList", deliveryList);
		
		return "/admin/product/product_update";
	}
	
	@PostMapping("/admin/product/update")
	public String updateWriteProduct(HttpServletRequest request, MallProduct product, @RequestParam("thumbFile") MultipartFile thumbFile, @RequestParam("file") List<MultipartFile> file) throws UnsupportedEncodingException {
		service.updateMallProduct(product, thumbFile, file, request);

		return "redirect:/admin/product/list";
	}
	
	@GetMapping("/admin/product/delete")
	public String deleteProduct(@RequestParam int id) {
		service.deleteMallProduct(id);
		return "redirect:/admin/product/list";
	}
}
