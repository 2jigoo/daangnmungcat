package daangnmungcat.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class Dongne2 {
	private int id;
	private Dongne1 dongne1;
	private String name;

	public Dongne2() {
	}
	
	public Dongne2(int id) {
		this.id = id;
	}

	public Dongne2(int id, Dongne1 dongne1, String name) {
		this.id = id;
		this.dongne1 = dongne1;
		this.name = name;
	}
	
}
