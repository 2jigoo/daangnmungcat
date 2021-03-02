package daangnmungcat.dto;

import static java.util.stream.Collectors.toMap;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Stream;

import org.apache.ibatis.type.MappedTypes;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import daangnmungcat.typehandler.CodeEnum;
import daangnmungcat.typehandler.CodeEnumTypeHandler;
import lombok.extern.log4j.Log4j2;

@Log4j2
public enum OrderState implements CodeEnum{
	
	DEPOSIT_REQUEST("대기"), PAID("결제"), 
	SHIPPING("배송"), DELIVERED("완료"),
	CANCEL("취소"), RETURN("반품"), SOLD_OUT("품절"),
	REFUNDED("환불"), PURCHASE_COMPLETED("구매확정");

	private String code;
	private String label;
	
	private OrderState(String label) {
		this.label = label;
	}
	
	@Override
	public String getCode() {
		return name();
	}
	
	@Override
	public String getLabel() {
		return label;
	}
	
	private static final Map<String, OrderState> StringToEnum =
			Stream.of(values()).collect(toMap(OrderState::getCode, e -> e));
	
	public static final List<OrderState> orderStateList = new ArrayList<>(Arrays.asList(values()));
	
	@JsonCreator
	public static OrderState fromString(@JsonProperty("code") String symbol) {
		OrderState state = StringToEnum.get(symbol);
		if(Objects.isNull(state)) {
			log.error("잘못된 판매상태 타입입니다. ", symbol);
			throw new IllegalStateException("잘못된 주문상태 타입입니다.");
		}
		return state;
	}
	
	
	@MappedTypes(OrderState.class)
	public static class TypeHandler extends CodeEnumTypeHandler<OrderState> {
		public TypeHandler() {
			super(OrderState.class);
		}
	}
	
}
