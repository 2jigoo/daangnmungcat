package daangnmungcat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import daangnmungcat.dto.Sale;
import daangnmungcat.mapper.JoongoSaleMapper;
import daangnmungcat.service.JoongoSaleService;

@Controller
//@RequestMapping(value ="/detailList/")
public class JoongoSaleController {

	@Autowired
	private JoongoSaleService service;
	
	@GetMapping("/joongsales")
	public ResponseEntity<Object> joongsales(){
		System.out.println("joongsales()");
		return ResponseEntity.ok(service.getLists());
	}
	
//	@GetMapping("/detailList")
//	public String list(Model model) {
//		List<Sale> list = service.getLists();
//		model.addAttribute("list", list);
//		System.out.println("컨트롤러 detailList >>> " + list);
//		return "/joongoSale/detailList";
//	}
//	
//	@GetMapping("/detailList/{id}")
//	public ResponseEntity<Object> sales(@PathVariable int id, HttpServletResponse response){
//		List<Sale> list = service.getListsById(id);
//		if (list == null) {
//			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
//		}
//		return ResponseEntity.ok(list);
//	}
	
	@RequestMapping(value="detailList", method=RequestMethod.GET)
	public String listById(@RequestParam int id, @RequestParam String memId, Model model) {
		List<Sale> list = service.getListsById(id);
		List<Sale> mlist = service.getListByMemID(memId);
		model.addAttribute("list", list);
		String ok =  "ok";
		if(mlist.size() == 1) {
			System.out.println("한개");
			model.addAttribute("emptylist", ok);
		}
		model.addAttribute("mlist", mlist);
//		System.out.println("mlist 출력  >> ");
//		mlist.stream().forEach(System.out::println);
		service.JSHits(id);
		return "/joongoSale/detailList";
	}
}
