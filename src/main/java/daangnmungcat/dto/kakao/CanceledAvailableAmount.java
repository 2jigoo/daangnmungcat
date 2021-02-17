package daangnmungcat.dto.kakao;

import lombok.Data;

@Data
public class CanceledAvailableAmount {
	private Integer total, tax_free, vat, point, discount;
}
