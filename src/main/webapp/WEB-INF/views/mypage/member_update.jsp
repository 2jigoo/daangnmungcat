<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.jsp" %>
<style>
.wrapper {margin:0 auto; padding:50px; text-align:center}
#myPic, #preview {border-radius: 50px; width:40px; height:40px;}
</style>
<script>
$(document).ready(function(){
	var contextPath = "<%=request.getContextPath()%>";

	$.get(contextPath +"/myProfilePic", function(json){
		console.log(contextPath + "/resources/" + json.path);
		if(json.path != null){
			$('#myPic').prop('src', contextPath + "/resources/" + json.path);
		}
	});
	
	$('#img_upload').on("click", function(){
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
	
	$('#img_delete').on("click", function(){
		if (confirm("프로필 사진을 삭제하시겠습니까?") == true){
			$.get(contextPath +"/deleteProfile", function(json){
				if(json == 1){
					location.reload(true);
				}
			});
		}else{   //취소
		    return;
		}
	});
	
	
        
});

function imageChange(){
	var file = document.getElementById("uploadFile").files[0]
	if (file) {
	//console.log(document.getElementById("uploadFile").files[0])
	 var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
    reader.onload = function (e) {
    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
        $('#preview').attr('src', e.target.result);
        //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
        //(아래 코드에서 읽어들인 dataURL형식)
    }                   
    reader.readAsDataURL(document.getElementById("uploadFile").files[0]);
    //File내용을 읽어 dataURL형식의 문자열로 저장
    
	}	
}
</script>
<div class="wrapper">
<input type="file" id="uploadFile" name="uploadFile" onchange="imageChange()">
	<input type="button" id="img_upload" value="변경">
	<input type="button" id="img_delete" value="삭제">
	<br>미리보기<br>
	<img id="preview">
	<br>현재 프로필 <br>
	<img id="myPic">
</div>
<jsp:include page="/resources/include/footer.jsp"/>