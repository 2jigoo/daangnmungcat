package daangnmungcat.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Notice;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.mapper.NoticeMapper;
import daangnmungcat.service.MileageService;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeMapper mapper;
	
	@Autowired
	private MileageService mService;
	
	@GetMapping("/notice")
	public String list(Model model, Criteria cri) throws UnsupportedEncodingException {

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
	
	@GetMapping("/notice/view")
	public String list2(@RequestParam int id,Model model, Criteria cri) throws UnsupportedEncodingException {
		
		Notice notice = mapper.selectNoticeByNo(id);
		model.addAttribute("notice", notice);
		
		return "/notice/notice_view";
	}
	
	
}