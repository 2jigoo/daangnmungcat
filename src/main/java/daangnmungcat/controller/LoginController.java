package daangnmungcat.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	private static final Log log = LogFactory.getLog(LoginController.class);
	
	@GetMapping("/signup")
	public String signForm() {
		return "sign/signup";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(HttpSession session) {
		return "/login";
	}
	
	/*@RequestMapping(value="/login", method=RequestMethod.POST)
	public String submit(Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = null;
		
		try {
			session = request.getSession();
			AuthInfo authInfo = authService.authenicate(member.getId(), member.getPwd());
			session.setAttribute("loginUser", authInfo);
			
			// 비회원 상태의 장바구니가 존재하면, 해당 회원의 장바구니로 이전시켜줌
			Optional<Cookie> cookie = Arrays.stream(request.getCookies()).filter(c -> c.getName().equals("basket_id")).findAny();
			cookie.ifPresent(c -> {
				c.setMaxAge(0);
				cartService.moveToMember(c.getValue(), authInfo.getId());
				response.addCookie(c);
			});
			
			return "redirect:/";
		} catch (Exception e) {
			e.printStackTrace(); // 에러 발생시 확인
			request.setAttribute("msg", "아이디나 비밀번호가 맞지 않습니다.");
			return "/login";
		}
	}*/
	
	/*@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}*/
		
}
