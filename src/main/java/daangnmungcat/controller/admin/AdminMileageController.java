package daangnmungcat.controller.admin;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;
import daangnmungcat.dto.PageMaker;
import daangnmungcat.exception.DuplicateMemberException;
import daangnmungcat.service.MemberService;
import daangnmungcat.service.MileageService;

@Controller
public class AdminMileageController {
	
	@Autowired
	private MileageService service;
	
	@Autowired
	private MemberService memService;
	
	@GetMapping("/admin/mileage/list")
	public String list(Model model, Criteria cri, @RequestParam @Nullable String content, @RequestParam @Nullable String member) {
		List<Mileage> list = new ArrayList<Mileage>();
		
		if(content != null  || member != null ) {
			Mileage mileage = new Mileage();
			if(content != null) {
				mileage.setContent(content);
			}
			if(member != null) {
				mileage.setMember(new Member(member));
			}
			list = service.selectMileageBySearch(mileage, cri);
		}else {
			list = service.selectMileageByAll(cri);
		}
		model.addAttribute("list", list);
		System.out.println(list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/mileage/mileage_list";
	}
	
	@GetMapping("/admin/mileage/update")
	public String updateViewProduct(Model model, @RequestParam int id) {
		Mileage mileage = service.selectMileageById(id);
		model.addAttribute("mileage", mileage);
		
		return "/admin/mileage/mileage_update";
	}
	
	@PostMapping("/admin/mileage/update")
	public ResponseEntity<Object> updateMileage (@RequestBody Mileage mileage ) {
		try {
			return ResponseEntity.ok(service.updateMileageById(mileage));
		} catch (DuplicateMemberException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}

	}
	
	@GetMapping("/admin/mileage/delete")
	public String deleteMileage (@RequestParam int id) {
		service.deleteMileage(id);
		return "redirect:/admin/mileage/list";
	}
	

	@GetMapping("/admin/mileage/write")
	public String writeMileage (Model model) {
		return "/admin/mileage/mileage_write";
	}
	
	@GetMapping("/members")
	public ResponseEntity<Object> members() {
		return ResponseEntity.ok(memService.selectMemberByAll());
	}
	

	@PostMapping("/admin/mileage/write")
	public ResponseEntity<Object> writeMileage (@RequestBody Mileage mileage ) {
		try {
			if(mileage.getMember().getId().equals("all")) {
				return ResponseEntity.ok(service.insertEventMilege(mileage));
			}else {
				return ResponseEntity.ok(service.insertMilegeInfo(mileage));
			}
		} catch (DuplicateMemberException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}

	}
}
