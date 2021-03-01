package daangnmungcat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Sale;
import daangnmungcat.service.JoongoSaleService;
import daangnmungcat.service.MallPdtService;

@Controller
public class SearchController {
	@Autowired
	private JoongoSaleService joongoService;
	
	@Autowired
	private MallPdtService mallService;
	
	@GetMapping("/search")
	public String search(Model model, @RequestParam String type, @RequestParam @Nullable String search, Criteria cri) {
		
		if (type.equals("중고")) {
			Sale sale = new Sale();
			sale.setTitle(search);
			List<Sale> list = joongoService.getListsSearchedBy(sale, cri);
			
			model.addAttribute("list", list);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(joongoService.listCount());
			model.addAttribute("pageMaker", pageMaker);
			
			return "/joongo_list";
		} else if (type.equals("몰")) {
			MallProduct product = new MallProduct();
			product.setName(search);
			List<MallProduct> list = mallService.selectProductBySearch(product, cri);
			
			model.addAttribute("list", list);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(mallService.productCount());
			model.addAttribute("pageMaker", pageMaker);

			System.out.println("search pdt2 : "+ product);
			System.out.println("search pdt : "+ list);
			
			return "/mall/mall_list";
		}
		return null;
	}
}
