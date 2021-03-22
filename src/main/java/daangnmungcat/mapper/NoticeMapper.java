package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Notice;
import daangnmungcat.dto.SearchCriteria;

public interface NoticeMapper {

	List<Notice> selectNoticeBySearch(@Param("scri") SearchCriteria scri, @Param("notice") Notice notice);
	int selectNoticeCountBySearch(@Param("scri") SearchCriteria scri, @Param("notice") Notice notice);
	
	List<Notice> selectNoticeByAll();
	Notice selectNoticeByNo(int id);
	Notice selectSimpleNoticeByNo(int id);
	
	List<Notice> selectNoticeByAllPage(Criteria cri);
	int listCount();
	
	int insertNotice(Notice notice);
	int updateNotice(Notice notice);
	int updateNoticeFileName(Notice notice);
	int deleteNotice(Notice notice);
	
	int addHits(int id);
}
