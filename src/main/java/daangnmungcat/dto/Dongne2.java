package daangnmungcat.dto;

public class Dongne2 {
	private int id;
	private int dongne1Id;
	private String name;

	public Dongne2() {
	}

	public Dongne2(int dong2Id, int dong1Id, String dong2Name) {
		super();
		this.id = dong2Id;
		this.dongne1Id = dong1Id;
		this.name = dong2Name;
	}

	public int getDong2Id() {
		return id;
	}

	public void setDong2Id(int dong2Id) {
		this.id = dong2Id;
	}

	
	public int getDong1Id() {
		return dongne1Id;
	}

	public void setDong1Id(int dong1Id) {
		this.dongne1Id = dong1Id;
	}

	public String getDong2Name() {
		return name;
	}

	public void setDong2Name(String dong2Name) {
		this.name = dong2Name;
	}

	@Override
	public String toString() {
		return String.format("Dongne2 [dong2Id=%s, dong2Name=%s]", id, name);
	}

}
