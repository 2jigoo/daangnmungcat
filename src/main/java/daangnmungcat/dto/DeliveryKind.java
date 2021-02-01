package daangnmungcat.dto;

import static java.util.stream.Collectors.toMap;

import java.util.Map;
import java.util.Objects;
import java.util.stream.Stream;

import org.apache.ibatis.type.MappedTypes;

import daangnmungcat.typehandler.CodeEnum;
import daangnmungcat.typehandler.CodeEnumTypeHandler;
import lombok.Getter;
import lombok.extern.log4j.Log4j2;

@Log4j2
public enum DeliveryKind implements CodeEnum {
	
	CONDITIONAL(1, "조건부 무료배송", 3000, 30000),
	FREE(2, "무료배송", 0, 0),
	CHARGED(3, "유료배송", 0, 0);
	
	private int code;
	@Getter private String label;
	@Getter private int price;
	@Getter private int condition;

	private DeliveryKind(int code, String label, int fee, int condition) {
		this.code = code;
		this.label = label;
		this.price = fee;
		this.condition = condition;
	}
	
	private static final Map<Integer, DeliveryKind> intToEnum =
			Stream.of(values()).collect(toMap(DeliveryKind::getCode, e -> e));
	
	public static DeliveryKind fromString(int symbol) {
		DeliveryKind deliveryType = intToEnum.get(symbol);
		if(Objects.isNull(deliveryType)) {
			log.error("잘못된 배송유형입니다. ", symbol);
			throw new IllegalStateException("잘못된 판매상태 타입입니다.");
		}
		return deliveryType;
	}
	
	@Override
	public int getCode() {
		return code;
	}

	@MappedTypes(DeliveryKind.class)
	public static class TypeHandler extends CodeEnumTypeHandler<DeliveryKind> {
		public TypeHandler() {
			super(DeliveryKind.class);
		}
	}
	
}
