package daangnmungcat.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.GpsToAddress;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Sale;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.mapper.JoongoListMapper;
import daangnmungcat.service.GpsToAddressService;
import daangnmungcat.service.MemberService;

@Controller
public class JoongoListController {
	private static final Log log = LogFactory.getLog(JoongoListController.class);
	
	@Autowired
	private JoongoListMapper mapper;
	
	@Autowired
	private MemberService service;
	
	@GetMapping("/joongo_list")
	public String list(Model model, Criteria cri, HttpSession session) throws UnsupportedEncodingException {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/joongo_list/all";
		} else {
			System.out.println("loginUser check : "+ loginUser);
			if (loginUser.getDongne1().getName() == null || loginUser.getDongne2().getName() == null) {
				return "redirect:/joongo_list/all";
			} else {
				return "redirect:/joongo_list/"+ URLEncoder.encode(loginUser.getDongne1().getName(), "UTF-8") +"/"+ URLEncoder.encode(loginUser.getDongne2().getName(), "UTF-8");
			}
		}
	}
	
	@GetMapping("/joongo_list/all")
	public String listAll(Model model, Criteria cri, HttpSession session) throws UnsupportedEncodingException {
		List<Sale> list = mapper.selectJoongoByAllPage(cri);
		System.out.println(list);
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(mapper.listCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/joongo_list";
	}
	
	@GetMapping("/joongo_list/{dongne1}")
	public String listDongne1(Model model, @PathVariable("dongne1") String dongne1, Criteria cri){
		List<Sale> list = mapper.selectJoongoByDongne1(dongne1, cri);
		model.addAttribute("list", list);
		model.addAttribute("dongne1Name", dongne1);

		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(mapper.listCount1(dongne1));
		model.addAttribute("pageMaker", pageMaker);
		return "/joongo_list";
	}
	
	@GetMapping("/joongo_list/{dongne1}/{dongne2}")
	public String listDongne2(Model model, @PathVariable("dongne1") String dongne1, @PathVariable("dongne2") String dongne2, Criteria cri) {
		System.out.println(dongne1);
		List<Sale> list = mapper.selectJoongoByDongne2(dongne1, dongne2, cri);
		model.addAttribute("list", list);
		model.addAttribute("dongne1Name", dongne1);
		model.addAttribute("dongne2Name", dongne2);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(mapper.listCount2(dongne1, dongne2));
		model.addAttribute("pageMaker", pageMaker);
		return "/joongo_list";
	}
	
	@PostMapping("/gpsToAddress")
	public void find(HttpServletResponse rs ,@RequestBody GpsToAddress gpsToAddress) throws Exception {
		try {
			JSONObject jso = new JSONObject();
			GpsToAddressService gps = new GpsToAddressService(gpsToAddress.getLat(), gpsToAddress.getLon());
			String[] address = gps.getAddress().split(" ");
			jso.put("address1", address[1]);
			jso.put("address2", address[2]);
			rs.setContentType("text/html;charset=utf-8");
			PrintWriter out = rs.getWriter();
			out.print(jso.toString());
		} catch (Exception e) {
			System.out.println("오류");
		}
	}
	
	@GetMapping("/GpsToAddress/{lat}/{lon}")
	public String findAddress(@PathVariable("lat") double lat, @PathVariable("lon") double lon) throws Exception {
		System.out.println("왔다리");
		double latitude = lat;
		double longitude = lon;

		GpsToAddressService gps = new GpsToAddressService(latitude, longitude);
		System.out.println(gps.getAddress());
		System.out.println(lat + ", " + lon);
		return null;
	}
	
	
	//insertForm용 - > 바로글쓰기버튼
	@GetMapping("/joongoSale/addList")
	public String addListForm(Model model, HttpSession session) {
			return "joongoSale/addList";
		}
	
	//insertForm용  -> 동네1 선택
	@GetMapping("/joongoSale/addList/dongne1")
	public ResponseEntity<Object> dongne1() {
		return ResponseEntity.ok(service.Dongne1List());
	}
	
	//insertForm용 -> 동네2선택 후
	@GetMapping("joongoSale/addList/dongne2/{dongne1}")
	public ResponseEntity<Object> dongne2(@PathVariable int dongne1) {
		return ResponseEntity.ok(service.Dongne2List(dongne1));
	}

	@PostMapping("/joongoSale/insert")
	public ResponseEntity<Object> newJoongoList(@RequestBody Sale sale) throws Exception {
		System.out.println("/insert 컨트롤러");
		try {
			return ResponseEntity.ok(mapper.insertJoongoSale(sale));
			
		} catch (DuplicateMemberException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
	}
}