package daangnmungcat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Member;
import daangnmungcat.dto.Mileage;
import daangnmungcat.mapper.MileageMapper;
import daangnmungcat.service.MileageService;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class MileageServiceImpl implements MileageService {
	
	@Autowired
	private MileageMapper mapper;
	
	@Override
	public int insertMilegeInfo(Mileage mile) {
		return mapper.insertMilegeInfo(mile);
	}

	@Override
	public int getMileage(String id) {
		return mapper.getMileage(id);
	}

	@Override
	public List<Mileage> selectMileageInfoByMemberId(String id) {
		return mapper.selectMileageInfoByMemberId(id);
	}

	@Override
	public int listCount() {
		return mapper.listCount();
	}

	@Override
	public List<Mileage> selectMileageByAll(Criteria cri) {
		return mapper.selectMileageByAll(cri);
	}

	@Override
	public List<Mileage> selectMileageBySearch(Mileage mileage, Criteria cri) {
		return mapper.selectMileageBySearch(mileage, cri);
	}

	@Override
	public Mileage selectMileageById(int id) {
		return mapper.selectMileageInfoById(id);
	}

	@Override
	public int updateMileageById(Mileage mileage) {
		return mapper.updateMileageById(mileage);
	}

	@Override
	public int deleteMileage(int id) {
		return mapper.deleteMileage(id);
	}

}