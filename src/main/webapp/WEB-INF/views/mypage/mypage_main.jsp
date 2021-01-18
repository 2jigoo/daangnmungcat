<%@page import="daangnmungcat.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:50px; text-align:center}
</style>
<script>
$(document).ready(function(){
	var contextPath = "<%=request.getContextPath()%>";

	$.get(contextPath +"/myProfilePic", function(json){
		console.log(contextPath + "/resources/" + json.path);
		$('#myPic').attr('src', contextPath + "/resources/" + json.path);
	});
	
	$('#upload').on("click", function(){
        var formData = new FormData();
        var file = $("input[name='uploadFile']")[0].files;
        for(var i=0; i<file.length; i++){
           console.log(file[i]);
           formData.append('uploadFile', file[i]);
        }
        
        console.log('file >> ' + file);
        
        for(var pair of formData.entries()) {
              console.log(pair[0]+ ', '+ pair[1]); 
        }
    	
    	$.ajax({
    		url: contextPath + "/uploadProfile",
    		type: "post",
    		enctype: 'multipart/form-data',
    		data: formData,
    		processData: false,
    		contentType: false, //multipart-form-data로 전송
    		cache: false,
    		success: function(res) {
    			console.log(res);
    			alert('전송');
    		},
    		error: function(request,status,error){
    			alert('에러' + request.status+request.responseText+error);
    		}
    	});
    });
	
	
	
        
});

function imageChange(){
	var file = document.getElementById("uploadFile").files[0]
	if (file) {
	//console.log(document.getElementById("uploadFile").files[0])
	 var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
    reader.onload = function (e) {
    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
        $('#productImg').attr('src', e.target.result);
        //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
        //(아래 코드에서 읽어들인 dataURL형식)
    }                   
    reader.readAsDataURL(document.getElementById("uploadFile").files[0]);
    //File내용을 읽어 dataURL형식의 문자열로 저장
    
	}	
}
</script>
<div class="wrapper">
프로필 업로드
<input type="file" id="uploadFile" name="uploadFile" onchange="imageChange()">
	<input type="button" id="upload" value="변경">
	<img id="productImg">
	<div id="preview">
	</div>
	<br>
	<br>
<br>
내 프로필 <br>
<img id="myPic">	
</div>
<jsp:include page="/resources/include/footer.jsp"/>