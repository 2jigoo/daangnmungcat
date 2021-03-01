package daangnmungcat.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Payment;
import daangnmungcat.dto.kakao.KakaoPayApprovalVO;
import daangnmungcat.service.KakaoPayService;
import daangnmungcat.service.OrderService;

@Controller
public class AdminOrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private KakaoPayService kakaoService;
	
	@GetMapping("/admin/order/list")
	public ModelAndView orderList(Criteria cri, @Nullable @RequestParam String content, @Nullable @RequestParam String query,
			@Nullable @RequestParam String state,
			@Nullable @RequestParam String start, @Nullable @RequestParam String end) {
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		List<Order> list = null;
		
		if(content != null  || query != null || state != null ||  start != null || end != null) {
			list = orderService.selectOrderBySearch(content, query, state,  start, end, cri);
			pageMaker.setTotalCount(orderService.searchListCount(content, query, state, start, end));
			System.out.println(orderService.searchListCount(content, query, state, start, end));
		}else {
			list = orderService.selectOrderAll(cri);
			pageMaker.setTotalCount(orderService.listCount());
			System.out.println(orderService.listCount());
		}
		
		for(Order o: list) {
			List<OrderDetail> odList = orderService.sortingOrderDetail(o.getId());
			o.setDetails(odList);
			for(OrderDetail od: odList) {
				od.setOrderId(o.getId());
			}
		}
		
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("totalCnt", orderService.listCount());
		mv.addObject("list", list);
		mv.addObject("pageMaker", pageMaker);
		mv.addObject("content", content);
		mv.addObject("query", query);
		mv.addObject("state", state);
		mv.addObject("start", start);
		mv.addObject("end", end);
	
		mv.setViewName("/admin/order/order_list");
		
		return mv;
	}
	
	@GetMapping("/admin/order")
	public ModelAndView orderList(@RequestParam String id) {
		
		System.out.println("id:" + id);
		
		Order order = orderService.getOrderByNo(id);
		List<OrderDetail> odList = orderService.sortingOrderDetail(order.getId());
		order.setDetails(odList);
		for(OrderDetail od: odList) {
			od.setOrderId(order.getId());
		}
		
		KakaoPayApprovalVO kakao = null;
		Payment pay = null;
		System.out.println("pay:" + pay);
		
		if(order.getPayId() != null) {
			kakao = kakaoService.kakaoPayInfo(order.getPayId());
		}else {
			pay = orderService.selectAccountPaymentByOrderId(order.getId());
		}
		
		//결제완료인 물품만 다시 계산
		List<OrderDetail> partList = orderService.selectOrderDetailUsingPartCancelByOrderId(order.getId());
		System.out.println("odList:" + partList);
		List<Cart> cartList = new ArrayList<Cart>();
		for(OrderDetail od: odList) {
			Cart cart = new Cart();
			cart.setMember(order.getMember());
			cart.setProduct(od.getPdt());
			cart.setQuantity(od.getQuantity());
			cartList.add(cart);
		}
		
		System.out.println("cartlist:" + cartList);
		 Map<String, Integer> map = orderService.calculateDeliveryFee(cartList);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("part", partList);
		mv.addObject("pay", pay);
		mv.addObject("kakao", kakao);
		mv.addObject("order", order);
		
		mv.addObject("total", map.get("total"));
		mv.addObject("conditional", map.get("conditional"));
		mv.addObject("charged", map.get("charged"));
		mv.setViewName("/admin/order/order_detail");
		
		return mv;
	}
	
	
}
