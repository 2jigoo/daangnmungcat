package daangnmungcat.mapper;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.Payment;

public interface OrderMapper {
	
	List<Order> selectOrderById(String id);
	List<Order> selectCancelOrderById(String id);
	
	Order getOrderByNo(String id);
	List<OrderDetail> selectOrderDetailByOrderNo(String orderId);
	OrderDetail getOrderDetailById(String id);
	
	int insertOrderDetail(OrderDetail od);
	int insertOrder(Order order);
	int insertPayment(Payment pay);
	
	List<OrderDetail> sortingOrderDetail(@Param("orderId")String id);
	
	List<Order> searchByDate(@Param("dateFrom")String start,  @Param("dateTo")String end, @Param("mem_id")String memId);
	List<Order> cancelSearchByDate(@Param("dateFrom")String start,  @Param("dateTo")String end, @Param("mem_id")String memId);

	int updateAllOrderDetailState(@Param("orderState")String state, @Param("orderId") String id);
	int updatePartOrderDetailState(@Param("orderState")String state, @Param("id") String id);
	int updateOrderState(@Param("returnPrice") int price, @Param("state")String state, @Param("id") String id);
	int updatePaymentState(@Param("payState")String state, @Param("id") String id);
}
