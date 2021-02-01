package daangnmungcat.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.FileForm;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Sale;
import daangnmungcat.dto.SaleComment;
import daangnmungcat.mapper.JoongoHeartMapper;
import daangnmungcat.mapper.JoongoSaleMapper;
import daangnmungcat.service.JoongoSaleCommentService;
import daangnmungcat.service.JoongoSaleService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class JoongoSaleController {

	@Autowired
	private JoongoSaleService service;
	
	@Autowired
	private JoongoSaleCommentService commentService;

	@Autowired
	private JoongoHeartMapper mapper;

	@Autowired
	private JoongoSaleMapper Smapper;

	@RequestMapping(value = "joongoSale/detailList", method = RequestMethod.GET)
	public String listById(@RequestParam int id, Model model, HttpSession session, Criteria cri) {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		
		Sale sale = service.getSaleById(id);
		String memId = sale.getMember().getId();
		
		List<Sale> mlist = service.getListByMemID(memId);
		List<FileForm> flist = service.selectImgPath(id);
		
		if (loginUser != null) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("memId", loginUser.getId());
			
			if(mapper.countHeart(map) != 0) {
				sale.setHearted(true);
			}
			
		}
//		list.stream().forEach(System.out::println);
		model.addAttribute("sale", sale);
		model.addAttribute("flist", flist);
		model.addAttribute("mlist", mlist);
		
		// 댓글
		List<SaleComment> commentList = commentService.selectJoongoCommentByAllPage(id, cri);
		model.addAttribute("commentList", commentList);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(commentService.commentCount(id));
		model.addAttribute("pageMaker", pageMaker);
		
		return "/joongoSale/detailList";
	}

	@GetMapping("/heart")
	public String heart(HttpSession session, HttpServletRequest req, Model model, @RequestParam int id) {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		if (loginUser == null) {
			String textUrl = "detailList?id=" + id;
			model.addAttribute("msg", "로그인을 하셔야 합니다.");
			model.addAttribute("url", textUrl);
		} else {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("memId", loginUser.getId());

			if (mapper.countHeart(map) == 0) {
				// 좋아요를 안 눌렀다면
				mapper.insertHeart(map);
				Smapper.inserthearCount(id);

				String textUrl = "/daangnmungcat/joongoSale/detailList?id=" + id;
				model.addAttribute("msg", "찜 처리하였습니다.");
				model.addAttribute("url", textUrl);
			}

		}
		return "/joongoSale/alertFrom";

	}

	@GetMapping("/heartNo")
	public String heartNo(HttpSession session, HttpServletRequest req, Model model, @RequestParam int id) {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("memId", loginUser.getId());
		mapper.deleteHeart(map);
		Smapper.deletehearCount(id);
		String textUrl = "/daangnmungcat/joongoSale/detailList?id=" + id;
		model.addAttribute("msg", "찜 해제하였습니다.");
		model.addAttribute("url", textUrl);
		return "/joongoSale/alertFrom";
	}
	
	
	@GetMapping("/joongo/heart/list")
	public String heartedList(HttpSession session, Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		
		PageMaker pageMaker = new PageMaker();
		Criteria criteria = new Criteria(page, 20);
		pageMaker.setCri(criteria);
		
		List<Sale> list = service.getHeartedList(loginUser.getId(), criteria);
		list.forEach(sale -> log.debug(sale.toString()));
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/joongoSale/sale_hearted_list";
	}
	
}