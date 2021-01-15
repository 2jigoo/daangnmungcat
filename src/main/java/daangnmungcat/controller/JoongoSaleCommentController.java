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
	
	@PostMapping("/joongoCommentWrite")
	public ResponseEntity<Object> insertComment(@RequestBody SaleComment saleComment) {
		System.out.println("왔다리");
		try {
			return ResponseEntity.ok(service.insertJoongoSaleComment(saleComment));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}

}
