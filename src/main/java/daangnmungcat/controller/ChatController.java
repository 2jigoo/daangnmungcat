package daangnmungcat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import daangnmungcat.dto.Chat;
import daangnmungcat.dto.Member;
import daangnmungcat.service.ChatService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class ChatController {

	@Autowired
	private ChatService service;
	
	@GetMapping("/chat")
	public String myChatList(Model model, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		log.debug("loginUser's ID: " + loginUser.getId());
			
		List<Chat> list = service.getMyChatsList(loginUser.getId());
		list.stream().forEach(chat -> log.debug(chat.toString()));
		
		model.addAttribute("list", list);
		
		return "/chat/mychats";
	}
}
