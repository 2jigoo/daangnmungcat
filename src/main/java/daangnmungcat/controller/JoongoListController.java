package daangnmungcat.controller;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.client.AuthCache;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.GpsToAddress;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Sale;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.mapper.JoongoListMapper;
import daangnmungcat.service.GpsToAddressService;

@Controller
public class JoongoListController {
	private static final Log log = LogFactory.getLog(JoongoListController.class);
	
	@Autowired
	private JoongoListMapper mapper;	
	
	@GetMapping("/joongo_list")
	public String list(Model model, Criteria cri, HttpSession session) {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		System.out.println("list : "+ loginUser);
		if (loginUser == null) {
			List<Sale> list = mapper.selectJoongoByAllPage(cri);
			System.out.println(list);
			model.addAttribute("list", list);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(mapper.listCount());
			model.addAttribute("pageMaker", pageMaker);
			
			return "/joongo_list";
		} else {
			return null;
		}
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
	public String insertfrom1(HttpSession session, Model model){
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/login";
		} else {
			model.addAttribute(loginUser.getId());
			return "/joongoSale/addList";
		}
	}
	
	
	//insertForm용  -> 동네1 선택
	@GetMapping("/joongoSale/addList/{dongne1}")
	public String insertfrom1(Model model, @PathVariable("dongne1") String dongne1){
		List<Sale> list = mapper.selectDongne1ByAll(dongne1);
		model.addAttribute("list", list);
		model.addAttribute("dongne1Name", dongne1);
		
		return "/joongoSale/addList";
	}
	
	
	//insertForm용 -> 동네2선택 후
	@GetMapping("/joongoSale/addList/{dongne1}/{dongne2}")
	public String insertfrom2(Model model, @PathVariable("dongne1") String dongne1, @PathVariable("dongne2") String dongne2) {
		System.out.println("addList 동네  -> " + dongne1);
		List<Sale> list = mapper.selectDongne2ByAll(dongne1, dongne2);
		model.addAttribute("list", list);
		model.addAttribute("dongne1Name", dongne1);
		model.addAttribute("dongne2Name", dongne2);

		return "/joongoSale/addList";
	}
	
	
	//insertForm용 -> 내위치클릭 후
	@PostMapping("/gpsToAddress2")
	public void find2(HttpServletResponse rs ,@RequestBody GpsToAddress gpsToAddress) throws Exception {
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
	
	// /joongoSale/insert
	@PostMapping("/insert")
	public ResponseEntity<Object> newJoongoList(@RequestBody Sale sale) throws Exception {
		System.out.println("/insert 컨트롤러");
		try {
			return ResponseEntity.ok(mapper.insertJoongoSale(sale));
			
		} catch (DuplicateMemberException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
	}
	
	@PostMapping("/uploadPhoto")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		String uploadFolder = "C:\\upload";
		
		// make folder --
		File uploadPath = new File(uploadFolder, getFolder());
		System.out.println("uploadPath: " + uploadPath);
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		
		for(MultipartFile multipartFile : uploadFile) {
			
			System.out.println("--------------------");
			System.out.println("Upload File Name: " + multipartFile.getOriginalFilename());
			System.out.println("Upload File Size: " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			System.out.println("only file name: " + uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			System.out.println("uploadFileName: " + uploadFileName);
			
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str;
	}
}