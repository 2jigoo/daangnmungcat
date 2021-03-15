package daangnmungcat.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class SearchCriteria extends Criteria {

	private String searchType;
	private String keyword;
	private String startDate;
	private String endDate;

	private Map<String, String> params;
	
	@Override
	public String toString() {
		return String.format("SearchCriteria [searchType=%s, keyword=%s, startDate=%s, endDate=%s, %s]", searchType,
				keyword, startDate, endDate, super.toString());
	}
	
}
