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
	
	CONDITIONAL("조건부 무료배송", 3000, 30000),
	FREE("무료배송", 0, 0),
	CHARGED("유료배송", 0, 0);
	
	private String code;
	private String label;
	@Getter private int price;
	@Getter private int condition;

	private DeliveryKind(String label, int fee, int condition) {
		this.label = label;
		this.price = fee;
		this.condition = condition;
	}
	
	private static final Map<String, DeliveryKind> intToEnum =
			Stream.of(values()).collect(toMap(DeliveryKind::getLabel, e -> e));
	
	public static DeliveryKind fromString(String symbol) {
		DeliveryKind deliveryType = intToEnum.get(symbol);
		if(Objects.isNull(deliveryType)) {
			log.error("잘못된 배송유형입니다. ", symbol);
			throw new IllegalStateException("잘못된 판매상태 타입입니다.");
		}
		return deliveryType;
	}
	
	@Override
	public String getLabel() {
		return label;
	}

	@Override
	public String getCode() {
		return name();
	}

	@MappedTypes(DeliveryKind.class)
	public static class TypeHandler extends CodeEnumTypeHandler<DeliveryKind> {
		public TypeHandler() {
			super(DeliveryKind.class);
		}
	}
	
}
