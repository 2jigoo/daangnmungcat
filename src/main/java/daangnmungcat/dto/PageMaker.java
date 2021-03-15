package daangnmungcat.dto;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	private int totalCount;
	private int lastPage;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10; // 페이지 수 (Ex. 10 -> 1 ~ 10, 20 -> 1 ~ 20
	private Criteria cri;

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getLastPage() {
		return lastPage;
	}
	
	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}

	private void calcData() {
		lastPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;

		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}

	public String makeQuery(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum()).build();

		return uriComponents.toUriString();
	}
	
	public String makeSearch(int page) {
		SearchCriteria scri = (SearchCriteria) cri;
		UriComponentsBuilder builder = 
			UriComponentsBuilder.newInstance()
			.queryParam("searchType", scri.getSearchType())
			.queryParam("keyword", scri.getKeyword())
			.queryParam("startDate", scri.getStartDate())
			.queryParam("endDate", scri.getEndDate())
			.queryParam("page", page)
			.queryParam("perPageNum", scri.getPerPageNum());
		
		if(scri.getParams() != null) {
			for( String key : scri.getParams().keySet() ){
	            builder.queryParam(key, scri.getParams().get(key));
	        }
		}

		return builder.build().toString();
	}
	
	public String makeSearchForMyPage(int page){
		 SearchCriteriaForOrder scri = (SearchCriteriaForOrder) cri;
		 
		 UriComponents uriComponents = 
            UriComponentsBuilder.newInstance()
            .queryParam("page", page)
            .queryParam("perPageNum", scri.getPerPageNum())
            .queryParam("start", encoding(scri.getStart()))
            .queryParam("end", encoding(scri.getEnd())).build();
		 
		return uriComponents.toUriString();
	}
	
	private String encoding(String keyword) {
		if(keyword == null || keyword.trim().length() == 0) { 
			return "";
		}
		 
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch(UnsupportedEncodingException e) { 
			return ""; 
		}
	}
}
