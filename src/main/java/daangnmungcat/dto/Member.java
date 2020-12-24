package daangnmungcat.dto;

import java.time.LocalDateTime;

public class Member {

	private String id;
	private String pwd;
	private String name;
	private String nickname;
	private String email;
	private String phone;
	private String grade;
	// 동네
	private int dongne1;
	private int dongne2;
	// 등급
	private String profilePic;
	private String profileText;
	private LocalDateTime regdate;

	/*
	 * private boolean identifyYn; 
	 * // 본인인증 여부 private LocalDate birthday;
	 *  private int zipcode; 
	 *  priavate int mileage;
	 */

	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(String id, String pwd) {
		super();
		this.id = id;
		this.pwd = pwd;
	}
	
	

	

	public Member(String id, String pwd, String name, String nickname, String email, String phone, String grade,
			int dongne1, int dongne2, String profilePic, String profileText) {
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.nickname = nickname;
		this.email = email;
		this.phone = phone;
		this.grade = grade;
		this.dongne1 = dongne1;
		this.dongne2 = dongne2;
		this.profilePic = profilePic;
		this.profileText = profileText;
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
	

	public int getDongne1() {
		return dongne1;
	}

	public void setDongne1(int dongne1) {
		this.dongne1 = dongne1;
	}

	public int getDongne2() {
		return dongne2;
	}

	public void setDongne2(int dongne2) {
		this.dongne2 = dongne2;
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

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
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

	// 암호일치여부 확인
	public boolean matchPassword(String pwd) {
		return this.pwd.equals(pwd);
	}

	@Override
	public String toString() {
		return String.format(
				"Member [id=%s, pwd=%s, name=%s, nickname=%s, email=%s, phone=%s, grade=%s, dongne1=%s, dongne2=%s, profilePic=%s, profileText=%s, regdate=%s]",
				id, pwd, name, nickname, email, phone, grade, dongne1, dongne2, profilePic, profileText, regdate);
	}


	

}
