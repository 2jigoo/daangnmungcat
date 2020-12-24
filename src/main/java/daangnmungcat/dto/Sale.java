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

	private int id;
	private Member member;
	private String dogCate;
	private String catCate;
	private String title;
	private String content;
	private int price;
	private Dongne1 dongene1;
	private Dongne2 dongne2;
	private Member buyMember;
	private int saleState;
	private LocalDateTime regdate;
	private LocalDateTime redate;
	private int hits;
	
	private List<SaleImage> images;
	/*
		public Sale() {
		}
		
		public Sale(int id) {
			this.id = id;
		}
	
		public Sale(int id, Member member, String dogCate, String catCate, String title, String content, int price,
				Dongne1 dongene1, Dongne2 dongne2, Member buyMember, int saleState, LocalDateTime regdate,
				LocalDateTime redate, int hits, List<SaleImage> images) {
			this.id = id;
			this.member = member;
			this.dogCate = dogCate;
			this.catCate = catCate;
			this.title = title;
			this.content = content;
			this.price = price;
			this.dongene1 = dongene1;
			this.dongne2 = dongne2;
			this.buyMember = buyMember;
			this.saleState = saleState;
			this.regdate = regdate;
			this.redate = redate;
			this.hits = hits;
			this.images = images;
		}
	
	
	
		public int getId() {
			return id;
		}
	
		public void setId(int id) {
			this.id = id;
		}
	
		public Member getMember() {
			return member;
		}
	
		public void setMember(Member member) {
			this.member = member;
		}
	
		public String getDogCate() {
			return dogCate;
		}
	
		public void setDogCate(String dogCate) {
			this.dogCate = dogCate;
		}
	
		public String getCatCate() {
			return catCate;
		}
	
		public void setCatCate(String catCate) {
			this.catCate = catCate;
		}
	
		public String getTitle() {
			return title;
		}
	
		public void setTitle(String title) {
			this.title = title;
		}
	
		public String getContent() {
			return content;
		}
	
		public void setContent(String content) {
			this.content = content;
		}
	
		public int getPrice() {
			return price;
		}
	
		public void setPrice(int price) {
			this.price = price;
		}
	
		public Dongne1 getDongene1() {
			return dongene1;
		}
	
		public void setDongene1(Dongne1 dongene1) {
			this.dongene1 = dongene1;
		}
	
		public Dongne2 getDongne2() {
			return dongne2;
		}
	
		public void setDongne2(Dongne2 dongne2) {
			this.dongne2 = dongne2;
		}
	
		public Member getBuyMember() {
			return buyMember;
		}
	
		public void setBuyMember(Member buyMember) {
			this.buyMember = buyMember;
		}
	
		public int getSaleState() {
			return saleState;
		}
	
		public void setSaleState(int saleState) {
			this.saleState = saleState;
		}
	
		public LocalDateTime getRegdate() {
			return regdate;
		}
	
		public void setRegdate(LocalDateTime regdate) {
			this.regdate = regdate;
		}
	
		public LocalDateTime getRedate() {
			return redate;
		}
	
		public void setRedate(LocalDateTime redate) {
			this.redate = redate;
		}
	
		public int getHits() {
			return hits;
		}
	
		public void setHits(int hits) {
			this.hits = hits;
		}
	
		public List<SaleImage> getImages() {
			return images;
		}
	
		public void setImages(List<SaleImage> images) {
			this.images = images;
		}
	
		@Override
		public String toString() {
			return "Sale [id=" + id + ", member=" + member + ", dogCate=" + dogCate + ", catCate=" + catCate + ", title="
					+ title + ", content=" + content + ", price=" + price + ", dongene1=" + dongene1 + ", dongne2="
					+ dongne2 + ", buyMember=" + buyMember + ", saleState=" + saleState + ", regdate=" + regdate
					+ ", redate=" + redate + ", hits=" + hits + ", images=" + images + "]";
		}
		*/
	
}
