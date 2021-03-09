package daangnmungcat.service.impl;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import daangnmungcat.dto.Criteria;
import daangnmungcat.dto.Notice;
import daangnmungcat.dto.SearchCriteria;
import daangnmungcat.mapper.NoticeMapper;
import daangnmungcat.service.NoticeService;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NoticeServiceImpl implements NoticeService {

	private static final String UPLOAD_PATH = "resources" + File.separator + "upload" + File.separator + "notice";
	
	@Autowired
	private NoticeMapper noticeMapper;
	
	
	@Override
	public List<Notice> getList() {
		return noticeMapper.selectNoticeByAll();
	}

	@Override
	public List<Notice> getList(Criteria cri) {
		return noticeMapper.selectNoticeByAllPage(cri);
	}

	@Override
	public int count() {
		return noticeMapper.listCount();
	}

	@Override
	public List<Notice> search(SearchCriteria scri, Notice notice) {
		return noticeMapper.selectNoticeBySearch(scri, notice);
	}

	@Override
	public int getTotalBySearch(SearchCriteria scri, Notice notice) {
		return noticeMapper.selectNoticeCountBySearch(scri, notice);
	}

	@Override
	public Notice get(int id) {
		return noticeMapper.selectNoticeByNo(id);
	}

	@Override
	@Transactional
	public int registNotice(Notice notice, MultipartFile file, File realPath) {
		
		String path = UPLOAD_PATH + File.separator + notice.getId();
		
		noticeMapper.insertNotice(notice);
		
		if(file != null) {
			
			/* 업로드할 폴더 지정. 폴더가 없는 경우 생성 */
			File dir = new File(realPath, path);
			
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			// 원본 파일명 자체를 수정하고 싶을 때 사용하기
	//		String originName = file.getOriginalFilename();
	//		int idx = originName.lastIndexOf(".");
	//		String ext = originName.substring(idx);
			
			String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
			File saveFile = new File(dir, fileName); // 위에서 지정한 폴더에 fileName 이름으로 저장
			
			try {
				file.transferTo(saveFile);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		
		return notice.getId();
	}

	@Override
	public int modifyNotice(Notice notice) {
		noticeMapper.updateNotice(notice);
		return notice.getId();
	}

	@Override
	public int deleteNotice(Notice notice) {
		return noticeMapper.deleteNotice(notice);
	}

}
