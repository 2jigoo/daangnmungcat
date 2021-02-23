package daangnmungcat.controller.admin;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Dongne1;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Sale;
import daangnmungcat.service.JoongoSaleService;

@Controller
public class AdminJoongoSaleController {
	
	@Autowired
	private JoongoSaleService service;
	
	@GetMapping("/admin/joongo/list")
	public String list(Model model, Criteria cri, @RequestParam @Nullable String name, @RequestParam @Nullable String category, @RequestParam @Nullable String id, @RequestParam @Nullable String dongne1, @RequestParam @Nullable String dongne2) {
		List<Sale> list = Collections.emptyList();
		System.out.println(cri);
		
		if (name != null || category != null || id != null || dongne1 != null) {
			Sale sale = new Sale();
			if(name != null) {
				sale.setTitle(name);
			}
			if(id != null) {
				sale.setMember(new Member(id));
			}
			if(dongne1 != null) {
				sale.setDongne1(new Dongne1(0, dongne1));
				sale.setDongne2(new Dongne2(0, null, dongne2));
			}
			if (category != null) {
				if (category.equals("멍")) {
					sale.setDogCate("y");
				} else if (category.equals("냥")) {
					sale.setCatCate("y");
				} else if (category.equals("모두")) {
					sale.setDogCate("y");
					sale.setCatCate("y");
				}
			}
			
			list = service.getListsSearchedBy(sale, cri);
			
		} else {
			list = service.getLists(cri);
		}
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/joongo/joongo_list";
	}
	
	@GetMapping("joongoSale/admin/delete")
	public String adminSaleDelete(HttpSession session, Model model, @RequestParam int id) {
		service.deleteJoongoSale(id);
		return "redirect:/admin/joongo/list";
	}
	
}
