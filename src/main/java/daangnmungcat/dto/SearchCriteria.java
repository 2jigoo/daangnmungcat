package daangnmungcat.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class SearchCriteria extends Criteria {

	private String searchType;
	private String keyword;
	private String startDate;
	private String endDate;
	
}
