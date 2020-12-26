package daangnmungcat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import daangnmungcat.service.JoongoSaleService;

@Controller
public class JoongoSaleController {

	@Autowired
	private JoongoSaleService service;
	
	@GetMapping("/joongsales")
	public ResponseEntity<Object> joongsales(){
		System.out.println("joongsales()");
		return ResponseEntity.ok(service.getLists());
	}
}
