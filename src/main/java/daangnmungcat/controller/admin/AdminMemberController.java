package daangnmungcat.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.Dongne1;
import daangnmungcat.dto.Dongne2;
import daangnmungcat.dto.Grade;
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
	public String memberListPage(SearchCriteria scri, String grade, String dongne1, String dongne2, Model model) {
		log.info("scri: " + scri);
		
		Member member = new Member();
		
		if(dongne1 != null && dongne1.length() != 0) {
			member.setDongne1(new Dongne1(Integer.parseInt(dongne1)));
		}
		if(dongne2 != null && dongne2.length() != 0) {
			member.setDongne2(new Dongne2(Integer.parseInt(dongne2)));
		}
		if(grade != null && grade.length() != 0) {
			member.setGrade(new Grade(grade));
		}
		
		log.info("member: " + member.getDongne1() + ", " + member.getDongne2() + ", " + member.getGrade());
		
		int total = memberService.getTotalBySearch(scri, member);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(total);
		
		List<Member> list = memberService.search(scri, member);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/member/member_list";
	}
	
	@GetMapping("/admin/member/detail/{id}")
	public String memberInfoViewPage() {
		return "/admin/member/member_detail";
	}

}
