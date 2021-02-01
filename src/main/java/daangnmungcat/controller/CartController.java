package daangnmungcat.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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
import daangnmungcat.dto.MallProduct;
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

		// 총 배송비
		int totalDeliveryFee = 0;
		
		
		// 무료배송, 유료상품 존재 여부
		boolean hasFreeDelivery = list.stream().anyMatch(cart -> cart.getProduct().getDeliveryKind().equals("무료배송"));
		boolean hasChargedDelivery = list.stream().anyMatch(cart -> cart.getProduct().getDeliveryKind().equals("유료배송"));
		
		// 조건부 무료배송 총 상품금액 합계 구하기
		List<Cart> listOfConditionalFee = list.stream()
											.filter(cart -> cart.getProduct().getDeliveryKind().equals("조건부 무료배송"))
											.collect(Collectors.toList());
		
		int totalPriceOfCondiFeePdt = 0;
		for(Cart cart : listOfConditionalFee) {
			totalPriceOfCondiFeePdt += cart.getProduct().getPrice() * cart.getQuantity();
		}
		
		// 무료배송 상품이 있거나 조건부 무료배송 상품 총 금액이 3만원 이상인 경우는 무료배송
		if(!(totalPriceOfCondiFeePdt >= 30000 || hasFreeDelivery == true)) {
			totalDeliveryFee = 3000;
		}
		
		// 유료배송 상품이 있는 경우
		int chargedDeliveryFee = 0;
		if(hasChargedDelivery == true) {
			List<Cart> listOfChargedFee = list.stream()
												.filter(cart -> cart.getProduct().getDeliveryKind().equals("유료배송"))
												.collect(Collectors.toList());
			// 모든 유료배송 상품의 합계 배송비
			for(Cart cart : listOfChargedFee) {
				chargedDeliveryFee += cart.getQuantity() * cart.getProduct().getDeliveryPrice();
			}
			
			totalDeliveryFee += chargedDeliveryFee;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("conditionalDeliveryFee", totalDeliveryFee - chargedDeliveryFee);
		model.addAttribute("chargedDelivery", chargedDeliveryFee);
		model.addAttribute("totalDeliveryFee", totalDeliveryFee);
		
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
	
	
	/*
	// 장바구니 추가
	@PostMapping("/mall/cart")
	@ResponseBody
	public ResponseEntity<Object> addCartItem(@RequestBody Cart cart, HttpSession session) {
		// product.id, quantity 넘어옴
		
		int res = 0;
		AuthInfo loginUser = null;
		
		loginUser = (AuthInfo) session.getAttribute("loginUser");
		try {
			if(loginUser == null) {
				List<Cart> cartList = (List<Cart>) session.getAttribute("cartList");
				if(cartList == null) {
					cartList = new ArrayList<Cart>();
				} else {
	//					Cart alreadyCart = cartList.stream().filter(cart -> cart.getProduct().getId() == cart.getProduct().getId()).to;
				}
	//				session.setAttribute(, value);
			} else {
				cart.setMember(new Member(loginUser.getId()));
				log.info(loginUser.getId().toString());
				log.info(cart.toString());
				res = cartService.addCartItem(cart);
			}
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		log.info(cart.toString());
		return ResponseEntity.ok(res);
		
	}
	*/
	
	
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
			log.debug("modify: id - " + cart.getId() + ", quantity: " + cart.getQuantity());
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
