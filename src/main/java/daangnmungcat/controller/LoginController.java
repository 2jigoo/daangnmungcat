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
import lombok.extern.log4j.Log4j2;

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
	public String submit(Member member, HttpServletRequest request) throws Exception {
		
		Integer res = mapper.checkPwd(member.getId(), member.getPwd());
		HttpSession session = null;
		
		System.out.println("member: " + member);
		System.out.println("res: " + res);
		
		try {
			session = request.getSession();
			if (res == 1) {
				AuthInfo authInfo = authService.authenicate(member.getId(), member.getPwd());
				// 세션에 id pwd 저장
				// mapper로 조회해서 비번을 제외한 다른 회원 정보까지 포함해 set해야 할 듯. 아니면 아이디, 이름 정도만?
				session.setAttribute("loginUser", member);
				return "redirect:/";
			}
		}catch (Exception e) {
			e.printStackTrace(); // 에러 발생시 확인
			request.setAttribute("msg", "아이디나 비밀번호가 맞지 않습니다.");
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
