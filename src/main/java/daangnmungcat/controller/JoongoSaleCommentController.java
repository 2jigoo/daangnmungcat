package daangnmungcat.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import daangnmungcat.dto.SaleComment;
import daangnmungcat.service.JoongoSaleCommentService;

@Controller
public class JoongoSaleCommentController {
	
	@Autowired
	private JoongoSaleCommentService service;
	
	@RequestMapping(value = "/joongoCommentWrite", method = RequestMethod.GET)
	public void insertComment(@RequestBody SaleComment saleComment) {
		System.out.println("왔다리");
		try {
			JSONObject jso = new JSONObject();
			
		} catch (Exception e) {
			System.out.println("오류");
		}
	}

}
