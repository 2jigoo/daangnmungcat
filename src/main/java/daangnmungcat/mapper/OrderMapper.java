package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.Payment;
import daangnmungcat.dto.SearchCriteriaForOrder;

public interface OrderMapper {
	
	List<Order> selectOrderById(@Param("cri")SearchCriteriaForOrder cri, @Param("id")String id);
	int selectOrderByIdCount(@Param("cri")SearchCriteriaForOrder cri, @Param("id")String id);
	
	List<Order> selectCancelOrderById(@Param("cri")SearchCriteriaForOrder cri, @Param("id")String id);
	int selectCancelOrderByIdCount(@Param("cri")SearchCriteriaForOrder cri, @Param("id")String id);
	
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
	
	List<Order> searchByDate(@Param("cri")Criteria cri, @Param("dateFrom")String start,  @Param("dateTo")String end, @Param("mem_id")String memId);
	int searchByDateCount(@Param("dateFrom")String start,  @Param("dateTo")String end, @Param("mem_id")String memId);
	
	List<Order> cancelSearchByDate(@Param("cri")Criteria cri, @Param("dateFrom")String start,  @Param("dateTo")String end, @Param("mem_id")String memId);
	int cancelSearchByDateCount(@Param("dateFrom")String start,  @Param("dateTo")String end, @Param("mem_id")String memId);
	
	int updateAllOrderDetail(OrderDetail od);
	int updatePartOrderDetail(OrderDetail od);
	int updateOrder(Order order);
	int updatePayment(Payment pay);
	
	List<OrderDetail> selectOrderDetailUsingPartCancelByOrderId(String orderId);
	List<Order> selectOrderByMonth(String memId);
	
	//admin
	
	List<Order> selectOrderAll(Criteria cri);
	int listCount();
	
	List<Order> selectOrderBySearch(@Param("cri")Criteria cri, @Param("content")String content, @Param("word")String word, 
									@Param("stateStr") String state, @Param("start") String start, @Param("end") String end, 
									@Param("settleCase") String settleCase, @Param("partCancel") String partCancel,
									@Param("misu") String misu, @Param("return") String returnPrice);
	
	int searchListCount(@Param("content")String content, @Param("word")String word, 
						@Param("stateStr") String state, @Param("start") String start, @Param("end") String end, 
						@Param("settleCase") String settleCase, @Param("partCancel") String partCancel,
						@Param("misu") String misu, @Param("return") String returnPrice);
	
	
}
