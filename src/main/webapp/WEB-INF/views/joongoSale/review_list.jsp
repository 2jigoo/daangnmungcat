<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>


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
		<div class="member_info">
			<div class="img_box">
				<c:if test="${empty saleMember.profilePic}">
					<img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
				</c:if>
				<c:if test="${not empty saleMember.profilePic}">
					<img src="/resources/${list.buyMember.profilePic}">
				</c:if>
			</div>
			<div class="txt_box">
				<p class="name">${saleMember.nickname } <span>${saleMember.dongne1.name } ${saleMember.dongne2.name }</span></p>
				<p class="count">거래 후기(${countMemId})</p>
			</div>
		</div>
		<ul class="joongo_review_list">
			<c:forEach items="${list}" var="list">
			<li>
				<div class="user">
				   <p class="img">
				      <c:if test="${empty list.buyMember.profilePic}">
				         <img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
				      </c:if>
				      <c:if test="${not empty list.buyMember.profilePic}">
				         <img src="/resources/${list.buyMember.profilePic}">
				      </c:if>
				   </p>
				   <p class="name">${list.buyMember.nickname }<span>${list.buyMember.dongne1.name} ${list.buyMember.dongne2.name}</span></p>
				</div>
				<div class="star_box star_box_data" data-star="${list.rating}">
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
				<pre class="content">${list.content }</pre>
				<div class="info">
				   <p class="date">${list.regdate }</p>
				   <c:if test="${loginUser.id == list.buyMember.id }">
				   <ul>
				      <li><a href="/joongo/review/update?id=${list.id}">수정</a></li>
				      <li><a class="review_delete" data-id="${list.id}">삭제</a></li>
				   </ul>
				   </c:if>
				</div>
			</li>
			</c:forEach>
			<c:if test="${empty list}">
            <li class="no_board">
               	등록된 후기가 없습니다.
            </li>
            </c:if>
		</ul>
	</div>
</div>



<jsp:include page="/resources/include/footer.jsp"/>