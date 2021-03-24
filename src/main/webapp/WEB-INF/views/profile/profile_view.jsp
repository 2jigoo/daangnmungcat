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
		<div class="profile_section">
			<div class="title">판매상품<span class="more_btn">더 보기</span></div>
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
		<div class="profile_section">
			<div class="title">받은 거래 후기<span class="more_btn">더 보기</span></div>
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