package daangnmungcat.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AuthInfo {
	private String id;
	private String grade;
	private String nickname;
	private Dongne1 dongne1;
	private Dongne2 dongne2;
	private String profilePic;


	public AuthInfo(String id, String nickname, Dongne1 dongne1, Dongne2 dongne2, String profilePic, String grade) {
		this.id = id;
		this.nickname = nickname;
		this.dongne1 = dongne1;
		this.dongne2 = dongne2;
		dongne2.setDongne1(dongne1);
		this.profilePic = profilePic;
		this.grade = grade;
	}
	
}
