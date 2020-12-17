package daangnmungcat.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class StompController {

	@MessageMapping("/TTT")
	@SendTo("/topic/message")
	public String tttMesage(String message) throws Exception {
		System.out.println("TTT >>> " + message);
		return message;
	}
}
