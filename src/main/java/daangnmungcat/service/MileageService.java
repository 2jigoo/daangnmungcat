package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;

public interface MileageService {
	int updateMemberMileage(Member member);
	List<Mileage> selectMileageInfoById(String id);
	int insertMilegeInfo(Mileage mile);
	int getMileage(String id);
	
}
