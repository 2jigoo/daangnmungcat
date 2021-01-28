package daangnmungcat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Cart;
import daangnmungcat.service.CartService;

@Controller
public class CartController {

	@Autowired
	CartService cartService;
	
	
	@GetMapping("/mall/cart/list")
	public String cart(HttpSession session, Model model) {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		
		List<Cart> list = cartService.getCart(loginUser.getId());
		model.addAttribute("list", list);
		
		return "/mall/cart/mall_cart_list";
	}
	
	@GetMapping("/mall/cart")
	@ResponseBody
	public ResponseEntity<List<Cart>> cart(HttpSession session) {
		
		List<Cart> list = null;
		
		try {
			AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
			list = cartService.getCart(loginUser.getId());
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(list);
	}
	
	@PostMapping("/mall/cart/{id}")
	@ResponseBody
	public ResponseEntity<Cart> addCartItem(@PathVariable int id,HttpSession session) {
		
		Cart gotCart = null;
		
		try {
			AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
			gotCart = cartService.getCartItem(id, loginUser.getId());
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(gotCart);
		
	}
	
}
