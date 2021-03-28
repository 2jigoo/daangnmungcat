<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
#pageCont {padding: 40px 0; margin:0 auto;}
	
	.trLineClass {width: 100%; border-collapse: collapse; border-top: 1px solid #e9ecef;}
	.trLineClass tr {border-bottom: 1px solid #e9ecef;}
	.trLineClass td:nth-child(2) {
 	   text-align: left;
	}
	.trLineClass td {text-align: center;}
	.trLineClass td, .trLineClass th {
		padding: 12px 6px;
	}
	.trLineClass thead th { font-weight: bolder;}
	.notice_board {
		color:#ff7e15;
	} 
</style>
<div id="subContent">
	<h2 id="subTitle">${loginUser.nickname}님의 마일리지 내역</h2>
	<div id="subContent">
	<div id="pageCont" class="s-inner">
		<table class="table_style1 trLineClass" style="width: 100%">
			<!-- 글 있는 경우 -->
			<colgroup>
				<col width="10%">
				<col width="40%">
				<col width="20%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>주문 번호</th>
					<th>적립/사용 내용</th>
					<th>적립/사용 금액</th>
					<th>적립/사용 일자</th>
				</tr>
			</thead>
			<c:forEach var="list" items="${list }">
				<tr class="board">
					<td>${list.order.id }</td>
					<td>${list.content }</td>
					<td><fmt:formatNumber value="${list.mileage}"></fmt:formatNumber> 원</td>
					<td><javatime:format value="${list.regDate }" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
			</c:forEach>

			<!-- 글 없는 경우 -->
			<c:if test="${empty list}">
				<td colspan="5" class="no_date">등록된 글이 없습니다.</td>
			</c:if>
		</table>
	</div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>