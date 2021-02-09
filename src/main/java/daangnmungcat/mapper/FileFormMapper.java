package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.FileForm;
import daangnmungcat.dto.Sale;

public interface FileFormMapper {
	
	int insertSaleFile(FileForm fileForm);
	
	List<FileForm> selectImgPath(@Param("id")int id);
	
	int deleteSaleFile(String fileName);
	int deleteSaleFileBySaleId(int id);
	
}
