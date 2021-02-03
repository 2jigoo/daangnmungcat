package daangnmungcat.mapper;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import daangnmungcat.dto.Cart;
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
	
}
