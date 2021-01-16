package daangnmungcat.dto;

import java.util.Date;
import java.util.List;

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
public class Sale {

	private int id;
	private Member member;
	private String dogCate;
	private String catCate;
	private String title;
	private String content;
	private int price;
	private Dongne1 dongne1;
	private Dongne2 dongne2;
	private Member buyMember;
//	private int saleState;
	private SaleState saleState;
	private Date regdate;	
	private Date redate;
	private int hits;
	private int chatCount;
	private String isHeart;
	private int heartCount;
	
	private String thumImg;
	private List<SaleImage> images;
	
}
