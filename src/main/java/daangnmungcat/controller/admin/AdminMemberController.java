package daangnmungcat.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import daangnmungcat.dto.Member;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.SearchCriteria;
import daangnmungcat.service.MemberService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class AdminMemberController {

	@Autowired
	private MemberService memberService;
	
	@GetMapping("/admin/member/list")
	public String memberListPage(SearchCriteria scri, Model model) {
		log.info("scri: " + scri);
		
		int total = memberService.getTotalBySearch(scri);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(total);
		
		List<Member> list = memberService.search(scri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/member/member_list";
	}
	
	@GetMapping("/admin/member/detail/{id}")
	public String memberInfoViewPage() {
		return "/admin/member/member_detail";
	}

}
