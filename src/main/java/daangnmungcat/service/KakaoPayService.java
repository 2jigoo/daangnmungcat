package daangnmungcat.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

import daangnmungcat.dto.kakao.KakaoPayApprovalVO;

public interface KakaoPayService {
	
	String kakaoPayReady(HttpServletRequest request, HttpSession session);
	
	//지우기
	KakaoPayApprovalVO kakaoPayApprovalInfo(String pg_token, HttpServletRequest request, HttpSession session);

	String kakaoPayCancel(Map<String, String> map, HttpServletRequest request, HttpSession session);

	String kakaoPayPartCancel(Map<String, String> map, HttpServletRequest request, HttpSession session);
	
	KakaoPayApprovalVO kakaoPayInfo(String tid, HttpServletRequest request, HttpSession session);
}
