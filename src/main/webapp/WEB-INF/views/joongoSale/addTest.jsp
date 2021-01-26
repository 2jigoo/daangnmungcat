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
	 
		$('#imgInput').on("change", handleImgs);
		
		
	
	});
	
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
	 /* $("#boardForm").ajaxForm({
			url		: contextPath + "/test/insert",
			enctype	: "multipart/form-data",
			cache   : false,
	        async   : true,
			type	: "POST",					 	
			success : function(obj) {
				alert("성공");
				console.log(obj);
		    },	       
		    error 	: function(xhr, status, error) {}
		    
	    }).submit(); */
	
	}
		

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
		<form id="boardForm" name="boardForm" action="<%=request.getContextPath() %>/test/insert" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<article>
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
					<input type="text" name="dongne1.id" id="dongne1" value="1">
					<input type="text" name="dongne2.id" id="dongne2" value="1">
			</tr>
			
			<tr>
				<td>사진</td>
				<td>
					<div id="fileArea">
						<input multiple="multiple" type="file" name="file" id="imgInput" accept="image/*"/>
						<img id="productImg1">
						<div id="preview1"></div>
					</div>
				</td>
			</tr>
			<tr>
			<tr>	
				<td>카테고리</td>
				<td>
					<input type="text" name="catCate" value="y" id="catCate">
					<input type="text" name="dogCate" value="y" id="dogCate">
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
					<input type="checkbox" id="checkFree" value="0">무료나눔하기
				</td>
			<tr>
			<tr>
				<td>내용</td>
				<td><textarea class="content" name="content" id="content"></textarea>
			</tr>
			
		 	<tr>
				<td colspan="2">
					<input type="submit" id="insertList" value="글 등록하기">
			</tr>
		</table>
		</article>	
	</form>
	</div>
</div>
<jsp:include page="/resources/include/footer.jsp"/>