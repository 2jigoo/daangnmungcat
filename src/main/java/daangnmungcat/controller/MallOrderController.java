package daangnmungcat.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Member;
import daangnmungcat.service.CartService;
import daangnmungcat.service.MallPdtService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.OrderService;

@Controller
@RestController
public class MallOrderController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MallPdtService mService;

	
	@GetMapping("/mall/pre-order")
	public void orderPage(HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		String[] id = request.getParameterValues("id");
		System.out.println("전달받은 id:" + Arrays.toString(id));
		List<Cart> cartList = new ArrayList<Cart>();
		for(int i=0; i<id.length; i++) {
			cartList.add(cartService.getCartItem(Integer.parseInt(id[i])));
		}
		System.out.println(cartList);
	}
	
	//카트에서 선택된 카트리스트
	@PostMapping("/mall/pre-order")
	public ModelAndView preOrderList(HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());	
		
		ModelAndView mv = new ModelAndView();
		
		String[] id = request.getParameterValues("id");
		
		List<Cart> cartList = new ArrayList<Cart>();
		for(int i=0; i<id.length; i++) {
			cartList.add(cartService.getCartItem(Integer.parseInt(id[i])));
			for(Cart cart: cartList) {
				//조건부일때만 하는걸로 수정해야함
				if(cart.getProduct().getPrice() * cart.getQuantity() >= 50000) {
					//cart.getProduct().setDeliveryPrice(0);
				}
			}
		}
		
		int total = 0;
		int delivery = 0;
		int final_price = 0;
		int mile = 0;
		
		for(Cart c: cartList) {
			total += c.getProduct().getPrice() * c.getQuantity();
			delivery += c.getProduct().getDeliveryPrice();
			mile = (int) (total * 0.01);
			final_price = total + delivery;
		}
		
		mv.addObject("delivery", delivery);
		mv.addObject("total", total);
		mv.addObject("final_price", final_price);
		mv.addObject("mileage", mile);
		mv.addObject("size", cartList.size());
		mv.addObject("cart", cartList);
		mv.addObject("member", loginUser);
		mv.setViewName("/mall/order/mall_pre_order");
		System.out.println(final_price);
		
		//결제시 detail로 받을 cartlist -> paySuccess
		session.setAttribute("cart", cartList);
		session.setAttribute("deli", delivery);
		session.setAttribute("total", total);
		session.setAttribute("final_price", final_price);
		session.setAttribute("plus_mile", mile);
		
		return mv;
	}
	
	
}
