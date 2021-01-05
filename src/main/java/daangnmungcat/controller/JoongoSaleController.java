package daangnmungcat.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.Sale;
import daangnmungcat.mapper.JoongoSaleMapper;
import daangnmungcat.service.JoongoSaleService;

@Controller
public class JoongoSaleController {

	@Autowired
	private JoongoSaleService service;
	
	@Autowired
	private JoongoSaleMapper mapper;
	
	@RequestMapping(value="detailList", method=RequestMethod.GET)
	public String listById(@RequestParam int id, @RequestParam String memId, Model model) {
		List<Sale> list = service.getListsById(id);
		List<Sale> mlist = service.getListByMemID(memId);
		model.addAttribute("list", list);
		String ok =  "ok";
		if(mlist.size() == 1) {
			System.out.println("한개");
			model.addAttribute("emptylist", ok);
		}
		model.addAttribute("mlist", mlist);
//		mlist.stream().forEach(System.out::println);
		list.stream().forEach(System.out::println);
		service.JSHits(id);
		return "/joongoSale/detailList";
	}
	
	@GetMapping("/heart")
	public String updateLike(HttpServletRequest req, Model model) {
		System.out.println("좋아요?");
		int id = 0;
		String res = (String) req.getParameter("id");
		if(res != null) {
			id = Integer.parseInt(res);
//			System.out.println("최종 id -> "  + id);
		}
		String memId = req.getParameter("memId");
		mapper.updateHeart(id, memId);
		
		String textUrl = "detailList?id="+id+"&"+"memId="+memId;
		model.addAttribute("msg","찜 설정하였습니다..");
		model.addAttribute("url", textUrl);
		
		return "joongoSale/alertFrom";
		
	}
	@GetMapping("/unheart")
	public String updateUnLike(HttpServletRequest req, Model model) {
		System.out.println("안좋아요?");
		int id = 0;
		String res = (String) req.getParameter("id");
		if(res != null) {
			id = Integer.parseInt(res);
//			System.out.println("최종 id -> "  + id);
		}
		String memId = req.getParameter("memId");
		mapper.updateUnHeart(id, memId);
		
		String textUrl = "detailList?id="+id+"&"+"memId="+memId;
		model.addAttribute("msg","찜 해제하였습니다..");
		model.addAttribute("url", textUrl);
		return "joongoSale/alertFrom";
		
	}
}
