package daangnmungcat.dto;

import java.time.LocalDateTime;

public class Member {

	private String id;
	private String pwd;
	private String name;
	private String nickname;
	private String email;
	private String phone;
	// 동네
	// 등급
	private String profilePic;
	private String profileText;
	private LocalDateTime regdate;
	
	
	/*
	private boolean identifyYn; // 본인인증 여부
	private LocalDate birthday;
	private int zipcode;
	private String address1;
	private String address2;
	priavate int mileage;
	*/
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getPwd() {
		return pwd;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getNickname() {
		return nickname;
	}


	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getProfilePic() {
		return profilePic;
	}


	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}


	public String getProfileText() {
		return profileText;
	}


	public void setProfileText(String profileText) {
		this.profileText = profileText;
	}


	public LocalDateTime getRegdate() {
		return regdate;
	}


	public void setRegdate(LocalDateTime regdate) {
		this.regdate = regdate;
	}


	@Override
	public String toString() {
		return String.format(
				"Member [id=%s, pwd=%s, name=%s, nickname=%s, email=%s, phone=%s, profilePic=%s, profileText=%s, regdate=%s]",
				id, pwd, name, nickname, email, phone, profilePic, profileText, regdate);
	}
	
	
	
	
}
