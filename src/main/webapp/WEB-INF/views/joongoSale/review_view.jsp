<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>


<script>
$(function(){
	$(".review_delete").click(function(){
		if (confirm("정말 삭제하시겠습니까?") == true){
			var deleteReview = {
		    	id : $(this).data("id"),
		    }
			
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
		}
	})
})
</script>

<div id="subContent">
	<div id="pageCont" class="s-inner">
		<h2 id="subTitle">
			거래 후기
		</h2>
		<ul class="joongo_review_list">
			<c:choose>
				<c:when test="${empty review}">
					<li class="no_board">
               			해당 ID의 후기가 존재하지 않습니다.
          			</li>
				</c:when>
				<c:otherwise>
					<c:set var="you" value="${review.writer.id eq review.sale.member.id ? review.sale.buyMember.nickname : review.sale.member.nickname }"></c:set>
					<li>
						<a href="/joongoSale/detailList?id=${review.sale.id }">
							<p style="font-weight: 600; margin-bottom: 8px; font-size: 24px;">${you }님에게 보낸 거래 후기</p>
							<p style="color: #888;">${you }님과 ${review.sale.title }를 거래했어요</p> 
						</a>
					</li>
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
						   <p class="date regdate" regdate="${review.regdate }">
						   <javatime:format value="${review.regdate }" pattern="yyyy년 mm월 dd일 HH:mm "/> </p>
						   <c:if test="${loginUser.id == review.writer.id }">
						   <ul>
						      <li><a href="/joongo/review/update?id=${review.id}">수정</a></li>
						      <li><a class="review_delete" data-id="${review.id}">삭제</a></li>
						   </ul>
						   </c:if>
						</div>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>