package daangnmungcat.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString
@JsonInclude(Include.NON_DEFAULT)
public class Member {

	private String id;
	private String pwd;
	private String name;
	private String nickname;
	private String email;
	private String phone;
	private String grade;
	private Dongne1 dongne1;
	private Dongne2 dongne2;
	private String profilePic;
	private String profileText;
	@JsonFormat(pattern = "yyyy-MM-dd kk:mm:ss")
	private LocalDateTime regdate;
	private LocalDate birthday;
	private String useYn;
	
	//통합시
	private int zipcode; 
	private String address1;
	private String address2;
	private int mileage;


	public Member(String id) {
		this.id = id;
	}

	public Member(String id, String nickname, String grade, Dongne1 dongne1, Dongne2 dongne2, String profilePic) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.grade = grade;
		this.dongne1 = dongne1;
		this.dongne2 = dongne2;
		this.profilePic = profilePic;
	}

	// 암호일치여부 확인
	public boolean matchPassword(String pwd) {
		return this.pwd.equals(pwd);
	}

	

}
