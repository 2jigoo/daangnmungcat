package daangnmungcat.dto;

import static java.util.stream.Collectors.toMap;

import java.util.Map;
import java.util.Objects;
import java.util.stream.Stream;

import org.apache.ibatis.type.MappedTypes;

import daangnmungcat.typehandler.CodeEnum;
import daangnmungcat.typehandler.CodeEnumTypeHandler;
import lombok.extern.log4j.Log4j2;

@Log4j2
public enum SaleState implements CodeEnum {

	ON_SALE(1, "판매중"), RESERVED(2, "예약중"), SOLD_OUT(3, "판매 완료");
	
	private static final Map<Integer, SaleState> intToEnum =
			Stream.of(values()).collect(toMap(SaleState::getCode, e -> e));
	
	private SaleState(int code, String label) {
		this.code = code;
		this.label = label;
	}

	private int code;
	private String label;
	
	@Override
	public int getCode() {
		return code;
	}
	
	public static SaleState fromString(int symbol) {
		SaleState state = intToEnum.get(symbol);
		if(Objects.isNull(state)) {
			log.error("잘못된 판매상태 타입입니다. ", symbol);
			throw new IllegalStateException("잘못된 판매상태 타입입니다.");
		}
		return state;
	}
	
	
	@MappedTypes(SaleState.class)
	public static class TypeHandler extends CodeEnumTypeHandler<SaleState> {
		public TypeHandler() {
			super(SaleState.class);
		}
	}
	
}