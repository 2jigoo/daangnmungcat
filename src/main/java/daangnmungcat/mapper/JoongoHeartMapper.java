package daangnmungcat.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Heart;
import daangnmungcat.dto.Sale;

public interface JoongoHeartMapper {
	
	Heart selectJoongoHeartById();
	
	void insertHeart(HashMap<String, Object> map);
	void deleteHeart(HashMap<String, Object> map);
	
	Integer countHeart(HashMap<String, Object> map);

	
}
