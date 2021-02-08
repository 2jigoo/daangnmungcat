package daangnmungcat.dto;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

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
@JsonInclude(Include.NON_DEFAULT)
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
	
	
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime regdate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime redate;
	
	private int hits;
	private int chatCount;
	private boolean hearted;
	private int heartCount;
	
	private String thumImg;
	private List<SaleImage> images;
	List<MultipartFile> files;
	
	public Sale(int id) {
		this.id = id;
	}
	
	
}
