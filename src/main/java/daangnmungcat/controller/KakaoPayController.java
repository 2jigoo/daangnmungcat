package daangnmungcat.controller;

import java.net.URI;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import daangnmungcat.dto.KakaoPayApprovalVO;
import daangnmungcat.service.KakaoPayService;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class KakaoPayController {
	
	@Autowired
	private KakaoPayService service;
	
	@GetMapping("/kakao-pay")
	public void kakaoGet(@RequestBody Map<String, String> map,HttpServletRequest request, HttpSession session) {
		
	}
	
	@PostMapping("/kakao-pay")
	public String kakaoPost(HttpServletRequest request, HttpSession session) {
		log.info("kakao post..................");
		
		request.setAttribute("pdt_id", "pdt_id");
		request.setAttribute("pdt_name", "pdt_name");
		request.setAttribute("pdt_qtt", "pdt_qtt");
		request.setAttribute("total", "total");
		request.setAttribute("mem_id","mem_id");
		
		return "redirect:" + service.kakaoPayReady(request,session);
	}
	
	@GetMapping("/kakaoPaySuccess")
	public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model, HttpServletRequest request) {
		log.info("kakaoPaySuccess get............................................");
		log.info("kakaoPaySuccess pg_token : " + pg_token);
		System.out.println(service.kakaoPayInfo(pg_token, request));
		return "/mall/pay_success";
		
	}
	
	
}
