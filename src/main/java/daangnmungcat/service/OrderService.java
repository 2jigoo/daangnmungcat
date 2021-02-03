package daangnmungcat.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import daangnmungcat.dto.KakaoPayApprovalVO;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.Payment;

@Service
public interface OrderService {

	List<Order> selectOrderById(String id);
	Order getOrderByNo(int id);
	
	int insertOrder(Order order);
	
	List<OrderDetail> getOrderDetail(int orderNo);
	
	int nextOrderNo();
	int nextPayNo();

	int insertPayment(Payment pay);

	int insertOrderDetail(OrderDetail orderDetail);

	void orderTransaction(KakaoPayApprovalVO kakao, HttpServletRequest request, HttpSession session);



}
