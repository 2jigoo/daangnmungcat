package daangnmungcat.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
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
	public String cart(@CookieValue(name = "basket_id", required = false) String cookie, AuthInfo loginUser, Model model) {
		List<Cart> list = null;
		Map<String, Integer> deliveryFee = null;
		
		if(loginUser == null) {
			// 비회원
			System.out.println("cookie: " + cookie);
			if(cookie != null) {
				list = cartService.getCartForNonmember(cookie);
			}
		} else {
			// 회원
			list = cartService.getCart(loginUser.getId());
		}
		
		if (list != null) {
			 deliveryFee = calculateDeliveryFee(list);
			 
			 int price = list.stream().collect(Collectors.summingInt(Cart::getAmount));
			 int quantity = list.stream().collect(Collectors.summingInt(Cart::getQuantity));
			 
			 Map<String, Integer> total = new HashMap<>();
			 
			 total.put("price", price);
			 total.put("quantity", quantity);
			 total.put("cost", price + deliveryFee.get("total"));
			 
			 model.addAttribute("total", total);
		}
		
		
		
		model.addAttribute("list", list);
		model.addAttribute("deliveryFee", deliveryFee);
		
		return "/mall/cart/mall_cart_list";
	}
	
	
	private Map<String, Integer> calculateDeliveryFee(List<Cart> list) {
		Map<String, Integer> deliveryFee = new HashMap<>();
		
		// 총 배송비
		int totalDeliveryFee = 0;
		
		// 무료배송, 유료상품 존재 여부
		boolean hasFreeDelivery = list.stream().anyMatch(cart -> cart.getProduct().getDeliveryKind().equals("무료배송"));
		boolean hasChargedDelivery = list.stream().anyMatch(cart -> cart.getProduct().getDeliveryKind().equals("유료배송"));
		
		// 조건부 무료배송 총 상품금액 합계 구하기
		int totalPriceOfCondiFeePdt = list.stream()
											.filter(cart -> cart.getProduct().getDeliveryKind().equals("조건부 무료배송"))
											.collect(Collectors.summingInt(Cart::getAmount));
		
		// 조건부 무료배송 상품 총 금액이 3만원 미만이고 무료배송 상품도 없다면 조건부 유료배송
//		if(!((totalPriceOfCondiFeePdt >= 30000) || hasFreeDelivery == true)) {
		if(totalPriceOfCondiFeePdt > 0 && totalPriceOfCondiFeePdt <= 30000 && hasFreeDelivery == false) {
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
		
		System.out.println(totalDeliveryFee + " = " + chargedDeliveryFee + " + " + (totalDeliveryFee - chargedDeliveryFee));
		
		deliveryFee.put("total", totalDeliveryFee);
		deliveryFee.put("conditional", totalDeliveryFee - chargedDeliveryFee);
		deliveryFee.put("charged", chargedDeliveryFee);
		
		
		return deliveryFee;
	}
	
	
	// 장바구니 목록 json
	@GetMapping("/mall/cart")
	@ResponseBody
	public ResponseEntity<List<Cart>> cart(AuthInfo loginUser) {
		
		List<Cart> list = null;
		
		try {
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
	public ResponseEntity<Object> addCartItem(@RequestBody Cart cart, HttpServletRequest request, HttpServletResponse response, AuthInfo loginUser) {
		// product.id, quantity 넘어옴
		
		int res = 0;
		
		if(loginUser == null) {
			Optional<Cookie> cookie = Arrays.stream(request.getCookies()).filter(c -> c.getName().equals("basket_id")).findAny();
			Cookie c = cookie.orElseGet(() -> new Cookie("basket_id", UUID.randomUUID().toString()));
			c.setMaxAge(7*24*60*60);
			c.setPath("/");
			
			String basketID = c.getValue();
			log.info("baketId: " + basketID);
			
			cart.setBasketId(basketID);
			cartService.addCartItem(cart);
			
			response.addCookie(c);
		} else {
			try {
				cart.setMember(new Member(loginUser.getId()));
				res = cartService.addCartItem(cart);
			} catch(Exception e) {
				e.printStackTrace();
				return ResponseEntity.status(HttpStatus.CONFLICT).build();
			}
		}
		
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
	public ResponseEntity<Cart> getCartItem(@PathVariable("id") int productId, AuthInfo loginUser) {
		Cart cart = null;
		
		try {
			cart = cartService.getCartItem(loginUser.getId(), productId);
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(cart);
		
	}
	
	
	@PutMapping("/mall/cart")
	@ResponseBody
	public ResponseEntity<Object> modifyCartItem(@RequestBody Cart cart, AuthInfo loginUser) {
		int res = 0;
		
		try {
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
	public ResponseEntity<Object> deleteCartItem(AuthInfo loginUser, @RequestBody Cart... cart) {
		int res = 0;
		
		try {
			res = cartService.deleteCartItem(cart);
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(res);
	}
	
}
