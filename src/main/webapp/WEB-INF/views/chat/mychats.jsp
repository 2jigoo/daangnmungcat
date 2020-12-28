<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="/resources/include/header.jsp"/>
<div>
	<c:forEach items="${list }" var="chat">
		<ul>
			<li>채팅번호: ${chat.id }</li>
			<li>판매글: ${chat.sale.id }</li>
			<li>판매자: ${chat.sale.member.id }</li>
			<li>구매자: ${chat.buyer.id }</li>
			<li>채팅시작일: ${chat.regdate }</li>
			<li>최근채팅일: ${chat.latestDate }</li>
		</ul>
		<br>
	</c:forEach>
</div>
<jsp:include page="/resources/include/footer.jsp"/>