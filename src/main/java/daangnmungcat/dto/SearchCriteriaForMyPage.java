package daangnmungcat.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class SearchCriteriaForMyPage extends Criteria {

	private String start;
	private String end;
	 
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	@Override
	public String toString() {
		return "SearchCriteriaForMyPage [start=" + start + ", end=" + end + "]";
	}

}
