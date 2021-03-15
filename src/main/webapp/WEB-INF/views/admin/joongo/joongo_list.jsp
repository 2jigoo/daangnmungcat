<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	$.get(contextPath+"/dongne1", function(json){
		console.log(json)
		var datalength = json.length; 
		if(datalength >= 1){
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<option value="' + json[i].id + '">' + json[i].name + '</option>';
			}
			$("select[name=dongne1]").append(sCont);
		}
	});
	
	
	$("select[name=dongne1]").change(function(){
		$("select[name=dongne2]").find('option').remove();
		var dong1 = $("select[name=dongne1]").val();
		$.get(contextPath+"/dongne2/"+dong1, function(json){
			var datalength = json.length; 
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<option value="' + json[i].id + '">' + json[i].name + '</option>';
			}
			$("select[name=dongne2]").append(sCont);	
		});
	});
	
	$(".delete_btn").click(function(){
		if (confirm("정말 삭제하시겠습니까??") == true){
		} else{
		    return false;
		}
	})
	
	$("#searchBtn").click(function(){
		if ($("select[name='where']").val() == ""){
			alert("검색 기준을 선택해주세요.")
			return false;
		} else if ($("input[name='query']").val() == ""){
			if ($("select[name='where']").val() == "address"){
				if ($("select[name='dongne1']").val() == "0"){
					alert("동네를 선택해주세요.")
					return false;
				} else {
					window.location = "/admin/joongo/list?dongne1="+$("select[name=dongne1] option:checked").text()+"&dongne2="+$("select[name=dongne2] option:checked").text()+"";
				}
			} else if ($("select[name='where']").val() == "category") {
				window.location = "/admin/joongo/list?"+$("select[name='where']").val()+"="+$("select[name='cate']").val()+"";
			} else {
				alert("검색 내용을 입력해주세요.")
				return false;
			}
		} else {
			window.location = "/admin/joongo/list?"+$("select[name='where']").val()+"="+$("input[name='query']").val()+"";
		}
	})
	
	$("select[name='where']").change(function(){
		if($(this).val() == "address"){
			$(".sch_txt").hide()
			$(".sch_select").show()
			$(".sch_select2").hide()
		} else if($(this).val() == "category"){
			$(".sch_txt").hide()
			$(".sch_select").hide()
			$(".sch_select2").show()
		} else {
			$(".sch_txt").show()
			$(".sch_select").hide()
			$(".sch_select2").hide()
		}
	})
});
</script>
<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">중고 리스트</div>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="col-sm-12 col-md-6 p-0">
			<div>
				<select class="custom-select custom-select-sm" name="where" style="width: 100px;">
					<option value="">기준</option>
					<option value="name">상품명</option>
					<option value="category">카테고리</option>
					<option value="id">아이디</option>
					<option value="address">동네</option>
				</select>
				<label class="sch_txt">
					<input type="search" class="form-control form-control-sm" name="query">
				</label>
				<div class="sch_select" style="display:none">
					<select name="dongne1" id="dongne1" class="custom-select custom-select-sm">
						<option value="0">지역을 선택하세요</option>
					</select> 
					<select name="dongne2" id="dongne2" class="custom-select custom-select-sm">
						<option value="0">동네를 선택하세요</option>
					</select>
				</div>
				<div class="sch_select2" style="display:none">
					<select name="cate" class="custom-select custom-select-sm">
						<option value="멍">멍</option>
						<option value="냥">냥</option>
						<option value="모두">모두</option>
					</select>
				</div>
				<input type="submit" class="btn btn-primary btn-sm" value="검색" id="searchBtn"></input>
			</div>
		</div>
		
		<table class="adm_table_style1">
			<colgroup>
				<col width="10%">
				<col width="29.5%">
				<col width="29.5%">
				<col width="11%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th rowspan="2">이미지</th>
					<th>동네</th>
					<th>카테고리</th>
					<th>가격</th>
					<th rowspan="2">아이디</th>
					<th rowspan="2">관리</th>
				</tr>
				<tr>
					<th colspan="2">제목(상품명)</th>
					<th>판매상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="list">
				<tr>
					<td rowspan="2">
						<c:if test="${empty list.thumImg}">
						<img src="<%=request.getContextPath() %>/resources/images/no_image.jpg">
						</c:if>
						<c:if test="${not empty list.thumImg}">
						<img src="<%=request.getContextPath() %>/resources/${list.thumImg}">
						</c:if>
					</td>
					<td>${list.dongne1.name} ${list.dongne2.name}</td>
					<td>
						<c:if test="${list.dogCate eq 'y'}">
							멍&nbsp;
						</c:if>
						<c:if test="${list.catCate eq 'y'}">
							냥 
						</c:if>
					</td>
					<td class="tc"><fmt:formatNumber value="${list.price}"/> 원</td>
					<td rowspan="2"  class="tc">${list.member.id}</td>
					<td rowspan="2">
						<a href="/joongoSale/detailList?id=${list.id}">보기</a>
						<a href="/joongoSale/admin/delete?id=${list.id}" class="delete_btn">삭제</a>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						${list.title}
						<ul class="adm_joongo_ico">
							<li class="heart">${list.heartCount}</li>
							<li class="chat">${list.chatCount}</li>
						</ul>
					</td>
					<td class="tc">${list.saleState.label }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="board_page">
		    <c:if test="${pageMaker.prev}">
		    	<c:choose>
		    		<c:when test="${not empty dongne2Name}">
		    			<p><a href="/admin/joongo/list/${dongne1Name}/${dongne2Name}${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    		</c:when>
		    		<c:when test="${not empty dongne1Name}">
		    			<p><a href="/admin/joongo/list/${dongne1Name}${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    		</c:when>
		    		<c:otherwise>
				    	<p><a href="/admin/joongo/list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    		</c:otherwise>
		    	</c:choose>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			   <c:choose>
			  		<c:when test="${not empty dongne2Name}">
			  			<li><a href="/admin/joongo/list/${dongne1Name}/${dongne2Name}${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  		</c:when>
			  		<c:when test="${not empty dongne1Name}">
			  			<li><a href="/admin/joongo/list/${dongne1Name}${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  		</c:when>
			  		<c:otherwise>
			    	<li><a href="/admin/joongo/list${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  		</c:otherwise>
			 		</c:choose>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			   <c:choose>
			  		<c:when test="${not empty dongne2Name}">
			  			<p><a href="/admin/joongo/list/${dongne1Name}/${dongne2Name}${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  		</c:when>
			  		<c:when test="${not empty dongne1Name}">
			  			<p><a href="/admin/joongo/list/${dongne1Name}${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  		</c:when>
			  		<c:otherwise>
			    		<p><a href="/admin/joongo/list${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  		</c:otherwise>
			 		</c:choose>
			  </c:if> 
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>