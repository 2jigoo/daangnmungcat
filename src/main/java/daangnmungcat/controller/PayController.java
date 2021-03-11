package daangnmungcat.controller;

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

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.kakao.KakaoPayApprovalVO;
import daangnmungcat.service.KakaoPayService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.OrderService;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class PayController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private KakaoPayService kakaoService;
	
	@Autowired
	private OrderService orderService;
	
	
	@GetMapping("/kakao-pay")
	public void kakaoGet(@RequestBody Map<String, String> map,HttpServletRequest request, HttpSession session) {

	}
	
	@PostMapping("/kakao-pay")
	public String kakaoPost(AuthInfo loginUser, HttpServletRequest request, HttpSession session) {
		log.info("kakao - post");
		String memberId = loginUser.getId();
		return "redirect:" + kakaoService.kakaoPayReady(memberId, request,session);
	}
	
	
	@GetMapping("/kakaoPaySuccess")
	public ModelAndView kakaoPaySuccess(@RequestParam("pg_token") String pg_token, AuthInfo loginUser, HttpServletRequest request, HttpSession session) {
		log.info("kakaoPaySuccess - get");
		
		ModelAndView mv = new ModelAndView();
		String memberId = loginUser.getId();
		KakaoPayApprovalVO kakao = kakaoService.kakaoPayApprovalInfo(memberId, pg_token, request, session);
		log.info("kakaoPaySuccess - 결제정보 :" + kakao);
		
		mv.setViewName("/mall/order/pay_success");
		mv.addObject("info", kakao);

		return mv;
	}
	
	@GetMapping("/kakaoPayCancel")
	public String payCancel(Model model) {
		return "/mall/cart/mall_cart_list";
	}
	
	@GetMapping("kakaoPaySuccessFail")
	public String paySuccessFail(Model model) {
		return "/mall/cart/mall_cart_list";
	}
	
	
	//결제 취소
	@PostMapping("kakao-cancel")
	public String kakaoCancel(@RequestBody Map<String, String> map, AuthInfo loginUser) {
		log.info("kakao-cancel - post");
//		session.setAttribute("map", map);
		return "redirect:" + kakaoService.kakaoPayCancel(loginUser.getId(), map);
	}
	
	@GetMapping("/kakaoPayCancelSuccess")
	public ModelAndView payCancelSuccess(Criteria cri, HttpServletRequest request, AuthInfo loginUser) {
		log.info("kakaoPayCancel - success");
	
		Member member = memberService.selectMemberById(loginUser.getId());
		
		List<Order> list = orderService.selectOrderById(cri, member.getId());
		
		for(Order o: list) {
			List<OrderDetail> odList = orderService.sortingOrderDetail(o.getId());
			o.setDetails(odList);
			for(OrderDetail od: odList) {
				od.setOrderId(o.getId());
			}
		}

		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("/mypage/mypage_order_list");
	
		return mv;
	}
	
	/*
	//부분 취소
	//@PostMapping("/kakao-part")
	public String kakaoPartCancel(@RequestBody Map<String, String> map, AuthInfo loginUser, HttpSession session) {
		log.info("kakao- part cancel - post");
		session.setAttribute("map", map);
		String memberId = loginUser.getId();
		return "redirect:" + kakaoService.kakaoPayPartCancel(memberId, map);
	}
	
	@GetMapping("/kakaoPayPartCancelSuccess")
	public ModelAndView payPartCancelSuccess(AuthInfo loginUser) {
		log.info("kakaoPayPartCancel - success");
	
		Member member = memberService.selectMemberById(loginUser.getId());
		
		List<Order> list = orderService.selectOrderById(member.getId());
		
		for(Order o: list) {
			List<OrderDetail> odList = orderService.sortingOrderDetail(o.getId());
			o.setDetails(odList);
			for(OrderDetail od: odList) {
				od.setOrderId(o.getId());
			}
		}

		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("/mypage/mypage_order_list");
	
		return mv;
	}
	*/
	//무통장
	@PostMapping("/accountPay")
	public String accountPay (AuthInfo loginUser, HttpServletRequest request, HttpSession session) {
		log.info("무통장입금 ");
		return "redirect:" + orderService.accountOrderTransaction(loginUser.getId(), request, session);
	}
	
	@GetMapping("/accountPaySuccess")
	public ModelAndView accountPaySuccess (HttpServletRequest request, HttpSession session) {
		log.info("무통장입금 - success");
		String nextNo = (String) session.getAttribute("orderNo");
		
		Order order = orderService.getOrderByNo(nextNo);
		List<OrderDetail> odList = orderService.sortingOrderDetail(order.getId());
		order.setDetails(odList);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("order", order);
		mv.setViewName("/mall/order/pay_account");
		return mv;
	}
	
	
}
