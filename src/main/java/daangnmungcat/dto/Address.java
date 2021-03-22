package daangnmungcat.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString
public class Address {
	private int id;
	private String memId;
	private String subject; 
	private String name; 
	private String phone1; 
	private String phone2; 
	private int zipcode; 
	private String address1; 
	private String address2; 
	private String memo;	
}
