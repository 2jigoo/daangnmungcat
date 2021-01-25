package daangnmungcat.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.FileForm;
import daangnmungcat.dto.Heart;
import daangnmungcat.dto.Sale;

public interface FileFormMapper {
	
	int insertSaleFile(FileForm fileForm);
	
}
