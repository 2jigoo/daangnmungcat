package daangnmungcat.service;

import java.util.List;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;

public interface MileageService {
	List<Mileage> selectMileageInfoByMemberId(String id);

	List<Mileage> selectMileageByAll(Criteria cri);
	
	int insertMilegeInfo(Mileage mile);
	int insertEventMilege(Mileage mileage);

	int getMileage(String id);

	int listCount();
	
	List<Mileage> selectMileageBySearch(Mileage mileage, Criteria cri);

	Mileage selectMileageById(int id);
	
	int updateMileageById(Mileage mileage);
	
	int deleteMileage(int id);
}
