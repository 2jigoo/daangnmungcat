package daangnmungcat.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
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

}
