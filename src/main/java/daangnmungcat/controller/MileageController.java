package daangnmungcat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.service.MileageService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class MileageController {
	
	@Autowired
	private MileageService mileageService;

	@GetMapping("/mypage/mileage/list")
	public String mileageMypageList(Model model, @RequestParam @Nullable String memId, Criteria cri) {
	
		Mileage mile = new Mileage();
		mile.setMember(new Member(memId));
		List<Mileage> list = mileageService.selectMileageBySearch(mile, cri);
		model.addAttribute("list",list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(mileageService.listSearchCount(mile));
		model.addAttribute("pageMaker", pageMaker);
		
		return "/mypage/mileage_list";
	}

}
