package daangnmungcat.dto;

import lombok.Getter;

@Getter
public enum SaleState {

	ON_SALE(1), RESERVED(2), SOLD_OUT(3);
	
	private SaleState(int num) {
		this.num = num;
	}

	int num;
	
}