package daangnmungcat.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.MallCate;
import daangnmungcat.service.MallCateService;

@Controller
public class MallCateController {
	
	@Autowired
	private MallCateService service;
	
	@GetMapping("/mall/cate/list")
	public String listCate(Model model) {
		List<MallCate> dogCate = service.selectByAllDogCate();
		List<MallCate> catCate = service.selectByAllCatCate();
		
		model.addAttribute("dogCate", dogCate);
		model.addAttribute("catCate", catCate);
		
		return "/mall/mall_cate_list";
	}
	
	@GetMapping("/mall/cate/write")
	public String insertViewCate() {
		return "/mall/mall_cate_add";
	}
	
	@PostMapping("/mall/cate/write")
	public ResponseEntity<Object> insertWriteCate(@RequestBody Map<String, String> cate){
		try {
			return ResponseEntity.ok(service.insertMallCate(cate.get("cateName"), new MallCate(0, cate.get("name"))));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	@GetMapping("/mall/cate/update")
	public String updateViewCate(@RequestParam String cateName, @RequestParam int id, Model model) {
		MallCate item = service.selectByIdCate(cateName, id);
		model.addAttribute("item", item);
		
		return "/mall/mall_cate_update";
	}
	
	@PostMapping("/mall/cate/update")
	public ResponseEntity<Object> updateWriteCate(@RequestBody Map<String, String> cate){
		try {
			return ResponseEntity.ok(service.updateMallCate(cate.get("cateName"), new MallCate(Integer.parseInt(cate.get("id")), cate.get("name"))));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
}
