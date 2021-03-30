<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>


<c:choose>
	<c:when test="${loginUser.id ne sale.member.id and loginUser.id ne sale.buyMember.id}">
		<script>
			alert("본인이 거래하지 않은 거래에 대해서 후기를 남길 수 없습니다.");
			window.history.go(-1);
		</script>
	</c:when>
	<c:when test="${sale.saleState.code ne 'SOLD_OUT' }">
		<script>
			alert("거래완료 처리가 되지 않은 판매글입니다.");
			window.history.go(-1);
		</script>
	</c:when>
	<c:when test="${not empty review}">
		<script>
			alert("이미 해당 판매글에 대해 거래후기를 남겼습니다.")
			window.history.go(-1);
		</script>
	</c:when>
</c:choose>



<script>
$(function(){
	$(".joongo_review #insert").click(function(){
		var star_num = ($(".star_box .star.on:last").index() + 1) * 0.5;
		
		if (star_num == 0){
			alert("상품평점을 선택해주세요.");
			return false;
		}
		if ($("textarea[name='content']").val() == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		const saleReview = {
			sale : {
				id : $("input[name='sale']").val(),
			},
			writer : {
				id : $("input[name='writer.id']").val(),
			},
			rating : star_num,
			content : $("textarea[name='content']").val(),
		}
		
		var buyer = $("input[name='sale.buyMember.id']").val();
		if(buyer) {
			const buyMember = {id: buyer};
			saleReview.sale.buyMember = buyMember;
		}
		
		console.log(saleReview);
		
		$.ajax({
         type: "post",
         url : "/joongo/review/write",
         contentType : "application/json; charset=utf-8",
         cache : false,
         dataType : "json",
         data : JSON.stringify(saleReview),
         beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
         success:function(data){
        	// data: 작성한 리뷰 id
            alert("리뷰를 등록했습니다.")
            window.location = "/";
         },
         error: function(request,status,error){
            alert('에러' + request.status+request.responseText+error);
            console.log(request);
            console.log(error);
         }
      })
	})
})
</script>



<div id="subContent">
	<h2 id="subTitle">중고 리뷰 글쓰기</h2>
	<div id="pageCont" class="s-inner">
		<div class="joongo_review">
			<input type="hidden" name="sale" value="${sale.id}">
			<input type="hidden" name="writer.id" value="${loginUser.id}">
			<input type="hidden" name="sale.buyMember.id" value="${buyer }">
			<ul>
				<li>
					<p>거래상대</p>
					<div>
						<c:choose>
							<c:when test="${loginUser.id eq sale.member.id }">
								<a href="/profile/${sale.buyMember.id}">${sale.buyMember.nickname } 님 (${sale.buyMember.id })</a>
							</c:when>
							<c:otherwise><a href="/profile/${sale.member.id}">${sale.member.nickname }님 (${sale.member.id })</a></c:otherwise>
						</c:choose>
					</div>
				</li>
				<li>
					<p>구매상품</p>
					<div>
						<div class="product">
							<a href="/joongoSale/detailList?id=${sale.id }">
								<div class="img">
									<c:if test="${empty sale.thumImg}">
										<img src="/resources/images/no_image.jpg">
									</c:if>
									<c:if test="${not empty sale.thumImg }">
										<img src="/resources/${sale.thumImg }">
									</c:if>
								</div>
								<div class="txt">
									<p class="name">${sale.title}</p>
								</div>
							</a>
						</div>
					</div>
				</li>
				<li>
					<p>상품평점</p>
					<div>
						<div class="star_box star_box_click">
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
					<div><textarea name="content"></textarea></div>
				</li>
			</ul>
			<a href="#" class="btn history_back_btn">목록</a>
			<input type="submit" id="insert" class="btn" value="등록">
		</div>
	</div>
</div>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>