package daangnmungcat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Notice;

public interface NoticeMapper {

	List<Notice> selectNoticeByAll();

	Notice selectNoticeByNo(int id);

	int listCount();

	List<Notice> selectNoticeByAllPage(Criteria cri);

	List<Notice> selectNoticeBySearch(@Param("notice") Notice notice, @Param("cri") Criteria cri);

	int insertNotice(Notice notice);
}
