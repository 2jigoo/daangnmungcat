package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Mileage;

public interface MileageMapper {

	int getMileage(String id);

	List<Mileage> selectMileageInfoByMemberId(String id);
	
	Mileage selectMileageInfoById(int id);

	List<Mileage> selectMileageByAll(Criteria cri);
	
	int insertMilegeInfo(Mileage mile);

	int listCount();
	
	int insertMileageByMemberAll(Mileage mile);
	
	List<Mileage> selectMileageBySearch(@Param("mileage") Mileage mileage, @Param("cri") Criteria cri);
	
	int updateMileageById(Mileage mile);
	
	int deleteMileage(int id);
	
	int insertEventMilege(Mileage mile);
	
	int mileageSearchCount(Mileage mile);
	
}
