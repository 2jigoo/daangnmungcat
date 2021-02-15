<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>

<style>
.wrapper {margin:0 auto; padding:50px;}
</style>

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
	 
	
	$.datepicker.setDefaults($.datepicker.regional['ko']); 
	$('#start_date').datepicker({
		dateFormat: 'yy-mm-dd',	//날짜 포맷이다. 보통 yy-mm-dd 를 많이 사용하는것 같다.
        prevText: '이전 달',	// 마우스 오버시 이전달 텍스트
        nextText: '다음 달',	// 마우스 오버시 다음달 텍스트
        closeText: '닫기', // 닫기 버튼 텍스트 변경
        currentText: '오늘', // 오늘 텍스트 변경
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더중 월 표시를 위한 부분
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더 중 월 표시를 위한 부분
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],	//한글 캘린더 요일 표시 부분
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],	//한글 요일 표시 부분
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],	// 한글 요일 표시 부분
        showMonthAfterYear: true,	// true : 년 월  false : 월 년 순으로 보여줌
        yearSuffix: '년',	//
        showButtonPanel: true,	// 오늘로 가는 버튼과 달력 닫기 버튼 보기 옵션
//        buttonImageOnly: true,	// input 옆에 조그만한 아이콘으로 캘린더 선택가능하게 하기
//        buttonImage: "images/calendar.gif",	// 조그만한 아이콘 이미지
//        buttonText: "Select date"
	})
	
	$('#end_date').datepicker({
		dateFormat: 'yy-mm-dd',	//날짜 포맷이다. 보통 yy-mm-dd 를 많이 사용하는것 같다.
        prevText: '이전 달',	// 마우스 오버시 이전달 텍스트
        nextText: '다음 달',	// 마우스 오버시 다음달 텍스트
        closeText: '닫기', // 닫기 버튼 텍스트 변경
        currentText: '오늘', // 오늘 텍스트 변경
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더중 월 표시를 위한 부분
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더 중 월 표시를 위한 부분
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],	//한글 캘린더 요일 표시 부분
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],	//한글 요일 표시 부분
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],	// 한글 요일 표시 부분
        showMonthAfterYear: true,	// true : 년 월  false : 월 년 순으로 보여줌
        yearSuffix: '년',	//
        showButtonPanel: true,	// 오늘로 가는 버튼과 달력 닫기 버튼 보기 옵션
//        buttonImageOnly: true,	// input 옆에 조그만한 아이콘으로 캘린더 선택가능하게 하기
//        buttonImage: "images/calendar.gif",	// 조그만한 아이콘 이미지
//        buttonText: "Select date"
		
	});
	
	$('#today').on('click', function(){
		$("#start_date").datepicker("setDate", 'today');
		$("#end_date").datepicker("setDate", 'today');
	});
	
	$('#7days_ago').on('click', function(){
		$("#start_date").datepicker("setDate", 'today-7');
		$("#end_date").datepicker("setDate", 'today');
	});
	
	$('#15days_ago').on('click', function(){
		$("#start_date").datepicker("setDate", 'today-15');
		$("#end_date").datepicker("setDate", 'today');
	});
	
	$('#1month_ago').on('click', function(){
		$("#start_date").datepicker("setDate", '-1M');
		$("#end_date").datepicker("setDate", 'today');
	});
	
	$('#6month_ago').on('click', function(){
		$("#start_date").datepicker("setDate", '-6M');
		$("#end_date").datepicker("setDate", 'today');
	});
	
	$('#1years_ago').on('click', function(){
		$("#start_date").datepicker("setDate", '-1Y');
		$("#end_date").datepicker("setDate", 'today');
	});
	
	$('#search').on('click', function(){
		
		var start_val = $("#start_date").datepicker({dateFormat:"yy-mm-dd"}).val();
		var end_val = $("#end_date").datepicker({dateFormat:"yy-mm-dd"}).val(); 
		
		if(start_val == "" || end_val == ""){
			alert('날짜를 선택하세요.')
		}else{
			location.href='/mypage/mypage_order_list/start='+start_val + '/end=' + end_val;
		}
		
	});
	

	$(document).on('click', '#order_cancel', function(){
		
		var pay_id = $(this).attr('pay_id');
		var pay_price = $(this).attr('pay_price');
		var order_id = $(this).attr('order_id');
		var name = $(this).attr('first_pdt');
		var order_qtt = $(this).attr('order_qtt');
		
		var data = {
				tid: pay_id, 
				partner_order_id: order_id,
				cancel_amount: pay_price,
				first_pdt: name,
				order_qtt: order_qtt
			};
			
		console.log(data);
		
		if(confirm('주문을 취소하시겠습니까?') == true){
			//post 전송
			$.ajax({
				url: '/kakao-cancel',
				type: "post",
				contentType: "application/json; charset=utf-8",
				data : JSON.stringify(data),
				success: function() {
					alert('주문 취소 완료');
					location.reload();
				},
				error: function(request,status,error){
					alert('에러' + request.status+request.responseText+error);
				}
			});
			
		}else{
			return;
		}
	});
	
	
	
	
	
	//부분취소
	$(document).on('click', '#part_cancel', function(){
			
			var pay_id = $(this).attr('pay_id');
			var od_price = $(this).attr('od_price');
			var order_id = $(this).attr('order_id');
			var name = $(this).attr('first_pdt');
			var order_qtt = $(this).attr('order_qtt');
			var od_id = $(this).attr('od_id');
			
			var data = {
					tid: pay_id, 
					partner_order_id: order_id,
					cancel_amount: od_price,
					first_pdt: name,
					order_qtt: order_qtt,
					od_id: od_id
				};
				
			console.log(data);
			
			if(confirm('주문을 취소하시겠습니까?') == true){
				//post 전송
				$.ajax({
					url: '/kakao-part',
					type: "post",
					contentType: "application/json; charset=utf-8",
					data : JSON.stringify(data),
					success: function() {
						alert('주문 취소 완료');
						location.reload();
					},
					error: function(request,status,error){
						alert('에러' + request.status+request.responseText+error);
					}
				});
				
			}else{
				return;
			}	
	});
	
	//결쩨정보
	$(document).on('click', '#order_info', function(){
		var tid = $(this).attr('tid');
		location.href= "/kakao-info/" + tid + "/";
	});
	
	
	
	
});


</script>
<div class="wrapper">
${vo.tid}
	<h2 id="subTitle">주문 내역</h2>
	<div class="order_list_search_div">
		조회 기간 
		<input type="button" value="오늘" id="today">
		<input type="button" value="7일" id="7days_ago">
		<input type="button" value="15일" id="15days_ago">
		<input type="button" value="1개월" id="1month_ago">
		<input type="button" value="6개월" id="6month_ago">
		<input type="button" value="1년" id="1years_ago">
		<input type="text" id="start_date"> ~ <input type="text" id="end_date"> 
		<input type="button" value="조회" id="search">
	</div>

<div>	
	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
	<table id="order_list_table">
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
				<th>총 결제금액</th>
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
            						<input type="hidden" id="order_id" value="${order.id}">
            					<span class="order_list_span"  onclick="location.href='/mypage/mypage_order_list/${order.id}'">	
	            					<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            					<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>
	            					<br> ${order.id}<br>	
            					</span>
            					<input type="button" value="결제정보" id="order_info" tid="${order.payId}">
            				</td>
            			</c:if>
            			<c:if test="${od.partcnt == 1}">
            				<td class="order_num">
            					<span class="order_list_span"  onclick="location.href='/mypage/mypage_order_list/${order.id}'">	
	            					<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            					<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>
	            					<br> ${order.id} <br>
	            				</span>
	            				<input type="button" value="결제정보" id="order_info" tid="${order.payId}">
            				</td>
            			</c:if>
							
						<td class="tl" >
							<div class="order_img_wrapper">
									<c:if test="${od.pdt.image1 eq null}"><a href="/mall/product/${od.pdt.id}"><img src="/resources/images/no_image.jpg" class="order_list_img"></a></c:if>
									<c:if test="${od.pdt.image1 ne null}"><a href="/mall/product/${od.pdt.id}"><img src="/resources${od.pdt.image1}" class="order_list_img"></a></c:if>
								<span style="margin-left:30px; line-height:100px"><a href="/mall/product/${od.pdt.id}">${od.pdt.name}</a></span></div>
							
						</td>
						<td>${od.quantity}</td>
						<td><fmt:formatNumber value="${od.pdt.price}"/></td>
						<td>
							${od.orderState.label}<br>
							<c:if test="${od.orderState.label ne '부분취소'}">
								<input type="button" value="부분취소" id="part_cancel"
										pay_id="${order.payId}" 
										od_price="${od.pdt.price}" 
										first_pdt="${od.pdt.name}" 
										order_qtt="${od.quantity}"  
										order_id="${order.id}"
										od_id = "${od.id}" >
							</c:if>
						</td>
							
						<c:if test="${od.partcnt > 1}">
            				<td class="gubun final_price">
            					<input type="hidden" value="<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            				<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>">
            					<fmt:formatNumber value="${order.finalPrice}"/>
            					<br>
            					<c:if test="${od.orderState.label == '결제완료'}">
									<input type="button" value="주문취소" id="order_cancel"
										 pay_id="${order.payId}" 
										 pay_price="${order.finalPrice}" 
										 first_pdt="${od.pdt.name}" 
										 order_qtt="${od.partcnt}"  
										 order_id="${order.id}" 
										 od_id = "${od.id}" ><br>
									
								</c:if>
								<c:if test="${od.orderState.label == '배송완료'}">
									<input type="button" value="구매확정" id="purchase_complited"><br>
									
								</c:if>
            					</td>
						</c:if>
						<c:if test="${od.partcnt == 1}">
            				<td class="final_price">
	            				<input type="hidden" value="<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            				<fmt:formatDate pattern="yyyy-MM-dd" value="${parseDate}"/>">
	            				<fmt:formatNumber value="${order.finalPrice}"/>
	            				<br>
	            			
            					<c:if test="${od.orderState.label == '결제완료'}">
									<input type="button" value="주문취소" id="order_cancel"
										 pay_id="${order.payId}" 
										 pay_price="${order.finalPrice}" 
										 first_pdt="${od.pdt.name}" 
										 order_qtt="${od.partcnt}"
										 order_id="${order.id}" ><br>
									
								</c:if>
								<c:if test="${od.orderState.label == '배송완료'}">
									<input type="button" value="구매확정" id="purchase_complited"> <br>
								
								</c:if>
            				</td>
            			</c:if>
						
					</tr>
					
				</c:forEach>
				
			</c:forEach>
		</tbody>
	</table>
</div>
</div>

<jsp:include page="/resources/include/footer.jsp"/>