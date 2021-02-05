package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Mileage;

public interface MileageMapper {

	int getMileage(String id);

	List<Mileage> selectMileageInfoByMemberId(String id);

	List<Mileage> selectMileageByAll(Criteria cri);
	
	int insertMilegeInfo(Mileage mile);

	int listCount();
	
	int insertMileageByMemberAll(Mileage mile);
}
