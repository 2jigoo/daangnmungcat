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
	Order getOrderByNo(int id);
	List<OrderDetail> getOrderDetail(int orderNo);
	
	int nextOrderNo();
	int nextPayNo();
	
	int insertOrderDetail(OrderDetail od);
	int insertOrder(Order order);
	int insertPayment(Payment pay);
	
	List<Order> orderListById(String id);
	List<OrderDetail> sortingOrderDetail(int orderId);
	
	List<Order> searchByDate(@Param("dateFrom")String start,  @Param("dateTo")String end, @Param("member")Member member);
}
