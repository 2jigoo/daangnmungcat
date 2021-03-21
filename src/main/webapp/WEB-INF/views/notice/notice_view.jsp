<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
<script type="text/javascript">
</script>

<style>

	#pageCont {padding:50px; width:80%; margin:0 auto;}
	
	.notice_board {
		color:#ff7e15;
	}
	
	#notice_section_title {
		font-size: 2em;
	} 
	.tit {
	 	display: inline;
	}
	
	.date {
		display: inline;
		float: right;
		font-size: 0.5em;
	}
	
	#notice_section_title {
		border-bottom: 1px solid #e9ecef;
		padding-bottom: 10px;
	}
	
	#notice_section_img img {
		padding : 20px;
	}
	
</style>
<div id="subContent">
	<h2 id="subTitle">공지사항 상세보기</h2>
	<div id="pageCont" class="s-inner">
		<div class="notice_content">
			<div class="board_view">
				<section id="notice_section_title">
				<c:choose>
					<c:when test="${notice.noticeYn == 'y' }">
						<span class="notice_board">공지)</span>
					</c:when>
					<c:when test="${notice.noticeYn == 'n' }"></c:when>
				</c:choose>
				<p class="tit">${notice.title }</p>
				<p class="date"><javatime:format value="${notice.regdate }" pattern="yyyy-MM-dd HH:mm"/></p>
				<p class="writer">${notice.writer.nickname }</p>
				</section>
				<section id="notice_section_img">
				<c:if test="${not empty notice.noticeFile}">
						<img src="<%=request.getContextPath() %>/resources/upload/notice/${notice.id}/${notice.noticeFile}">
				</c:if>
				</section>	
				<p>${notice.contents }</p>
			</div>
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>