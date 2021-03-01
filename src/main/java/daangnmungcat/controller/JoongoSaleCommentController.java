package daangnmungcat.controller;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.SaleComment;
import daangnmungcat.service.JoongoSaleCommentService;

@Controller
public class JoongoSaleCommentController {
	
	@Autowired
	private JoongoSaleCommentService service;
	
	@GetMapping("/mypage/joongo/comment")
	public String mypageCommentList(Model model, @RequestParam @Nullable String memId, Criteria cri) {
		if (!memId.equals("") || memId != null) {
			SaleComment saleComment = new SaleComment();
			saleComment.setMember(new Member(memId));

			// 댓글
			List<SaleComment> commentList = service.selectJoongoCommentSearchByAllPage(saleComment, cri);
			model.addAttribute("commentList", commentList);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(service.commentSearchCount(saleComment));
			model.addAttribute("pageMaker", pageMaker);
		}
		
		return "/mypage/joongo_comment";
	}
	
	@PostMapping("/joongo/comment/write")
	public ResponseEntity<Object> insertComment(@RequestBody SaleComment saleComment) {
		try {
			return ResponseEntity.ok(service.insertJoongoSaleComment(saleComment));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	@PostMapping("/joongo/comment/delete")
	public ResponseEntity<Object> deleteComment(@RequestBody SaleComment saleComment){
		try {
			return ResponseEntity.ok(service.deleteComment(saleComment.getId()));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	@PostMapping("/joongo/comment/update")
	public ResponseEntity<Object> updateComment(@RequestBody SaleComment saleComment){
		try {
			return ResponseEntity.ok(service.updateComment(saleComment));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}

}
