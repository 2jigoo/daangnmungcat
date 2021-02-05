package daangnmungcat.controller.admin;

import java.util.ArrayList;
import java.util.List;

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
import daangnmungcat.dto.Mileage;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Sale;
import daangnmungcat.service.JoongoSaleService;
import daangnmungcat.service.MileageService;

@Controller
public class AdminMileageController {
	
	@Autowired
	private MileageService service;
	
	@GetMapping("/admin/mileage/list")
	public String list(Model model, Criteria cri, @RequestParam @Nullable String name, @RequestParam @Nullable String category, @RequestParam @Nullable String id, @RequestParam @Nullable String dongne1, @RequestParam @Nullable String dongne2) {
		List<Mileage> list = new ArrayList<Mileage>();
		list = service.selectMileageByAll(cri);
		model.addAttribute("list", list);
		System.out.println(list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/mileage/mileage_list";
	}
}
