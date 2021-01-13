package daangnmungcat.dto;

public class Dongne1 {
	private int id;
	private String name;

	public Dongne1() {
	}

	public Dongne1(int id) {
		this.id = id;
	}

	public Dongne1(int id, String name) {
		this.id = id;
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return String.format("Dongne1 [id=%s, name=%s]", id, name);
	}

}
