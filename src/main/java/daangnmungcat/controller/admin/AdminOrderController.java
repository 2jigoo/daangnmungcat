package daangnmungcat.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.service.OrderService;

@Controller
public class AdminOrderController {
	
	@Autowired
	private OrderService orderService;
	
	
	@GetMapping("/admin/order/list")
	public ModelAndView orderList(Criteria cri) {
		
		List<Order> list = orderService.selectOrderAll(cri);
		
		for(Order o: list) {
			List<OrderDetail> odList = orderService.sortingOrderDetail(o.getId());
			o.setDetails(odList);
			for(OrderDetail od: odList) {
				od.setOrderId(o.getId());
			}
		}
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(orderService.listCount());
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.addObject("pageMaker", pageMaker);
		mv.setViewName("/admin/order/order_list");
		
		return mv;
	}
	
}
