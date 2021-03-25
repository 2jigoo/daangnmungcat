package daangnmungcat.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.OrderState;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Payment;
import daangnmungcat.dto.kakao.KakaoPayApprovalVO;
import daangnmungcat.service.KakaoPayService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.OrderService;
import lombok.extern.log4j.Log4j2;

@Controller
@RestController
@Log4j2
public class AdminOrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private KakaoPayService kakaoService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/admin/order/list")
	public ModelAndView orderList(Criteria cri, 
			@Nullable @RequestParam String search, @Nullable @RequestParam String query,
			@Nullable @RequestParam String start, @Nullable @RequestParam String end,
			@Nullable @RequestParam String state,@Nullable @RequestParam String part_cancel,
			@Nullable @RequestParam String settle_case,
			@Nullable @RequestParam String misu, @Nullable @RequestParam String return_price) {
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		cri.setPerPageNum(10);
		List<Order> list = null;

		System.out.println(search);
		
			if(search != null  || query != null || state != null ||  start != null || end != null || settle_case != null || 
				part_cancel != null || misu != null || return_price != null) {
			
			if(state.equals("전체")) {
				state = "";
			}
			if(state.equals("전체취소")) {
				state = "취소";
			}
			if(state.equals("부분취소")) {
				state = null; 
			}
			
			if(settle_case.equals("전체")) {
				settle_case = null;
			}
			System.out.println(state);
			
			list = orderService.selectOrderBySearch(cri, search, query, state,  start, end, settle_case, part_cancel, misu, return_price);
			pageMaker.setTotalCount(orderService.searchListCount(search, query, state,  start, end, settle_case, part_cancel, misu, return_price));
			
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
		
		System.out.println("query:" + query);
		System.out.println("state:" + state);
		System.out.println("settle" + settle_case);
		
		System.out.println("총 갯수: " + pageMaker.getTotalCount());
		
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("totalCnt", orderService.listCount());
		mv.addObject("list", list);
		mv.addObject("pageMaker", pageMaker);
		mv.addObject("search", search);
		mv.addObject("query", query);
		mv.addObject("state", state);
		mv.addObject("start", start);
		mv.addObject("end", end);
		mv.addObject("settleCase", settle_case);
		mv.addObject("partCancel", part_cancel);
		mv.addObject("misu", misu);
		mv.addObject("returnPrice", return_price);
	
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
		
		if(order.getSettleCase().equals("카카오페이")) {
			kakao = kakaoService.kakaoPayInfo(order.getPayId());
			pay = orderService.selectAccountPaymentByOrderId(order.getId());
			System.out.println("kakao: " + kakao);
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
	public ResponseEntity<Object> updateOrderState(@RequestBody String[] od, @PathVariable String status, HttpServletRequest request){
		try {
			return ResponseEntity.ok(orderService.UpdateOrderState(od, status, request));
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
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
	
	
	@PostMapping("/admin/shipping/post")
	public ResponseEntity<Object> updatesOrderShipping(@RequestBody Map<String, String> map){
		System.out.println("shipping update");
		try {
			
			String id = map.get("id");
			String name =  map.get("name");
			String zipcode =  map.get("zipcode");
			String add1 = map.get("add1");
			String add2 =  map.get("add2");
			String phone1 =  map.get("phone1");
			String phone2 =  map.get("phone2");
			String memo =  map.get("memo");
			
			Order o = orderService.getOrderByNo(id);
			
			o.setAddName(name);
			o.setZipcode(Integer.parseInt(zipcode));
			o.setAddress1(add1);
			o.setAddress2(add2);
			o.setAddPhone1(phone1);
			o.setAddPhone2(phone2);
			o.setAddMemo(memo);
			
			return ResponseEntity.ok(orderService.updateOrder(o, o.getId()));
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
	}
	
	@GetMapping("/admin/order/part_cancel")
	public ModelAndView partCancel(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		String oid = request.getParameter("oid");
		String tid = request.getParameter("tid");
		
		Order order = orderService.getOrderByNo(oid);
		KakaoPayApprovalVO kakao = kakaoService.kakaoPayInfo(tid);
		
		mv.addObject("order", order);
		mv.addObject("kakao", kakao);
		mv.setViewName("/admin/order/part_cancel");
		
		return mv;
		
	}
	
	@PostMapping("/kakao-part")
	public String kakaoPartCancel(@RequestBody Map<String, String> map) {
		log.info("kakao- part cancel - post");
		return "redirect:" + kakaoService.kakaoPayPartCancel(map);
	}
	
	
}
