<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/resources/include/header.jsp" %>

<script>
$(function(){
	$(".mall_cate_list .delete_btn").click(function(){
		if (confirm("정말 삭제하시겠습니까??") == true){
		} else{
		    return false;
		}
	})
	
})
</script>


<div id="subContent">
	<h2 id="subTitle">쇼핑몰 카테고리 리스트</h2>
	<div id="pageCont" class="s-inner">
		<div class="mall_cate_list">
			<p class="tit">강아지</p>
			<ul>
			<c:forEach items="${dogCate}" var="list">
				<li>
					<p>${list.name}</p>
					<div>
						<a href="<%=request.getContextPath()%>/mall/cate/update?cateName=멍&id=${list.id}">수정</a>
						<a href="<%=request.getContextPath()%>/mall/cate/delete?cateName=멍&id=${list.id}" class="delete_btn">삭제</a>
					</div>
				</li>
			</c:forEach>
			</ul>
			
			<br>
			
			<p class="tit">고양이</p>
			<ul>
			<c:forEach items="${catCate}" var="list">
				<li>
					<p>${list.name}</p>
					<div>
						<a href="<%=request.getContextPath()%>/mall/cate/update?cateName=냥&id=${list.id}">수정</a>
						<a href="<%=request.getContextPath()%>/mall/cate/delete?cateName=냥&id=${list.id}" class="delete_btn">삭제</a>
					</div>
				</li>
			</c:forEach>
			</ul>
			
			<a href="<%=request.getContextPath()%>/mall/cate/write">글쓰기</a>
		</div>
	</div>
</div>

<jsp:include page="/resources/include/footer.jsp"/>