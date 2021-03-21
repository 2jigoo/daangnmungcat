<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	$("#submitBtn").click(function(){
		if ($("select[name='search']").val() == ""){
			alert("검색 기준을 선택해주세요.")
			return false;
		} else {
			if ($("select[name='search']").val() == "content"){
			window.location = "/admin/mileage/list?"+$("select[name='search']").val()+"="+$("input[name='query']").val()+"";
		}else if($("select[name='search']").val() == "member"){
			window.location = "/admin/mileage/list?"+$("select[name='search']").val()+"="+$("input[name='query']").val()+"";		
		}else if($("select[name='search']").val() == "order"){
			window.location = "/admin/mileage/list?"+$("select[name='search']").val()+"="+$("input[name='query']").val()+"";		
		}else {
			window.location = "/admin/mileage/list?"+$("select[name=search]").val()+"="+$("input[name='query']").val()+"";
		}
		}
	})
	
	$("select[name='search']").change(function(){
		if($(this).val() == "member"){
			$(".sch_txt").hide()
			$(".sch_select").show()
			$(".sch_select2").hide()
		} else if($(this).val() == "content"){
			$(".sch_txt").hide()
			$(".sch_select").hide()
			$(".sch_select2").show()
		} else if($(this).val() == "order"){
			$(".sch_txt").hide()
			$(".sch_select").hide()
			$(".sch_select2").show()
		} else {
			$(".sch_txt").show()
			$(".sch_select").hide()
			$(".sch_select2").hide()
		}
	})
	
	$("#mileDelBtn").click(function(){
		if (confirm("정말 삭제하시겠습니까??") == true){
		} else{
		    return false;
		}
	})
	
	
	
});
</script>

<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">마일리지 리스트</div>
			<button id="addNew" class="btn btn-success btn-sm" onclick="location.href='/admin/mileage/write' " style="float: right;">마일리지 등록</button>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="col-sm-12 col-md-6 p-0">
			<div>
				<select class="custom-select custom-select-sm" name="search" style="width: 80px;">
					<option value="">기준</option>
					<option value="content">적립 내용</option>
					<option value="member">회원 아이디</option>
					<option value="order">주문 번호</option>
					</select>
				<label>
					<input type="search" class="form-control form-control-sm" name="query">
				</label>
				<input type="submit" class="btn btn-primary btn-sm" value="검색" id="submitBtn"></input>
			</div>
		</div>
	
		<table class="adm_table_style1">
			<colgroup>
				<col width="5%">
				<col width="7%">
				<col width="25%">
				<col width="15%">
				<col width="27%">
				<col width="10%">
				<col width="12%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>주문 번호</th>
					<th>회원 아이디</th>
					<th>금액</th>
					<th>적립 내용</th>
					<th>등록일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.id }</td>
					<td><a href="/admin/order?id=${list.order.id}">${list.order.id}</a></td>
					<td>${list.member.id}</td>
					<td>${list.mileage}</td>
					<td>${list.content}</td>
					<td><javatime:format value="${list.regDate }" pattern="yyyy-MM-dd HH:mm"/></td>
					<td>
						<a class="a_btn2" href="<%=request.getContextPath() %>/admin/mileage/update?id=${list.id}">수정</a>
						<a class="a_btn2" href="<%=request.getContextPath() %>/admin/mileage/delete?id=${list.id}" id="mileDelBtn">삭제</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="board_page">
		    <c:if test="${pageMaker.prev}">
		    	<p><a href="<%=request.getContextPath()%>/admin/mileage/list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			  	<li><a href="<%=request.getContextPath()%>/admin/mileage/list${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    <p><a href="<%=request.getContextPath()%>/admin/mileage/list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  </c:if> 
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>