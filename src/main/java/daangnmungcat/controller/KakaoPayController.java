package daangnmungcat.controller;

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

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.service.CartService;
import daangnmungcat.service.KakaoPayService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.OrderService;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class KakaoPayController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private KakaoPayService service;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	
	@GetMapping("/kakao-pay")
	public void kakaoGet(@RequestBody Map<String, String> map,HttpServletRequest request, HttpSession session) {

	}
	
	@PostMapping("/kakao-pay")
	public String kakaoPost(HttpServletRequest request, HttpSession session) {
		log.info("kakao - post");
		String[] id = request.getParameterValues("pdt_id");
		session.setAttribute("id_arr", Arrays.toString(id));
		
		return "redirect:" + service.kakaoPayReady(request,session);
	}
	
	@GetMapping("/kakaoPaySuccess")
	public ModelAndView kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model, HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		log.info("kakaoPaySuccess - get");
		log.info("kakaoPaySuccess pg_token : " + pg_token);
		
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = memberService.selectMemberById(info.getId());
		request.setAttribute("list", session.getAttribute("id_arr"));
		
		ArrayList<String> list = (ArrayList) session.getAttribute("id_arr");
		System.out.println(list.size());
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i));
		}
		
			
//		String[] id = request.getParameterValues("id");
//		System.out.println("성공후전달받은 id:" + Arrays.toString(id));
//		
//		List<Cart> cartList = new ArrayList<Cart>();
//		for(int i=0; i<id.length; i++) {
//			cartList.add(cartService.getCartItem(Integer.parseInt(id[i])));
//			for(Cart cart: cartList) {
//				//조건부일때만 하는걸로 수정해야함
//				if(cart.getProduct().getPrice() * cart.getQuantity() >= 50000) {
//					//cart.getProduct().setDeliveryPrice(0);
//				}
//			}
//		}
//		
//		int nextNo = orderService.nextOrderNo();
//		System.out.println("다음번호:" + nextNo);
//		
//		int total = 0;
//		int res = 0;
//		
//		//주문할 리스트 -> detail에 추가
//		List<OrderDetail> detailList = new ArrayList<OrderDetail>();
//		
//		for(Cart c: cartList) {
//			detailList.add(new OrderDetail(c));	
//			total = c.getProduct().getPrice() * c.getQuantity();
//			
//			OrderDetail od = new OrderDetail();
//			od.setOrderId(nextNo);
//			od.setCart(c);
//			od.setMember(loginUser);
//			od.setTotalPrice(total);
//			res = orderService.insertOrderDetail(od);
//			System.out.println("total:" + total);
//		}
//		
//		System.out.println("detail insert:" + res);
//		
//		Order order = new Order();
//		order.setId(nextNo);
//		order.setMember(loginUser);
//		
//		System.out.println(detailList);
		
		
		mv.setViewName("/mall/order/pay_success");
		mv.addObject("info", service.kakaoPayInfo(pg_token, request, session));
  
		return mv;
	}
	
	
}
