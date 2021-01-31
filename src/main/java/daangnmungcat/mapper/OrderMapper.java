package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;

public interface OrderMapper {

	int insertOrder(Order order);

	List<OrderDetail> getOrderDetail(int orderNo);
	
	int nextOrderNo();

	int insertOrderDetail(OrderDetail od);
}
