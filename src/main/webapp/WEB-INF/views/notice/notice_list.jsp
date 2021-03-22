<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<script>
	$(function(){
	})
</script>

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
	<h2 id="subTitle">공지사항</h2>
	<div id="pageCont" class="s-inner">
		<table class="table_style1 trLineClass" style="width: 100%">
			<!-- 글 있는 경우 -->
			<colgroup>
				<col width="100px">
				<col>
				<col width="100px">
				<col width="180px">
				<col width="100px">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<c:forEach var="notice" items="${notice }">
				<tr class="board">
					<td>
						<c:choose>
							<c:when test="${notice.noticeYn == 'y' }">
								<span class="notice_board">공지</span>
							</c:when>
							<c:otherwise>${notice.id }</c:otherwise>
						</c:choose>
					</td>
					<td><a href="<%=request.getContextPath()%>/notice/view?id=${notice.id}">${notice.title }</a></td>
						<td>${notice.writer.nickname}</td>
					<td><javatime:format value="${notice.regdate }" pattern="yyyy-MM-dd HH:mm"/></td>
					<td>${notice.hits }</td>
				</tr>
			</c:forEach>

			<!-- 글 없는 경우 -->
			<c:if test="${empty notice}">
				<td colspan="5" class="no_date">등록된 글이 없습니다.</td>
			</c:if>
		</table>
	</div>

	<div class="board_page">
		<c:if test="${pageMaker.prev}">
			<p>
				<a
					href="<%=request.getContextPath()%>/notice${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a>
			</p>
		</c:if>
		<ul>
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
				var="idx">
				<li><a
					href="<%=request.getContextPath()%>/notice${pageMaker.makeQuery(idx)}">${idx}</a></li>
			</c:forEach>
		</ul>

		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<p>
				<a
					href="<%=request.getContextPath()%>/notice${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a>
			</p>
		</c:if>
	</div>
</div>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>