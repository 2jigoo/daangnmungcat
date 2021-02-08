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
	Order getOrderByNo(String id);
	List<OrderDetail> getOrderDetail(String orderId);
	
	int insertOrderDetail(OrderDetail od);
	int insertOrder(Order order);
	int insertPayment(Payment pay);
	
	List<OrderDetail> sortingOrderDetail(@Param("orderId")String orderId);
	
	List<Order> searchByDate(@Param("dateFrom")String start,  @Param("dateTo")String end, Member member);
}
