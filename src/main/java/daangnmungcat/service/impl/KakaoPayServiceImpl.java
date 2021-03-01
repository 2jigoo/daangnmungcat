package daangnmungcat.service.impl;

import java.net.URI;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.core.appender.mom.kafka.KafkaProducerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;
import daangnmungcat.dto.Order;
import daangnmungcat.dto.OrderDetail;
import daangnmungcat.dto.OrderState;
import daangnmungcat.dto.Payment;
import daangnmungcat.dto.kakao.KakaoPayApprovalVO;
import daangnmungcat.dto.kakao.KakaoPayCancel;
import daangnmungcat.dto.kakao.KakaoPayReadyVO;
import daangnmungcat.service.KakaoPayService;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.MileageService;
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

	@Autowired
	private MileageService mileService;

    private KakaoPayReadyVO  kakaoPayReadyVO;
    private KakaoPayApprovalVO kakaoPayApprovalVo;
    private KakaoPayCancel kakaoPayCancel;
    
    
    @Override
    public String kakaoPayReady(String memberId, HttpServletRequest request, HttpSession session) {
    	log.info("kakao - ready");
		Member member = service.selectMemberById(memberId);
    	
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(new Date());
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}
		String nextOrderNo = today + numStr;
		
		System.out.println("다음 주문 번호:" + nextOrderNo);
   
		
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
		String totalQtt = request.getParameter("total_qtt");
		String finalPrice = request.getParameter("final");
		String plusMile = request.getParameter("plus_mile");
		
		if(usedMile == "") {
			usedMile = "0";
		}
		
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
		session.setAttribute("total_qtt", totalQtt);
		session.setAttribute("final_price", finalPrice);
		session.setAttribute("plus_mile", plusMile);
		session.setAttribute("nextOrderNo", nextOrderNo);
		
        RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "64eac7ea0faa7f908904ee07ec3f2a67");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        int qtt = Integer.parseInt(request.getParameter("pdt_qtt"));
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", nextOrderNo);
        params.add("partner_user_id", request.getParameter("mem_id"));
        
        String name;
        if(qtt <= 1) {
        	name = request.getParameter("first_pdt");
        }else {
        	name = request.getParameter("first_pdt") + " 외 " +(qtt-1) + "건";
        }
        
        params.add("item_name", name);
        params.add("quantity", totalQtt);
        params.add("total_amount", finalPrice);
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
        
        //결제창가면 끊긴ㄷㅏ,,
      
        return null;
        
    }
    
    @Override
    @Transactional
    public KakaoPayApprovalVO kakaoPayApprovalInfo(String memberId, String pg_token, HttpServletRequest request, HttpSession session) {
    	
    	
        log.info("KakaoPayInfoVO............................................");
        log.info("-----------------------------");
        
		Member member = service.selectMemberById(memberId);
		
		String finalPrice = (String) session.getAttribute("final_price");
		String nextNo = (String) session.getAttribute("nextOrderNo");
		String usedMile = (String) session.getAttribute("usedMile");
		
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
        params.add("partner_order_id", nextNo);
        params.add("partner_user_id", member.getId());
        params.add("pg_token", pg_token);
        params.add("total_amount", finalPrice);
        
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
       
        try {
        	KakaoPayApprovalVO kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            log.info("" + kakaoPayApprovalVO);
            
            //결제, 주문상세 , 주문, payment, 마일리지사용내역 테이블 트랜잭션처리
            orderService.kakaoOrderTransaction(memberId, pg_token, kakaoPayApprovalVO, session);
    		
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

    
	@Override
	@Transactional
	public String kakaoPayCancel(String memberId, @RequestBody Map<String, String> map) {
		
		//부분취소 -> 부가세(cancel_vat_amount)만 계산해서 던져주면 됨 
		//금액오버시 오류 자동
		
		log.info("kakao-cancel ");
		
//		Map<String, String> json = (Map<String, String>) session.getAttribute("map") ;
		
		String tid = map.get("tid");
		String partner_order_id = map.get("partner_order_id");
		String cancel_amount = map.get("cancel_amount");
		String first_pdt = map.get("first_pdt");
		String qtt =  map.get("order_qtt");
		int order_qtt = Integer.parseInt(qtt);
		System.out.println(cancel_amount);
		
		Member member = service.selectMemberById(memberId);

		RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "64eac7ea0faa7f908904ee07ec3f2a67");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
       
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
       
        params.add("cid", "TC0ONETIME");
        params.add("tid", tid);
        params.add("cancel_amount", cancel_amount);
        params.add("cancel_tax_free_amount", "0");
        params.add("partner_order_id", partner_order_id);
        params.add("partner_user_id", member.getId());
        
        String name;
        if(order_qtt <= 1) {
        	name = first_pdt;
        }else {
        	name = first_pdt + " 외 " +(order_qtt - 1) + "건";
        }
        
        
        params.add("item_name", name);
        
         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
         System.out.println("body" + body);
         
        try {
        	//RestTemplate을 이용해 카카오페이에 데이터를 보내는 방법
        	//redirect page 안쓰므로 여기서 함
        	// order-detail -> 환불완료
        	// order -> 환불완료 
        	// payment -> 환불완료 
        	// mileage -> 사용한 마일리지 회복
        	
        	Order order = orderService.getOrderByNo(partner_order_id);
        	List<OrderDetail> odList = orderService.sortingOrderDetail(order.getId());
        	order.setDetails(odList);
        	System.out.println(order);
        	
        	order.setReturnPrice(Integer.parseInt(cancel_amount));
        	order.setState("환불완료");
        	
        	//order의 final_price 어케 처리할지,,
        	int finalPrice = order.getFinalPrice();
        	order.setFinalPrice(finalPrice - Integer.parseInt(cancel_amount));
        	int res1 = orderService.updateOrder(order, order.getId());
        	
        	
        	int res2 = 0;
        	for(OrderDetail od:odList) {
        		od.setOrderState(OrderState.REFUNDED);
        		res2 = orderService.updateAllOrderDetail(od, order.getId());
        	}
        	
        	Payment pay = orderService.getPaymentById(tid);
        	pay.setPayState("환불완료");
        	int res3 = orderService.updatePayment(pay, tid);
        	System.out.println("pay 정보:" + pay);
        	
        	Mileage plus = new Mileage();
    		plus.setMember(member);
    		plus.setOrder(order);
    		plus.setMileage(order.getUsedMileage());
    		plus.setContent("상품 구매 적립");
    		mileService.insertMilegeInfo(plus);
        	
        	System.out.println("orderstate:" + res1 + "/ od 총 " +odList.size() + "개 = " + res2 + "/ paystate:" + res3);

        	kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/cancel"), body, KakaoPayReadyVO.class);
        	log.info("" + kakaoPayReadyVO);
        	 
        	return "/kakaoPayCancelSuccess";

        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
		return null;
      
	}
	
	
	@Override
	@Transactional
	public String kakaoPayPartCancel(String memberId, Map<String, String> map) {
		Member member = service.selectMemberById(memberId);
		
		//부분취소 -> 부가세(cancel_vat_amount)만 계산해서 던져주면 됨 -> 안해도되는듯
		//전체 결제 금액오버시 exception 자동, 모두 부분취소 -> cancel_pay로 됨
		//부분취소시 total_price에서만 빼놓고 final은 배송비 추가 있을 수 있으니 admin에서 수정하는걸로,,
		
		log.info("kakao - part cancel ");
		
//		Map<String, String> json = (Map<String, String>) session.getAttribute("map") ;
		
		String tid = map.get("tid");
		String partner_order_id = map.get("partner_order_id");
		//String cancel_amount = json.get("cancel_amount");
		String first_pdt = map.get("first_pdt");
		String qtt =  map.get("order_qtt");
		String od_id = map.get("od_id");
		
		RestTemplate restTemplate = new RestTemplate();
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "64eac7ea0faa7f908904ee07ec3f2a67");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
       
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
       
        List<OrderDetail> newOdList = orderService.selectOrderDetailUsingPartCancelByOrderId(partner_order_id); 
        
        kakaoPayApprovalVo = kakaoPayInfo(tid);
        kakaoPayApprovalVo.setItem_name(first_pdt);
        
        String cancel_amount = null;
    	if(newOdList.size() == 1) {
    		cancel_amount = String.valueOf(kakaoPayApprovalVo.getCancel_available_amount().getTotal());
    		System.out.println("1개남았을때 남은금액:" + cancel_amount);
    	} else {
    		cancel_amount = map.get("cancel_amount");
    	}
    	System.out.println(cancel_amount);
        
        params.add("cid", "TC0ONETIME");
        params.add("tid", tid);
        params.add("cancel_amount", cancel_amount);
        params.add("cancel_tax_free_amount", "0");
        //params.add("cancel_vat_amount", cancel_vat_amount);
        params.add("partner_order_id", partner_order_id);
        params.add("partner_user_id", member.getId());
        //params.add("item_name", first_pdt);
        
        
         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
         System.out.println("body" + body);
         
        try {
        	
        	// order detail 취소건만 상태 부분취소로 변경
        	//payment 가격 변경, order 결제가격 변경 -> 상태 부분취소
        	//사용한 마일리지 복구
        	//부분취소시 배송비?? -> total만 수정하고 admin에서 알아서..
        	System.out.println("취소할 상품 이름:" + first_pdt);
        	
        	params.add("item_name", first_pdt);
        	 
        	Order order = orderService.getOrderByNo(partner_order_id);
         	List<OrderDetail> odList = orderService.sortingOrderDetail(order.getId());
         	order.setDetails(odList);
         	
         	OrderDetail od = orderService.getOrderDetailById(od_id);
         	od.setOrderState(OrderState.PART_CANCEL);
         
         	order.setState("부분취소");
         	order.setReturnPrice(order.getReturnPrice() + Integer.parseInt(cancel_amount));
        	
         	int total;
         	int finalPrice;
         	int mileRes = 0; 
         	
         	//결제완료가 하나인데 그것도 취소할때 -> 걍 하나면 주문취소로 하기
         	if(newOdList.size() == 1) {
        		total = 0 ;
        		finalPrice = 0;
        		order.setState("환불완료");
        		order.setTotalPrice(total);
             	order.setFinalPrice(finalPrice);
        		order.setDeliveryPrice(0);
        		
        		Mileage plus = new Mileage();
        		plus.setMember(member);
        		plus.setOrder(order);
        		plus.setMileage(order.getUsedMileage());
        		plus.setContent("상품 구매 적립");
        		mileRes = mileService.insertMilegeInfo(plus);
        		
        	} else {
        		total = order.getTotalPrice() - Integer.parseInt(cancel_amount);
        		order.setTotalPrice(total);
        		
        		finalPrice = order.getTotalPrice() + order.getDeliveryPrice() - order.getUsedMileage();
        		order.setFinalPrice(finalPrice);
        	}
        	
        	Payment pay = orderService.getPaymentById(tid);
        	pay.setPayState("부분취소");
        	pay.setOrder(order);

        	
        	
        	int res1= orderService.updatePartOrderDetail(od, od.getId());
        	int res2 = orderService.updateOrder(order, order.getId());
        	int res3 = orderService.updatePayment(pay, tid);
        	
        	System.out.println("orderstate:" + res1 + "/ od:" + res2 + "/ paystate:" + res3 + "/ mile:" + mileRes);
        	
        	//RestTemplate을 이용해 카카오페이에 데이터를 보내는 방법
       		kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/cancel"), body, KakaoPayReadyVO.class);
       		log.info("" + kakaoPayReadyVO);
        	
        	return "/kakaoPayPartCancelSuccess";

        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
		return null;
	}

	//결제 정보
	@Override
	public KakaoPayApprovalVO kakaoPayInfo(String tid) {
		log.info("kakao - info");
		System.out.println(tid);
		RestTemplate restTemplate = new RestTemplate();
		
		// 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "64eac7ea0faa7f908904ee07ec3f2a67");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
       
        params.add("cid", "TC0ONETIME");
        params.add("tid", tid);
        
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        System.out.println("body" + body);
       
		 try {
	        	//RestTemplate을 이용해 카카오페이에 데이터를 보내는 방법
			kakaoPayApprovalVo = restTemplate.postForObject(new URI(HOST + "/v1/payment/order"), body, KakaoPayApprovalVO.class);
			
			return kakaoPayApprovalVo;
			
		 } catch (RestClientException e) {
	            e.printStackTrace();
	        } catch (URISyntaxException e) {
	            e.printStackTrace();
	     }
		 
		return null;
	}

	

}
 
