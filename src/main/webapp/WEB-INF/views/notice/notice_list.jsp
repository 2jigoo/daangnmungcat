<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<script>
$(function(){
})
</script>

<div id="subContent">
	<h2 id="subTitle">공지사항</h2>
	<div id="pageCont" class="s-inner">
		<table class="table_style1" border="1">
			<!-- 글 있는 경우 -->
			<colgroup>
				<col width="10%">
				<col width="40%">
				<col width="10%">
			</colgroup>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>
			<c:forEach var="notice" items="${notice }">
				<tr class="board">
					<td>
						<c:choose>
							<c:when test="${notice.noticeYn == 'y' }">
								<span class="notice_board">공지(${notice.id})</span>
							</c:when>
							<c:otherwise>${notice.id }</c:otherwise>
						</c:choose>
					</td>
					<td><a href="<%=request.getContextPath()%>/notice/view?id=${notice.id}">${notice.title }</a></td>
					<td>${notice.regdate}</td>
				</tr>
			</c:forEach>

			<!-- 글 없는 경우 -->
			<c:if test="${empty notice}">
				<td colspan="3" class="no_date">등록된 글이 없습니다.</td>
			</c:if>
		</table>
	</div>

	<div class="board_page">
		<c:if test="${pageMaker.prev}">
			<p>
				<a
					href="<%=request.getContextPath()%>/notice/${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a>
			</p>
		</c:if>
		<ul>
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="idx">
				<li><a
					href="<%=request.getContextPath()%>/notice/${pageMaker.makeQuery(idx)}">${idx}</a></li>
			</c:forEach>
		</ul>

		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<p>
				<a
					href="<%=request.getContextPath()%>/notice/${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a>
			</p>
		</c:if>
	</div>
</div>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>