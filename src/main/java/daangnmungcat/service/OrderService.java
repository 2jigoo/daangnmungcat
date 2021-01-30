package daangnmungcat.service;

import java.util.List;

import org.springframework.stereotype.Service;

import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;

@Service
public interface OrderService {

	int insertOrder(Order order);
	
	List<OrderDetail> getOrderDetail(int orderNo);
	
	int nextOrderNo();

	int insertOrderDetail(OrderDetail od);

}
