package daangnmungcat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;
import daangnmungcat.dto.SaleReview;
import daangnmungcat.service.JoongoSaleReviewService;
import daangnmungcat.service.JoongoSaleService;
import daangnmungcat.service.MemberService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/profile")
public class ProfileController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JoongoSaleService saleService;
	
	@Autowired
	private JoongoSaleReviewService reviewService;
	
	
	@GetMapping("/{memberId}")
	public String profileView(@PathVariable(name = "memberId") String memberId, Model model) {
		
		Member member = memberService.selectMemberById(memberId);
		List<SaleReview> reviewList = reviewService.getReviewListOnMe(memberId);
		int countReviewList = reviewList.size();

		Sale saleCondition = new Sale();
		saleCondition.setMember(new Member(memberId));
		
		Criteria cri = new Criteria(1, 8);
		List<Sale> saleList = saleService.getListsSearchedBy(saleCondition, cri);
		
		model.addAttribute("member", member);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("countReviewList", countReviewList);
		model.addAttribute("saleList", saleList);
		
		return "/profile/profile_view";
	}
	
	
}
