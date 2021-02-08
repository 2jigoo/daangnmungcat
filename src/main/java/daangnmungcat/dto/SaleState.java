package daangnmungcat.dto;

import static java.util.stream.Collectors.toMap;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Stream;

import org.apache.ibatis.type.MappedTypes;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonFormatTypes;

import daangnmungcat.typehandler.CodeEnum;
import daangnmungcat.typehandler.CodeEnumTypeHandler;
import lombok.Builder;
import lombok.extern.log4j.Log4j2;

@Log4j2
@JsonFormat(shape = JsonFormat.Shape.OBJECT)

public enum SaleState implements CodeEnum {

	ON_SALE("판매중"), RESERVED("예약중"), SOLD_OUT("판매 완료");
	
	private String code;
	private String label;
	
	private SaleState(String label) {
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
	
	private static final Map<String, SaleState> StringToEnum =
			Stream.of(values()).collect(toMap(SaleState::getLabel, e -> e));
	
	public static final List<SaleState> saleStateList = new ArrayList<>(Arrays.asList(values()));
	
	public static SaleState fromString(String symbol) {
		SaleState state = StringToEnum.get(symbol);
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