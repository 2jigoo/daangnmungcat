package daangnmungcat.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import daangnmungcat.dto.kakao.KakaoPayApprovalVO;
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
public class Payment {
	private String id; 
	private Member member;
	private Order order; //id, final_price, date
	private KakaoPayApprovalVO kakao;
	private int	payPrice; //무통장
	private String payType;
	private int quantity;
	private String payState;
	private LocalDateTime payDate;
}
