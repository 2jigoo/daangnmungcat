package daangnmungcat.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.MallProduct;

@Service
public interface MallPdtService {
	int insertMallProduct(MallProduct product, MultipartFile thumbFile, List<MultipartFile> fileList, HttpServletRequest request);
}
