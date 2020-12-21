package daangnmungcat.dto;

import java.time.LocalDateTime;
import java.util.List;

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
public class Sale {

	int id;
	Member member;
	String dogCate;
	String catCate;
	String title;
	String content;
	int price;
	Dongne1 dongene1;
	Dongne2 dongne2;
	Member buyMember;
	int saleState;
	LocalDateTime regdate;
	LocalDateTime redate;
	int hits;
	
	List<SaleImage> images;
	
}
