package daangnmungcat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Member;
import daangnmungcat.exception.WrongIdPasswordException;
import daangnmungcat.mapper.MemberMapper;
import daangnmungcat.service.AuthService;

@Controller
public class LoginController {
	private static final Log log = LogFactory.getLog(LoginController.class);
	
	@Autowired
	private AuthService authService;
	
	@Autowired
	private MemberMapper mapper;
	
	@GetMapping("/signup")
	public String signForm() {
		return "/signup";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		return "/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String submit(Member member,HttpServletRequest request) throws Exception {
		Integer res = mapper.checkPwd(member.getId(), member.getPwd());
		HttpSession session = null;
		try {
			session = request.getSession();
			if (res == 1) {
				AuthInfo authInfo = authService.authenicate(member.getId(), member.getPwd());
				// 세션에 id pwd 저장
				System.out.println(res);
				session.setAttribute("member", member);
				return "redirect:/";
			}
		}catch (Exception e) {
			session.removeAttribute("member");
			session.setAttribute("member", null);
			session.setAttribute("msg", "아이디나 비밀번호가 맞지 않습니다.");
			return "/login";
		}
		return null;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	//security 테스트용
	@GetMapping("/all")
	public String doAll() {
		return "/sample/all";
	}
	
	@GetMapping("/admin")
	public String doAdmin() {
		return "/sample/admin";
	}
	
	@GetMapping("/member")
	public String doMember() {
		return "/sample/member";
	}

}
