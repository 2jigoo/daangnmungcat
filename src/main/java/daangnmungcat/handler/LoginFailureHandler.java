package daangnmungcat.handler;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j2;

@Component
@Log4j2
public class LoginFailureHandler implements AuthenticationFailureHandler {

	@Autowired
	private ObjectMapper objectMapper;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		/*
		if (exception instanceof AuthenticationServiceException) {
			request.setAttribute("loginFailMsg", "로그인 에러");
		} else if(exception instanceof UsernameNotFoundException) {
			// 해당 아이디가 존재하지 않는 경우
			request.setAttribute("loginFailMsg", "아이디 또는 비밀번호가 틀립니다.");
		} else if(exception instanceof BadCredentialsException) {
			request.setAttribute("loginFailMsg", "아이디 또는 비밀번호가 틀립니다.");
			
			// 아래 4개 AccountStatusException의 하위 클래스
		} else if(exception instanceof LockedException) {
			request.setAttribute("loginFailMsg", "잠긴 계정입니다.");
			
		} else if(exception instanceof DisabledException) {
			request.setAttribute("loginFailMsg", "비활성화된 계정입니다.");
			
		} else if(exception instanceof AccountExpiredException) {
			request.setAttribute("loginFailMsg", "만료된 계정입니다.");
			
		} else if(exception instanceof CredentialsExpiredException) {
			request.setAttribute("loginFailMsg", "비밀번호가 만료되었습니다.");
		}
		*/
		
		log.info("exception: " + exception.toString() + ", " + exception.getMessage());
		
		response.setStatus(HttpStatus.UNAUTHORIZED.value());
		response.setCharacterEncoding("UTF-8");
		
        Map<String, Object> data = new HashMap<>();
        data.put("exception", exception.getMessage());
        
        response.getWriter().println(objectMapper.writeValueAsString(data));
		
		// 로그인 페이지로 다시 포워딩
//		response.sendRedirect("/login?error");
//		request.getRequestDispatcher("/login?error").forward(request, response);
		
	}

}
