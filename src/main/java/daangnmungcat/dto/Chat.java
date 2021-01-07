package daangnmungcat.dto;

import java.time.LocalDateTime;
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
public class Chat {

	private int id;
	private Sale sale;
	// Member sellers
	private Member buyer;
	private LocalDateTime regdate;
	private LocalDateTime latestDate;
	
	private List<ChatMessage> messages;
	
}
