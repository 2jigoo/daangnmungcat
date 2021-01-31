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
	private MemberService memberService;
	
	@Autowired
	private KakaoPayService service;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private MallPdtService pdtService;
	
	@GetMapping("/kakao-pay")
	public void kakaoGet(@RequestBody Map<String, String> map,HttpServletRequest request, HttpSession session) {

	}
	
	@PostMapping("/kakao-pay")
	public String kakaoPost(HttpServletRequest request, HttpSession session) {
		log.info("kakao - post");
		
		//주문할거만 담은 새로운 id
		String[] id = request.getParameterValues("pdt_id");
		String zipcode = request.getParameter("zipcode");
		String name = request.getParameter("add_name");
		String add1 = request.getParameter("address1");
		String add2 = request.getParameter("address2");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String memo = request.getParameter("order_memo");
		String usedMile = request.getParameter("use_mileage");
		
		System.out.println(id + zipcode + name + add1+ add2 + phone1 + phone2 + memo + usedMile);
		// request는 끊김
		List<String> list = new ArrayList<String>();
		for(int i=0; i<id.length; i++) {
			list.add(i, id[i]);
		}
		
		session.setAttribute("list", list);
		session.setAttribute("add_name", name);
		session.setAttribute("zipcode", zipcode);
		session.setAttribute("add1", add1);
		session.setAttribute("add2", add2);
		session.setAttribute("phone1", phone1);
		session.setAttribute("phone2", phone2);
		session.setAttribute("memo", memo);
		session.setAttribute("usedMile", usedMile);
		
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

		//pre-order -> 주문한거만 담은 새로운 cartList
		List<Cart> cartList =  (ArrayList)session.getAttribute("cart");
		
		int total = (int) session.getAttribute("total");
		int deli = (int) session.getAttribute("deli");
		String final_price = (String) session.getAttribute("final_price");
		int plus_mile = (int) session.getAttribute("plus_mile");
		
		//받은 session
		String name = (String) session.getAttribute("add_name");
		String zipcode = (String) session.getAttribute("zipcode");
		String add1 = (String) session.getAttribute("add1");
		String add2 = (String) session.getAttribute("add2");
		String phone1 = (String) session.getAttribute("phone1");
		String phone2 = (String) session.getAttribute("phone2");
		String memo = (String) session.getAttribute("memo");
		String usedMile = (String) session.getAttribute("usedMile");
		
		//order 다음 번호
		int nextOrderNo = orderService.nextOrderNo();
		System.out.println("order다음번호:" + nextOrderNo);
				
		//주문할 리스트 -> detail에 추가
		List<OrderDetail> detailList = new ArrayList<OrderDetail>();
		
		int res = 0;
		
		for(Cart c: cartList) {
			detailList.add(new OrderDetail(c));	
			
			OrderDetail od = new OrderDetail();
			od.setOrderId(nextOrderNo);
			od.setCart(c);
			od.setMember(loginUser);
			od.setTotalPrice(c.getProduct().getPrice() * c.getQuantity());
			res = orderService.insertOrderDetail(od);
		}
		System.out.println("detail insert:" + res);
		
		
		//order insert
		int nextPayNo = orderService.nextPayNo(); 
		System.out.println("pay번호:" + nextPayNo);
		Order order = new Order();
		order.setId(nextOrderNo);
		order.setMember(loginUser);
		order.setDetails(detailList);
		order.setAddName(name);
		order.setZipcode(Integer.parseInt(zipcode));
		order.setAddress1(add1);
		order.setAddress2(add2);
		order.setAddPhone1(phone1);
		order.setAddPhone2(phone2);
		order.setAddMemo(memo);
		order.setTotalPrice(total);
		order.setUsedMileage(Integer.parseInt(usedMile));
		order.setFinalPrice(Integer.parseInt(final_price));
		order.setPlusMileage(plus_mile);
		order.setDeliveryPrice(deli);
		order.setPayId(nextPayNo);
		int orderRes = orderService.insertOrder(order);
		System.out.println("order insert:" + orderRes);
		
		//결제정보 얻어오기
		KakaoPayApprovalVO kakao = service.kakaoPayInfo(pg_token, request, session);
		
		//payment insert
		Payment pay = new Payment();
		pay.setId(nextPayNo);
		pay.setKakao(kakao);
		pay.setMember(loginUser);
		pay.setOrder(order);
		pay.setPayType(kakao.getPayment_method_type());
		pay.setQuantity(kakao.getQuantity());
		System.out.println("pay:" + pay);
		System.out.println("결제정보:" + kakao);
		int payRes = orderService.insertPayment(pay);
		System.out.println("pay insert:" + payRes);
        
		
		mv.setViewName("/mall/order/pay_success");
		mv.addObject("info", kakao);
  
		return mv;
	}
	
	
	
}
