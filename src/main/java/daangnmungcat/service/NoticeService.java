package daangnmungcat.service;

import java.io.File;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Notice;
import daangnmungcat.dto.SearchCriteria;

public interface NoticeService {

	List<Notice> getList();
	List<Notice> getList(Criteria cri);
	
	int count();
	
	List<Notice> search(SearchCriteria scri, Notice notice);
	int getTotalBySearch(SearchCriteria scri, Notice notice);
	
	Notice get(int id);
	
	int registNotice(Notice notice, MultipartFile file, File realPath);
	int modifyNotice(Notice notice);
	int modifyNoticeFileName(Notice notice);
	int deleteNotice(Notice notice);
	
}
