<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
</script>

<style>

	#pageCont {padding:40px 0; margin:0 auto;}
	
	.board_view {
		border-top: 1px solid #e9ecef;
		border-bottom: 1px solid #e9ecef;
	}
	
	#notice_section_title {
		border-bottom: 1px solid #e9ecef;
		padding: 20px 20px;
	}
	
	#notice_section_contents {
		padding: 40px 20px;
	}
	
	.notice_board {
		color:#ff7e15;
		margin-right: 10px;
	}
	
	.title {
		font-size: 2em;
	 	font-weight: 500;
	 	margin-bottom: 10px;
	}
	
	.txt_item {
		margin-left: 0;
 		margin-right: 10px;
 		color: darkgray;
	}
	
	.writer {
		color: inherit;
	}
	
	#notice_section_contents img {
		width: 100%;
		padding-bottom: 40px;
	}
	
	.prev_next_link {border-bottom: 1px solid #e9ecef; padding: 10px 20px;}
	.prev_next_link div {display: inline-block;}
	.prev_next_link .link_label {text-align: center; margin-right: 20px; color: #ff7e15; font-weight: 500;}
	.prev_next_link .link_info {float: right;}
	.list_btn {float:right;width: 80px;text-align: center;padding: 8px 0px;margin-top: 10px;border: 1px solid #e9ecef;}
</style>
<div id="subContent">
	<h2 id="subTitle">공지사항</h2>
	<div id="pageCont" class="s-inner">
		<div class="board_view">
			<section id="notice_section_title">
			<div class="title">
				<c:choose>
					<c:when test="${notice.noticeYn == 'y' }">
						<span class="notice_board">[공지]</span>
					</c:when>
					<c:when test="${notice.noticeYn == 'n' }"></c:when>
				</c:choose>
				${notice.title }
			</div>
			<div>
				<span class="txt_item writer">${notice.writer.nickname }</span>
				<span class="txt_item">조회 ${notice.hits }</span>
				<span class="txt_item"><javatime:format value="${notice.regdate }" pattern="yyyy-MM-dd HH:mm"/></span>	
			</div>
			
			</section>
			<section id="notice_section_contents">
				<c:if test="${not empty notice.noticeFile}">
						<img src="<%=request.getContextPath() %>/resources/upload/notice/${notice.id}/${notice.noticeFile}">
				</c:if>
				<p>${notice.contents }</p>
			</section>	
		</div>
		
		<c:if test="${prev ne null}">
			<div class="prev_next_link">
				<div class="link_label">이전</div>
				<div class="link_title"><a href="/notice/view?id=${prev.id }">
					<c:if test="${prev.noticeYn eq 'y' }"><span class="notice_board">[공지]</span></c:if>${prev.title }</a></div>
				<div class="link_info">
					<span class="txt_item">${prev.writer.nickname }</span>
					<span class="txt_item"><javatime:format value="${prev.regdate }" pattern="yyyy-MM-dd HH:mm"/></span>
					<span class="txt_item">${prev.hits }</span>
				</div>
			</div>
		</c:if>
		<c:if test="${next ne null}">
			<div class="prev_next_link">
				<div class="link_label">다음</div>
				<div class="link_title"><a href="/notice/view?id=${next.id }">
					<c:if test="${next.noticeYn eq 'y' }"><span class="notice_board">[공지]</span></c:if>${next.title }</a></div>
				<div class="link_info">
					<span class="txt_item">${next.writer.nickname }</span>
					<span class="txt_item"><javatime:format value="${next.regdate }" pattern="yyyy-MM-dd HH:mm"/></span>
					<span class="txt_item">${next.hits }</span>
				</div>
			</div>
		</c:if>
		<a href="/notice">
			<div class="list_btn">
				목록
			</div>
		</a>
	</div>	
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>