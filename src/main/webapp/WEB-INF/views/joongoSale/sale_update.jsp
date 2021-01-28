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

#preview1 > img {
	width: 160px;
	height: 160px;
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
			$("select[name='dongne1.id']").append(sCont);
			//$('#dongne1').val(dong).attr("selected","selected");
		}
	});
	
	$("select[name='dongne1.id']").change(function(){
		$("select[name='dongne2.id']").find('option').remove();
		var dong1 = $("select[name='dongne1.id']").val();
		$.get(contextPath+"/dongne2/"+dong1, function(json){
			var datalength = json.length; 
			var sCont = "";
			for(i=0; i<datalength; i++){
				sCont += '<option value="' + json[i].id + '">' + json[i].name + '</option>';
			}
			$("select[name='dongne2.id']").append(sCont);	
		});
	});
	
	
		//라디오 버튼으로 카테고리 
		$(document).ready(function(){
			if("${sale.dogCate}" == "y"){
				if("${sale.catCate}" == "y"){
					$("input[name='category'][value='3']").prop('checked', true);
				}else{
				$("input[name='category'][value='1']").prop('checked', true);
				}
			}else if("${sale.dogCate}" == "n" ){
				$("input[name='category'][value='2']").prop('checked', true);
			}
			});
	
		
		
		
	$(".my_location").on("click", function(){
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
	 
	 $('#insertList').on("click", function(e){
		
		var price = $('#price').val();	
		 var num = /^[0-9]*$/;
		 
		 if($('#title').val() == ""){
			 alert('제목을 입력해주세요.');
			 return false; 
		 }else if($('#content').val() == ""){
			 alert('내용을 입력해주세요.');
			 return false; 
		 }else if(num.test(price) == false){
			 alert('가격은 숫자만 입력 가능합니다.');
			 return false; 
		 }else if($('#price').val() == ""){
			 alert('가격을 입력해주세요.');
			 return false; 
		 }else if($('#dongne1').val() == "0"){
			alert('지역을 선택하세요.');
			return false; 
		}else if($('#dongne2').val() == "0"){
			alert('동네를 선택하세요.');
			return false; 
		}
		 
	 });
	 
		$('#imgInput').on("change", handleImgs);	
		
		function insertBoard(){
			var formData = new FormData($("#boardForm")[0]);
			
			$.ajax({
				type : 'post',
				url : contextPath + "/test/insert",
				data : formData,
				processData : false,
				contentType : false,
				success : function(html) {
					alert("파일 업로드하였습니다.");
					console.log(html);
				},
				error : function(error) {
					alert("파일 업로드에 실패하였습니다.");
					console.log(error);
					console.log(error.status);
				}
			});
		}
});

function handleImgs(e) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	var sel_files = [];
	
	filesArr.forEach(function(f) {
		if(!f.type.match("image.*")){
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		sel_files.push(f);
		var reader = new FileReader();
		reader.onload = function(e){
			var img_html = "<img src=\"" + e.target.result + "\" />";
			$('#preview1').append(img_html);
		}
		reader.readAsDataURL(f);
	});
	
}


</script>
<div id="subContent">
	<h2 id="subTitle">글쓰기</h2> 	
	<div id="pageCont" class="s-inner">
		<article>
<form id="boardForm" name="boardForm" action="<%=request.getContextPath() %>/joongoSale/insert" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
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
						<select name="dongne1.id" id="dongne1">
							<option value="0">지역을 선택하세요</option>
						</select> 
						<select name="dongne2.id" id="dongne2">
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
				<td>사진</td>
				<td>
					<div id="fileArea">
						<input multiple="multiple" type="file" name="file" id="imgInput" />
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
					<input type="radio" name="category" id="category" value="1" >강아지 카테고리
					<input type="radio" name="category" id="category" value="2" style="margin-left: 15px;">고양이 카테고리
					<input type="radio" name="category" id="category" value="3" style="margin-left: 15px;">모두 포함
					<!-- <input type="hidden" name="catCate" value="y" id="catCate">
					<input type="hidden" name="dogCate" value="y" id="dogCate"> -->
				</td>
			</tr>
			<tr>
				<td>제목(상품명)</td>
				<td><input type="text" name="title" id="title" style="width: 100%" value="${sale.title }"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td>
					<div id="priceDiv"><input type="text" name="price" id="price" value="${sale.price }"></div>
					<input type="checkbox" id="checkFree" value="0">무료나눔하기
				</td>
			<tr>
			<tr>
				<td>내용</td>
				<td><textarea class="content" name="content" id="content" value="${sale.content }"></textarea>
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
					<input type="submit" id="insertList" value="글 등록하기">
				</td>
			</tr>
		</table>
		</form>
		</article>
	
	</div>
</div>
<jsp:include page="/resources/include/footer.jsp"/>