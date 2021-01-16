package daangnmungcat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.dto.Criteria;
import daangnmungcat.service.ChatService;
import daangnmungcat.websocket.ChatMessageController;

@Controller
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	private static final Log log = LogFactory.getLog(ChatMessageController.class);
	
	@GetMapping("/chat")
	public String myChatList(Model model, HttpSession session) {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		log.debug("loginUser's ID: " + loginUser.getId());
			
		List<Chat> list = chatService.getMyChatsList(loginUser.getId());
		list.stream().forEach(chat -> log.debug(chat.toString()));
		
		model.addAttribute("list", list);
		
		return "/chat/mychats";
	}
	
	
	@GetMapping("/chat/{id}")
	public String chatView(@PathVariable("id") int id, Model model, HttpSession session) {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		
		Criteria cri = new Criteria(1, 20);
		Chat chat = chatService.getChatWithMessages(id, cri);
		log.debug("chat: " + chat.toString());
		
		model.addAttribute("chat", chat);
		
		return "/chat/room";
	}
	
	@ResponseBody
	@GetMapping("/api/chat/")
	public List<Chat> chatList(HttpSession session) {
		AuthInfo loginUser = (AuthInfo) session.getAttribute("loginUser");
		List<Chat> list = chatService.getMyChatsList("chattest1");
		
		return list;
	}
	
}
