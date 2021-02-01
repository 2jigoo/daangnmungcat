package daangnmungcat.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeException;
import org.apache.ibatis.type.TypeHandler;

import daangnmungcat.dto.SaleState;

public abstract class CodeEnumTypeHandler<E extends Enum<E>> implements TypeHandler<CodeEnum> {

	private Class<E> type;
	
	public CodeEnumTypeHandler(Class<E> type) {
		this.type = type;
	}
	
	@Override
	public void setParameter(PreparedStatement ps, int i, CodeEnum parameter, JdbcType jdbcType) throws SQLException {
		ps.setString(i, parameter.getLabel());
	}

	@Override
	public CodeEnum getResult(ResultSet rs, String columnName) throws SQLException {
		String label = rs.getString(columnName);
		return getCodeEnum(label);
	}

	@Override
	public CodeEnum getResult(ResultSet rs, int columnIndex) throws SQLException {
		String label = rs.getString(columnIndex);
		return getCodeEnum(label);
	}

	@Override
	public CodeEnum getResult(CallableStatement cs, int columnIndex) throws SQLException {
		String label = cs.getString(columnIndex);
		return getCodeEnum(label);
	}

	private CodeEnum getCodeEnum(String label) {
		try {
			CodeEnum[] enumConstrants = (CodeEnum[]) type.getEnumConstants();
			for(CodeEnum codeNum : enumConstrants) {
				if(codeNum.getLabel().equals(label)) {
					return codeNum;
				}
			}
			return null;
		} catch(Exception e) {
			throw new TypeException("Can't make enum object '" + type + "'", e);
		}
	}
}
