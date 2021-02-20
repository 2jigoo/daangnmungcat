<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>


<script>
$(document).ready(function(){
	
	$('#searchBtn').on('click', function(){
		var keyword = $("select[name=search]").val();
		var query = $('#query').val();
		if(query == ""){
			alert('검색어를 입력하세요.');
			return;
		}
		location.href='/admin/order/list?content=' + keyword + '&query=' + query;
	});
	
	$("select[name=search]").change(function(){
		if($(this).val() == 'mem_phone' || $(this).val() == 'address_phone1' || $(this).val() == 'address_phone2'){
			$('#query').keyup(function(){
				$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
			});
		}
	});
	
	$("input[name=order_state]").change(function(){
		var query = $(this).val();
		if(query == '전체'){
			location.href='/admin/order/list';
		}else {
			location.href='/admin/order/list?content=state&query=' + query;
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
	
	
});
</script>

<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">주문 리스트</div>
			<button id="addNew" class="btn btn-success btn-sm" onclick="location.href='/admin/mileage/write' " style="float: right;">주문 등록</button>
		</h6>
	</div>
	<!-- card-body -->
	
	<div class="card-body" style="padding:30px;">
		<div class="col-sm-12 col-md-6 p-0">
			<div><a href="/admin/order/list">전체 목록</a> | 전체 주문내역  ${totalCnt}건</div>
			<div>
				<select class="custom-select custom-select-sm" name="search" style="width: 100px;">
					<option value="id">주문번호</option>
					<option value="mem_id">회원 ID</option>
					<option value="mem_name">주문자</option>
					<option value="mem_phone">주문자휴대폰</option>
					<option value="address_name">받는분</option>
					<option value="address_phone1">받는분일반전화</option>
					<option value="address_phone2">받는분휴대폰</option>
				</select>
				<label>
					<input type="text" class="form-control form-control-sm" id="query">
				</label>
				<input type="button" class="btn btn-primary btn-sm" value="검색" id="searchBtn"></input>
			</div>
		</div>
		<div class="col-sm-12 col-md-6 p-0">
			<div>
				<span style="font-weight:bold; margin-right:20px;">주문상태 </span> 
				<input type="radio" name="order_state" value="전체">전체
				<input type="radio" name="order_state" value="결제완료">결제완료
				<input type="radio" name="order_state" value="배송중">배송중
				<input type="radio" name="order_state" value="배송완료">배송완료
				<input type="radio" name="order_state" value="구매확정">구매확정
				<input type="radio" name="order_state" value="부분취소">부분취소
				<input type="radio" name="order_state" value="환불완료">환불완료
			</div>
			<div>
				<span style="font-weight:bold; margin-right:20px;"> 주문일자 </span> 
				<input type="text" id="start_date"> ~ <input type="text" id="end_date">
				<div class="order_list_search_div">
				<input type="button" value="오늘" id="today">
				<input type="button" value="7일" id="7days_ago">
				<input type="button" value="15일" id="15days_ago">
				<input type="button" value="1개월" id="1month_ago">
				<input type="button" value="6개월" id="6month_ago">
				<input type="button" value="1년" id="1years_ago">
				<input type="button" value="검색" id="search">
	</div>
			</div>
		</div>
	</div>
		<table class="adm_table_style1">
			<colgroup>
				<col width="5%">
				<col width="12%">
				<col width="10%">
				<col width="12%">
				<col width="10%">
				<col width="12%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th rowspan="3">번호</th>
					<th>주문 번호</th>
					<th>주문자</th>
					<th>주문자전화</th>
					<th>받는 분</th>
					<th rowspan="3">결제합계<br>배송비포함</th>
					<th rowspan="3">주문취소</th>
					<th rowspan="3">사용한<br>마일리지</th>
					<th rowspan="3">주문일</th>
					<th rowspan="3">관리</th>
				</tr>
				<tr>
					<th rowspan="2">결제정보</th>
					<th>아이디</th>
					<th>상품 수</th>
					<th>누적주문수</th>
				</tr>
				
			</thead>
			<tbody>
				<c:forEach var="order" items="${list}" varStatus="status">	
				<tr>
				
					<td rowspan="2">${pageMaker.totalCount - ((pageMaker.cri.page -1) * pageMaker.cri.perPageNum + status.index)}</td>
					<td>${order.id }</td>
					<td>${order.member.name}</td>
					<td>${order.member.phone}</td>
					<td>${order.addName}</td>
					<td rowspan="2">${order.finalPrice }</td>
					<td rowspan="2">${order.returnPrice}</td>
					<td rowspan="2">${order.usedMileage}</td>
					<td rowspan="2">
						<fmt:parseDate value="${order.payDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parseDate" type="both" />
	            		<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${parseDate}"/>
					</td>
					<td rowspan="2">
						<input type="button" value="보기">
					</td>
				</tr>
				<tr>
					<td>${order.state}</td>
					<td>${order.member.id}</td>
					<td>${order.details.size()}</td>
					<td>${order.ordercnt}건</td>
				</tr>
				
					</c:forEach>
				
			</tbody>
		</table>
		
		<div class="board_page">
			<c:if test="${content != null || query != null}">
			    <c:if test="${pageMaker.prev}">
			    	<p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.startPage - 1)}&content=${content}&query=${query}">이전</a></p>
			    </c:if> 
				<ul>
				
				  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				  	<li><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(idx)}&content=${content}&query=${query}">${idx}</a></li>
				  </c:forEach>
				</ul>
				
				  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				  	
				    <p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.endPage + 1)}&content=${content}&query=${query}">다음</a></p>
				  </c:if> 
			 </c:if> 
			 
			  <c:if test="${content == null || query == null}">
			   		<c:if test="${pageMaker.prev}">
			    	<p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
			    	</c:if> 
					<ul>
				
				  	<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				  		<li><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(idx)}">${idx}</a></li>
				 	</c:forEach>
					</ul>
				
				  	<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				    <p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
				  </c:if> 
			  
			  </c:if>
		</div>
<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>