<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ include file="/resources/include/header.jsp" %>

<style>
td, th {
	word-break: keep-all;
}

table {
 border-collapse: separate;
  border-spacing: 0 10px;
  height: auto;
}

textarea {
	width: 100%;
	height: 200px;
}

</style>
<script type="text/javascript">
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
		var dong = document.getElementById("dongName").value
		var nae = document.getElementById("naeName").value
        //	$('#dongne1').val(dong).prop("selected",true);
       // 	$('#dongne2').val(nae).prop("selected",true);
	
	$.get(contextPath+"/dongne1", function(json){
		console.log(json)
		var datalength = json.length; 
		if(datalength >= 1){
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<option value="' + json[i].id + '">' + json[i].name + '</option>';
			}
			$("select[name=dongne1]").append(sCont);
			//$('#dongne1').val(dong).attr("selected","selected");
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
	
	
	$("input:radio[name=category]").change(function(){
			if($("input:radio[name=category]:checked").val() == '1'){
				//alert("강아지 선택");
				$('#catCate').attr('value','n');
			}else if($("input:radio[name=category]:checked").val() == '2'){
				//alert("고양이 선택");
				$('#catCate').attr('value','y');
				$('#dogCate').attr('value','n');
			}else{
				//alert("모두 선택");
			}
	});
	
	
	$(".my_location").on("click", function(){z
		navigator.geolocation.getCurrentPosition(success, fail)
	    
	    return false;
	})
	
	 
	 $('#checkFree').change(function(e){
		 console.log(this);
		 console.log(e);
	        if(this.checked){
	            $('#priceDiv').fadeOut('fast');
	        	$('#price').prop('value', 0);
	        }else{
	            $('#priceDiv').fadeIn('fast');
	        }
	    });
	
	 
	 $('#insertList').on("click", function(json){
		var price = $('#price').val();	
		 var num = /^[0-9]*$/;
		 
		 if($('#title').val() == ""){
			 alert('제목을 입력해주세요.');
			 return; 
		 }else if($('#content').val() == ""){
			 alert('내용을 입력해주세요.');
			 return;
		 }else if(num.test(price) == false){
			 alert('가격은 숫자만 입력 가능합니다.');
			 return;
		 }else if($('#price').val() == ""){
			 alert('가격을 입력해주세요.');
		 	return;
		 }else if($('#dongne1').val() == "0"){
			alert('지역을 선택하세요.');
			return;
		}else if($('#dongne2').val() == "0"){
			alert('동네를 선택하세요.');
			return;
		}

		 
		 var newlist = {
			member : {
				id : $('#memId').val()
			},
			dogCate : $('#dogCate').val(),
			catCate : $('#catCate').val(),
			title : $('#title').val(),
			content : $('#content').val(),
			price : $('#price').val(),			
			dongne1: {
		 		id : $('#dongne1').val()
		 	},
		 	dongne2: {
		 		id : $('#dongne2').val()
		 	}
		};
		 
		 	//alert(JSON.stringify(newlist));
		 	
		 	
			$.ajax({
				url: contextPath + "/joongoSale/insert",
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
					window.location.replace(contextPath+"/joongo_list");
				},
				error: function(request,status,error){
					alert('에러!!!!' + request.status+request.responseText+error);
				}
			});
			console.log(contextPath+"/insert");	
	 
	});
	 
		//자바스크립트에서 DOM을 가져오기(문서객체모델 가져오기) -> 한번 다 읽고나서 
		var form = document.forms[0]; //젤 첫번째 form을 dom으로 받겠다.
		
		var addFileBtn = document.getElementById("addFileBtn");
		var delFileBtn = document.getElementById("delFileBtn");
		var fileArea = document.getElementById("fileArea");
		var cnt = 1;
		
		
		//업로드input 미리만들지 않고 필요한 만큼 증가
		$("#addFileBtn").on("click", function() {
			if (cnt < 10) {
				cnt++;
				var element = document.createElement("input");
				element.type = "file";
				element.name = "upfile" + cnt;
				element.id = "upfile" + cnt;
				var element2 = document.createElement("img");
				element2.id = "productImg"+cnt;
				var element3 = document.createElement('div');
				element3.setAttribute("id", "preview"+cnt);

				fileArea.appendChild(element);
				fileArea.appendChild(element2);
				fileArea.appendChild(element3);
				fileArea.appendChild(document.createElement("br"));
				
			} else {
				alert("파일은 10개까지 추가 가능합니다.");
			}
 
		});
		
		$("#delFileBtn").on("click", function() {
			if (cnt > 1) {
				cnt--;
				var inputs = fileArea.getElementsByTagName('input');
				var imgs = fileArea.getElementsByTagName('img');
				var divs = fileArea.getElementsByTagName('div');
				var brArr = fileArea.getElementsByTagName('br');
				fileArea.removeChild(brArr[brArr.length-1]);
				fileArea.removeChild(imgs[imgs.length-1]);
				fileArea.removeChild(divs[divs.length-1]);
				fileArea.removeChild(inputs[inputs.length-1]);
			} else {
				alert("상품 사진 최소 1개는 업로드 필요합니다.");
			}

		});

		
});


</script>
<div id="subContent">
	<h2 id="subTitle">글쓰기</h2> 	
	<div id="pageCont" class="s-inner">
		<article>
		<form action="/insert" method="POST">
		<table style="width: 800px; table-layout: fixed;">
			<tr>
				<td width="300px;">아이디</td>
				<td width="500px;">
					<input type="text" id="memId" value="${loginUser.getId()}" readonly="readonly" style="border: none;">
					<input type="text" id="dongName" style="display: none;" value="${loginUser.getDongne1().getId()}">
					<input type="text" id="naeName" style="display: none;" value="${loginUser.getDongne2().getId()}">
				</td>
					
			</tr>
			<tr>
				<td>동네</td>
				<td>
					<div id="add_location" class="s-inner">
						<select name="dongne1" id="dongne1">
							<option value="0">지역을 선택하세요</option>
						</select> 
						<select name="dongne2" id="dongne2">
							<option value="0">동네를 선택하세요</option>
						</select>
						<div class="list_location">
							<button class="my_location">내 위치</button>
						<div>
						</div>
						</div>
					</div>
				</td>
			</tr>
			
			<tr>
				<td>사진 추가 / 제거 <br>
					<input type="button" value="파일추가" id="addFileBtn">
					<input type="button" value="파일제거" id="delFileBtn">
				</td>
				<td>
					<div id="fileArea">
						<input type="file" id="upfile1" name="upfile1" onchange="imageChange()">
						<img id="productImg1">
						<div id="preview1"></div>
					</div>
				</td>
			</tr>
			<tr>
			<tr>	
				<td>카테고리</td>
				<td>
				<!-- 	<select name="dogCate" id="dogCate" >
						<option value="">카테고리를 선택하세요.</option>
						<option value="y">강아지 카테고리</option>
						<option value="n">고양이 카테고리 </option>
						<option value="y"> 모두 포함 </option>
					</select> -->
					<input type="radio" name=category id="category" value="1" checked="checked">강아지 카테고리
					<input type="radio" name="category" id="category" value="2" style="margin-left: 15px;">고양이 카테고리
					<input type="radio" name="category" id="category" value="3" style="margin-left: 15px;">모두 포함
					<input type="hidden" name="catCate" value="y" id="catCate">
					<input type="hidden" name="dogCate" value="y" id="dogCate">
				</td>
			</tr>
			<tr>
				<td>제목(상품명)</td>
				<td><input type="text" name="title" id="title" style="width: 100%"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td>
					<div id="priceDiv"><input type="text" name="price" id="price"></div>
					<input type="checkbox" id="checkFree" name="price" value="0">무료나눔하기
				</td>
			<tr>
			<tr>
				<td>내용</td>
				<td><textarea class="content" name="content" id="content"></textarea>
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
		</form>
		</article>
	
	</div>
</div>
<jsp:include page="/resources/include/footer.jsp"/>