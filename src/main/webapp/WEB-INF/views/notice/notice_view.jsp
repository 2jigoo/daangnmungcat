<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<div id="subContent">
	<h2 id="subTitle">중고</h2>
	<div id="pageCont" class="s-inner">
		<div class="notice_content">
			<div class="board_view">
				<c:choose>
					<c:when test="${notice.noticeYn == 'y' }">
						<span class="notice_board">공지</span>
					</c:when>
					<c:when test="${notice.noticeYn == 'n' }"></c:when>
				</c:choose>
				<p class="tit">${notice.title }</p>
				<p class="date">${notice.regdate }</p>
				<p>${notice.contents }</p>
				<c:if test="${not empty notice.noticeFile }">
				<p><img src="<%=request.getContextPath() %>/resources/${notice.noticeFile}">
				</p></c:if>
			</div>
		</div>
	</div>
</div>


<jsp:include page="/resources/include/footer.jsp" />