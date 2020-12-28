<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/resources/include/header.jsp" %>

<script type="text/javascript">
var dongne1Id;
var dongne1Name = "${dongne1Name}"
$(function(){
	
	if (navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(
	        function(location){

	            //succ - 유저가 허용버튼을 클릭하여 값을 가져올 수 있는 상태
	            var lat = location.coords.latitude;
	            var lon = location.coords.longitude;
	            
	            console.log("lat : "+ lat)
	            console.log("lon : "+ lon)
	        },
	        function(error){
	            //fail - 유저가 차단버튼을 클릭하여 값을 가져올 수 없는 상태

	       }
	    );
	}
	else {
	    //fail - 애초에 GPS 정보를 사용할 수 없는 상태
	}
	
	var contextPath = "<%=request.getContextPath()%>";
	
	$.get(contextPath+"/dongne1", function(json){
		var datalength = json.length; 
		if(datalength >= 1){
			var sCont = "";
			for(i=0; i<datalength; i++){
				if (json[i].dong1Name == dongne1Name){
					sCont += '<option value="' + json[i].dong1Id + '" selected>';
					dongne1Id = json[i].dong1Id;
					console.log("test2 : "+ dongne1Id)
				} else {
					sCont += '<option value="' + json[i].dong1Id + '">';
				}
				sCont += json[i].dong1Name;
				sCont += '</option>';
			}
			$("select[name=dongne1]").append(sCont);
		}
	});
	
	setTimeout(function(){
		console.log("test : "+ dongne1Id)
		if (dongne1Name != ""){
			$.get(contextPath+"/dongne2/"+ dongne1Id, function(json){
				var datalength = json.length; 
				var sCont = "<option>동네를 선택하세요</option>";
				for(i=0; i<datalength; i++){
					if (json[i].dong2Name == "${dongne2Name}"){
						sCont += '<option value="' + json[i].dong2Id + '" selected>';
					} else {
						sCont += '<option value="' + json[i].dong2Id + '">';
					}
					sCont += json[i].dong2Name;
					sCont += '</option>';
				}
				$("select[name=dongne2]").append(sCont);	
			});
		}
	}, 50)
	
	$("select[name=dongne1]").change(function(){
		if ($("select[name=dongne1]").val() == "시 선택"){
			window.location = "<c:url value='/joongo_list' />";
		} else {
			var dong1 = $("select[name=dongne1] option:checked").text();
			window.location = "<c:url value='/joongo_list/"+ dong1 +"' />";
		}
	});
	
	$("select[name=dongne2]").change(function(){
		if ($("select[name=dongne2]").val() == "동네를 선택하세요"){
			window.location = "<c:url value='/joongo_list/"+ dongne1Name +"' />";
		} else {
			var dong1 = $("select[name=dongne1] option:checked").text();
			var dong2 = $("select[name=dongne2] option:checked").text();
			window.location = "<c:url value='/joongo_list/"+ dong1 +"/"+ dong2 +"' />";
		}
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
						<p class="location">${list.dongne1.dong1Name} ${list.dongne2.dong2Name}</p>
						<p class="subject">${list.title}</p>
						<p class="price"><span>${list.price}</span>원</p>
						<ul>
							<li class="heart">${list.heartCount}</li>
							<li class="chat">${list.chatCount}</li>
						</ul>
					</div>
				</a></li>
				</c:forEach>
				<c:if test="${empty list}">
					<li class="no_date">등록된 글이 없습니다.</li>
				</c:if>
			</ul>
		</div>
	</div>
</div>


<jsp:include page="/resources/include/footer.jsp"/>