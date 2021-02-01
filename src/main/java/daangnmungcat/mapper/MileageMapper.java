package daangnmungcat.mapper;

import java.util.List;

import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;

public interface MileageMapper {
	
	int updateMemberMileage(Member member);
	int getMileage(String id);
	
	List<Mileage> selectMileageInfoById(String id);
	int insertMilegeInfo(Mileage mile);
	
}
