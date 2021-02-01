package daangnmungcat.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Cart;
import daangnmungcat.dto.KakaoPayApprovalVO;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.Payment;
import daangnmungcat.mapper.OrderMapper;
import daangnmungcat.service.CartService;
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
	private OrderMapper mapper;

	@Transactional
	@Override
	public void orderTransaction(KakaoPayApprovalVO kakao, HttpServletRequest request, HttpSession session) {
		
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = memberService.selectMemberById(info.getId());

		//pre-order -> 주문한거만 담은 새로운 cartList
		List<Cart> cartList =  (ArrayList)session.getAttribute("cart");
		//parameter로 온 것
		int total = (int) session.getAttribute("total");
		int deli = (int) session.getAttribute("deli");
		int final_price = (int) session.getAttribute("final_price");
		int plus_mile = (int) session.getAttribute("plus_mile");
		
		System.out.println("total::" + final_price);
		
		//받은 session
		String name = (String) session.getAttribute("add_name");
		String zipcode = (String) session.getAttribute("zipcode");
		String add1 = (String) session.getAttribute("add1");
		String add2 = (String) session.getAttribute("add2");
		String phone1 = (String) session.getAttribute("phone1");
		String phone2 = (String) session.getAttribute("phone2");
		String memo = (String) session.getAttribute("memo");
		String usedMile = (String) session.getAttribute("usedMile");
		
		if(usedMile.equals("")) {
			usedMile = "0";
		}
		
		//order 다음 번호
		int nextOrderNo = nextOrderNo();
				
		//주문할 리스트 -> detail에 추가
		List<OrderDetail> detailList = new ArrayList<OrderDetail>();
		
		OrderDetail od = new OrderDetail();
		for(Cart c: cartList) {
			detailList.add(new OrderDetail(c));	
			od.setOrderId(nextOrderNo);
			od.setCart(c);
			od.setMember(loginUser);
			od.setTotalPrice(c.getProduct().getPrice() * c.getQuantity());
		}
		log.info("insert od..........................................");
		mapper.insertOrderDetail(od);
		
		//order insert
		int nextPayNo = nextPayNo(); 
		
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
		order.setFinalPrice(final_price);
		order.setPlusMileage(plus_mile);
		order.setDeliveryPrice(deli);
		order.setPayId(nextPayNo);
		log.info("insert order..........................................");
		mapper.insertOrder(order);
		
		//결제정보 얻어오기
		String pg_token = request.getParameter("pg_token");
		System.out.println("pg_token: " + pg_token);
		System.out.println("결제정보:" + kakao);
		
		//payment insert
		Payment pay = new Payment();
		pay.setId(nextPayNo);
		pay.setKakao(kakao);
		pay.setMember(loginUser);
		pay.setOrder(order);
		pay.setPayType(kakao.getPayment_method_type());
		pay.setQuantity(kakao.getQuantity());
		System.out.println("pay:" + pay);
		mapper.insertPayment(pay);
		log.info("insert payment..........................................");
		
		
		for(Cart c :cartList) {
			cartService.deleteCartItem(c);
		}
		log.info("주문한 카트아이템만 카트에서 삭제");
		
		//멤버 마일리지에서 use_mile 사용 -> 내 마일리지에서 감소/ 사용내역 테이블에 추가
		//plus mile은 증가 
		
		System.out.println("사용한 마일리지:" + usedMile);
		System.out.println("적립 마일리지:" + plus_mile);
		
		int mile = loginUser.getMileage();
		System.out.println("현재마일리지:" + mile);
//		mile += plus_mile;
		Mileage plus = new Mileage();
		plus.setMember(loginUser);
		plus.setOrderDetail(od);
		plus.setMileage("+" + plus_mile);
		plus.setContent("상품 구매 적립");
		mileService.insertMilegeInfo(plus);
		
//		mile -= Integer.parseInt(usedMile);
		Mileage minus = new Mileage();
		minus.setMember(loginUser);
		minus.setOrderDetail(od);
		minus.setMileage("-" + usedMile);
		minus.setContent("상품 구매 사용");
		
		if(!usedMile.equals("0")) {
			mileService.insertMilegeInfo(minus);
		}
		
//		loginUser.setMileage(mile);
//		System.out.println("처리후:" + mile);
//		mileService.updateMemberMileage(loginUser);
		
		log.info("마일리지 set / 내역테이블 insert");
		
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
	public List<OrderDetail> getOrderDetail(int orderNo) {
		// TODO Auto-generated method stub
		return mapper.getOrderDetail(orderNo);
	}

	@Override
	public int nextOrderNo() {
		return mapper.nextOrderNo();
	}

	@Override
	public int nextPayNo() {
		// TODO Auto-generated method stub
		return mapper.nextPayNo();
	}

	@Override
	public int insertPayment(Payment pay) {
		// TODO Auto-generated method stub
		return mapper.insertPayment(pay);
	}


}
