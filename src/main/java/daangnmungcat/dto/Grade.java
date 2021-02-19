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
public class Grade {

	private String code;
	private String name;
	
	public Grade(String code) {
		this.code = code;
	}
	
}
