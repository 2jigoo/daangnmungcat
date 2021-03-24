<%@page import="daangnmungcat.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
$(document).ready(function(){
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
				<dd><a href="<c:url value="/mypage/pwd_confirm" />">회원정보 변경</a></dd>
				<dd><a href="<c:url value="/mypage/mypage_pwd" />">비밀번호 변경</a></dd>
				<dd><a href="<c:url value="/mypage/shipping_main" />">배송지 관리</a></dd>
				<dd><a href="<c:url value="/mypage/mypage_withdraw" />">회원 탈퇴</a></dd>
			</dl>
			<dl>
				<dt>거래정보</dt>
				<dd>내 채팅목록</dd>
				<dd><a href="/mypage/joongo/list?memId=${loginUser.id}">내 판매글</a></dd>
				<dd><a href="/mypage/joongo/comment?memId=${loginUser.id}">내 댓글</a></dd>
				<dd><a href="<c:url value="/mypage/joongo/heart/list"/>">찜 목록</a></dd>
				<dd><a href="/mypage/joongo/review/list?memId=${loginUser.id}">거래후기</a></dd>
			</dl>
			<dl>
				<dt>쇼핑정보</dt>
				<dd><a href="<c:url value="/mall/cart/list"/>">장바구니</a></dd>
				<dd><a href="<c:url value="/mypage/mypage_order_list" />">주문내역</a></dd>
				<dd><a href="<c:url value="/mypage/mypage_order_cancel_list" />">취소/환불내역</a></dd>
				<dd>상품 후기</dd>
				<dd>찜리스트</dd>
			</dl>
			<dl>
				<dt>커뮤니티</dt>
				<dd>내 게시물</dd>
				<dd>내 댓글</dd>
				<dd>마일리지</dd>
			</dl>
		</div>

	<div class="mypage_grade_div">
		<span class="mypage_grade"><span style="color:#ff7e15;font-weight:bold">${member.nickname}</span>
			님 회원등급은 <span style="font-weight:bold">${grade}</span> 입니다. </span>
		<span class="mypage_mile">
			마일리지 <br><br>
			<span class="mypage_num"><fmt:formatNumber value="${mile}"/></span>
		</span>
		<span class="mypage_mile">
			중고거래 <br><br>
			<a class="mypage_num" href="/mypage/joongo/list?memId=${loginUser.getId()}">${saleCnt}</a>
		</span>
	</div>
	
	<div class="mypage_sale_div">
		<div class="mypage_title_div">
			<span class="mypage_sub_title">최근 거래 정보</span> 
			<span class="mypage_sub_exp">${member.name}님께서 최근 30일 내에 작성한 판매글입니다.</span>
		</div>
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