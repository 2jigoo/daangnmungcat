package daangnmungcat.controller;

import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
}
