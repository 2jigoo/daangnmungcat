package daangnmungcat.dto;

import static java.util.stream.Collectors.toMap;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
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
	
	CONDITIONAL("조건부 무료배송", 3000, 30000) {
		@Override
		public int getFee() {
			return 0;
		}
	},
	FREE("무료배송", 0, 0) {
		@Override
		public int getFee() {
			return 0;
		}
	},
	CHARGED("유료배송", 0, 0) {
		@Override
		public int getFee() {
			return 0;
		}
	};
	
	private String code;
	private String label;
	@Getter private int price;
	@Getter private int condition;

	private DeliveryKind(String label, int price, int condition) {
		this.label = label;
		this.price = price;
		this.condition = condition;
	}
	
	@Override
	public String getLabel() {
		return label;
	}

	@Override
	public String getCode() {
		return name();
	}
	
	private static final Map<String, DeliveryKind> intToEnum =
			Stream.of(values()).collect(toMap(DeliveryKind::getLabel, e -> e));
	
	public static final List<DeliveryKind> saleStateList = new ArrayList<>(Arrays.asList(values()));
	
	public static DeliveryKind fromString(String symbol) {
		DeliveryKind deliveryType = intToEnum.get(symbol);
		if(Objects.isNull(deliveryType)) {
			log.error("잘못된 배송유형입니다. ", symbol);
			throw new IllegalStateException("잘못된 배송유형입니다.");
		}
		return deliveryType;
	}
	
	@MappedTypes(DeliveryKind.class)
	public static class TypeHandler extends CodeEnumTypeHandler<DeliveryKind> {
		public TypeHandler() {
			super(DeliveryKind.class);
		}
	}
	
	public abstract int getFee();
	
}
