package daangnmungcat.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.dto.SaleComment;
import daangnmungcat.service.JoongoSaleCommentService;

@Controller
public class AdminJoongoSaleCommentController {
	
	@Autowired
	private JoongoSaleCommentService service;
	
	@GetMapping("/admin/comment/list")
	public String list(Model model, Criteria cri) {
		List<SaleComment> list = service.selectJoongoCommentByAllPage2(cri);
		model.addAttribute("list", list);
		

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.commentCount2());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/comment/comment_list";
	}
}
