package daangnmungcat.service.impl;

import java.io.File;
import java.io.IOException;
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
		
		noticeMapper.insertNotice(notice);
		
		String path = UPLOAD_PATH + File.separator + notice.getId();
		
		if(!file.isEmpty()) {
			
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
				notice.setNoticeFile(fileName);
				noticeMapper.updateNoticeFileName(notice);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		
		
		return notice.getId();
	}

	@Override
	@Transactional
	public int modifyNotice(Notice notice, MultipartFile file, File realPath, boolean isChanged) {
		
		// notice.noticeFile = null임
		String path = UPLOAD_PATH + File.separator + notice.getId();
		
		
		// 이미지가 변경된 경우와 삭제된 경우  (둘 다 기존 파일 삭제해야함)
		// 없었는데 추가된 경우
		if(isChanged == true) {
			try {
				Notice originNotice = get(notice.getId());
				
				File dir = new File(realPath, path);
				
				if(!dir.exists()) {
					dir.mkdirs();
				}
				
				// 이미지가 변경되거나 추가된 경우 파일 저장
				if(!file.isEmpty()) {
					String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
					File saveFile = new File(dir, fileName); // 위에서 지정한 폴더에 fileName 이름으로 저장
					file.transferTo(saveFile);
					notice.setNoticeFile(fileName);
				} 
				
				log.info("notice: " + notice.toString());
				
				noticeMapper.updateNoticeFileName(notice); // DB에 파일명 변경
				noticeMapper.updateNotice(notice);
				
				// 이미지가 삭제된 경우 디렉토리 삭제
				if(file.isEmpty()) {
					dir.delete();
				}
				
				// 기존파일 삭제
				if(originNotice.getNoticeFile() != null) {
					File deleteFile = new File(dir, originNotice.getNoticeFile());
					deleteFile.delete();
				}
				
			} catch(IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		} else {
			log.info("notice: " + notice.toString());
			noticeMapper.updateNotice(notice);
		}
		
		return notice.getId();
	}

	@Override
	@Transactional
	public int deleteNotice(Notice notice, File realPath) {
		notice = get(notice.getId());
		String imageFile = notice.getNoticeFile();
		
		int res = noticeMapper.deleteNotice(notice);
		
		if(imageFile != null) {
			String path = UPLOAD_PATH + File.separator + notice.getId();
			
			File dir = new File(realPath, path);
			File deleteFile = new File(dir, imageFile);
			
			deleteFile.delete();
			dir.delete();
		}
		
		return res;
	}

	
	@Override
	public int modifyNoticeFileName(Notice notice) {
		return noticeMapper.updateNoticeFileName(notice);
	}
}
