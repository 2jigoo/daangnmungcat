package daangnmungcat.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

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
	public String memberListPage(SearchCriteria scri, String grade, String dongne1, String dongne2, String state, Model model) {
		log.info("컨트롤러 처음 받아 온 scri: " + scri);
		
		if(scri.getPerPageNum() == scri.DEFAULT_PERPAGE_NUM) {
			scri.setPerPageNum(10);
		}
		
		Map<String, String> paramsMap = new HashMap<>();
		paramsMap.put("grade", grade);
		paramsMap.put("dongne1", dongne1);
		paramsMap.put("dongne2", dongne2);
		paramsMap.put("state", state);
		scri.setParams(paramsMap);
		
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
		if(state != null && state.length() != 0) {
			member.setUseYn(state);
		}
		
		log.info("member: " + member.getDongne1() + ", " + member.getDongne2() + ", " + member.getGrade() + ", " + member.getUseYn());
		
		int total = memberService.getTotalBySearch(scri, member);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(total);
		
		List<Member> list = memberService.search(scri, member);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("dongne1", dongne1);
		model.addAttribute("dongne2", dongne2);
		model.addAttribute("grade", grade);
		
		log.info("페이징 계산 끝난 scri: " + scri);
		
		return "/admin/member/member_list";
	}
	
	@GetMapping("/admin/member/detail")
	public String memberInfoViewPage(String id) {
		return "/admin/member/member_detail";
	}

}
