package daangnmungcat.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class SaleImage {

	private int id;
	private String imageName;
	/*
	public SaleImage() {
	}
	
	public SaleImage(int id) {
		this.id = id;
	}
	
	public SaleImage(int id, String imageName) {
		this.id = id;
		this.imageName = imageName;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getImageName() {
		return imageName;
	}
	
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	
	@Override
	public String toString() {
		return "SaleImage [id=" + id + ", imageName=" + imageName + "]";
	}
	*/
}
