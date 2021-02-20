package daangnmungcat.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.Payment;
import daangnmungcat.dto.kakao.KakaoPayApprovalVO;

@Service
public interface OrderService {
	
	List<Order> selectOrderAll(Criteria cri);
	int listCount();
	List<Order> selectOrderBySearch(String content, String word, Criteria cri);
	int searchListCount(String content, String word);
	
	/////////////////////////////////////
	List<Order> selectOrderById(String id);
	List<Order> selectCancelOrderById(String id);
	
	Order getOrderByNo(String id);
	OrderDetail getOrderDetailById(String id);
	Payment getPaymentById(String tid);
	
	int insertOrder(Order order);
	
	List<OrderDetail> getOrderDetail(String orderNo);

	int insertPayment(Payment pay);

	int insertOrderDetail(OrderDetail orderDetail);


	List<OrderDetail> sortingOrderDetail(String id);
	
	List<Order> searchByDate(String start, String end, String memId);
	List<Order> cancelSearchByDate(String start, String end,String memId);
	
	void orderTransaction(KakaoPayApprovalVO kakao, HttpServletRequest request, HttpSession session);
	
	int updateAllOrderDetail(OrderDetail od, String orderId);
	int updatePartOrderDetail(OrderDetail od, int id);
	int updateOrder(Order order, String orderId);
	int updatePayment(Payment pay, String id);
	
	List<OrderDetail> selectOrderDetailUsingPartCancelByOrderId(String orderId);
	Map<String, Integer> calculateDeliveryFee(List<Cart> list);
	
	
	
}
