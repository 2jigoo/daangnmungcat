package daangnmungcat.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString
public class Chat {

	private int id;
	private Sale sale;
	// Member sellers
	private Member buyer;
	private LocalDateTime regdate;
	private LocalDateTime latestDate;
	/*
	public Chat() {
	}
	
	public Chat(int id) {
		this.id = id;
	}
	
	public Chat(Sale sale, Member buyer) {
		this.sale = sale;
		this.buyer = buyer;
	}
	
	public Chat(int id, Sale sale, Member buyer, LocalDateTime regdate, LocalDateTime latestDate) {
		this.id = id;
		this.sale = sale;
		this.buyer = buyer;
		this.regdate = regdate;
		this.latestDate = latestDate;
	}
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Sale getSale() {
		return sale;
	}
	public void setSale(Sale sale) {
		this.sale = sale;
	}
	public Member getBuyer() {
		return buyer;
	}
	public void setBuyer(Member buyer) {
		this.buyer = buyer;
	}
	public LocalDateTime getRegdate() {
		return regdate;
	}
	public void setRegdate(LocalDateTime regdate) {
		this.regdate = regdate;
	}
	public LocalDateTime getLatestDate() {
		return latestDate;
	}
	public void setLatestDate(LocalDateTime latestDate) {
		this.latestDate = latestDate;
	}
	*/
	
}
