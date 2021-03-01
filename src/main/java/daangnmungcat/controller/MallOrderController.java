package daangnmungcat.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Order;
import daangnmungcat.service.CartService;
import daangnmungcat.service.MallPdtService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.MileageService;
import daangnmungcat.service.OrderService;
import oracle.net.aso.c;

@Controller
@RestController
public class MallOrderController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private MileageService mileService;
	
	@Autowired
	private MallPdtService pdtService;
	
	@Autowired
	private OrderService orderService;


	@PostMapping("/mall/pre-order/single")
	public ModelAndView singleOrder(HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		String id = request.getParameter("id");
		String qtt = request.getParameter("quantity"); 
		
		Cart newCart = new Cart();
		newCart.setMember(loginUser);
		newCart.setProduct(pdtService.getProductById(Integer.parseInt(id)));
		newCart.setQuantity(Integer.parseInt(qtt));

		List<Cart> cartList = new ArrayList<Cart>();
		cartList.add(newCart);
		
		ModelAndView mv = new ModelAndView();
		
		// 총 배송비
		int totalDeliveryFee = 0;
		
		
		// 무료배송, 유료상품 존재 여부
		boolean hasFreeDelivery = cartList.stream().anyMatch(cart -> cart.getProduct().getDeliveryKind().equals("무료배송"));
		boolean hasChargedDelivery = cartList.stream().anyMatch(cart -> cart.getProduct().getDeliveryKind().equals("유료배송"));
		
		// 조건부 무료배송 총 상품금액 합계 구하기
		List<Cart> listOfConditionalFee = cartList.stream()
											.filter(cart -> cart.getProduct().getDeliveryKind().equals("조건부 무료배송"))
											.collect(Collectors.toList());
		
		int totalPriceOfCondiFeePdt = 0;
		for(Cart cart : listOfConditionalFee) {
			totalPriceOfCondiFeePdt += cart.getProduct().getPrice() * cart.getQuantity();
		}
		
		// 무료배송 상품이 있거나 조건부 무료배송 상품 총 금액이 3만원 이상인 경우는 무료배송
		if(!(totalPriceOfCondiFeePdt >= 30000 || hasFreeDelivery == true)) {
			totalDeliveryFee = 3000;
		}
		
		// 유료배송 상품이 있는 경우
		int chargedDeliveryFee = 0;
		if(hasChargedDelivery == true) {
			List<Cart> listOfChargedFee = cartList.stream()
												.filter(cart -> cart.getProduct().getDeliveryKind().equals("유료배송"))
												.collect(Collectors.toList());
			// 모든 유료배송 상품의 합계 배송비
			for(Cart cart : listOfChargedFee) {
				chargedDeliveryFee += cart.getQuantity() * cart.getProduct().getDeliveryPrice();
				System.out.println(chargedDeliveryFee);
			}
			
			totalDeliveryFee += chargedDeliveryFee;
		}
		
		// 총 배송비

		int total = 0;
		int final_price = 0;
		int mile = 0;
		int total_qtt = 0;

		for (Cart c : cartList) {
			total += c.getProduct().getPrice() * c.getQuantity();
			mile = (int) (total * 0.01);
			final_price = total + totalDeliveryFee;
			total_qtt += c.getQuantity();
		}

		int myMileage = mileService.getMileage(loginUser.getId());

		mv.addObject("member", loginUser);
		mv.addObject("total", total);
		mv.addObject("final_price", final_price);
		mv.addObject("mileage", mile);
		mv.addObject("size", cartList.size());
		mv.addObject("total_qtt", total_qtt);
		mv.addObject("cart", cartList);
		mv.addObject("memberMileage", myMileage);
		
		mv.addObject("conditionalDeliveryFee", totalDeliveryFee - chargedDeliveryFee);
		mv.addObject("chargedDelivery", chargedDeliveryFee);
		mv.addObject("totalDeliveryFee", totalDeliveryFee);

		// 결제시 detail로 받을 cartlist -> paySuccess
		session.setAttribute("cart", cartList);
		session.setAttribute("total", total);
		session.setAttribute("final_price", final_price);
		session.setAttribute("deli", totalDeliveryFee);
		session.setAttribute("plus_mile", mile);

		mv.setViewName("/mall/order/mall_pre_order");
		return mv;
		
	}
	
	//카트에서 선택된 카트리스트
	@PostMapping("/mall/pre-order/list")
	public ModelAndView preOrderList(HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());	
		
		String[] id = request.getParameterValues("id");
		
		List<Cart> cartList = new ArrayList<Cart>();
		for(int i=0; i<id.length; i++) {
			cartList.add(cartService.getCartItem(Integer.parseInt(id[i])));
		}
		
		ModelAndView mv = new ModelAndView();
		
		// 총 배송비
		int totalDeliveryFee = 0;
			
			
		// 무료배송, 유료상품 존재 여부
		boolean hasFreeDelivery = cartList.stream().anyMatch(cart -> cart.getProduct().getDeliveryKind().equals("무료배송"));
		boolean hasChargedDelivery = cartList.stream().anyMatch(cart -> cart.getProduct().getDeliveryKind().equals("유료배송"));
			
		// 조건부 무료배송 총 상품금액 합계 구하기
		List<Cart> listOfConditionalFee = cartList.stream()
											.filter(cart -> cart.getProduct().getDeliveryKind().equals("조건부 무료배송"))
											.collect(Collectors.toList());
			
		int totalPriceOfCondiFeePdt = 0;
		for(Cart cart : listOfConditionalFee) {
			totalPriceOfCondiFeePdt += cart.getProduct().getPrice() * cart.getQuantity();
		}
			
		// 무료배송 상품이 있거나 조건부 무료배송 상품 총 금액이 3만원 이상인 경우는 무료배송
		if(!(totalPriceOfCondiFeePdt >= 30000 || hasFreeDelivery == true)) {
			totalDeliveryFee = 3000;
		}
			
		// 유료배송 상품이 있는 경우
		int chargedDeliveryFee = 0;
		if(hasChargedDelivery == true) {
		List<Cart> listOfChargedFee = cartList.stream()
											.filter(cart -> cart.getProduct().getDeliveryKind().equals("유료배송"))
											.collect(Collectors.toList());
		// 모든 유료배송 상품의 합계 배송비
		for(Cart cart : listOfChargedFee) {
			chargedDeliveryFee += cart.getQuantity() * cart.getProduct().getDeliveryPrice();
			System.out.println(chargedDeliveryFee);
		}
				
		totalDeliveryFee += chargedDeliveryFee;
		}


		int total = 0;
		int final_price = 0;
		int mile = 0;
		int total_qtt = 0;

		for (Cart c : cartList) {
			total += c.getProduct().getPrice() * c.getQuantity();
			mile = (int) (total * 0.01);
			final_price = total + totalDeliveryFee;
			total_qtt += c.getQuantity();
		}

		int myMileage = mileService.getMileage(loginUser.getId());

		mv.addObject("member", loginUser);
		mv.addObject("total", total);
		mv.addObject("final_price", final_price);
		mv.addObject("mileage", mile);
		mv.addObject("size", cartList.size());
		mv.addObject("total_qtt", total_qtt);
		mv.addObject("cart", cartList);
		mv.addObject("memberMileage", myMileage);
		mv.addObject("totalDeliveryFee", totalDeliveryFee);

		// 결제시 detail로 받을 cartlist -> paySuccess
		session.setAttribute("cart", cartList);
		session.setAttribute("total", total);
		session.setAttribute("final_price", final_price);
		session.setAttribute("plus_mile", mile);
		session.setAttribute("deli", totalDeliveryFee);
		
		mv.setViewName("/mall/order/mall_pre_order");
		return mv;
	}
	
	
}