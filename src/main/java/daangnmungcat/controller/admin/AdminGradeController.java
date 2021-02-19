package daangnmungcat.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import daangnmungcat.dto.Grade;
import daangnmungcat.service.GradeService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class AdminGradeController {

	@Autowired
	private GradeService gradeService;
	
	@GetMapping("/api/grade")
	public ResponseEntity<Object> memberListPage() {
		List<Grade> list = null;
		try {
			list = gradeService.getList();
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
		return ResponseEntity.ok(list);
	}
	
}
