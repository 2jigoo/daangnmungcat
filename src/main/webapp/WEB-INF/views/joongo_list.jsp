<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/resources/include/header.jsp" %>
<script type="text/javascript">
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	$.get(contextPath+"/dongne1", function(json){
		var datalength = json.length; 
		console.log(datalength)
		if(datalength >= 1){
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<option value="' + json[i].dong1Id + '">' + json[i].dong1Name + '</option>';
			}
			$("select[name=dongne1]").append(sCont);
		}
	});
	
	$("select[name=dongne1]").change(function(){
		$("select[name=dongne2]").find('option').remove();
		var dong1 = $("select[name=dongne1]").val();
		window.location = "joongo_list/"+ dong1;
		/*$.get(contextPath+"/dongne2/"+dong1, function(json){
			var datalength = json.length; 
			var sCont = "<option>동네를 선택하세요</option>";
			for(i=0; i<datalength; i++){
				sCont += '<option value="' + json[i].dong2Id + '">' + json[i].dong2Name + '</option>';
			}
			$("select[name=dongne2]").append(sCont);	
		});*/
	});
});
</script>

<div id="subContent">
	<h2 id="subTitle">중고거래 인기매물</h2>
	<div id="pageCont" class="s-inner">
		<div class="list_top">
			<p class="my_location">내 위치</p>
			<div>
				<select name="dongne1">
					<option>시 선택</option>
				</select> 
				<select name="dongne2">
				</select>
			</div>
		</div>
		<div>
			<ul class="product_list s-inner">
				<c:forEach items="${list}" var="list">
				<li><a href="#">
					<div class="img"><img src="<c:url value="/resources/images/mProduct_img1.png" />"></div>
					<div class="txt">
						<p class="location">서울 노원구 하계동</p>
						<p class="subject">${list.title}</p>
						<p class="price"><span><fmt:formatNumber value="${list.price}"></fmt:formatNumber></span>원</p>
						<ul>
							<li class="heart">${list.heartCount}</li>
							<li class="chat">${list.chatCount}</li>
						</ul>
					</div>
				</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>


<jsp:include page="/resources/include/footer.jsp"/>