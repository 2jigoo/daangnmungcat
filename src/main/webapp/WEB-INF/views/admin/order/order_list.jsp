<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

   
<script>

$(document).ready(function(){
 	
	var state;
	var start = getParameter('start');
	var end = getParameter('end');
	var stateStr = getParameter('state');
	var content = getParameter('content');
	var query = getParameter('query');
	
	$('input[name=order_state]').change(function(){
		state = $(this).val(); 
	});
	
	$('input[id=start_date]').change(function(){
		start = $(this).val(); 
	});
	
	$('input[id=end_date]').change(function(){
		end = $(this).val(); 
	});
	
	
	if(start != null || end != null){
		$("#start_date").attr("value", start);
		$("#end_date").attr("value", end);
	}
	
	if(stateStr != null){
		$('input:radio[name="order_state"][value="' + stateStr + '"]').prop('checked', true);
	}
	
	if(content != null || query !=null){
		$("select[name='search'").val(content).prop("selected", true);
		$('#query').prop('value', query);  
	}
	
	
	
	$('#searchBtn').on('click', function(){
		var keyword = $("select[name=search]").val();
		var query = $('#query').val();
		
		var start_val = $("#start_date").val();
		var end_val = $("#end_date").val();
		
		if(query == ""){
			alert('검색어를 입력하세요.');
			return;
		}
		var add = '/admin/order/list?content=' + keyword + '&query=' + query;
		location.href= add;
	});
	
	$("select[name=search]").change(function(){
		if($(this).val() == 'mem_phone' || $(this).val() == 'address_phone1' || $(this).val() == 'address_phone2'){
			$('#query').keyup(function(){
				$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
			});
		}
	});
	
	
	$(document).on('click', '#search', function(){
		
		var start_val = $("#start_date").val();
		var end_val = $("#end_date").val();
	
		var add = '/admin/order/list';
		if(start_val == "" && end_val == "" && state == undefined){
			alert('상태나 날짜를 선택하세요.');
			return;
		
		}else if (start_val == "" || end_val == "" ){
			if(state == '전체'){
				add = add;
			}else{
				add += '?start='+ start_val + '&end=' + end_val;
			}
		}else if(state == undefined ){
			add += '?start='+ start_val + '&end=' + end_val;
		}else if(state != null || getParameter('state') != null ){
			if( state== '전체'){
				console.log('전체')
				add += '?start='+ start_val + '&end=' + end_val;
			}else{
				add += '?state=' + state + '&start='+ start_val + '&end=' + end_val;	
			}
			
		}
		
		location.href= add;
		
	});
	

	var date = getDateStr(new Date());
	
	$('#today').on('click', function(){
		$("#start_date").attr("value", date);
		$("#end_date").attr("value", date);
	});
	
	$('#7days_ago').on('click', function(){
		var today = new Date();
		var date =  getDateStr(new Date());
		var dayOfMonth = today.getDate();
		today.setDate(dayOfMonth - 7);
		var todayStr =  getDateStr(today);

		$("#start_date").attr("value", todayStr);
		$("#end_date").attr("value",date);
	});
	
	$('#15days_ago').on('click', function(){
		var today = new Date();
		var dayOfMonth = today.getDate();
		today.setDate(dayOfMonth - 15);

		$("#start_date").attr("value", getDateStr(today));
		$("#end_date").attr("value", date);
	});
	
	$('#1month_ago').on('click', function(){
		var d = new Date()
		var monthOfYear = d.getMonth()
		d.setMonth(monthOfYear - 1);
		
		$("#start_date").attr("value", getDateStr(d));
		$("#end_date").attr("value",date);
	});
	
	$('#6month_ago').on('click', function(){
		var d = new Date()
		var monthOfYear = d.getMonth()
		d.setMonth(monthOfYear - 6);

		$("#start_date").attr("value",  getDateStr(d));
		$("#end_date").attr("value", date);
	});
	
	$('#1years_ago').on('click', function(){
		var d = new Date()
		var monthOfYear = d.getFullYear();
		d.setFullYear(monthOfYear - 1);

		$("#start_date").attr("value", getDateStr(d));
		$("#end_date").attr("value", date);
	});
	
	
	
	
	
	
});

function getParameter(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

function getDateStr(myDate){
	var year = myDate.getFullYear();
	var month = (myDate.getMonth() + 1);
	var day = myDate.getDate();
	
	month = (month < 10) ? "0" + String(month) : month;
	day = (day < 10) ? "0" + String(day) : day;
	
	return  year + '-' + month + '-' + day;
}

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
				<select class="custom-select custom-select-sm" name="search" style="width:100px;">
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
		<hr>
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
		</div>
		<div style="width:100%">
				<span style="font-weight:bold; margin-right:20px;"> 주문일자 </span> 
				<input type="date" id="start_date"> ~ <input type="date" id="end_date">
				<input type="button" value="오늘" id="today">
				<input type="button" value="7일" id="7days_ago">
				<input type="button" value="15일" id="15days_ago">
				<input type="button" value="1개월" id="1month_ago">
				<input type="button" value="6개월" id="6month_ago">
				<input type="button" value="1년" id="1years_ago">
				<input type="button" value="조회" id="search">
		
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
		<c:choose>
			<c:when test="${content != null || query != null}">
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
			 </c:when> 
			 
			 <c:when test="${state != null }">
			    <c:if test="${pageMaker.prev}">
			    	<p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.startPage - 1)}&state=${state}">이전</a></p>
			    </c:if> 
				<ul>
				
				  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				  	<li><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(idx)}&state=${state}">${idx}</a></li>
				  </c:forEach>
				</ul>
				
				  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				  	
				    <p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.endPage + 1)}&state=${state}">다음</a></p>
				  </c:if> 
			 </c:when> 
			 
			 
			 <c:when test="${ start != null || end != null }">
			    <c:if test="${pageMaker.prev}">
			    	<p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.startPage - 1)}&start=${start}&end=${end}">이전</a></p>
			    </c:if> 
				<ul>
				
				  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				  	<li><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(idx)}&start=${start}&end=${end}">${idx}</a></li>
				  </c:forEach>
				</ul>
				
				  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				  	
				    <p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.endPage + 1)}&start=${start}&end=${end}">다음</a></p>
				  </c:if> 
			 </c:when> 
			 
			  <c:when test="${ state != null && start != null && end != null }">
			    <c:if test="${pageMaker.prev}">
			    	<p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.startPage - 1)}&state=${state}&start=${start}&end=${end}">이전</a></p>
			    </c:if> 
				<ul>
				
				  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				  	<li><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(idx)}&state=${state}&start=${start}&end=${end}">${idx}</a></li>
				  </c:forEach>
				</ul>
				
				  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				  	
				    <p><a href="<%=request.getContextPath()%>/admin/order/list${pageMaker.makeQuery(pageMaker.endPage + 1)}&state=${state}&start=${start}&end=${end}">다음</a></p>
				  </c:if> 
			 </c:when> 
			 
			 
			  <c:otherwise>
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
			   </c:otherwise>
		</c:choose>
		</div>
<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>
