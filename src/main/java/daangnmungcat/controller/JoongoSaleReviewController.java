package daangnmungcat.controller;

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

import daangnmungcat.dto.Sale;
import daangnmungcat.dto.SaleReview;
import daangnmungcat.service.JoongoSaleReviewService;
import daangnmungcat.service.JoongoSaleService;

@Controller
public class JoongoSaleReviewController {
	
	@Autowired
	private JoongoSaleReviewService service;
	
	@Autowired
	private JoongoSaleService saleService;
	
	@GetMapping("/joongo/review/write")
	public String insertViewJoongoReview(Model model, @RequestParam @Nullable String saleId) {
		if (saleId != null) {
			SaleReview review = service.selectJoongoReviewBySaleId(Integer.parseInt(saleId));
			model.addAttribute("review", review);
			
			Sale sale = saleService.getSaleById(Integer.parseInt(saleId));
			model.addAttribute("sale", sale);
		}
		
		return "joongoSale/review_write";
	}
	
	@PostMapping("/joongo/review/write")
	public ResponseEntity<Object> insertJoongoReview(@RequestBody SaleReview review){
		System.out.println("review : "+ review);
		
		try {
			return ResponseEntity.ok(service.insertJoongoSaleReview(review));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
}
