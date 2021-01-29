package daangnmungcat.controller.admin;

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
import daangnmungcat.service.MallPdtService;

@Controller
public class AdminMallCateController {
	
	@Autowired
	private MallCateService service;
	
	@Autowired
	private MallPdtService pdtService;
	
	@GetMapping("/admin/category/list")
	public String listCate(Model model) {
		List<MallCate> dogCate = pdtService.dogCateList();
		List<MallCate> catCate = pdtService.catCateList();
		
		model.addAttribute("dogCate", dogCate);
		model.addAttribute("catCate", catCate);
		
		return "/admin/category/cate_list";
	}
	
	@GetMapping("/admin/category/write")
	public String insertViewCate() {
		return "/admin/category/cate_write";
	}
	
	@PostMapping("/admin/category/write")
	public ResponseEntity<Object> insertWriteCate(@RequestBody Map<String, String> cate){
		try {
			return ResponseEntity.ok(service.insertMallCate(cate.get("cateName"), new MallCate(0, cate.get("name"))));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	@GetMapping("/admin/category/update")
	public String updateViewCate(@RequestParam String cateName, @RequestParam int id, Model model) {
		MallCate item = service.selectByIdCate(cateName, id);
		model.addAttribute("item", item);
		
		return "/admin/category/cate_update";
	}
	
	@PostMapping("/admin/category/update")
	public ResponseEntity<Object> updateWriteCate(@RequestBody Map<String, String> cate){
		try {
			return ResponseEntity.ok(service.updateMallCate(cate.get("cateName"), new MallCate(Integer.parseInt(cate.get("id")), cate.get("name"))));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	
	@GetMapping("/admin/category/delete")
	public String deleteCate(@RequestParam String cateName, @RequestParam int id) {
		service.deleteMallCate(cateName, id);
		return "redirect:/admin/category/list";
	}

}
