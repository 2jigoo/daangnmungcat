package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;

public interface MileageService {
	int updateMileage(Mileage mile);
	List<Mileage> selectMileageInfoByMemberId(String id);
	int insertMilegeInfo(Mileage mile);
	int getMileage(String id);
	
}
