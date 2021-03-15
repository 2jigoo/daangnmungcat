package daangnmungcat.controller;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import daangnmungcat.service.MemberService;

@RestController
public class SmsController {

	@Autowired
	private MemberService service;

	@GetMapping("/send-sms/{phoneNumber}")
	public String sendNum(@PathVariable String phoneNumber) {
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}

		System.out.println("수신자 번호 : " + phoneNumber);
		System.out.println("인증번호 : " + numStr);
		service.certifiedPhoneNumber(phoneNumber, numStr);

		return numStr;
	}
}
