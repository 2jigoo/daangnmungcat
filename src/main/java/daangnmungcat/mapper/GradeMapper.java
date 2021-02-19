package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Grade;

public interface GradeMapper {

	List<Grade> selectGrades();
	Grade selectGradeByCode(String code);
	
}
