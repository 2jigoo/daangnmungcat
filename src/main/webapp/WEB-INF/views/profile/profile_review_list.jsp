<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	var pathname;
	
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
		
		$("select[name=writer]").change(function() {
			var reviewForm = document.reviewForm;
			reviewForm.target = pathname;
			reviewForm.submit();
		});
		
	})
	
	function setFilteringPaging() {
		var thisUrl = new URL(window.location.href);
		pathname = thisUrl.pathname;
		
		var writer = thisUrl.searchParams.get("writer");
		$("select[name=writer]").val(writer);
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
			<a href="/profile/${member.id }/sale"><div class="menu">판매상품</div></a><a href="/profile/${member.id }/review"><div class="menu selected">받은 거래후기</div></a>
		</div>
		<div class="profile_section">
			<form name="reviewForm" method="get">
				<select name="writer">
					<option value="all" selected>전체</option>
					<option value="seller">판매자 후기</option>
					<option value="buyer">구매자 후기</option>
				</select>
			</form>
			<div class="title">
				후기 ${reviewList.size() }
			</div>
			<ul class="joongo_review_list">
				<c:choose>
					<c:when test="${empty reviewList}">
						<li class="no_board">
	               			등록된 후기가 없습니다.
	          			</li>
					</c:when>
					<c:otherwise>
						<c:forEach items="${reviewList}" var="review">
							<li>
								<div class="user">
								   <p class="img">
								      <c:if test="${empty review.writer.profilePic}">
								         <img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
								      </c:if>
								      <c:if test="${not empty review.writer.profilePic}">
								         <img src="/resources/${review.writer.profilePic}">
								      </c:if>
								   </p>
								   <p class="name">${review.writer.nickname }<span>${review.writer.dongne1.name} ${review.writer.dongne2.name}</span></p>
								</div>
								<div class="content_box">
									<div class="star_box star_box_data" data-star="${review.rating}">
										<span class="star star_left"></span>
										<span class="star star_right"></span>
										
										<span class="star star_left"></span>
										<span class="star star_right"></span>
										
										<span class="star star_left"></span>
										<span class="star star_right"></span>
										
										<span class="star star_left"></span>
										<span class="star star_right"></span>
										
										<span class="star star_left"></span>
										<span class="star star_right"></span>
									</div>
									<pre class="content">${review.content }</pre>
									<div class="info">
									   <p class="date"><javatime:format value="${review.regdate }" pattern="yyyy-MM-dd"/> </p>
									   <c:if test="${loginUser.id == review.writer.id }">
									   <ul>
									      <li><a href="/joongo/review/update?id=${review.id}">수정</a></li>
									      <li><a class="review_delete" data-id="${review.id}">삭제</a></li>
									   </ul>
									   </c:if>
									</div>
								</div>
							</li>
							</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</div>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>