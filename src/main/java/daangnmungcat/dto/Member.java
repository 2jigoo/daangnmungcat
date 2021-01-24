package daangnmungcat.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

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
	

	public Member() {
	}

	public Member(String id, String pwd) {
		this.id = id;
		this.pwd = pwd;
	}
	

	public Member(String email) {
		this.email = email;
	}
	
	

	public Member(String id, String pwd, String name, String nickname, String email, String phone, Dongne1 dongne1,
			Dongne2 dongne2, String profilePic, String profileText) {
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.nickname = nickname;
		this.email = email;
		this.phone = phone;
		this.dongne1 = dongne1;
		this.dongne2 = dongne2;
		this.profilePic = profilePic;
		this.profileText = profileText;
	}

	public Member(String id, String pwd, String name, String nickname, String email, String phone, String grade,
			Dongne1 dongne1,Dongne2 dongne2, String profilePic, String profileText) {
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
	
	

	public Member(String id, String pwd, String name, String nickname, String email, String phone, String grade,
			Dongne1 dongne1, Dongne2 dongne2, String profilePic, String profileText, LocalDateTime regdate,
			LocalDate birthday, String useYn, int zipcode, String address1, String address2, int mileage) {
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
		this.regdate = regdate;
		this.birthday = birthday;
		this.useYn = useYn;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
		this.mileage = mileage;
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

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public Dongne1 getDongne1() {
		return dongne1;
	}

	public void setDongne1(Dongne1 dongne1) {
		this.dongne1 = dongne1;
	}

	public Dongne2 getDongne2() {
		return dongne2;
	}

	public void setDongne2(Dongne2 dongne2) {
		this.dongne2 = dongne2;
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

	public LocalDate getBirthday() {
		return birthday;
	}

	public void setBirthday(LocalDate birthday) {
		this.birthday = birthday;
	}

	public int getZipcode() {
		return zipcode;
	}

	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public int getMileage() {
		return mileage;
	}

	public void setMileage(int mileage) {
		this.mileage = mileage;
	}
	
	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	// 암호일치여부 확인
	public boolean matchPassword(String pwd) {
		return this.pwd.equals(pwd);
	}

	@Override
	public String toString() {
		return String.format(
				"Member [id=%s, pwd=%s, name=%s, nickname=%s, email=%s, phone=%s, grade=%s, dongne1=%s, dongne2=%s, profilePic=%s, profileText=%s, regdate=%s, birthday=%s, zipcode=%s, address1=%s, address2=%s, mileage=%s]",
				id, pwd, name, nickname, email, phone, grade, dongne1, dongne2, profilePic, profileText, regdate,
				birthday, zipcode, address1, address2, mileage);
	}

	
	

}
