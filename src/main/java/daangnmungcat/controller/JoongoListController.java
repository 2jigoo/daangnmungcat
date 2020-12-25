package daangnmungcat.controller;

import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import daangnmungcat.dto.Sale;
import daangnmungcat.mapper.JoongoListMapper;

@Controller
public class JoongoListController {
	private static final Log log = LogFactory.getLog(JoongoListController.class);
	
	@Autowired
	private JoongoListMapper mapper;	
	
	@GetMapping("/joongo_list")
	public String list(Model model) {
		List<Sale> list = mapper.selectJoongoByAll();
		model.addAttribute("list", list);
		System.out.println(list);
		return "/joongo_list";
	}
	
	@GetMapping("/joongo_list/{dongne1}")
	public String listDongne1(Model model, @PathVariable("dongne1") String dongne1){
		List<Sale> list = mapper.selectJoongoByDongne1(dongne1);
		model.addAttribute("list", list);
		model.addAttribute("dongne1Name", dongne1);
		return "/joongo_list";
	}
	
	@GetMapping("/joongo_list/{dongne1}/{dongne2}")
	public String listDongne2(Model model, @PathVariable("dongne1") String dongne1, @PathVariable("dongne2") String dongne2) {
		System.out.println(dongne1);
		List<Sale> list = mapper.selectJoongoByDongne2(dongne1, dongne2);
		model.addAttribute("list", list);
		model.addAttribute("dongne1Name", dongne1);
		model.addAttribute("dongne2Name", dongne2);
		return "/joongo_list";
	}
}
