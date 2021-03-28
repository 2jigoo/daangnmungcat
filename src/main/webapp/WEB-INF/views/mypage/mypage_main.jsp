<%@page import="daangnmungcat.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
$(document).ready(function(){
	var csrfToken = $("meta[name='_csrf']").attr("content");
	$.ajaxPrefilter(function(options, originalOptions, jqXHR){
	    if (options['type'].toLowerCase() === "post") {
	        jqXHR.setRequestHeader('X-CSRF-TOKEN', csrfToken);
	    }
	});

	 $(".gubun").each(function () {
	    var rows = $(".gubun:contains('" + $(this).text() + "')");
	    if (rows.length > 1) {
	        rows.eq(0).prop("rowspan", rows.length);
	        rows.not(":eq(0)").remove();
	        
	    } 
	});
	 
	 $(document).on('click', '#cancel_single', function(){
			var id = {id: $(this).attr('orderId')};
			console.log(id)
			if(confirm('주문을 취소하시겠습니까?') == true){
				$.ajax({
					url: '/order-cancel',
					type: "post",
					contentType: "application/json; charset=utf-8",
					data : JSON.stringify(id),
					dataType: "json",
					cache : false,
					success: function(res) {
						alert('주문 취소 완료');
						location.reload();
					},
					error: function(request,status,error){
						alert('에러' + request.status+request.responseText+error);
					}
				});
			}else {
				return;
			}
			
		});
		
		$(document).on('click', '#cancel_multiple', function(){
			var id = {id: $(this).attr('orderId')};
			console.log(id)
			if(confirm('주문을 취소하시겠습니까?') == true){
				$.ajax({
					url: '/order-cancel',
					type: "post",
					contentType: "application/json; charset=utf-8",
					data : JSON.stringify(id),
					dataType: "json",
					cache : false,
					success: function(res) {
						alert('주문 취소 완료');
					},
					error: function(request,status,error){
						alert('에러' + request.status+request.responseText+error);
					}
				});
			}else {
				return;
			}
			
		});
		
		$(document).on('click', '#order_confirm', function(){
			var id = {id: $(this).attr('odId')};
			console.log(id)
			if(confirm('구매확정 하시겠습니까? ') == true){
				$.ajax({
					url: '/order-confirm',
					type: "post",
					contentType: "application/json; charset=utf-8",
					data : JSON.stringify(id),
					dataType: "json",
					cache : false,
					success: function(mileage) {
						alert(mileage + '원이 적립되었습니다.')
						location.reload();
					},
					error: function(request,status,error){
						alert('에러' + request.status+request.responseText+error);
					}
				});
			}else {
				return;
			}
		});
	
});
</script>
<Style>

</Style>
<div id="subContent">
	<h2 id="subTitle">마이페이지</h2>
	<div id="pageCont" class="s-inner">
		<div class="mypage_main">
			<dl>
				<dt>회원정보</dt>
				<a href="<c:url value="/mypage/pwd_confirm" />"><dd>회원정보 변경</dd></a>
				<a href="<c:url value="/mypage/mypage_pwd" />"><dd>비밀번호 변경</dd></a>
				<a href="<c:url value="/mypage/shipping_main" />"><dd>배송지 관리</dd></a>
				<a href="<c:url value="/mypage/mypage_withdraw" />"><dd>회원 탈퇴</dd></a>
			</dl>
			<dl>
				<dt>거래정보</dt>
				<a href="/chat"><dd>내 채팅목록</dd></a>
				<a href="/mypage/joongo/list?memId=${loginUser.id}"><dd>내 판매글</dd></a>
				<a href="/mypage/joongo/comment?memId=${loginUser.id}"><dd>내 댓글</dd></a>
				<a href="<c:url value="/mypage/joongo/heart/list"/>"><dd>찜 목록</dd></a>
				<a href="/mypage/joongo/review/list?memId=${loginUser.id}"><dd>거래후기</dd></a>
			</dl>
			<dl>
				<dt>쇼핑정보</dt>
				<a href="<c:url value="/mall/cart/list"/>"><dd>장바구니</dd></a>
				<a href="<c:url value="/mypage/mypage_order_list" />"><dd>주문내역</dd></a>
				<a href="<c:url value="/mypage/mypage_order_cancel_list" />"><dd>취소/환불내역</dd></a>
				<!-- <dd>상품 후기</dd>
				<dd>찜리스트</dd> -->
				<a href="/mypage/mileage/list?memId=${loginUser.id}"><dd>마일리지</dd></a>
			</dl>
			<dl>
				<dt>커뮤니티</dt>
				<dd>내 게시물</dd>
				<dd>내 댓글</dd>
			</dl>
		</div>

	<div class="mypage_grade_div">
		<div class="img_box">
			<a href="/profile/${member.id }">
			<c:if test="${empty member.profilePic}">
				<img alt="기본프로필" src="/resources/images/default_user_image.png">
			</c:if>
			<c:if test="${not empty member.profilePic}">
				<img src="/resources/${member.profilePic}">
			</c:if>
			</a>
		</div>
		<div class="txt_box">
			<p><span class="bold orange">${member.nickname}</span>
			님 회원등급은 <span class="bold">${grade}</span> 입니다.</p>
			<p class="dongne">
				${member.dongne1.name } ${member.dongne2.name }
			</p>
		</div>
		<div class="btn_box">
			<a class="item" href="/chat">채팅</a>
			<a class="item" href="/joongo/comment">댓글</a>
			<a class="item" href="/joongo/review">거래후기</a>
		</div>
		<div class="info_box">
			<span class="item">
				마일리지 <br><br>
				<a class="num" href="/mypage/mileage/list?memId=${loginUser.getId()}"><fmt:formatNumber value="${mile}"/></a>
			</span>
			<span class="item">
				중고거래 <br><br>
				<a class="num" href="/mypage/joongo/list?memId=${loginUser.getId()}">${saleTotal}</a>
			</span>
		</div>
	</div>
	
	<div class="mypage_sale_div">
		<div class="mypage_title_div">
			<span class="mypage_sub_title">최근 판매상품</span> 
			<span class="mypage_sub_exp">${member.name}님께서 최근 작성한 중고판매글입니다.</span>
			<a href="/profile/${member.id }/joongo"><span class="btn" list="joongo">더 보기</span></a>
		</div>
	</div>
	<div class="profile_section" style="border-bottom: 1px solid #e6e6e6; margin-bottom: 80px;">
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
	
	
	<div class="mypage_sale_div">
		<div class="mypage_title_div">
			<span class="mypage_sub_title">최근 주문 정보</span> 
			<span class="mypage_sub_exp">최근 30일 내에 진행중인 주문정보입니다.</span>
		</div>
		<table id="order_list_table" style="font-size:14px">
		<colgroup>
			<col width="200px">
			<col width="400px">
			<col width="100px">
			<col width="200px">
			<col width="150px">
			<col width="150px">
		</colgroup>
		<thead>
			<tr>
				<th>주문일/주문번호</th>
				<th>상품명/옵션</th>
				<th>수량</th>
				<th>상품금액</th>
				<th>주문상태</th>
				<th>상품 합계 금액</th>
			</tr>
		</thead>
		<tbody>
		
		<c:if test="${empty list}">
			<tr>
				<td colspan="6" style="padding:50px">주문 내역이 없습니다.</td>
			</tr>
		</c:if>
		
			<c:forEach var="order" items="${list}" varStatus="status">
				<c:forEach var="od" items="${order.details}" varStatus="odstatus">
            		<tr>
            			<c:if test="${od.partcnt > 1}">
            				<td class="gubun order_num">
           						<fmt:parseDate value="${order.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
            					<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>
           						<input type="hidden" id="order_id" value="${order.id}"><br>
           						<span class="order_list_span" onclick="location.href='/mypage/mypage_order_list?id=${order.id}'">	
            						${order.id}
           						</span>
           						
           						<c:if test="${order.state == '대기'}">
           							<br><input type="button" value="주문취소" orderId="${order.id}" id="cancel_multiple" class="order_list_cancel" style="margin:10px;">
           						</c:if>
            				</td>
            			</c:if>
            			<c:if test="${od.partcnt == 1}">
            				<td class="order_num">
            					<fmt:parseDate value="${order.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
            					<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>
           						<input type="hidden" id="order_id" value="${order.id}"><br>
           						<span class="order_list_span" onclick="location.href='/mypage/mypage_order_list?id=${order.id}'">	
            						${order.id}
           						</span>
           						<c:if test="${order.state == '대기'}">
           							<br><input type="button" value="주문취소" orderId="${order.id}" id="cancel_single" class="order_list_cancel" style="margin:10px;">
           						</c:if>
	            				
            				</td>
            			</c:if>
							
						<td class="tl" >
							<div class="order_img_wrapper">
									<c:if test="${od.pdt.image1 eq null}"><a href="/mall/product/${od.pdt.id}"><img src="/resources/images/no_image.jpg" class="order_list_img"></a></c:if>
									<c:if test="${od.pdt.image1 ne null}"><a href="/mall/product/${od.pdt.id}"><img src="/resources${od.pdt.image1}" class="order_list_img"></a></c:if>
								<span style="margin-left:30px; line-height:100px; overflow:hidden" id="part_pdt" pdt="${od.pdt.name}">
									<a href="/mall/product/${od.pdt.id}">${od.pdt.name}</a>
								</span>
							</div>
							
						</td>
						<td>${od.quantity}개</td>
						<td><fmt:formatNumber value="${od.pdt.price}"/> 원</td>
						<td>
							<c:if test="${od.orderState.label == '대기'}">입금대기</c:if>
							<c:if test="${od.orderState.label == '결제'}">결제완료</c:if>
							<c:if test="${od.orderState.label == '배송'}">배송중</c:if>
							<c:if test="${od.orderState.label == '완료'}">배송완료</c:if>
							<c:if test="${od.orderState.label == '취소'}">결제취소</c:if>
							<c:if test="${od.orderState.label == '반품'}">반품취소</c:if>
							<c:if test="${od.orderState.label == '품절'}">품절취소</c:if>
							<c:if test="${od.orderState.label == '환불'}">환불완료</c:if>
							<c:if test="${od.orderState.label == '구매확정'}">구매확정</c:if>
							<br>
							<c:if test="${od.orderState.label == '완료' || od.orderState.label == '배송'}">
								<input type="button" value="구매확정" id="order_confirm"  odId="${od.id}" class="pre_order_btn3" style="margin-top:5px;">
							</c:if>
						</td>
							
						<c:if test="${od.partcnt > 1}">
            				<td class="gubun final_price">
            				<span style="display:none;">${order.id }</span>
            					<input type="hidden" value="<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            				<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>">
	            				<fmt:formatNumber value="${order.finalPrice}"/> 원
	            				<br>
	            				<c:if test="${order.state == '대기'}">입금대기</c:if>
								<c:if test="${order.state == '결제'}">결제완료</c:if>
								<c:if test="${order.state == '배송'}">배송중</c:if>
								<c:if test="${order.state == '완료'}">배송완료</c:if>
								<c:if test="${order.state == '취소'}">결제취소</c:if>
								<c:if test="${order.state == '반품'}">반품취소</c:if>
								<c:if test="${order.state == '퓸절'}">품절취소</c:if>
								<c:if test="${order.state == '환불'}">환불완료</c:if>
								<c:if test="${order.state == '구매확정'}">구매확정</c:if>
	            				<br>
	            				<c:if test="${order.trackingNumber != null}">[<a href="#" style="text-decoration:underline">${order.trackingNumber}</a>]</c:if>
	            				
            				</td>
						</c:if>
						
						<c:if test="${od.partcnt == 1}">
            				<td class="final_price">	
	            			<span style="display:none;">${order.id }</span>	
	            				<input type="hidden" value="<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />	
	            				<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>">
	            				<fmt:formatNumber value="${order.finalPrice}"/> 원
	            				<br>
		            			<c:if test="${order.state == '대기'}">입금대기</c:if>
								<c:if test="${order.state == '결제'}">결제완료</c:if>
								<c:if test="${order.state == '배송'}">배송중</c:if>
								<c:if test="${order.state == '완료'}">배송완료</c:if>
								<c:if test="${order.state == '취소'}">결제취소</c:if>
								<c:if test="${order.state == '반품'}">반품취소</c:if>
								<c:if test="${order.state == '퓸절'}">품절취소</c:if>
								<c:if test="${order.state == '환불'}">환불완료</c:if>
								<c:if test="${order.state == '구매확정'}">구매확정</c:if>
	            				<br>
	            				<c:if test="${order.trackingNumber != null}">[<a href="#" style="text-decoration:underline">${order.trackingNumber}</a>]</c:if>

            				</td>
            			</c:if>
						
					</tr>
					
				</c:forEach>
				
			</c:forEach>
		</tbody>
	</table>
	</div>

</div>
	
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>