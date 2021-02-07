package daangnmungcat.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import daangnmungcat.dto.SaleComment;
import daangnmungcat.service.JoongoSaleCommentService;

@Controller
public class JoongoSaleCommentController {
	
	@Autowired
	private JoongoSaleCommentService service;
	
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
