package daangnmungcat.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;

import daangnmungcat.dto.KakaoPayApprovalVO;

public interface KakaoPayService {
	
	String kakaoPayReady(HttpServletRequest request, HttpSession session);
	
	KakaoPayApprovalVO kakaoPayInfo(String pg_token, HttpServletRequest request, HttpSession session);

	String kakaoPayCancel(Map<String, String> map, HttpServletRequest request, HttpSession session);
}
