package daangnmungcat.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.kakao.KakaoPayApprovalVO;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.service.KakaoPayService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.OrderService;

@RestController
@Controller
public class MypageController {
	
	//_대신 - 이고 최소화
	//대문, 행위는 url에 포함 x
	//마지막 슬래시 x
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private KakaoPayService kakaoService;
	
	@Autowired
	private PasswordEncoder encoder;
	
	//프로필사진 삭제 -> default로
	@GetMapping("/profile/get")
	public int defaultSetProfile(AuthInfo info, HttpSession session) {
		int res = service.deleteProfilePic(info.getId(), getRealPath(session));
		return res;
	}
	
	//프로필 사진 변경
	@PostMapping("/profile/post")
	public int uploadProfile(AuthInfo info, MultipartFile[] uploadFile, HttpSession session) {
		int res = service.updateProfilePic(info.getId(), uploadFile, getRealPath(session));
		return res;
	}

	//프로필소개 변경
	@PostMapping("/profile-text/post")
	public int updateProfileText(@RequestBody String json, AuthInfo info) throws ParseException {
		Member loginUser = service.selectMemberById(info.getId());
		
		String text = json.toString();
		loginUser.setProfileText(text);
		int res = service.updateProfileText(loginUser);
		return res;
	}
	
	//내 프로필사진만 가져오기
	@GetMapping("/member/pic")
	public Map<String, String> profilePic(AuthInfo loginUser) throws ParseException {
		Member member = service.selectMemberById(loginUser.getId());
		String path = member.getProfilePic();
		Map<String, String> map = new HashMap<>();
		map.put("path", path);
		return map;
		
	}
	
	//비밀번호 일치 확인
	@PostMapping("/member/checkPwd")
	public ResponseEntity<Object> checkPwd(AuthInfo loginUser, @RequestBody Map<String, Object> data) {
		try {
			String pwd = (String) data.get("pwd");
			System.out.println("pwd: " + pwd);
			
			Member member = service.selectMemberById(loginUser.getId());
			boolean res = encoder.matches(pwd, member.getPwd());
			System.out.println(res);
			if(res == true) {
				return ResponseEntity.ok(res);
			} else {
				return ResponseEntity.status(HttpStatus.CONFLICT).build();
			}
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	//비밀번호 수정
	@PutMapping("/member/pwd")
	public ResponseEntity<Object> updatePwd(AuthInfo loginUser, @RequestBody Map<String, Object> data) {
		try {
			String nowPwd = (String) data.get("now_pwd");
			String newPwd = (String) data.get("new_pwd");
			
			System.out.println("nowPwd: " + nowPwd);
			System.out.println("newPwd: " + newPwd);
			
			Member member = service.selectMemberById(loginUser.getId());
			boolean res = encoder.matches(nowPwd, member.getPwd());
			System.out.println(res);
			
			if(res == true) {
				member.setPwd(encoder.encode(newPwd));
				return ResponseEntity.ok(service.updatePwd(member));
			} else {
				return ResponseEntity.status(HttpStatus.CONFLICT).build();
			}
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	
	//멤버 모든 정보
	@GetMapping("/member/info")
	public Map<String, Object> memberInfo(AuthInfo loginUser) throws ParseException {
		Member member = service.selectMemberById(loginUser.getId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member", member);
		return map;

	}
	
	
	//멤버 정보 수정
	@PostMapping("/member/info/post")
	public ResponseEntity<Object> updateMember(@RequestBody Member member) {
		System.out.println("update member");
		try {
			return ResponseEntity.ok(service.updateInfo(member));
		} catch (DuplicateMemberException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}

	}
	
	//폰번호 변경
	@PostMapping("/phone/post")
	public int updatePhone(@RequestBody String json, AuthInfo info) throws ParseException {
		Member loginUser = service.selectMemberById(info.getId());
		String phone = json.toString();
		loginUser.setPhone(phone);
		
		int res = service.updatePhone(loginUser);
		System.out.println("폰번호변경:" + res);
		return res;
	}
	
	//비밀번호 변경
	@PostMapping("/pwd/post")
	public int updatePwd(@RequestBody String json, AuthInfo info) {
		Member loginUser = service.selectMemberById(info.getId());
		
		String pwd = json.toString();
		loginUser.setPwd(pwd);
		int res = service.updatePwd(loginUser);
		return res;
	}
	
	//탈퇴
	@PostMapping("/withdrawal")
	public ResponseEntity<Object> withdraw(AuthInfo loginUser, @RequestBody Map<String, String> data, HttpSession session) {
		try {
			String pwd = (String) data.get("pwd");
			System.out.println("pwd: " + pwd);
			
			Member member = service.selectMemberById(loginUser.getId());
			boolean matches = encoder.matches(pwd, member.getPwd());
			System.out.println(matches);
			if(matches == true) {
				int res = service.deleteMember(member.getId());
				session.invalidate();
				return ResponseEntity.ok(res);
			} else {
				return ResponseEntity.status(HttpStatus.CONFLICT).build();
			}
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	
/////// 주문내역 mv
	
	@GetMapping("/mypage/mypage_order_list")
	public ModelAndView orderList(AuthInfo loginUser) {
		Member member = service.selectMemberById(loginUser.getId());
		
		List<Order> list = orderService.selectOrderById(member.getId());
		
		for(Order o: list) {
			List<OrderDetail> odList = orderService.sortingOrderDetail(o.getId());
			o.setDetails(odList);
			for(OrderDetail od: odList) {
				od.setOrderId(o.getId());
			}
		}
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("list", list);
		mv.setViewName("/mypage/mypage_order_list");
		return mv;
	}
	
	@GetMapping("/mypage/mypage_order_list/start={start}/end={end}")
	public ModelAndView searchOrder(@PathVariable String start, @PathVariable String end, AuthInfo loginUser) throws java.text.ParseException {
		Member member = service.selectMemberById(loginUser.getId());
		System.out.println(start +"/"+ end);
		
		List<Order> list = orderService.searchByDate(start, end, member.getId());
		for(Order o: list) {
			List<OrderDetail> odList = orderService.sortingOrderDetail(o.getId());
			o.setDetails(odList);
			for(OrderDetail od: odList) {
				od.setOrderId(o.getId());
			}
		}
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("list", list);
		mv.setViewName("/mypage/mypage_order_list");
		return mv;
	}
	
	@GetMapping("/mypage/mypage_order_list/{id}")
	public ModelAndView getOrderNo(@PathVariable String id, AuthInfo loginUser) {
		Member member = service.selectMemberById(loginUser.getId());
		
		Order order = orderService.getOrderByNo(id);
		List<OrderDetail> odList = orderService.sortingOrderDetail(order.getId());
		order.setDetails(odList);
		for(OrderDetail od: odList) {
			od.setOrderId(order.getId());
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("first_pdt", odList.get(0));
		mv.addObject("order", order);
		mv.setViewName("/mypage/mypage_order_detail");
		return mv;
	}
	
	
	@GetMapping("/mypage/mypage_order_cancel_list")
	public ModelAndView getCancelOrder(AuthInfo loginUser) {
		Member member = service.selectMemberById(loginUser.getId());
		
		List<Order> list = orderService.selectCancelOrderById(member.getId());
		for(Order o: list) {
			List<OrderDetail> odList = orderService.sortingOrderDetail(o.getId());
			o.setDetails(odList);
			for(OrderDetail od: odList) {
				od.setOrderId(o.getId());
			}
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("/mypage/mypage_order_cancel_list");
		return mv;
		
	}

	
	@GetMapping("/mypage/mypage_order_cancel_list/start={start}/end={end}")
	public ModelAndView searchCancelOrder(@PathVariable String start, @PathVariable String end, AuthInfo loginUser) throws java.text.ParseException {
		Member member = service.selectMemberById(loginUser.getId());
		System.out.println(start +"/"+ end);
		
		List<Order> list = orderService.cancelSearchByDate(start, end, member.getId());
		for(Order o: list) {
			List<OrderDetail> odList = orderService.sortingOrderDetail(o.getId());
			o.setDetails(odList);
			for(OrderDetail od: odList) {
				od.setOrderId(o.getId());
			}
		}
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("list", list);
		mv.setViewName("/mypage/mypage_order_cancel_list");
		return mv;
	}
	
	//결제정보 조회
	@GetMapping("/kakao-info/{tid}/")
	public ModelAndView kakaoPayinfo(@PathVariable String tid) {
		KakaoPayApprovalVO vo = kakaoService.kakaoPayInfo(tid);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("info", vo);
		mv.setViewName("/mypage/pay_info");
		
		return mv;
	}
	
	private File getRealPath(HttpSession session) {
		return new File(session.getServletContext().getRealPath("")); 
	}
}
