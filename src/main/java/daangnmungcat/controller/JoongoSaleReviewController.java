package daangnmungcat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Sale;
import daangnmungcat.dto.SaleReview;
import daangnmungcat.service.JoongoSaleReviewService;
import daangnmungcat.service.JoongoSaleService;
import daangnmungcat.service.MemberService;

@Controller
public class JoongoSaleReviewController {
	
	@Autowired
	private JoongoSaleReviewService service;
	
	@Autowired
	private JoongoSaleService saleService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/joongo/review/list")
	public String listReive(Model model, @RequestParam @Nullable String memId) {
		if (memId != null) {
			List<SaleReview> list = service.getBuyersReviewOnMe(memId);
			Member saleMember = memberService.selectMemberById(memId);
			int countMemId = service.countReviewListOfMySales(memId);
			
			model.addAttribute("list", list);
			model.addAttribute("saleMember", saleMember);
			model.addAttribute("countMemId", countMemId);
		}
		return "joongoSale/review_list";
	}
	
	@GetMapping("/mypage/joongo/review/list")
	public String mypageListReive(Model model, @RequestParam @Nullable String memId) {
		if (!memId.equals("")) {
			Member member = memberService.selectMemberById(memId);
			List<SaleReview> reviewList = service.getReviewListOnMe(memId);
			int countReviewList = reviewList.size();
			
			model.addAttribute("member", member);
			model.addAttribute("reviewList", reviewList);
			model.addAttribute("countReviewList", countReviewList);
		}
		return "joongoSale/review_list";
	}
	
	@GetMapping("/joongo/review/write")
	public String insertViewJoongoReview(Model model, @RequestParam @Nullable String saleId, AuthInfo loginUser) {
		if (saleId != null) {
			SaleReview review = service.getReviewBySaleId(Integer.parseInt(saleId), loginUser.getId());
			model.addAttribute("review", review);
			
			Sale sale = saleService.getSaleById(Integer.parseInt(saleId));
			model.addAttribute("sale", sale);
		}
		
		return "joongoSale/review_write";
	}
	
	@PostMapping("/joongo/review/write")
	public ResponseEntity<Object> insertJoongoReview(@RequestBody SaleReview review){
		try {
			System.out.println("리뷰 쓰기");
			System.out.println(review);
			return ResponseEntity.ok(service.writeReview(review));
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	@GetMapping("/joongo/review/update")
	public String updateViewJoongoReview(Model model, @RequestParam @Nullable String id) {
		if (id != null) {
			SaleReview review = service.getReviewByReviewId(Integer.parseInt(id));
			model.addAttribute("review", review);
		}
		
		return "joongoSale/review_update";
	}
	
	@PostMapping("/joongo/review/update")
	public ResponseEntity<Object> updateJoongoReview(@RequestBody SaleReview review) {
		try {
			return ResponseEntity.ok(service.modifyReview(review));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	@PostMapping("/joongo/review/delete")
	public ResponseEntity<Object> deleteJoongoReview(@RequestBody SaleReview review) {
		try {
			return ResponseEntity.ok(service.deleteReview(review.getId()));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
}
