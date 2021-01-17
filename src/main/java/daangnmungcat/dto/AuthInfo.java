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
	private Dongne1 dongne1;
	private Dongne2 dongne2;
	private String profilePic;
	
	public AuthInfo(String string, String nickname, String profilePic) {
		this.id = string;
	}

	public AuthInfo(String id, String nickname, Dongne1 dongne1, Dongne2 dongne2, String profilePic) {
		this.id = id;
		this.nickname = nickname;
		this.dongne1 = dongne1;
		this.dongne2 = dongne2;
		this.profilePic = profilePic;
	}
	
}
