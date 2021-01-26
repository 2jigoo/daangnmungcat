package daangnmungcat.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import daangnmungcat.dto.Address;
import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Member;
import daangnmungcat.service.MemberService;

@RestController
public class ShippingAddressController {
		
	@Autowired
	private MemberService service;
	
	//배송지관리 - 리스트
	@GetMapping("/address-list")
	public List<Address> address(HttpSession session, HttpServletRequest request){
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		List<Address> list = service.myAddress(loginUser.getId());
		list.stream().forEach(System.out::println);
		return list;
	}
	
	//배송지 추가
	@PostMapping("/address/post")
	public ResponseEntity<Object> addAdress(@RequestBody Address address) {
		try {
			return ResponseEntity.ok(service.insertAddress(address));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	//배송지 수정
	@PostMapping("/member/adddress/post")
	public int updateMyAddress(@RequestBody Map<String, Object> map, HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		AuthInfo info = (AuthInfo) session.getAttribute("loginUser");
		Member loginUser = service.selectMemberById(info.getId());
		
		String zipcode = map.get("zipcode").toString();
		String add1 = map.get("address1").toString();
		String add2 = map.get("address2").toString();
		
		loginUser.setZipcode(Integer.parseInt(zipcode));
		loginUser.setAddress1(add1);
		loginUser.setAddress2(add2);
		int res = service.updateMyAddress(loginUser);
		return res;
	}
	
	//배송지 수정 팝업 - 배송지정보
	@GetMapping("/address/{id}")
	public ResponseEntity<Object> addr(@PathVariable String id) {
		return ResponseEntity.ok(service.getAddress(id));

	}
	
	//배송지 수정
	@PostMapping("/address/post/{id}")
	public ResponseEntity<Object> updateShipping(@PathVariable String id, @RequestBody Map<String, Object> map) {
		try {
			Address add = service.getAddress(id);
			add.setSubject(map.get("subject").toString());
			add.setName(map.get("name").toString());
			add.setZipcode(Integer.parseInt(map.get("zipcode").toString()));
			add.setAddress1(map.get("address1").toString());
			add.setAddress2(map.get("address2").toString());
			add.setPhone(map.get("phone").toString());
			add.setMemo(map.get("memo").toString());
			
			return ResponseEntity.ok(service.updateShippingAddress(add));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	//배송지 삭제
	@GetMapping("/address/get/{id}")
	public ResponseEntity<Object> deleteShipping(@PathVariable String id) {
		return ResponseEntity.ok(service.deleteShippingAddress(id));
	}
	
}
