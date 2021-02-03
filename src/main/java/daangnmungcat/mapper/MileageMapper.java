package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;

public interface MileageMapper {
	
	int getMileage(String id);
	List<Mileage> selectMileageInfoByMemberId(String id);
	int insertMilegeInfo(Mileage mile);
	
}
