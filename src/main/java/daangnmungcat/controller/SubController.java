package daangnmungcat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SubController {
	@GetMapping("/sub")
	public String hello(Model model, @RequestParam(value="name", required=false) String name) {
		return "sub";
	}
}