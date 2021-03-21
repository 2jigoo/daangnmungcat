package daangnmungcat.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import daangnmungcat.service.CartService;
import lombok.extern.log4j.Log4j2;

@Component
@Log4j2
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Autowired
	private CartService cartService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		
		String url = "/";
		
		List<String> roleNames = new ArrayList<>();
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		System.out.println("auth: " + auth.getName());
		log.info("auth: " + auth.toString());
		
		//사용자가 admin권한이면 바로 admin 페이지로
		if(roleNames.contains("ROLE_ADMIN")) {
			url = "/admin/main";
		}
		
		if(roleNames.contains("ROLE_USER")) {
			// 비회원 상태의 장바구니가 존재하면, 해당 회원의 장바구니로 이전시켜줌
			Optional<Cookie> cookie = Arrays.stream(request.getCookies()).filter(c -> c.getName().equals("basket_id")).findAny();
			cookie.ifPresent(c -> {
				c.setMaxAge(0);
				cartService.moveToMember(c.getValue(), auth.getName());
				response.addCookie(c);
			});
		}
		
		response.setStatus(HttpStatus.OK.value());
		response.getWriter().println(url);
	}

}
