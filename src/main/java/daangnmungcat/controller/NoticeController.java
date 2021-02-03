package daangnmungcat.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Notice;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.mapper.NoticeMapper;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class NoticeController {
	
	@Autowired
	private NoticeMapper mapper;
	
	@GetMapping("/notice")
	public String list(Model model, Criteria cri, HttpSession session) throws UnsupportedEncodingException {

		System.out.println(cri);
		List<Notice> notice = mapper.selectNoticeByAllPage(cri);
		model.addAttribute("notice", notice);
		System.out.println(notice);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(mapper.listCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/notice/notice_list";
	}
	
	@RequestMapping(value = "notice/view", method = RequestMethod.GET)
	public String list2(@RequestParam int id,Model model, Criteria cri, HttpSession session) throws UnsupportedEncodingException {
		
		Notice notice = mapper.selectNoticeByNo(id);
		model.addAttribute("notice", notice);
		
		return "/notice/notice_view";
	}
	
	
}