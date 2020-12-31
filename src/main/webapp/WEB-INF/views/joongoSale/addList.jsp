<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ include file="/resources/include/header.jsp" %>

<style>
</style>
<script type="text/javascript">
var dongne1Id;
var dongne1Name = "${dongne1Name}"
$(function(){
	
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
			window.location = "<c:url value='/joongoSale/addList' />";
		} else {
			var dong1 = $("select[name=dongne1] option:checked").text();
			window.location = "<c:url value='/joongoSale/addList/"+ dong1 +"' />";
		}
	});
	
	$("select[name=dongne2]").change(function(){
		if ($("select[name=dongne2]").val() == "동네를 선택하세요"){
			window.location = "<c:url value='/joongoSale/addList/"+ dongne1Name +"' />";
		} else {
			var dong1 = $("select[name=dongne1] option:checked").text();
			var dong2 = $("select[name=dongne2] option:checked").text();
			 window.location = "<c:url value='/joongoSale/addList/"+ dong1 +"/"+ dong2 +"' />";
		}
	});
	
	
	$(".my_location").on("click", function(){
		navigator.geolocation.getCurrentPosition(success, fail)
	    
	    return false;
	})
	
	function success(position) { //성공시
	    var lat=position.coords["latitude"];
	    var lon=position.coords["longitude"];
	    console.log("1 : "+ lat)
	    console.log("1 : "+ lon)
	    
		var test = {lat:lat, lon:lon}
		console.log(test);
	    $.ajax({
			type:"post",
			contentType:"application/json; charset=utf-8",
			url:contextPath+"/gpsToAddress2",
			cache:false,
			dataType: "json",
			data:JSON.stringify(test),
			beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
	        success:function(data){
				console.log(data.address);
				if(confirm("검색된 주소로 검색하시겠습니다? - "+ data.address1+" "+ data.address2) == true){
					window.location=contextPath+"/joongoSale/addList/"+ data.address1 +"/"+ data.address2;
				}
			    else{
			        return ;
			    }
	        }, 
	        error: function(){
				alert("에러");
			}
		})
		console.log(contextPath+"/gpsToAddress2")
	}
	
	 function fail(err){
	    switch (err.code){
	        case err.PERMISSION_DENIED:
	        	alert("사용자 거부");
	        break;
	 
	        case err.PERMISSION_UNAVAILABLE:
	        	alert("지리정보를 얻을 수 없음");
	        break;
	 
	        case err.TIMEOUT:
	        	alert("시간초과");
	        break;
	 
	        case err.UNKNOWN_ERROR:
	        	alert("알 수 없는 오류 발생");
	        break;
	    }
	 }
	 
	 
	 $("input:radio[name=dogCate]").change(function(){
		 //라디오버튼 강아지 눌렀을때 
		 
	 });

	 
	 $('#insertList').on("click", function(json){
		 var newlist = {
			member : {
				id:'chattest1'
			},
			
			dogCate : 'y',
			catCate : 'n',
			title : $('#title').val(),
			content : $('#content').val(),
			price : $('#price').val(),			
		 	dongne1: {
		 		dong1Id : $('#result_dong1_id').val()
		 	},
		 	dongne2: {
		 		dong2Id : $('#result_dong2_id').val()
		 	}
		 };
		 	alert(JSON.stringify(newlist));
		 	
		 	
		 	
			$.ajax({
				url: contextPath + "/insert",
				type: "POST",
				contentType:"application/json; charset=UTF-8",
				dataType: "json",
				cache : false,
				data : JSON.stringify(newlist),
				beforeSend : function(xhr)
	            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
				success: function() {
					alert('완료되었습니다.');
				},
				error: function(request,status,error){
					alert('에러!!!!' + request.status+request.responseText+error);
				}
			});
			console.log(contextPath+"/insert");	
	 
	});
});
</script>
<article>
<form action="/insert" method="POST">
<div>
<table border="1">
	<colgroup>
		<col width="20%">
		<col width="80%">
	</colgroup>

	<tr>
		<td>동네</td>
		<td>
			<div id="add_location" class="s-inner">
				<div class="list_top">
					<button class="my_location">내 위치</button>
				<div>
				<select name="dongne1" id="dongne1">
					<option>시 선택</option>
				</select> 
				<select name="dongne2" id="dongne2">
				</select>
				</div>
				</div>
			</div>
			
		</td>
	</tr>
	<tr>
		<td>
			<div id="result_dong1_id">
			</div>
			<div id="result_dong2_id">
			</div>
		</td>
	
	</tr>
	
	<tr>
		<td>사진</td>
		<td><input type="image"></td>
	</tr>
	<tr>
	<tr>	
		<td>강아지 카테고리 인가요 ? </td>
		<td>
			<input type="radio" name="dogCate" id="dogCate" value="y">네! 맞아요!
			<input type="radio" name="dogCate" id="dogCate" value="n">아니에요!
		</td>
	</tr>
	<tr>	
		<td>고양이 카테고리 인가요 ? </td>
		<td>
			<input type="radio" name="catCate" id="catCate" value="y">네! 맞아요!
			<input type="radio" name="catCate" id="catCate" value="n">아니에요!
		</td>
	</tr>
	<tr>
		<td>제목(상품명)</td>
		<td><input type="text" name="title" id="title"></td>
	</tr>
	<tr>
		<td>가격</td>
		<td><input type="text" name="price" id="price"></td>
	<tr>
	<tr>
		<td>내용</td>
		<td><textarea class="content" name="content" id="content"></textarea>>
	</tr>
<!-- 	<tr>
		<td></td>
		<td>
			<select>
				<option>판매상태</option>
				<option>판매중</option>		
			</select>
			
		</td>
	</tr>
 -->	
 	<tr>
	<td colspan="2">
			<input type="button" id="insertList" value="글 등록하기">
		</td>
	</tr>
</table>
</div>
</form>
</article>
<jsp:include page="/resources/include/footer.jsp"/>