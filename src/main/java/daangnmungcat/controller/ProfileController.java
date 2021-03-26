package daangnmungcat.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.PageMaker;
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
		
		// select가 이상함. joongo_image 제대로 안 걸러짐.
		Criteria cri = new Criteria(1, 8);
		List<Sale> saleList = saleService.getListsByStateAndMember("ALL", memberId, cri);
		
		model.addAttribute("member", member);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("countReviewList", countReviewList);	
		model.addAttribute("saleList", saleList);
		
		return "/profile/profile_view";
	}
	
	@GetMapping("/edit")
	public String profileEditView(AuthInfo loginUser, Model model) {
		
		return "/profile/profile_edit_view";
	}
	
	@GetMapping("/{memberId}/review")
	public String profileReviewView(@PathVariable(name = "memberId") String memberId, @RequestParam(name = "writer", required = false) String writer, Model model) {
		
		Member member = memberService.selectMemberById(memberId);
		
		List<SaleReview> reviewList = null;
		
		if(writer == null) {
			reviewList = reviewService.getReviewListOnMe(memberId);
		} else if(writer.equalsIgnoreCase("seller")) {
			reviewList = reviewService.getSellersReviewOnMe(memberId);
		} else if(writer.equalsIgnoreCase("buyer")) {
			reviewList = reviewService.getBuyersReviewOnMe(memberId);
		} else {
			reviewList = reviewService.getReviewListOnMe(memberId);
		}
		
		int countReviewList = reviewList.size();
		
		model.addAttribute("member", member);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("countReviewList", countReviewList);
		
		return "/profile/profile_review_list";
	}
	
	
	@GetMapping("/{memberId}/joongo")
	public String profileJoongoView(@PathVariable(name = "memberId") String memberId, @RequestParam(name = "state", required = false) String state, Criteria cri, Model model) {
		
		log.info("cri: " + cri.toString());
		System.out.println("stae: " + state);
		
		Member member = memberService.selectMemberById(memberId);
		
		List<Sale> saleList = saleService.getListsByStateAndMember(state, memberId, cri);
		int total = saleService.countsByStateAndMember(state, memberId);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(total);
		
		model.addAttribute("member", member);
		model.addAttribute("saleList", saleList);
		model.addAttribute("total", total);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/profile/profile_joongo_list";
	}
	
	
	@PostMapping("/{memberId}")
	@ResponseBody
	public ResponseEntity<Object> modifyProfile(@PathVariable(name = "memberId") String memberId, Member member, MultipartFile uploadImage, @RequestParam boolean isChanged, AuthInfo loginUser, HttpSession session) {
		String id = null;
		try {
			log.info(member.toString());
			log.info("파일 변경? " + isChanged);
			log.info("uploadFile: " + (uploadImage.isEmpty() ? "null" : uploadImage.getOriginalFilename()));
			
			id = memberService.modifyProfile(member, uploadImage, getRealPath(session), isChanged);
			loginUser.setNickname(member.getNickname());
			loginUser.setProfilePic(member.getProfilePic());
			
		} catch(RuntimeException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(id);
	}
	
	
	private File getRealPath(HttpSession session) {
		return new File(session.getServletContext().getRealPath("")); 
	}
}
