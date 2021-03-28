package daangnmungcat.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import daangnmungcat.dto.Mail;


public interface EmailService {
	
	Map<String, String> sendEmail(String email);

}
