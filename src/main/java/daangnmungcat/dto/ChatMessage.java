package daangnmungcat.dto;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Builder
@Getter @Setter
@ToString
@JsonInclude(Include.NON_DEFAULT)
public class ChatMessage {

	private int id;
	private Chat chat;
	private Member member;
	private String content;
	
	@JsonFormat(pattern = "yyyy-MM-dd kk:mm:ss")
	private LocalDateTime regdate;
	
	private String image;
	private String readYn;
	
}
