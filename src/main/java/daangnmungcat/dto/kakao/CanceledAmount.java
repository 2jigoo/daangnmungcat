package daangnmungcat.dto.kakao;

import lombok.Data;

@Data
public class CanceledAmount {
	private Integer total, tax_free, vat, point, discount;
}
