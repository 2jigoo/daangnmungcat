<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>


<script>
<c:choose>
	<c:when test="${empty review}">
		alert("작성하지 않은 리뷰입니다.");
		window.history.go(-1);
	</c:when>
	<c:when test="${loginUser.id ne review.writer.id}">
		alert("작성하지 않은 리뷰입니다.");
		window.history.go(-1);
	</c:when>
</c:choose>

$(function(){
	$(".joongo_review #update").click(function(){
		var star_num = ($(".star_box .star.on:last").index() + 1) * 0.5;
		
		if (star_num == 0){
			alert("상품평점을 선택해주세요.");
			return false;
		}
		if ($("textarea[name='content']").val() == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		var saleReview = {
			id : $("input[name='id']").val(),
			sale : {
				id : $("input[name='sale']").val(),
			},
			writer : {
				id : $("input[name='writer']").val(),
			},
			rating : star_num,
			content : $("textarea[name='content']").val(),
		}
		
		console.log(saleReview)
		
		$.ajax({
         type: "post",
         url : "/joongo/review/update",
         contentType : "application/json; charset=utf-8",
         cache : false,
         dataType : "json",
         data : JSON.stringify(saleReview),
         beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
         success:function(){
            alert("리뷰가 수정됐습니다.")
            window.history.back();
         },
         error: function(request,status,error){
            alert('에러' + request.status+request.responseText+error);
         }
      })
	})
})
</script>



<div id="subContent">
	<h2 id="subTitle">중고 리뷰 글쓰기</h2>
	<div id="pageCont" class="s-inner">
		<div class="joongo_review">
			<input type="hidden" name="id" value="${review.id}">
			<input type="hidden" name="sale" value="${review.sale.id}">
			<input type="hidden" name="writer" value="${loginUser.id}">
			<ul>
				<li>
					<p>거래상대</p>
					<div>
						<c:choose>
							<c:when test="${loginUser.id eq sale.member.id }"><a href="/profile/${sale.buyMember.id}">${sale.buyMember.nickname } 님 (${sale.buyMember.id })</a></c:when>
							<c:otherwise><a href="/profile/${sale.member.id}">${sale.member.nickname }님 (${sale.member.id })</a></c:otherwise>
						</c:choose>
					</div>
				</li>
				<li>
					<p>구매상품</p>
					<div>
						<div class="product">
							<a href="/joongoSale/detailList?id=${review.sale.id }">
								<div class="img">
									<c:if test="${empty review.sale.thumImg}">
										<img src="/resources/images/no_image.jpg">
									</c:if>
									<c:if test="${not empty review.sale.thumImg }">
										<img src="/resources/${review.sale.thumImg }">
									</c:if>
								</div>
								<div class="txt">
									<p class="name">${review.sale.title}</p>
								</div>
							</a>
						</div>
					</div>
				</li>
				<li>
					<p>상품평점</p>
					<div>
						<div class="star_box star_box_click star_box_data" data-star="${review.rating}">
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
						<p>별을 클릭하여 상품 만족도를 알려주세요.</p>
					</div>
				</li>
				<li>
					<p>내용</p>
					<div><textarea name="content">${review.content}</textarea></div>
				</li>
			</ul>
			<a href="#" class="btn history_back_btn">목록</a>
			<input type="submit" id="update" class="btn" value="수정">
		</div>
	</div>
</div>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>