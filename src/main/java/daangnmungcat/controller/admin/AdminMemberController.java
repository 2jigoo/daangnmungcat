package daangnmungcat.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class AdminMemberController {

	@GetMapping("/admin/member/list")
	public String memberListPage() {
		return "/admin/member/member_list";
	}
	
	@GetMapping("/admin/member/detail/{id}")
	public String memberInfoViewPage() {
		return "/admin/member/member_detail";
	}
	
}
