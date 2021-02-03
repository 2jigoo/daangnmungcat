package daangnmungcat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.service.CartService;
import daangnmungcat.service.MallPdtService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.OrderService;

@RestController
@Controller
public class MypageController {
	private static final Log log = LogFactory.getLog(MypageController.class);
	
	//_대신 - 이고 최소화
	//대문, 행위는 url에 포함 x
	//마지막 슬래시 x
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private MallPdtService pdtService;
	
	//프로필사진 삭제 -> default로
	@GetMapping("/profile/get")
	public int defaultSetProfile(HttpServletRequest request, HttpSession session) {
		int res = service.deleteProfilePic(request, session);
		return res;
	}
	
	//프로필 사진 변경
	@PostMapping("/profile/post")
	public int uploadProfile(MultipartFile[] uploadFile, HttpSession session, HttpServletRequest request) {
		int res = service.updateProfilePic(uploadFile, session, request);
		return res;
	}

	//프로필소개 변경
	@PostMapping("/profile-text/post")
	public int updateProfileText(@RequestBody String json, HttpSession session, HttpServletRequest request) throws ParseException {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		String text = json.toString();
		loginUser.setProfileText(text);
		int res = service.updateProfileText(loginUser);
		return res;
	}
	
	//내 프로필사진만 가져오기
	@GetMapping("/member/pic")
	public Map<String, String> profilePic(HttpSession session, HttpServletRequest request) throws ParseException {
		session = request.getSession();
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		Member member = service.selectMemberById(loginUser.getId());
		String path = member.getProfilePic();
		Map<String, String> map = new HashMap<>();
		map.put("path", path);
		return map;
		
	}
	
	//멤버 모든 정보
	@GetMapping("/member/info")
	public Map<String, Object> memberInfo(HttpSession session, HttpServletRequest request) throws ParseException {
		session = request.getSession();
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
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
	public int updatePhone(@RequestBody String json, HttpSession session, HttpServletRequest request) throws ParseException {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		String phone = json.toString();
		loginUser.setPhone(phone);
		int res = service.updatePhone(loginUser);
		System.out.println("폰번호변경:" + res);
		return res;
	}
	
	//비밀번호 변경
	@PostMapping("/pwd/post")
	public int updatePwd(@RequestBody String json, HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		String pwd = json.toString();
		loginUser.setPwd(pwd);
		int res = service.updatePwd(loginUser);
		return res;
	}
	
	//탈퇴
	@PostMapping("/withdrawal")
	public int withdraw(@RequestBody String id, HttpSession session) {
		int res = service.deleteMember(id);
		session.invalidate();
		return res;
	}
	
	//주문내역

	
	@GetMapping("/mypage/order_list")
	public ModelAndView deleteShipping(HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		Member member = service.selectMemberById(loginUser.getId());
		List<Order> list = orderService.selectOrderById(member.getId());
		
		for(Order o: list) {
			List<OrderDetail> odList = orderService.getOrderDetail(o.getId());
			o.setDetails(odList);
			for(OrderDetail od: odList) {
				od.setMember(member);
				od.setOrderId(o.getId());
				od.setPdt(pdtService.getProductById(od.getCart().getProduct().getId()));
			}
		}
		System.out.println(list);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("/mypage/order_list");
		return mv;
	}

}
