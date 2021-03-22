package daangnmungcat.controller.admin;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@PostMapping("/admin/notice")
	@ResponseBody
	public ResponseEntity<Object> noticeWriting(Notice notice, @RequestParam(value = "uploadImage", required = false) MultipartFile uploadFile, AuthInfo loginUser, HttpSession session) {
		
		log.info(notice.toString());
		
		File realPath = null;
		
		if(uploadFile != null) {
			log.info(uploadFile.getOriginalFilename());
			realPath = getRealPath(session);
		}
		
		int id = 0;
		notice.setWriter(new Member(loginUser.getId()));
		
		try {
			id = noticeService.registNotice(notice, uploadFile, realPath);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		
		return ResponseEntity.ok(id);
	}
	
	@GetMapping("/admin/notice/modify")
	public String noticeModifyFormPage(int id, Model model) {
		Notice notice = noticeService.get(id);
		model.addAttribute("notice", notice);
		
		return "/admin/notice/notice_modify";
	}

	
	@PostMapping("/admin/notice/{noticeId}")
	@ResponseBody
	public ResponseEntity<Object> noticeModifying(@PathVariable int noticeId, Notice notice, @RequestParam(value = "uploadImage") MultipartFile uploadFile, @RequestParam boolean isChanged, AuthInfo loginUser, HttpSession session) {
		
		try {
			notice.setId(noticeId);
			log.info("notice.getNoticeFile(): " + notice.getNoticeFile());
			log.info("파일 변경? " + isChanged);
			log.info("uploadFile: " + (uploadFile.isEmpty() ? "null" : uploadFile.getOriginalFilename()));
			
			int res = noticeService.modifyNotice(notice, uploadFile, getRealPath(session), isChanged);
			return ResponseEntity.ok(res);
			
		} catch(RuntimeException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	
	@DeleteMapping("/admin/notice/{noticeId}")
	@ResponseBody
	public ResponseEntity<Object> noticeDeleting(@PathVariable int noticeId, HttpSession session) {
		try {
			noticeService.deleteNotice(new Notice(noticeId), getRealPath(session));
		} catch(RuntimeException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		return ResponseEntity.ok("success");
	}
	
	
	private File getRealPath(HttpSession session) {
		return new File(session.getServletContext().getRealPath("")); 
	}
}
