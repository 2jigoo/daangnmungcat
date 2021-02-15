package daangnmungcat.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Member;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.Payment;
import daangnmungcat.dto.kakao.KakaoPayApprovalVO;

@Service
public interface OrderService {

	List<Order> selectOrderById(String id);
	List<Order> selectCancelOrderById(String id);
	
	Order getOrderByNo(String id);
	OrderDetail getOrderDetailById(String id);
	
	int insertOrder(Order order);
	
	List<OrderDetail> getOrderDetail(String orderNo);

	int insertPayment(Payment pay);

	int insertOrderDetail(OrderDetail orderDetail);


	List<OrderDetail> sortingOrderDetail(String id);
	
	List<Order> searchByDate(String start, String end, String memId);
	List<Order> cancelSearchByDate(String start, String end,String memId);
	
	void orderTransaction(KakaoPayApprovalVO kakao, HttpServletRequest request, HttpSession session);
	
	int updateAllOrderDetailState(String state,String orderId);
	int updatePartOrderDetailState(String state,String id);
	int updateOrderState(int price, String state, String id);
	int updatePaymentState(String state, String id);
	
	
}
