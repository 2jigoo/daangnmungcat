package daangnmungcat.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.Address;
import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Cart;
import daangnmungcat.dto.KakaoPayApprovalVO;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.Payment;
import daangnmungcat.service.CartService;
import daangnmungcat.service.KakaoPayService;
import daangnmungcat.service.MallPdtService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.OrderService;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class KakaoPayController {
	
	@Autowired
	private KakaoPayService kakaoService;
	
	@Autowired
	private OrderService orderService;
	
	@GetMapping("/kakao-pay")
	public void kakaoGet(@RequestBody Map<String, String> map,HttpServletRequest request, HttpSession session) {

	}
	
	@PostMapping("/kakao-pay")
	public String kakaoPost(HttpServletRequest request, HttpSession session) {
		log.info("kakao - post");
		return "redirect:" + kakaoService.kakaoPayReady(request,session);
	}
	
	@GetMapping("/kakaoPaySuccess")
	public ModelAndView kakaoPaySuccess(@RequestParam("pg_token") String pg_token, HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		log.info("kakaoPaySuccess - get");
		log.info("kakaoPaySuccess pg_token : " + pg_token);
		
		KakaoPayApprovalVO kakao = kakaoService.kakaoPayInfo(pg_token, request, session);
		//결제, 주문상세 , 주문, payment, 멤버마일리지, 마일리지사용내역 테이블 트랜잭션처리
		orderService.orderTransaction(kakao, request, session);
		
		mv.setViewName("/mall/order/pay_success");
		mv.addObject("info", kakao);
  
		return mv;
	}
	
	
	
}
