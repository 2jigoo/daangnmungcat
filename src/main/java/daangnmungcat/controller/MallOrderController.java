package daangnmungcat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.MallProduct;
import daangnmungcat.dto.Member;
import daangnmungcat.service.CartService;
import daangnmungcat.service.MallPdtService;
import daangnmungcat.service.MemberService;

@RestController
public class MallOrderController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private MallPdtService mService;
	
	@PostMapping("/mall/pre-order")
	public void orderCheck(@RequestBody Map<String, Object> map, HttpSession session, HttpServletRequest request) {

		String total = map.get("total_price").toString();
		String qtt = map.get("quantity").toString();
		MallProduct pdt = mService.getProductById(Integer.parseInt(map.get("m_id").toString()));
		session.setAttribute("total", total);
		session.setAttribute("qtt", qtt);
		session.setAttribute("pdt", pdt);
		session.setAttribute("pdt_id", pdt.getId());
		session.setAttribute("pdt_name", pdt.getName());
	}
	
	@GetMapping("/mall/pre-order")
	public Map<String, Object> orderPage(HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		Map<String, Object> map = new HashMap<>();
		map.put("total",session.getAttribute("total"));
		map.put("qtt",  session.getAttribute("qtt"));
		map.put("pdt", session.getAttribute("pdt"));
		map.put("member", info);
		return map;
	}
	
//	@GetMapping("/mall/pre-order")
//	public List<MallProduct> cartSelectPdt(@PathVariable Integer[] id, HttpSession session, HttpServletRequest request){
//		session = request.getSession();
//		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
//		Member loginUser = service.selectMemberById(info.getId());
//		
//		//List<MallProduct> list = cartService.getCartItem(loginUser.getId(), productId);
//	}
	
	
}
