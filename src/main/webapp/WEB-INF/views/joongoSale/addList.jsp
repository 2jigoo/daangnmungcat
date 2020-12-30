<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ include file="/resources/include/header.jsp" %>

<style>
</style>
<script type="text/javascript">

</script>
<article>
<div>
<table border="1">
	<colgroup>
		<col width="20%">
		<col width="80%">
	</colgroup>

	<tr>
		<td>동네</td>
		<td><input type="text"></td>
	</tr>
	<tr>
		<td>사진</td>
		<td><input type="image"></td>
	</tr>
	<tr>
		<td>상품명</td>
		<td><input type="text"></td>
	</tr>
	<tr>
		<td>가격</td>
		<td><input type="text"></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><input type="text"></td>
	</tr>
	<tr>
		<td></td>
		<td>
			<select>
				<option>판매상태</option>
				<option>판매중</option>		
			</select>
			<input type="radio" name="dogCate" value="y">
			<input type="radio" name="catCate" value="y">
		</td>
	</tr>
	<tr>	
		<td colspan="2">
			<button>
				버튼
			</button>
		</td>
	</tr>
</table>
</div>
</article>
<jsp:include page="/resources/include/footer.jsp"/>