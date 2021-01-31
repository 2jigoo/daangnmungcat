package daangnmungcat.service.impl;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
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
import daangnmungcat.dto.Payment;
import daangnmungcat.service.KakaoPayService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.OrderService;
import lombok.extern.java.Log;

@Service
@Log
public class KakaoPayServiceImpl implements KakaoPayService {
private static final String HOST = "https://kapi.kakao.com";
    
	@Autowired
	private OrderService orderService;

	@Autowired
	private MemberService service;

    private KakaoPayReadyVO kakaoPayReadyVO;
    private KakaoPayApprovalVO kakaoPayApprovalVo;
    
    
    public String kakaoPayReady(HttpServletRequest request, HttpSession session) {
    	
    	AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		Member member = service.selectMemberById(loginUser.getId());

		//주문할거만 담은 새로운 id
		String[] id = request.getParameterValues("pdt_id");
		String zipcode = request.getParameter("zipcode");
		String addname = request.getParameter("add_name");
		String add1 = request.getParameter("address1");
		String add2 = request.getParameter("address2");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String memo = request.getParameter("order_memo");
		String usedMile = request.getParameter("use_mileage");
		
		//session에 담아서 전송
		List<String> list = new ArrayList<String>();
		for(int i=0; i<id.length; i++) {
			list.add(i, id[i]);
		}
		
		session.setAttribute("list", list);
		session.setAttribute("add_name", addname);
		session.setAttribute("zipcode", zipcode);
		session.setAttribute("add1", add1);
		session.setAttribute("add2", add2);
		session.setAttribute("phone1", phone1);
		session.setAttribute("phone2", phone2);
		session.setAttribute("memo", memo);
		session.setAttribute("usedMile", usedMile);
		
        RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "64eac7ea0faa7f908904ee07ec3f2a67");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        int qtt = Integer.parseInt(request.getParameter("pdt_qtt"));
        int nextPayNo = orderService.nextPayNo(); 
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", String.valueOf(nextPayNo));
        params.add("partner_user_id",  request.getParameter("mem_id"));
        
        String name;
        if(qtt <= 1) {
        	name = request.getParameter("first_pdt");
        }else {
        	name = request.getParameter("first_pdt") + " 외 " +(qtt-1) + "건";
        }
        
        params.add("item_name", name);
        params.add("quantity", request.getParameter("pdt_qtt"));
        params.add("total_amount", request.getParameter("final"));
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
    	
    	
        log.info("KakaoPayInfoVO............................................");
        log.info("-----------------------------");
        
        AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		Member member = service.selectMemberById(loginUser.getId());
		
        RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "64eac7ea0faa7f908904ee07ec3f2a67");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        int nextPayNo = orderService.nextPayNo(); 
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id", String.valueOf(nextPayNo));
        params.add("partner_user_id", member.getId());
        params.add("pg_token", pg_token);
        params.add("total_amount", session.getAttribute("final_price").toString());
        
        
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
 
