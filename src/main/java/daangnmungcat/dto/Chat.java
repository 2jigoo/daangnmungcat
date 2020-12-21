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
public class Chat {

	int id;
	Sale sale;
	// Member saleMember 
	// Member buyMember
	LocalDateTime regdate;
	LocalDateTime latestDate;
	
}
