package daangnmungcat.mapper;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.Payment;

public interface OrderMapper {
	
	List<Order> selectOrderAll(Criteria cri);
	int listCount();
	
	List<Order> selectOrderBySearch(@Param("cri")Criteria cri, @Param("content")String content, @Param("word")String word, 
									@Param("stateStr") String state, @Param("start") String start, @Param("end") String end);
	
	int searchListCount(@Param("content")String content, @Param("word")String word, 
						@Param("stateStr") String state, @Param("start") String start, @Param("end") String end);
	
	/////////////////////
	List<Order> selectOrderById(String id);
	List<Order> selectCancelOrderById(String id);
	
	Payment getPaymentById(String tid);
	Payment selectAccountPaymentByOrderId(String orderId);
	
	Order getOrderByNo(String id);
	List<OrderDetail> selectOrderDetailByOrderNo(String orderId);
	OrderDetail getOrderDetailById(String id);
	
	int insertOrderDetail(OrderDetail od);
	int insertOrder(Order order);
	int insertPayment(Payment pay);
	int insertAccountPayment(Payment pay);
	
	List<OrderDetail> sortingOrderDetail(@Param("orderId")String id);
	List<OrderDetail> selectNotSoldOutOrderDetailById(String id);
	
	List<Order> searchByDate(@Param("dateFrom")String start,  @Param("dateTo")String end, @Param("mem_id")String memId);
	List<Order> cancelSearchByDate(@Param("dateFrom")String start,  @Param("dateTo")String end, @Param("mem_id")String memId);

	int updateAllOrderDetail(OrderDetail od);
	int updatePartOrderDetail(OrderDetail od);
	int updateOrder(Order order);
	int updatePayment(Payment pay);
	
	List<OrderDetail> selectOrderDetailUsingPartCancelByOrderId(String orderId);
}
