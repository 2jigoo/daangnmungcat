package daangnmungcat.controller;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.FileForm;
import daangnmungcat.dto.GpsToAddress;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Sale;
import daangnmungcat.mapper.JoongoListMapper;
import daangnmungcat.service.GpsToAddressService;
import daangnmungcat.service.JoongoSaleService;
import daangnmungcat.service.MemberService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class NoticeController {
	
	@GetMapping("/notice")
	public String list(Model model, Criteria cri, HttpSession session) throws UnsupportedEncodingException {

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		//pageMaker.setTotalCount(mapper.listCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/notice/notice_list";
	}
	
	
}