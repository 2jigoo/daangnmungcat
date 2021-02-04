package daangnmungcat.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.KakaoPayApprovalVO;
import daangnmungcat.dto.Member;
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

	List<OrderDetail> sortingOrderDetail(int orderId);
	
	List<Order> searchByDate(String start, String end, Member member);
	List<Order> search(Map<String, Object> map);
}
