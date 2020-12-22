package daangnmungcat.dto;

import java.time.LocalDateTime;

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
public class ChatMessage {

	private int id;
	private Chat chatId;
	private Member member;
	private String content;
	private LocalDateTime regdate;
	private String image;
	private String readYn;
	/*
	public ChatMessage() {
	}
	
	public ChatMessage(int id) {
		this.id = id;
	}
	
	public ChatMessage(Chat chatId, Member member, String content, String image) {
		this.chatId = chatId;
		this.member = member;
		this.content = content;
		this.image = image;
	}
	
	public ChatMessage(int id, Chat chatId, Member member, String content, LocalDateTime regdate, String image,
			String readYn) {
		this.id = id;
		this.chatId = chatId;
		this.member = member;
		this.content = content;
		this.regdate = regdate;
		this.image = image;
		this.readYn = readYn;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Chat getChatId() {
		return chatId;
	}
	public void setChatId(Chat chatId) {
		this.chatId = chatId;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public LocalDateTime getRegdate() {
		return regdate;
	}
	public void setRegdate(LocalDateTime regdate) {
		this.regdate = regdate;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getReadYn() {
		return readYn;
	}
	public void setReadYn(String readYn) {
		this.readYn = readYn;
	}
	
	@Override
	public String toString() {
		return "ChatMessage [id=" + id + ", chatId=" + chatId + ", member=" + member + ", content=" + content
				+ ", regdate=" + regdate + ", image=" + image + ", readYn=" + readYn + "]";
	}
	*/
}
