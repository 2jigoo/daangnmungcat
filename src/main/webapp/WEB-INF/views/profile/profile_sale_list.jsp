<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
$(function(){
	$(document).ready(function(){
		setFilteringPaging();
	});
	
	$(".review_delete").click(function(){
		if (confirm("정말 삭제하시겠습니까?") == false) return;
		
		var deleteReview = {id : $(this).data("id")};
		
		$.ajax({
	         type: "post",
	         url : "/joongo/review/delete",
	         contentType : "application/json; charset=utf-8",
	         cache : false,
	         dataType : "json",
	         data : JSON.stringify(deleteReview),
	         beforeSend : function(xhr){
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	         },
	         success:function(){
	            alert("리뷰가 삭제됐습니다.");
	            location.reload();
	         },
	         error: function(request,status,error){
	            alert('에러' + request.status+request.responseText+error);
			}
		})
	});
	
	$("select[name=state]").change(function() {
		var saleForm = document.saleForm;
		saleForm.target = pathname;
		saleForm.submit();
	});
	
})
	
	function setFilteringPaging() {
		var thisUrl = new URL(window.location.href);
		pathname = thisUrl.pathname;
		
		var state = thisUrl.searchParams.get("state");
		$("select[name=state]").val(state);
	}
</script>

<div id="subContent">
	<div id="pageCont" class="s-inner">
		<div class="member_info">
			<div class="img_box">
				<c:if test="${empty member.profilePic}">
					<img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
				</c:if>
				<c:if test="${not empty member.profilePic}">
					<img src="/resources/${member.profilePic}">
				</c:if>
			</div>
			<div class="txt_box">
				<p class="name">${member.nickname } <span>${member.dongne1.name } ${member.dongne2.name } ${member.grade.name }</span></p>
				<p class="bio">
					<c:choose>
						<c:when test="${not empty member.profileText }">
							${member.profileText }
						</c:when>
						<c:otherwise>
							<span class="none">인삿말이 없습니다</span>
						</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
		<div class="profile_menu">
			<a href="/profile/${member.id }/sale"><div class="menu selected">판매상품</div></a><a href="/profile/${member.id }/review"><div class="menu">받은 거래후기</div></a>
			<span class="back_btn">뒤로가기</span>
		</div>
		<div class="profile_section">
			<form name="saleForm" method="get">
				<select name="state">
					<option value="" selected>전체</option>
					<option value="ON_SALE">거래중</option>
					<option value="SOLD_OUT">거래완료</option>
				</select>
			</form>
			<div class="title">판매상품</div>
			<ul class="product_list">
				<c:forEach items="${saleList}" var="sale">
				<c:choose>
					<c:when test="${sale.saleState.code eq 'SOLD_OUT'}">
						<li class="SOLD_OUT">
					</c:when>
					<c:otherwise>
						<li>
					</c:otherwise>
				</c:choose>
				<a href="<%=request.getContextPath()%>/joongoSale/detailList?id=${sale.id}">
					<div class="img">
						<c:if test="${empty sale.thumImg}">
							<img src="<%=request.getContextPath()%>/resources/images/no_image.jpg">
						</c:if>
						<c:if test="${not empty sale.thumImg}">
							<img src="<%=request.getContextPath() %>/resources/${sale.thumImg}">
						</c:if>
					</div>
					<div class="txt">
						<p class="location">${sale.dongne1.name} ${sale.dongne2.name}</p>
						<p class="subject">${sale.title}</p>
						<p class="price">
							<span class="${sale.saleState.code }">${sale.saleState.label}</span>
							<span>
								<c:if test="${sale.price eq 0 }" >무료 나눔</c:if>
								<c:if test="${sale.price ne 0 }"> ${sale.price }원</c:if>
							</span>
						</p>
						<ul>
							<li class="heart">${sale.heartCount}</li>
							<li class="chat">${sale.chatCount}</li>
						</ul>
					</div>
				</a></li>
				</c:forEach>
				<c:if test="${empty saleList}">
					<li class="no_date">등록된 글이 없습니다.</li>
				</c:if>
			</ul>
		</div>
	</div>
</div>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>