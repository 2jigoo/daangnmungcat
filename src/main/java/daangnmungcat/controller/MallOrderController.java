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


	/*
	@PostMapping("/mall/pre-order")
	public void orderCheck(@RequestBody Map<String, Object> map, HttpSession session, HttpServletRequest request) {

		String total = map.get("total_price").toString();
		String qtt = map.get("quantity").toString();
		MallProduct pdt = mService.getProductById(Integer.parseInt(map.get("m_id").toString()));
		session.setAttribute("total", total);
		session.setAttribute("qtt", qtt);
		session.setAttribute("pdt", pdt);
		session.setAttribute("pdt_id", pdt.getId());
		session.setAttribute("pdt_name", pdt.getName());
	} */
	
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
	
	
	@PostMapping("/mall/pre-order")
	public ModelAndView preOrderList(HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());	
		
		ModelAndView mv = new ModelAndView();
		
		String[] id = request.getParameterValues("id");
		System.out.println("전달받은 id:" + Arrays.toString(id));
		
		List<Cart> cartList = new ArrayList<Cart>();
		for(int i=0; i<id.length; i++) {
			cartList.add(cartService.getCartItem(Integer.parseInt(id[i])));
			for(Cart cart: cartList) {
				if(cart.getProduct().getPrice() * cart.getQuantity() >= 50000) {
					cart.getProduct().setDeliveryPrice(0);
				}
			}
		}
		
		int total = 0;
		int delivery = 0;
		int final_price = 0;
		double mile = 0;
		
		for(Cart c: cartList) {
			total += c.getProduct().getPrice() * c.getQuantity();
			delivery += c.getProduct().getDeliveryPrice();
			mile = total * 0.01;
			final_price = total + delivery;
		}
		
		System.out.println("마일리지:" + mile);
		mv.addObject("delivery", delivery);
		mv.addObject("total", total);
		mv.addObject("final_price", final_price);
		mv.addObject("mileage", mile);
		mv.addObject("size", cartList.size());
		mv.addObject("cart", cartList);
		mv.setViewName("/mall/mall_pre_order");
		
		/*
		//다음 주문번호
		int nextNo = orderService.nextOrderNo();
		System.out.println("다음번호:" + nextNo);
		
		int total = 0;
		int res = 0;
		
		//주문할 리스트 -> detail에 추가
		List<OrderDetail> detailList = new ArrayList<OrderDetail>();
		
		for(Cart c: cartList) {
			detailList.add(new OrderDetail(c));	
			total = c.getProduct().getPrice() * c.getQuantity();
			
			OrderDetail od = new OrderDetail();
			od.setOrderId(nextNo);
			od.setCart(c);
			od.setMember(loginUser);
			od.setTotalPrice(total);
			res = orderService.insertOrderDetail(od);
			System.out.println("total:" + total);
		}
		
		System.out.println("detail insert:" + res);
		
		Order order = new Order();
		order.setId(nextNo);
		order.setMember(loginUser);
		
		System.out.println(detailList);
		
		*/
		return mv;
	}
	
	
}
