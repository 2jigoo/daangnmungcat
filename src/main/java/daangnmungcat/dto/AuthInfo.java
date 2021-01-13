package daangnmungcat.dto;

public class AuthInfo {
	private String id;
	private String name;
	private String email;
	
	public AuthInfo(String string) {
		this.id = string;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "AuthInfo [id=" + id + ", name=" + name + ", email=" + email + "]";
	}
	
	
	
}
