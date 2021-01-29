package daangnmungcat.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Sale;
import daangnmungcat.service.JoongoSaleService;

@Controller
public class AdminJoongoSaleController {
	
	@Autowired
	private JoongoSaleService service;
	
	@GetMapping("/admin/joongo/list")
	public String list(Model model, Criteria cri) {
		List<Sale> list = service.selectJoongoByAllPage(cri);
		
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/joongo/joongo_list";
	}
}
