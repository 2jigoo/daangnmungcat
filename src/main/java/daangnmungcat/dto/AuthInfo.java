package daangnmungcat.dto;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AuthInfo implements UserDetails {
	private String id;
	private String password;
	private String nickname;
	private Dongne1 dongne1;
	private Dongne2 dongne2;
	private String profilePic;
	private Grade grade;
	
    private boolean isEnabled;
    private boolean isAccountNonExpired;
    private boolean isAccountNonLocked;
    private boolean isCredentialsNonExpired;
    private Collection<? extends GrantedAuthority> authorities;

	public AuthInfo(String id, String password, String nickname, Dongne1 dongne1, Dongne2 dongne2, String profilePic, Grade grade) {
		this.id = id;
		this.password = password;
		this.nickname = nickname;
		this.dongne1 = dongne1;
		this.dongne2 = dongne2;
		dongne2.setDongne1(dongne1);
		this.profilePic = profilePic;
		this.grade = grade;
	}

	@Override
	public String getUsername() {
		return id;
	}
	
}
