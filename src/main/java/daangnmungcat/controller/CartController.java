package daangnmungcat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Cart;
import daangnmungcat.dto.Member;
import daangnmungcat.service.CartService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class CartController {

	@Autowired
	CartService cartService;
	
	
	// 장바구니 목록
	@GetMapping("/mall/cart/list")
	public String cart(HttpSession session, Model model) {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		
		List<Cart> list = cartService.getCart(loginUser.getId());
		model.addAttribute("list", list);
		
		return "/mall/cart/mall_cart_list";
	}
	
	
	// 장바구니 목록 json
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
	
	
	// 장바구니 추가
	@PostMapping("/mall/cart")
	@ResponseBody
	public ResponseEntity<Object> addCartItem(@RequestBody Cart cart, HttpSession session) {
		// product.id, quantity 넘어옴
		
		int res = 0;
		AuthInfo loginUser = null;
		
		try {
			loginUser = (AuthInfo) session.getAttribute("loginUser");
		} catch (NullPointerException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}
		
		try {
			cart.setMember(new Member(loginUser.getId()));
			//log.info(loginUser.getId().toString());
			//log.info(cart.toString());
			res = cartService.addCartItem(cart);
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		//log.info(cart.toString());
		return ResponseEntity.ok(res);
		
	}
	
	// 장바구니 상품 하나 정보 얻어오기
	// 필요한지는 모르겠음
	@GetMapping("/mall/cart/{id}")
	@ResponseBody
	public ResponseEntity<Cart> getCartItem(@PathVariable("id") int productId, HttpSession session) {
		Cart cart = null;
		
		try {
			AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
			cart = cartService.getCartItem(loginUser.getId(), productId);
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(cart);
		
	}
	
	
	@PutMapping("/mall/cart")
	@ResponseBody
	public ResponseEntity<Object> modifyCartItem(@RequestBody Cart cart, HttpSession session) {
		int res = 0;
		
		try {
			AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
			cart.setMember(new Member(loginUser.getId()));
			res = cartService.modifyQuantity(cart);
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(res);
	}
	
	
	@DeleteMapping("/mall/cart")
	@ResponseBody
	public ResponseEntity<Object> deleteCartItem(@RequestBody Cart cart, HttpSession session) {
		int res = 0;
		
		try {
			AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
			cart.setMember(new Member(loginUser.getId()));
			res = cartService.deleteCartItem(cart);
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(res);
	}
	
}
