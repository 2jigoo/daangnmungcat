package daangnmungcat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Notice;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.service.NoticeService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/notice")
	public String list(Model model, Criteria cri) {

		System.out.println(cri);
		List<Notice> notice = noticeService.getList(cri);
		model.addAttribute("notice", notice);
		System.out.println(notice);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(noticeService.count());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/notice/notice_list";
	}
	
	@GetMapping("/notice/view")
	public String list2(@RequestParam int id,Model model, Criteria cri) {
		
		noticeService.addHits(id);
		Notice notice = noticeService.get(id);
		
		log.info("prev: " + notice.getPrev() + ", next: " + notice.getNext());
		
		Notice prev = noticeService.getSimpleInfo(notice.getPrev());
		Notice next = noticeService.getSimpleInfo(notice.getNext());
		
		
		model.addAttribute("notice", notice);
		model.addAttribute("prev", prev);
		model.addAttribute("next", next);
		
		return "/notice/notice_view";
	}
	
	
}