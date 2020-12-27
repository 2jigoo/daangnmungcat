package daangnmungcat.dto;

import java.time.LocalDateTime;

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
public class ChatMessage {

	private int id;
	private Chat chat;
	private Member member;
	private String content;
	private LocalDateTime regdate;
	private String image;
	private String readYn;
	
}
