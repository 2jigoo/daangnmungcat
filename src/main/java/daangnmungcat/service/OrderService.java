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
	
	List<Order> selectOrderBySearch(String content, String word, String state, String start, String end, String settleCase, String partCancel, String misu, String returnPrice, Criteria cri);
	int searchListCount(String content, String query, String state, String start, String end, String settleCase, String partCancel, String misu, String returnPrice);
	
	List<OrderDetail> selectNotSoldOutOrderDetailById(String orderId);
	
	/////////////////////////////////////
	
	List<Order> selectOrderById(Criteria cri, String id);
	int selectOrderByIdCount(String id);
	
	List<Order> selectCancelOrderById(Criteria cri, String id);
	int selectCancelOrderByIdCount(String id);
	
	List<Order> searchByDate(Criteria cri, String start, String end, String memId);
	int searchByDateCount(String start, String end, String memId);
	
	List<Order> cancelSearchByDate(Criteria cri, String start, String end,String memId);
	int cancelSearchByDateCount(String start, String end, String memId);
	
	Order getOrderByNo(String id);
	OrderDetail getOrderDetailById(String id);
	Payment getPaymentById(String tid);
	Payment selectAccountPaymentByOrderId(String orderId);
	
	int insertOrder(Order order);
	
	List<OrderDetail> getOrderDetail(String orderNo);

	int insertPayment(Payment pay);
	int insertAccountPayment(Payment pay);

	int insertOrderDetail(OrderDetail orderDetail);
	int adminInsertPaymentAndOrderUpdate(Map<String, String> map);

	List<OrderDetail> sortingOrderDetail(String id);
	
	void kakaoOrderTransaction(String memberId, String pg_token, KakaoPayApprovalVO kakao, HttpSession session);
	String accountOrderTransaction(String memberId, HttpServletRequest request, HttpSession session);
	
	int updateAllOrderDetail(OrderDetail od, String orderId);
	int updatePartOrderDetail(OrderDetail od, int id);
	int updateOrder(Order order, String orderId);
	int updatePayment(Payment pay, String id);
	
	List<OrderDetail> selectOrderDetailUsingPartCancelByOrderId(String orderId);
	Map<String, Integer> calculateDeliveryFee(List<Cart> list);
	
	
	
	
}
