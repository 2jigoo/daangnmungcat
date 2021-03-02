package daangnmungcat.controller.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.OrderState;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Payment;
import daangnmungcat.dto.kakao.KakaoPayApprovalVO;
import daangnmungcat.exception.DuplicateMemberException;
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
		
		Order order = orderService.getOrderByNo(id);
		List<OrderDetail> odList = orderService.sortingOrderDetail(order.getId());
		order.setDetails(odList);
		for(OrderDetail od: odList) {
			od.setOrderId(order.getId());
		}
		
		KakaoPayApprovalVO kakao = null;
		Payment pay = null;
		
		if(order.getPayId() != null) {
			kakao = kakaoService.kakaoPayInfo(order.getPayId());
		}else {
			pay = orderService.selectAccountPaymentByOrderId(order.getId());
		}
		
		//결제완료인 물품만 다시 계산
		List<OrderDetail> partList = orderService.selectOrderDetailUsingPartCancelByOrderId(order.getId());
		List<Cart> cartList = new ArrayList<Cart>();
		for(OrderDetail od: odList) {
			Cart cart = new Cart();
			cart.setMember(order.getMember());
			cart.setProduct(od.getPdt());
			cart.setQuantity(od.getQuantity());
			cartList.add(cart);
		}
		
		
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
	
	@ResponseBody
	@PostMapping("/admin/order/{status}")
	public int updateOrderState(@RequestBody String[] od, @PathVariable String status){
		
		Order order = null;
		int res = 0;
		
		for(int i=0; i<od.length; i++) {
			
			OrderDetail ord = orderService.getOrderDetailById(od[i]);
			order = orderService.getOrderByNo(ord.getOrderId());
			int price = order.getFinalPrice();
			List<OrderDetail> odList = orderService.getOrderDetail(ord.getOrderId());
			
			System.out.println(order);
			
			if(status.equals("대기")) {
				ord.setOrderState(OrderState.DEPOSIT_REQUEST);
			}else if(status.equals("결제")) {
				ord.setOrderState(OrderState.PAID);
			}else if(status.equals("배송")) {
				ord.setOrderState(OrderState.SHIPPING);
			}else if(status.equals("완료")) {
				ord.setOrderState(OrderState.DELIVERED);
			}else if(status.equals("취소")) {
				ord.setOrderState(OrderState.CANCEL);
			}else if(status.equals("반품")) {
				ord.setOrderState(OrderState.RETURN);
			}else if(status.equals("품절")) {
				ord.setOrderState(OrderState.SOLD_OUT);
				//품절시 order 전체 금액에서 해당 상품 금액 빼기 -> 상태 수정시 되돌림
				order.setFinalPrice(order.getFinalPrice() - ord.getTotalPrice());
				order.setMisu(order.getFinalPrice() - ord.getTotalPrice());
				orderService.updateOrder(order, order.getId());
			}
			
			if(odList.size() == od.length) {
				//모든상품
				order.setState(status);
			}
			
			res = orderService.updatePartOrderDetail(ord, ord.getId());
		}
		//System.out.println(list);
		
		return res;
	}
	
	@ResponseBody
	@PostMapping("/admin/order/post")
	public ResponseEntity<Object> updateOrder(@RequestBody Map<String, String> map){
		
		try {
			return ResponseEntity.ok(orderService.adminInsertPaymentAndOrderUpdate(map));
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
	}
}
