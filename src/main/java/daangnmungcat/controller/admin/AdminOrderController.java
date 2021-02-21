package daangnmungcat.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public ModelAndView orderList(Criteria cri, @Nullable @RequestParam String content, @Nullable @RequestParam String query,
			@Nullable @RequestParam String state,
			@Nullable @RequestParam String start, @Nullable @RequestParam String end) {
		System.out.println(content);
		System.out.println(query);
		System.out.println(state);
		System.out.println(start + "/"+ end);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		List<Order> list = null;
		
		if(content != null  || query != null || state != null ||  start != null || end != null) {
			list = orderService.selectOrderBySearch(content, query, state,  start, end, cri);
			pageMaker.setTotalCount(orderService.searchListCount(content, query, state, start, end));
			System.out.println(orderService.searchListCount(content, query, state, start, end));
		}else {
			list = orderService.selectOrderAll(cri);
			pageMaker.setTotalCount(orderService.listCount());
			System.out.println(orderService.listCount());
		}
		
		for(Order o: list) {
			List<OrderDetail> odList = orderService.sortingOrderDetail(o.getId());
			o.setDetails(odList);
			for(OrderDetail od: odList) {
				od.setOrderId(o.getId());
			}
		}
		
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("totalCnt", orderService.listCount());
		mv.addObject("list", list);
		mv.addObject("pageMaker", pageMaker);
		mv.addObject("content", content);
		mv.addObject("query", query);
		mv.addObject("state", state);
		mv.addObject("start", start);
		mv.addObject("end", end);
	
		mv.setViewName("/admin/order/order_list");
		
		return mv;
	}
	
	
}
