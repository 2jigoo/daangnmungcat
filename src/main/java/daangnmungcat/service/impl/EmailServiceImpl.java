package daangnmungcat.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Mail;
import daangnmungcat.service.EmailService;

@Service
public class EmailServiceImpl implements EmailService {

	@Autowired
    JavaMailSender mailSender;
	
	@Override
    public Map<String, String> sendEmail(String email) {
		
		Mail mail = new Mail();
		
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}

        mail.setTo(email);
        mail.setSubject("This is Email test.");
        mail.setContent("인증번호는 [" + numStr + "]입니다.");
 
        final MimeMessagePreparator preparator = new MimeMessagePreparator() {
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
                
                helper.setFrom(mail.getFrom()); // recipient
                helper.setTo(mail.getTo()); //sender
                helper.setSubject(mail.getSubject()); // mail title
                helper.setText(mail.getContent(), true); // mail content
            }
        };
        
        mailSender.send(preparator);
        
        Map<String, String> map = new HashMap<String, String>();
        map.put("email", email);
        map.put("certiKey", numStr);
        
		return map;
        
    }


}
