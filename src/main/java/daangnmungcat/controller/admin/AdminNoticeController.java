package daangnmungcat.controller.admin;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.AuthInfo;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Notice;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.SearchCriteria;
import daangnmungcat.service.NoticeService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminNoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/admin/notice/list")
	public String noticeListPage(SearchCriteria scri, String noticeYn, Model model) {
		log.info("컨트롤러 처음 받아 온 scri: " + scri);
		
		if(scri.getPerPageNum() == scri.DEFAULT_PERPAGE_NUM) {
			scri.setPerPageNum(10);
		}
		
		Map<String, String> paramsMap = new HashMap<>();
		paramsMap.put("noticeYn", noticeYn);
		scri.setParams(paramsMap);
		
		Notice notice = new Notice();
		
		if(noticeYn != null && noticeYn.length() != 0) {
			notice.setNoticeYn(noticeYn);
		}
		
		log.info("notice: " + notice.getNoticeYn());
		
		int total = noticeService.getTotalBySearch(scri, notice);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(total);
		
		List<Notice> list = noticeService.search(scri, notice);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("noticeYn", noticeYn);
		
		log.info("페이징 계산 끝난 scri: " + scri);
		
		return "/admin/notice/notice_list";
	}
	
	@GetMapping("/admin/notice/detail")
	public String noticeViewPage(int id){
		return "/admin/notice/notice_detail";
	}
	
	@GetMapping("/admin/notice/write")
	public String noticeWriteFormPage() {
		return "/admin/notice/notice_write";
	}
	
	@PostMapping("/admin/notice/write")
	@ResponseBody
	public String noticeWriting(Notice notice, @RequestParam(value = "noticeFile", required = false) MultipartFile file, AuthInfo loginUser, HttpSession session) {
		
		log.info(notice.toString());
		
		File realPath = null;
		
		if(file != null) {
			log.info(file.getOriginalFilename());
			realPath = getRealPath(session);
		}
		
		notice.setWriter(new Member(loginUser.getId()));
		int id = noticeService.registNotice(notice, file, realPath);
		
		return "id";
	}
	
	private File getRealPath(HttpSession session) {
		return new File(session.getServletContext().getRealPath("")); 
	}
}
