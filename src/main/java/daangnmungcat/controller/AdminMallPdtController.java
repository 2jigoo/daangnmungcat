package daangnmungcat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.service.MallPdtService;

@Controller
public class AdminMallPdtController {
	
	@Autowired
	private MallPdtService service;

	@GetMapping("/admin/mall/product/list")
	public String list(Model model, Criteria cri) {
		List<MallProduct> list = service.selectProductByAllPage(cri);
		list.stream().forEach(System.out::println);
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.productCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/mall/mall_adm_pdt_list";
	}
}
