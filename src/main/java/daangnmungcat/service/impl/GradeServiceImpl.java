package daangnmungcat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Grade;
import daangnmungcat.mapper.GradeMapper;
import daangnmungcat.service.GradeService;

@Service
public class GradeServiceImpl implements GradeService {

	@Autowired
	private GradeMapper gradeMapper;
	
	@Override
	public List<Grade> getList() {
		return gradeMapper.selectGrades();
	}

	@Override
	public Grade get(String code) {
		return gradeMapper.selectGradeByCode(code.toUpperCase());
	}

}
