package daangnmungcat.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Chat;
import daangnmungcat.dto.ChatMessage;
import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.Sale;
import daangnmungcat.dto.SaleReview;
import daangnmungcat.exception.AlreadySoldOut;
import daangnmungcat.service.ChatService;
import daangnmungcat.service.JoongoSaleReviewService;
import daangnmungcat.service.JoongoSaleService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	@Autowired
	private JoongoSaleService saleService;
	
	@Autowired
	private JoongoSaleReviewService reviewService;
	
	@GetMapping("/chat")
	public String myChatList(Model model, Criteria cri, AuthInfo loginUser) {
		
		if(cri.getPerPageNum() == 20) {
			cri.setPerPageNum(10);
		}
		
		List<Chat> list = chatService.getMyChatsList(loginUser.getId(), cri);
		int totalCount = chatService.countMyChatsList(loginUser.getId());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/chat/mychats";
	}
	
	@GetMapping("/chat/sale/{id}")
	public String myChatList(@PathVariable("id") int id, Criteria cri, Model model, AuthInfo loginUser, RedirectAttributes ra) {
		Sale sale = saleService.getSaleById(id);
		
		if (sale == null) {
			ra.addFlashAttribute("errorCode", -1);
			return "redirect:/joongo_list";
		}
		
		if(cri.getPerPageNum() == 20) {
			cri.setPerPageNum(10);
		}
		
		String memberId = loginUser.getId();
		int totalCount = chatService.countsMyChatsOnSale(memberId, id);
		List<Chat> list = chatService.getMyChatsListOnSale(memberId, id, cri);
		
		if (!loginUser.getId().equals(sale.getMember().getId())) {
			if(totalCount == 0) {
				ra.addFlashAttribute("errorCode", -2);
				return "redirect:/joongo_list";
			} else {
				return "redirect:/chat/" + list.get(0).getId();
			}
		}
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		model.addAttribute("sale", sale);
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/chat/mychats";
	}
	
	
	@GetMapping("/chat/{id}")
	public String chatView(@PathVariable("id") int id, Model model, AuthInfo loginUser) {
		chatService.readChat(id, loginUser.getId());
		
		Criteria cri = new Criteria(1, 20);
		Chat chat = chatService.getChatWithMessages(id, cri);
		log.debug("chat: " + chat.toString());
		
		SaleReview review = reviewService.getReviewBySaleId(chat.getSale().getId(), loginUser.getId());
		if(review != null) {
			log.info("review: " + review.getId());
			model.addAttribute("reviewed", true);
			model.addAttribute("review", review);
		}
		
		model.addAttribute("chat", chat);
		
		return "/chat/room";
	}
	
	@ResponseBody
	@GetMapping("/api/chat/message")
	public List<ChatMessage> chatList(@RequestParam(value = "id", required = true) int chatId, @RequestParam(value = "page", defaultValue = "1") int page, AuthInfo loginUser) {
		
		Criteria criteria = new Criteria(page, 20);
		chatService.getChatMessages(chatId, criteria);
		List<ChatMessage> list = chatService.getChatMessages(chatId, criteria);
		
		return list;
	}
	
	
	@GetMapping("/go-to-chat")
	public String goToChatFromSale(@RequestParam(value = "id") int saleId, AuthInfo loginUser, RedirectAttributes redirectAttributes, Model model) {
		
		Sale sale = null;
		String memberId = loginUser.getId();

		sale = saleService.getSaleById(saleId);
		
		if (sale == null) {
			redirectAttributes.addFlashAttribute("errorMsg", -1);
			return "redirect:/joongo_list";
		}
		
		if(sale.getMember().getId().equals(memberId)) {
			return "redirect:/chat/sale/" + saleId;
		}
		
		int totalCount = chatService.countsMyChatsOnSale(loginUser.getId(), saleId);
		if(totalCount != 0) {
			Chat chat = chatService.getMyChatsListOnSale(memberId, saleId, null).get(0);
			return "redirect:/chat/" + chat.getId();
		}
		
		model.addAttribute("sale", sale);
		return "/chat/new_room";
	}
	
	
	@PostMapping("/chat/room")
	@ResponseBody
	public ResponseEntity<Object> createNewRoom(@RequestBody Sale sale, AuthInfo loginUser) {
		
		// #{id}, #{sale.id}, #{sale.member.id}, #{buyer.id}
		Member buyer = null;
		int chatId = 0;
		
		try {
			buyer = new Member(loginUser.getId());
			Chat chat = new Chat(sale, buyer);
			log.debug(chat.toString());
			
			chatId = chatService.createNewChat(chat);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(chatId);
	}
	
	@PostMapping("/chat/{id}/upload")
	@ResponseBody
	public ResponseEntity<Object> uploadImageFile(@PathVariable(value = "id") int id, @RequestParam(value="imageFile") MultipartFile file, ChatMessage message, HttpSession session, AuthInfo loginUser) {
		System.out.println(">> uploadImageFile()");
		String fileName = null;
		
		try {
			message.setChat(new Chat(id));
			fileName = chatService.uploadImageMessage(message, file, getRealPath(session));
		} catch(Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(fileName);
	}
	
	
	@PostMapping("/chat/{id}/sold-out")
	public ResponseEntity<Object> soldOut(@PathVariable(value = "id") int id, HttpServletRequest request, AuthInfo loginUser) {
		int res = 0;
		try {
			String loginUserID = loginUser.getId();
			Chat chat = chatService.getChatInfo(id);
			if(!loginUserID.equals(chat.getSale().getMember().getId()) && !loginUserID.equals(chat.getBuyer().getId())) {
				return ResponseEntity.status(HttpStatus.CONFLICT).body("해당 채팅의 참여자가 아닙니다.");
			}
			res = saleService.soldOut(chat.getBuyer(), chat.getSale());
		} catch (AlreadySoldOut so) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body(so.getMessage());
		}
		
		return ResponseEntity.ok(res);
	}
	
	private File getRealPath(HttpSession session) {
		return new File(session.getServletContext().getRealPath("")); 
	}
	
}
