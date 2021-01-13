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

import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;
import daangnmungcat.mapper.JoongoHeartMapper;
import daangnmungcat.mapper.JoongoSaleMapper;
import daangnmungcat.service.JoongoSaleService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class JoongoSaleController {

	@Autowired
	private JoongoSaleService service;

	@Autowired
	private JoongoHeartMapper mapper;

	@Autowired
	private JoongoSaleMapper Smapper;

	@RequestMapping(value = "detailList", method = RequestMethod.GET)
	public String listById(@RequestParam int id, Model model, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			// 무조건 하트 0으로 설정
			List<Sale> list = service.getListsById(id);
			String memId = list.get(0).getMember().getId();
			List<Sale> mlist = service.getListByMemID(memId);
			model.addAttribute("list", list);
				if (mlist.size() == 1) {
					model.addAttribute("emptylist", 1);
				}
			model.addAttribute("mlist", mlist);
//		list.stream().forEach(System.out::println);
			service.JSHits(id);
			model.addAttribute("isLiked", 1);
		} else {
			List<Sale> list = service.getListsById(id);
			String memId = list.get(0).getMember().getId();
			List<Sale> mlist = service.getListByMemID(memId);
			model.addAttribute("list", list);
				if (mlist.size() == 1) {
					model.addAttribute("emptylist", 1);
				}
			model.addAttribute("mlist", mlist);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("memId", loginUser.getId());
				if (mapper.countHeart(map) == 0) {
	//				System.out.println("좋아요안되있는상태");
					model.addAttribute("isLiked", 1);
				}
		}
		return "/joongoSale/detailList";
	}

	@GetMapping("/heart")
	public String heart(HttpSession session, HttpServletRequest req, Model model, @RequestParam int id) {
		Member loginUser = (Member) session.getAttribute("loginUser");
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

				String textUrl = "detailList?id=" + id;
				model.addAttribute("msg", "찜 처리하였습니다.");
				model.addAttribute("url", textUrl);
			}

		}
		return "/joongoSale/alertFrom";

	}

	@GetMapping("/heartNo")
	public String heartNo(HttpSession session, HttpServletRequest req, Model model, @RequestParam int id) {
		Member loginUser = (Member) session.getAttribute("loginUser");
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("memId", loginUser.getId());
			mapper.deleteHeart(map);
			Smapper.deletehearCount(id);
			String textUrl = "detailList?id=" + id;
			model.addAttribute("msg", "찜 해제하였습니다.");
			model.addAttribute("url", textUrl);
			return "/joongoSale/alertFrom";
		}
	}

