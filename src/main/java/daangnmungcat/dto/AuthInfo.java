package daangnmungcat.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AuthInfo {
	private String id;
	private String nickname;
	private String profilePic;
	
	public AuthInfo(String string, String nickname, String profilePic) {
		this.id = string;
	}
	
}
