package daangnmungcat.service.impl;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.core.appender.mom.kafka.KafkaProducerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.KakaoPayApprovalVO;
import daangnmungcat.dto.KakaoPayReadyVO;
import daangnmungcat.dto.Member;
import daangnmungcat.service.KakaoPayService;
import daangnmungcat.service.MemberService;
import lombok.extern.java.Log;

@Service
@Log
public class KakaoPayServiceImpl implements KakaoPayService {
private static final String HOST = "https://kapi.kakao.com";
    
	
    private KakaoPayReadyVO kakaoPayReadyVO;
    private KakaoPayApprovalVO kakaoPayApprovalVo;
    
    @Autowired
    private MemberService service;
    
    public String kakaoPayReady(HttpServletRequest request, HttpSession session) {
    	
    	AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		Member member = service.selectMemberById(loginUser.getId());
	
    	
        RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "64eac7ea0faa7f908904ee07ec3f2a67");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
       // System.out.println("map: "+ map);
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "1");
        params.add("partner_user_id",  request.getParameter("mem_id"));
        params.add("item_name", request.getParameter("pdt_name"));
        params.add("quantity", request.getParameter("pdt_qtt"));
        params.add("total_amount", request.getParameter("total"));
        params.add("tax_free_amount", "0"); //비과세금액
        params.add("approval_url", "http://localhost:8080/kakaoPaySuccess");
        params.add("cancel_url", "http://localhost:8080/kakaoPayCancel");
        params.add("fail_url", "http://localhost:8080/kakaoPaySuccessFail");
 
         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
         System.out.println("body" + body);
 
        try {
        	//RestTemplate을 이용해 카카오페이에 데이터를 보내는 방법
            kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
           
            log.info("" + kakaoPayReadyVO);
            request.setAttribute("body", kakaoPayReadyVO);
            request.setAttribute("pdt_id", request.getParameter("pdt_id").trim());
    		request.setAttribute("pdt_name", request.getParameter("pdt_name").trim());
    		request.setAttribute("pdt_qtt", request.getParameter("pdt_qtt").trim());
    		request.setAttribute("total", request.getParameter("total").trim());
    		request.setAttribute("mem_id", request.getParameter("mem_id"));
            
            return kakaoPayReadyVO.getNext_redirect_pc_url();
 
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        
        return "/pay";
        
    }
    
    public KakaoPayApprovalVO kakaoPayInfo(String pg_token, HttpServletRequest request, HttpSession session) {
    	
    	AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		Member member = service.selectMemberById(loginUser.getId());
    	
        log.info("KakaoPayInfoVO............................................");
        log.info("-----------------------------");
        
        RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "64eac7ea0faa7f908904ee07ec3f2a67");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
       
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id", "1");
        params.add("partner_user_id", member.getId());
        params.add("pg_token", pg_token);
        params.add("total_amount", (String) request.getAttribute("total"));
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
       
        try {
        	KakaoPayApprovalVO kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            log.info("" + kakaoPayApprovalVO);
            
            return kakaoPayApprovalVO;
        
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
		return null;
        
        
    }
    
}
 
