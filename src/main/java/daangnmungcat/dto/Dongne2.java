package daangnmungcat.dto;

public class Dongne2 {
	private int id;
	private int dongne1Id;
	private String name;

	public Dongne2() {
	}
	
	public Dongne2(int id) {
		this.id = id;
	}

	public Dongne2(int id, int dongne1Id, String name) {
		super();
		this.id = id;
		this.dongne1Id = dongne1Id;
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getDongne1Id() {
		return dongne1Id;
	}

	public void setDongne1Id(int dongne1Id) {
		this.dongne1Id = dongne1Id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return String.format("Dongne2 [id=%s, dongne1Id=%s, name=%s]", id, dongne1Id, name);
	}

	
}
