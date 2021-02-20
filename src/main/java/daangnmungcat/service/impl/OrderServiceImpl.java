package daangnmungcat.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.Payment;
import daangnmungcat.dto.kakao.KakaoPayApprovalVO;
import daangnmungcat.mapper.OrderMapper;
import daangnmungcat.service.CartService;
import daangnmungcat.service.KakaoPayService;
import daangnmungcat.service.MallPdtService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.MileageService;
import daangnmungcat.service.OrderService;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MileageService mileService;
	
	@Autowired
	private KakaoPayService kakaoService;
	
	@Autowired
	private OrderMapper mapper;

	@Transactional
	@Override
	public void orderTransaction(KakaoPayApprovalVO kakao, HttpServletRequest request, HttpSession session) {
		
		//order, payment의 pay - id
		System.out.println("TID:" + kakao.getTid());
		
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = memberService.selectMemberById(info.getId());

		//pre-order -> 주문한거만 담은 새로운 cartList
		List<Cart> cartList =  (ArrayList)session.getAttribute("cart");
		System.out.println(cartList);
		
		//parameter로 온 것
		int total = (int) session.getAttribute("total");
		int deli = (int) session.getAttribute("deli");
		
		//kakao -> 세션으로
		String finalPrice = (String) session.getAttribute("final_price");
		
		//받은 session
		String name = (String) session.getAttribute("add_name");
		String zipcode = (String) session.getAttribute("zipcode");
		String add1 = (String) session.getAttribute("add1");
		String add2 = (String) session.getAttribute("add2");
		String phone1 = (String) session.getAttribute("phone1");
		String phone2 = (String) session.getAttribute("phone2");
		String memo = (String) session.getAttribute("memo");
		String usedMile = (String) session.getAttribute("usedMile");
		String plus_mile = (String) session.getAttribute("plus_mile");
		String nextNo = (String) session.getAttribute("nextOrderNo");
		
		System.out.println("session으로 받은 no:" + nextNo);
		
		
		if(usedMile.equals("")) {
			usedMile = "0";
		}

		//order insert
		
		Order order = new Order();
		order.setId(nextNo);
		order.setMember(loginUser);
		
		//주문할 리스트 -> detail에 추가
		List<OrderDetail> detailList = new ArrayList<OrderDetail>();
		
		for(Cart c: cartList) {
			OrderDetail od = new OrderDetail();
			od.setOrderId(nextNo);
			System.out.println(nextNo);
			od.setPdt(c.getProduct());
			od.setMember(loginUser);
			od.setQuantity(c.getQuantity());
			od.setTotalPrice(c.getProduct().getPrice() * c.getQuantity());
			detailList.add(od);
			mapper.insertOrderDetail(od);
		}
		System.out.println(detailList);
		log.info("insert od..........................................");
		
		
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
		order.setFinalPrice(Integer.parseInt(finalPrice));
		order.setPlusMileage(Integer.parseInt(plus_mile));
		order.setDeliveryPrice(deli);
		order.setPayId(kakao.getTid());
		log.info("insert order..........................................");
		mapper.insertOrder(order);
		
		
		//결제정보 얻어오기
		String pg_token = request.getParameter("pg_token");
		System.out.println("pg_token: " + pg_token);
		System.out.println("결제정보:" + kakao);
		
		//payment insert
		Payment pay = new Payment();
		pay.setId(kakao.getTid());
		pay.setKakao(kakao);
		pay.setMember(loginUser);
		pay.setOrder(order);
		pay.setPayType(kakao.getPayment_method_type());
		pay.setQuantity(kakao.getQuantity());
		System.out.println("pay:" + pay);
		mapper.insertPayment(pay);
		log.info("insert payment..........................................");
		
		
		int myMileage = mileService.getMileage(loginUser.getId());
		
		//현재마일리지
		System.out.println("현재 마일리지: " + myMileage);
		
		//보유금액 -일때
		if(usedMile.contains("-")) {
			usedMile = usedMile.replace("-", "");
		}
		
		/*
		Mileage plus = new Mileage();
		plus.setMember(loginUser);
		plus.setOrder(order);
		plus.setMileage(Integer.parseInt(plus_mile));
		plus.setContent("상품 구매 적립");
		mileService.insertMilegeInfo(plus);
		*/
		
		Mileage minus = new Mileage();
		minus.setMember(loginUser);
		minus.setOrder(order);
		minus.setMileage(Integer.parseInt("-"+usedMile));
		minus.setContent("상품 구매 사용");
		
		if(!usedMile.equals("0")) {
			mileService.insertMilegeInfo(minus);
		}
		
		int afterMile = mileService.getMileage(loginUser.getId());
		System.out.println("처리 후 현재마일리지:" + afterMile);
		log.info("마일리지 set / 내역테이블 insert");
		
		// 주문완료된 상품 카트에서 삭제
		List<MallProduct> pdtList = detailList.stream().map(OrderDetail::getPdt).collect(Collectors.toList());
		cartService.deleteAfterOrdered(loginUser.getId(), pdtList);
		
		log.info("..........end..........");
		
	}
	
	@Override
	public int insertOrder(Order order) {
		return mapper.insertOrder(order);
	}

	@Override
	public int insertOrderDetail(OrderDetail od) {
		return mapper.insertOrderDetail(od);
	}

	@Override
	public List<OrderDetail> getOrderDetail(String orderNo) {
		// TODO Auto-generated method stub
		return mapper.selectOrderDetailByOrderNo(orderNo);
	}

	@Override
	public int insertPayment(Payment pay) {
		// TODO Auto-generated method stub
		return mapper.insertPayment(pay);
	}

	@Override
	public List<Order> selectOrderById(String id) {
		return mapper.selectOrderById(id);
	}

	@Override
	public Order getOrderByNo(String id) {
		return mapper.getOrderByNo(id);
	}


	@Override
	public List<Order> searchByDate(String start, String end, String memId) {
		// TODO Auto-generated method stub 
		return mapper.searchByDate(start, end, memId);
	}
	
	@Override
	public List<Order> cancelSearchByDate(String start, String end, String memId) {
		return mapper.cancelSearchByDate(start, end, memId);
	}


	@Override
	public List<OrderDetail> sortingOrderDetail(String id) {
		// TODO Auto-generated method stub
		return mapper.sortingOrderDetail(id);
	}

	@Override
	public int updatePartOrderDetail(OrderDetail orderDetail, int id) {
		return mapper.updatePartOrderDetail(orderDetail);
	}

	@Override
	public int updateAllOrderDetail(OrderDetail orderDetail, String id) {
		return mapper.updateAllOrderDetail(orderDetail);
	}

	@Override
	public int updateOrder(Order order, String id) {
		return mapper.updateOrder(order);
	}

	@Override
	public int updatePayment(Payment pay, String id) {
		return mapper.updatePayment(pay);
	}

	
	@Override
	public List<Order> selectCancelOrderById(String id) {
		return mapper.selectCancelOrderById(id);
	}

	
	@Override
	public OrderDetail getOrderDetailById(String id) {
		return mapper.getOrderDetailById(id);
	}

	@Override
	public Payment getPaymentById(String tid) {
		// TODO Auto-generated method stub
		return mapper.getPaymentById(tid);
	}

	@Override
	public List<OrderDetail> selectOrderDetailUsingPartCancelByOrderId(String orderId) {
		// TODO Auto-generated method stub
		return mapper.selectOrderDetailUsingPartCancelByOrderId(orderId);
	}
	
	@Override
	public Map<String, Integer> calculateDeliveryFee(List<Cart> list) {
		Map<String, Integer> deliveryFee = new HashMap<>();
		
		// 총 배송비
		int totalDeliveryFee = 0;
		
		// 무료배송, 유료상품 존재 여부
		boolean hasFreeDelivery = list.stream().anyMatch(cart -> cart.getProduct().getDeliveryKind().equals("무료배송"));
		boolean hasChargedDelivery = list.stream().anyMatch(cart -> cart.getProduct().getDeliveryKind().equals("유료배송"));
		
		// 조건부 무료배송 총 상품금액 합계 구하기
		int totalPriceOfCondiFeePdt = list.stream()
											.filter(cart -> cart.getProduct().getDeliveryKind().equals("조건부 무료배송"))
											.collect(Collectors.summingInt(Cart::getAmount));
		
		// 무료배송 상품이 있거나 조건부 무료배송 상품 총 금액이 3만원 이상인 경우는 무료배송
		if(!(totalPriceOfCondiFeePdt >= 30000 || hasFreeDelivery == true)) {
			totalDeliveryFee = 3000;
		}
		
		// 유료배송 상품이 있는 경우
		int chargedDeliveryFee = 0;
		if(hasChargedDelivery == true) {
			List<Cart> listOfChargedFee = list.stream()
												.filter(cart -> cart.getProduct().getDeliveryKind().equals("유료배송"))
												.collect(Collectors.toList());
			// 모든 유료배송 상품의 합계 배송비
			for(Cart cart : listOfChargedFee) {
				chargedDeliveryFee += cart.getQuantity() * cart.getProduct().getDeliveryPrice();
			}
			
			totalDeliveryFee += chargedDeliveryFee;
		}
		
		System.out.println(totalDeliveryFee + " = " + chargedDeliveryFee + " + " + (totalDeliveryFee - chargedDeliveryFee));
		
		deliveryFee.put("total", totalDeliveryFee);
		deliveryFee.put("conditional", totalDeliveryFee - chargedDeliveryFee);
		deliveryFee.put("charged", chargedDeliveryFee);
		
		
		return deliveryFee;
	}

////////////////admin
	
	@Override
	public List<Order> selectOrderAll(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.selectOrderAll(cri);
	}

	@Override
	public int listCount() {
		// TODO Auto-generated method stub
		return mapper.listCount();
	}

	@Override
	public List<Order> selectOrderBySearch(String content, String word, Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.selectOrderBySearch(cri, content, word);
	}

	@Override
	public int searchListCount(String content, String word) {
		return mapper.searchListCount(content, word);
	}

	

}
