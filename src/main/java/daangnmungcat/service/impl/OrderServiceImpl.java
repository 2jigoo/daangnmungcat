package daangnmungcat.service.impl;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.OrderState;
import daangnmungcat.dto.Payment;
import daangnmungcat.dto.SearchCriteriaForOrder;
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
	private MallPdtService pdtService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MileageService mileService;
	
	@Autowired
	private OrderMapper mapper;
	
	@Autowired
	private KakaoPayService kakaoService;

	@Transactional
	@Override
	public void kakaoOrderTransaction(String memberId, String pg_token, KakaoPayApprovalVO kakao, HttpSession session) {
		//order, payment의 pay - id
		System.out.println("TID:" + kakao.getTid());
		
		Member loginUser = memberService.selectMemberById(memberId);

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
			od.setOrderState(OrderState.PAID);
			detailList.add(od);
			pdtService.calculateStock(od.getPdt(), od.getQuantity()); // 주문 수량만큼 재고 차감
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
		order.setPayDate(LocalDateTime.now());
		order.setSettleCase("카카오페이");
		order.setState(OrderState.PAID.getLabel());
		order.setMisu(0);
		log.info("insert order..........................................");
		mapper.insertOrder(order);
		
		
		//결제정보 얻어오기
//		String pg_token = request.getParameter("pg_token");
		System.out.println("pg_token: " + pg_token);
		System.out.println("결제정보:" + kakao);
		
		//payment insert
		Payment pay = new Payment();
		pay.setId(kakao.getTid());
		pay.setKakao(kakao);
		pay.setPayPrice(Integer.parseInt(finalPrice));
		pay.setMember(loginUser);
		pay.setOrder(order);
		pay.setPayType(kakao.getPayment_method_type());
		pay.setQuantity(kakao.getQuantity());
		pay.setPayDate(LocalDateTime.now());
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
	public List<Order> selectOrderById(SearchCriteriaForOrder cri, String id) {
		return mapper.selectOrderById(cri, id);
	}

	@Override
	public int selectOrderByIdCount(SearchCriteriaForOrder cri, String id) {
		// TODO Auto-generated method stub
		return mapper.selectOrderByIdCount(cri, id);
	}
	
	@Override
	public Order getOrderByNo(String id) {
		return mapper.getOrderByNo(id);
	}


	@Override
	public List<Order> searchByDate(SearchCriteriaForOrder cri, String start, String end, String memId) {
		// TODO Auto-generated method stub 
		return mapper.searchByDate(cri, start, end, memId);
	}
	
	@Override
	public int searchByDateCount(String start, String end, String memId) {
		// TODO Auto-generated method stub
		return mapper.cancelSearchByDateCount(start, end, memId);
	}
	
	@Override
	public List<Order> cancelSearchByDate(SearchCriteriaForOrder cri, String start, String end, String memId) {
		return mapper.cancelSearchByDate(cri, start, end, memId);
	}
	
	@Override
	public int cancelSearchByDateCount(String start, String end, String memId) {
		// TODO Auto-generated method stub
		return mapper.cancelSearchByDateCount(start, end, memId);
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
	public List<Order> selectCancelOrderById(SearchCriteriaForOrder cri, String id) {
		return mapper.selectCancelOrderById(cri, id);
	}
	
	@Override
	public int selectCancelOrderByIdCount(SearchCriteriaForOrder cri, String id) {
		// TODO Auto-generated method stub
		return mapper.selectCancelOrderByIdCount(cri, id);
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
		
		// 조건부 무료배송 상품 총 금액이 3만원 미만이고 무료배송 상품도 없다면 조건부 유료배송
		if(totalPriceOfCondiFeePdt > 0 && totalPriceOfCondiFeePdt <= 30000 && hasFreeDelivery == false) {
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
		
		//System.out.println(totalDeliveryFee + " = " + chargedDeliveryFee + " + " + (totalDeliveryFee - chargedDeliveryFee));
		
		deliveryFee.put("total", totalDeliveryFee);
		deliveryFee.put("conditional", totalDeliveryFee - chargedDeliveryFee);
		deliveryFee.put("charged", chargedDeliveryFee);
		
		
		return deliveryFee;
	}
	

	@Transactional
	@Override
	public int myPageOrderCancel(Order order, List<OrderDetail> odList) {
		
		int res = 0;
		for(OrderDetail od:odList) {
			od.setOrderState(OrderState.CANCEL);
			res += updateAllOrderDetail(od, order.getId());
		}
		
		order.setState(OrderState.CANCEL.getLabel());
		res += updateOrder(order, order.getId());
		return res;
	}

	@Transactional
	@Override
	public int myPageOrderConfirm(OrderDetail od, Member member) {

		int mileage = (int) Math.floor(od.getTotalPrice() * 0.01);
		
		Mileage mile = new Mileage();
		mile.setMileage(mileage);
		mile.setOrder(getOrderByNo(String.valueOf(od.getId())));
		//order -> od도 상태 다를 수 있으니까 od로 바꿔서 개별 적립하는게 맞는듯
		// 배송도 od로 바꾸는게 맞음
		mile.setContent("상품 구매 적립");
		mile.setMember(member);
		mileService.insertMilegeInfo(mile);
		
		od.setOrderState(OrderState.PURCHASE_COMPLETED);
		updatePartOrderDetail(od, od.getId());
		
		return mileage;
	}
	
	

////////////////admin///////////////////////////////////////////////////
	
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
	public List<Order> selectOrderBySearch(Criteria cri, String content, String word, String state, String start, String end, String settleCase, String partCancel, String misu, String returnPrice) {
		// TODO Auto-generated method stub
		return mapper.selectOrderBySearch(cri, content, word, state, start, end, settleCase, partCancel, misu, returnPrice);
	}

	@Override
	public int searchListCount(String content, String word, String state, String start, String end, String settleCase, String partCancel, String misu, String returnPrice) {
		return mapper.searchListCount(content, word, state, start, end, settleCase, partCancel, misu, returnPrice);
	}
	

	@Transactional
	@Override
	public String accountOrderTransaction(String memberId, HttpServletRequest request, HttpSession session) {
		
		// od, order, mileage 처리 -> admin에서 입금완료로 상태 변경하면 payment 테이블에 추가
		
		Member loginUser = memberService.selectMemberById(memberId);

		//pre-order -> 주문한거만 담은 새로운 cartList
		List<Cart> cartList =  (ArrayList)session.getAttribute("cart");
		System.out.println(cartList);
		
		//form -> parameter로 온 것
		String total = request.getParameter("total");
		String deli = request.getParameter("deli");
		String finalPrice = request.getParameter("final");
		String name = request.getParameter("add_name");
		String zipcode = request.getParameter("zipcode");
		String add1 = request.getParameter("address1");
		String add2 = request.getParameter("address2");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String memo = request.getParameter("order_memo");
		String usedMile = request.getParameter("use_mileage");
		String plus_mile = request.getParameter("plus_mile"); 
		
		//새로운 주문번호
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(new Date());
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}
		String nextNo = today + numStr;
		
		
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
			od.setOrderState(OrderState.DEPOSIT_REQUEST);
			detailList.add(od);
			pdtService.calculateStock(od.getPdt(), od.getQuantity());
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
		order.setTotalPrice(Integer.parseInt(total));
		order.setUsedMileage(Integer.parseInt(usedMile));
		order.setFinalPrice(Integer.parseInt(finalPrice));
		order.setPlusMileage(Integer.parseInt(plus_mile));
		order.setDeliveryPrice(Integer.parseInt(deli));
		order.setSettleCase("무통장");
		order.setState(OrderState.DEPOSIT_REQUEST.getLabel());
		order.setMisu(Integer.parseInt(finalPrice));
		log.info("insert order..........................................");
		mapper.insertOrder(order);
		System.out.println(order);
		
		int myMileage = mileService.getMileage(loginUser.getId());
		
		//현재마일리지
		System.out.println("현재 마일리지: " + myMileage);
		
		//보유금액 -일때
		if(usedMile.contains("-")) {
			usedMile = usedMile.replace("-", "");
		}
		
		
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
	
		return "/accountPaySuccess?id=" + nextNo;
		
	}

	@Override
	public int insertAccountPayment(Payment pay) {
		// TODO Auto-generated method stub
		return mapper.insertAccountPayment(pay);
	}

	@Override
	public Payment selectAccountPaymentByOrderId(String orderId) {
		// TODO Auto-generated method stub
		return mapper.selectAccountPaymentByOrderId(orderId);
	}

	
	@Transactional
	@Override
	public int adminInsertPaymentAndOrderUpdate(Map<String, String> map) {
		
		log.info("admin insert pay & update order");
		int res = 0;
		//2021-03-03 00:33:07
		
		String price = null;
		String depositor = null;
		String cancelPrice = null; 
		int payPrice = 0;
		
		if(map.get("price") != null) {
			price = map.get("price");
			payPrice = Integer.parseInt(price);
		}
		
		if(map.get("depositor") != null) {
			depositor =  map.get("depositor");
		}
		
		
		if(map.get("cancelPrice") != null) {
			cancelPrice = map.get("cancelPrice");
		}
		
		String order = map.get("order");
		String qtt = map.get("qtt");
		String payDate = map.get("payDate");
		String deli = map.get("deli");
		String addDeli = map.get("addDeli");
		
		Order o = getOrderByNo(order);

		String trackingNumber = null;
		String shippingDate = null;
		
		if(map.get("trackingNum") != null && map.get("trackingNum") != "") {
			trackingNumber = map.get("trackingNum");
			o.setTrackingNumber(trackingNumber);
			
		}
		
		if(map.get("shippingDate") != null && map.get("shippingDate") != "") {
			shippingDate = map.get("shippingDate");
			o.setShippingDate(LocalDateTime.parse(shippingDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm").withLocale(Locale.KOREA)));
		}
		
		Member member = null;
		if(depositor != null) {
			member = memberService.selectMemberById(depositor);
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String today = sdf.format(new Date());
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}
		String payId = today + numStr;
		
		//pay가 null이면 insert, 있으면 update
	
		
		if(o.getSettleCase().equals("카카오페이")) {
			System.out.println("카카오");
			
			Payment pay = getPaymentById(o.getPayId());
			KakaoPayApprovalVO kakao = kakaoService.kakaoPayInfo(pay.getId());
			int partCancel = kakao.getCanceled_amount().getTotal();
			
			o.setCancelPrice(Integer.parseInt(cancelPrice));
			o.setDeliveryPrice(Integer.parseInt(deli));
			o.setAddDeliveryPrice(Integer.parseInt(addDeli));
			
			// payPrice = 카카오결제금액
			pay.setPayPrice(payPrice);
			pay.setPayDate(LocalDateTime.parse(payDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm").withLocale(Locale.KOREA)));
			
			log.info("update pay");
			res += updatePayment(pay, pay.getId());
			
			o.setFinalPrice(o.getTotalPrice() + o.getDeliveryPrice() + o.getAddDeliveryPrice() - o.getUsedMileage());
			o.setMisu(o.getFinalPrice() - o.getReturnPrice() + Integer.parseInt(cancelPrice) - payPrice - partCancel);
			
			System.out.println("입금액:" + payPrice);
			System.out.println("환불금액:" + cancelPrice);
			System.out.println("주문취소" + o.getReturnPrice());
			System.out.println("카카오 부분취소된금액:" + kakao.getCanceled_amount().getTotal());
			
			res += updateOrder(o, o.getId());
	
			
		}else {
			
			//무통장
			int p = 0;
			Payment pay = selectAccountPaymentByOrderId(o.getId());
			
			if(pay != null) {
				
				p = pay.getPayPrice();
				
				pay.setMember(member);
				pay.setPayPrice(payPrice);
				pay.setPayDate(LocalDateTime.parse(payDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm").withLocale(Locale.KOREA)));
				pay.setPayState(o.getState());
				pay.setPayType("무통장");
				pay.setQuantity(Integer.parseInt(qtt));
				log.info("update pay");
				res += updatePayment(pay, pay.getId());
				
			}else {
				if(payPrice != 0) {
				
					Payment newPay = new Payment();
					
					System.out.println("새로운 payId: " + payId);
					newPay.setId(payId);
					newPay.setMember(member);
					newPay.setOrder(o);
					newPay.setPayPrice(Integer.parseInt(price));
					newPay.setPayDate(LocalDateTime.parse(payDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm").withLocale(Locale.KOREA)));
					newPay.setPayState(o.getState());
					newPay.setPayType("무통장입금");
					newPay.setQuantity(Integer.parseInt(qtt));
					System.out.println(pay);
					log.info("insert pay");
					insertAccountPayment(newPay);
					
					o.setPayId(newPay.getId());					
					
				}
			
			}
			

			o.setCancelPrice(Integer.parseInt(cancelPrice));
			o.setDeliveryPrice(Integer.parseInt(deli));
			o.setAddDeliveryPrice(Integer.parseInt(addDeli));
			
			//최종금액 = 현재 total + 배송비 + 추가 배송비 
			o.setFinalPrice(o.getTotalPrice() + o.getDeliveryPrice() + o.getAddDeliveryPrice() - o.getUsedMileage());
			System.out.println("최종금액:" + o.getTotalPrice() + o.getDeliveryPrice() + o.getAddDeliveryPrice());
			

			if(payPrice == 0) {
				//미수 = 환불 + 취소 
				System.out.println("payPrice = 0");
				o.setMisu(o.getFinalPrice() - o.getReturnPrice() + Integer.parseInt(cancelPrice));
			}else {
				
				//총결제액 = 입금액 이면  총금액에서 빼기

				if(p != payPrice) {
					System.out.println("p != price");
					if(o.getFinalPrice() == payPrice) {
						System.out.println("final = payprice");
						o.setMisu(Integer.parseInt(cancelPrice) + o.getReturnPrice());
					}else {
						System.out.println("final != payprice");
						//o.setMisu(o.getFinalPrice() - payPrice + Integer.parseInt(cancelPrice) + o.getReturnPrice());
						o.setMisu(o.getFinalPrice() - o.getReturnPrice() + Integer.parseInt(cancelPrice) - payPrice);
						// 43000-23000+0-20000 = 0
					}
					
				}else {
					System.out.println("p == price");
					if(o.getFinalPrice() == payPrice) {
						System.out.println("final = payprice");
						o.setMisu(o.getFinalPrice() - o.getReturnPrice() + Integer.parseInt(cancelPrice) - payPrice);
					}else if(o.getFinalPrice() != payPrice) {
						System.out.println("final != payprice");
						int cp = Integer.parseInt(cancelPrice);
						
						if(cp != o.getCancelPrice()) {
							System.out.println("cp != cancelprice");
							o.setMisu(o.getMisu() + cp);
						}else {
							o.setMisu(o.getFinalPrice() - o.getReturnPrice() + Integer.parseInt(cancelPrice) - payPrice);
						}
					}
				}
			}
			System.out.println("입금액:" + payPrice);
			System.out.println("환불금액:" + cancelPrice);
			System.out.println("주문취소" + o.getReturnPrice());
			
			res += updateOrder(o, o.getId());
			
		
		}
		
		return res;
	}

	@Override
	public List<OrderDetail> selectNotSoldOutOrderDetailById(String orderId) {
		// TODO Auto-generated method stub
		return mapper.selectNotSoldOutOrderDetailById(orderId);
	}

	@Override
	public List<Order> selectOrderByMonth(String memId) {
		// TODO Auto-generated method stub
		return mapper.selectOrderByMonth(memId);
	}

	
	@Transactional
	@Override
	public int UpdateOrderState(String[] od, String status, HttpServletRequest request) {
		
		int res = 0;
		//od id list
		Order order = null;
		Payment pay = null;
		
		for(int i=0; i<od.length; i++) {
			
			OrderDetail ord = getOrderDetailById(od[i]);
			order = getOrderByNo(ord.getOrderId());
			List<OrderDetail> odList = getOrderDetail(ord.getOrderId());
			pay = selectAccountPaymentByOrderId(order.getId());
			
			//품절상태에서 다른 상태로 되돌리면 복구
			
			if(!status.equals(OrderState.SOLD_OUT.getLabel()) && 
					!status.equals(OrderState.CANCEL.getLabel()) &&
					!status.equals(OrderState.RETURN.getLabel())) {
					
			//대기, 결제, 배송, 완료는 하나라도 변경 시 order도 변경
			
				if(!ord.getOrderState().getLabel().equals(OrderState.DEPOSIT_REQUEST.getLabel()) 
						&& !ord.getOrderState().getLabel().equals(OrderState.PAID.getLabel()) 
						&& !ord.getOrderState().getLabel().equals(OrderState.SHIPPING.getLabel()) 
						&& !ord.getOrderState().getLabel().equals(OrderState.DELIVERED.getLabel())){
						
						if(status.equals("대기")) {
							ord.setOrderState(OrderState.DEPOSIT_REQUEST);
							order.setState(OrderState.DEPOSIT_REQUEST.getLabel());
		
						}else if(status.equals("결제")) {
							ord.setOrderState(OrderState.PAID);
							order.setState(OrderState.PAID.getLabel());
			
						}else if(status.equals("배송")) {
							ord.setOrderState(OrderState.SHIPPING);
							order.setState(OrderState.SHIPPING.getLabel());
				
						}else if(status.equals("완료")) {
							ord.setOrderState(OrderState.DELIVERED);
							order.setState(OrderState.DELIVERED.getLabel());
						}
						

						if(order.getPayId() == null) {
							System.out.println("pay 없음");
							System.out.println(ord);
							//현재 51000. return = 0 + 33000취소
							//order.setReturnPrice(order.getReturnPrice() + ord.getTotalPrice());
							//order.setMisu(order.getFinalPrice() - order.getReturnPrice());
							//미수 = 51000 - 33000 + 0 = 18000
							
							//33000 - 33000 = 0
							order.setReturnPrice(order.getReturnPrice() - ord.getTotalPrice());
							order.setMisu(order.getFinalPrice() - order.getReturnPrice()); 
							
							//54000 - 0
						
						}else {
							System.out.println("pay있음");
							order.setReturnPrice(order.getReturnPrice() - ord.getTotalPrice());	
							order.setMisu(order.getMisu() + ord.getTotalPrice());
	
							//order.setMisu(order.getFinalPrice() - order.getReturnPrice() + order.getCancelPrice() - ord.getTotalPrice() - pay.getPayPrice());
						}
						
						updatePartOrderDetail(ord, ord.getId());
						updateOrder(order, order.getId());
						
						
				} else {
						
					if(status.equals("대기")) {
						ord.setOrderState(OrderState.DEPOSIT_REQUEST);
						order.setState(OrderState.DEPOSIT_REQUEST.getLabel());
	
					}else if(status.equals("결제")) {
						ord.setOrderState(OrderState.PAID);
						order.setState(OrderState.PAID.getLabel());
		
					}else if(status.equals("배송")) {
						ord.setOrderState(OrderState.SHIPPING);
						order.setState(OrderState.SHIPPING.getLabel());
			
					}else if(status.equals("완료")) {
						ord.setOrderState(OrderState.DELIVERED);
						order.setState(OrderState.DELIVERED.getLabel());
					}
					
					updatePartOrderDetail(ord, ord.getId());
					updateOrder(order, order.getId());
				}
				
					
				
					
					
			//취소, 반품, 품절일때 -> 상세 각자 상태변경
			//대기 상태에서 변경 order 미수금에서 해당 상품 금액 빼기
			//입금 상태에서 품절 시 전체금액 - 해당상품금액 -> 미수금 마이너스됨 -> 취소/환불금액에서 입력하면 처리
			//주문 총액은 변경 x 미수만 변경	
			//반품,품절금액 -> return_price에 반영 
			//결제 취소 금액 -> cancel_price. 최종미수금에서 + 
				
			//무통장일때 pay가 존재하지 않으면 미수도 0
				
			} else { 
				
				//취소반품 품절일때 중복 변경 x
				if(!ord.getOrderState().getLabel().equals(OrderState.CANCEL.getLabel()) 
						&& !ord.getOrderState().getLabel().equals(OrderState.RETURN.getLabel()) 
						&& !ord.getOrderState().getLabel().equals(OrderState.SOLD_OUT.getLabel())){
					
					if(status.equals("취소")) {
						ord.setOrderState(OrderState.CANCEL);
					}else if(status.equals("반품")) {
						ord.setOrderState(OrderState.RETURN);	
					}else if(status.equals("품절")) {
						ord.setOrderState(OrderState.SOLD_OUT);
					}

					if(order.getPayId() == null) {
						System.out.println("pay 없음");
						
						// 무통장시 미수금 있음 지금 미수에서 -> 취소시 해당 ord의 total 빼기
						//현재 51000. return = 0 + 33000취소
						order.setReturnPrice(order.getReturnPrice() + ord.getTotalPrice());
						order.setMisu(order.getFinalPrice() - order.getReturnPrice());
						//미수 = 51000 - 33000 + 0 = 18000
						
						//대기,결제
						//order.setReturnPrice(order.getReturnPrice() - ord.getTotalPrice());
						//order.setMisu(order.getFinalPrice() - order.getReturnPrice()); 
					
					}else {
						//주문취소에 추가  => 현재 취소액 + 선택한 금액
						System.out.println("pay있음");
						order.setReturnPrice(order.getReturnPrice() + ord.getTotalPrice());
						order.setMisu(order.getMisu() - ord.getTotalPrice());
	
					}
					
				}else {
					System.out.println("취반품");
					System.out.println(status + " - " + ord.getOrderState().getLabel());
					if(status.equals("취소")) {
						ord.setOrderState(OrderState.CANCEL);
					}else if(status.equals("반품")) {
						ord.setOrderState(OrderState.RETURN);	
					}else if(status.equals("품절")) {
						ord.setOrderState(OrderState.SOLD_OUT);
					}

				}

				updatePartOrderDetail(ord, ord.getId());
				updateOrder(order, order.getId());
				
			}
				
			
			if(odList.size() == od.length) {
				// 전체선택 ->  order의 상태도 같이 변경
				// 하나라도 있으면 유지
				// 하나 취소 -> 상태유지
				order.setState(status);
				updateOrder(order, order.getId());
			}
			
	
		} //end
		
		//모든 처리 후 현재 모든 status가 동일하면 order도 같이 변경
		
		List<OrderDetail> odList = null;
		for(int i=0; i<od.length; i++) {
			OrderDetail ord = getOrderDetailById(od[i]);
			odList = getOrderDetail(ord.getOrderId());
			order = getOrderByNo(ord.getOrderId());
			
			int j = 0;
			for(i=0; i<odList.size(); i++) {
				if(odList.get(i).getOrderState().getLabel().equals(status)) {
					j++;
				}
			}
			if(j == odList.size()) {
				order.setState(status);
				updateOrder(order, order.getId());
			}
			
		}
		
		//최종 미수: 품절 아닌 odList의 가격 - 입금액
		int deposit = 0;
		int pdtPrice = 0;
		
		List<OrderDetail> notSoldOutList = selectNotSoldOutOrderDetailById(order.getId());
		
		if(pay == null) {
			deposit = 0;
			for(OrderDetail notSoldOutOd: notSoldOutList) {
				pdtPrice += notSoldOutOd.getPdt().getPrice() * notSoldOutOd.getQuantity();
			}
			
		}else {
			deposit = pay.getPayPrice();
			for(OrderDetail notSoldOutOd: notSoldOutList) {
				pdtPrice += notSoldOutOd.getPdt().getPrice() * notSoldOutOd.getQuantity();
			}
			System.out.println(pdtPrice);
		}
		
					
		return res;
	}



}
