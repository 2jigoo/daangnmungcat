package daangnmungcat.dto;

import java.util.List;

public class Dongne1 {
	private int id;
	private String name;

	public Dongne1() {
	}

	public Dongne1(int id) {
		this.id = id;
	}

	public Dongne1(int dong1Id, String dong1Name) {
		super();
		this.id = dong1Id;
		this.name = dong1Name;
	}

	public int getDong1Id() {
		return id;
	}

	public void setDong1Id(int dong1Id) {
		this.id = dong1Id;
	}

	public String getDong1Name() {
		return name;
	}

	public void setDong1Name(String dong1Name) {
		this.name = dong1Name;
	}


	@Override
	public String toString() {
		return String.format("Dongne1 [dong1Id=%s, dong1Name=%s]", id, name);
	}

}
