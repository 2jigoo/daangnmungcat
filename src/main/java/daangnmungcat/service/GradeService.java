package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.Grade;

public interface GradeService {

	List<Grade> getList();
	Grade get(String code);
	
}
