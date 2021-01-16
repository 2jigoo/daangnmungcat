package daangnmungcat.dto;

import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

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
public class SaleComment {
	private int id;
	private Sale sale;
	private Member member;
	private SaleComment saleComment;
	private Member tagMember;
	private String content;
	@JsonFormat(pattern = "yyyy-MM-dd kk:mm:ss")
	private LocalDateTime regdate;
}
