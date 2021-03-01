<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ include file="/WEB-INF/views/include/header.jsp" %>

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

#preview1 > img, #preview1 > a > img {
	width: 160px;
	height: 160px;
}

#preview2 > a > img, #preview2  > img  {
	width: 160px;
	height: 160px;
	float: left;
}

#hidden{
	color:#ff7e15;
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
		}
			//$('#dongne1').val(dong).attr("selected","selected");
		var resDong = $('#dongne1 option:contains('+ dong +')').val();
		setTimeout(function(){
	         $.get(contextPath+"/dongne2/"+ resDong, function(json){
	            var datalength = json.length; 
	            var sCont = "";
	            for(i=0; i<datalength; i++){
	               if (json[i].name == nae){
	                  sCont += '<option value="' + json[i].id + '" selected>';
	                  $('#dongne1').val(resDong).attr("selected","selected");
	               } else {
	                  sCont += '<option value="' + json[i].id + '">';
	               }
	               sCont += json[i].name;
	               sCont += '</option>';
	            }
	            $("select[name='dongne2.id']").append(sCont);
	            var resNae =  $('#dongne2 option:contains('+ nae +')').val();
	            $("select[name='dongne2.id']").val(resNae).attr("selected", "selected");
	         });
	   }, 50);  

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
	

	$("select[name='saleState']").change(function(){
		var state = $("select[name='saleState']").val();
		if(state == 3){
			$('#hidden').css({
			   display: ""
			});
		}
	});
	
		$(document).ready(function(){
			// 판매상태
			$.ajax({
				type : 'get',
				url : contextPath + "/joongo/sale-state",
				success : function(list) {
					console.log(list);
					loadSaleStatesBox(list);
				},
				error : function(error) {
					console.log(error);
				}
			});
		
		
		
		
		//라디오 버튼으로 카테고리 
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
	         url:contextPath+"/gpsToAddress",
	         cache:false,
	         dataType: "json",
	         data:JSON.stringify(test),
	         beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	         },
	           success:function(data){
	            console.log(data);
	            if(confirm("검색된 주소로 검색하시겠습니다? - "+ data.address1+" "+ data.address2) == true){
	            	var buttonDong = $('#dongne1 option:contains('+ data.address1 +')').val();
				       $('#dongne1').val(buttonDong).attr("selected","selected");
						setTimeout(function(){
				         $.get(contextPath+"/dongne2/"+ buttonDong, function(json){
				            var datalength = json.length; 
				            var sCont = "";
				            for(i=0; i<datalength; i++){
				               if (json[i].name == data.address2){
				                  sCont += '<option value="' + json[i].id + '" selected>';
				                  $('#dongne1').val(buttonDong).attr("selected","selected");
				               } else {
				                  sCont += '<option value="' + json[i].id + '">';
				               }
				               sCont += json[i].name;
				               sCont += '</option>';
				            }
				            $("select[name='dongne2.id']").append(sCont);
				            var buttonNae =  $('#dongne2 option:contains('+ data.address2 +')').val();
				            $("select[name='dongne2.id']").val(buttonNae).attr("selected", "selected");
				         });
				   }, 50); 
	            }
	             else{
	                 return ;
	             }
	           }, 
	           error: function(){
	            alert("에러");
	         }
	      })
	      console.log(contextPath+"/gpsToAddress")
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
	 
	 $('#update').on("click", function(e){
		
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
		}else if($('#thumImgInput').val() == "" && $('.checkThum').length == 0){
			alert("대표사진 업로드는 필수입니다.");
			return false;
		}
	});
	 
	 
	 $("#thumImgInput").on("click", function(){
		    if($('.checkThum').length > 0){
		    	alert("기존 대표사진 삭제 후 추가하세요.");
		    	return false;
		    } 
		})
	 
	 
	 
	 //클릭한 사진 db에서 삭제
	 $("#sale_pic_delete_btn").click(function(){
		if (confirm("정말 삭제하시겠습니까??") == true){
		} else{
		    return false;
		}
	})
	 
	 
	$('#imgInput').on("change", handleImgs);	
	
});

function loadSaleStatesBox(list) {
	var box = '';
	
	$.each(list, function(idx, item) {
		box += '<option value="' + item.code + '">' + item.label + '</option>';
	});
	
	$("select[name='saleState']").append(box);
	$('#saleState').val("${sale.saleState}").attr("selected", "selected");
}


function handleImgs(e) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	var sel_files = [];
	
	var index=0;
	filesArr.forEach(function(f) {
		if(!f.type.match("image.*")){
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		sel_files.push(f);
		var reader = new FileReader();
		reader.onload = function(e){
			var img_html = "<a href='#this' name='delete' class='btn'> <img src=\"" + e.target.result + "\" /></a>";
			$('#preview1').append(img_html);
			
			$("a[name='delete']").on("click",function(e){
				$(this).remove();
			})
		}
		reader.readAsDataURL(f);
	});
	
}

function handleThumImgs(){
	var file = document.getElementById("thumImgInput").files[0]
	if(file){
		console.log(document.getElementById("thumImgInput").files[0])
		 var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
	    reader.onload = function (e) {
	    //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
	        $('#productImg1').attr('src', e.target.result);
	        //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
	        //(아래 코드에서 읽어들인 dataURL형식)
	    }                   
	    reader.readAsDataURL(document.getElementById("thumImgInput").files[0]);
	    //File내용을 읽어 dataURL형식의 문자열로 저장
		}	
}



</script>
<div id="subContent">
	<h2 id="subTitle">글 수정하기</h2> 	
	<div id="pageCont" class="s-inner">
		<article>
<form id="modifyForm" name="modifyForm" action="<%=request.getContextPath() %>/joongoSale/modify" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" name="id" value="${param.id}">
		<table style="width: 800px; table-layout: fixed;">
			<tr>
				<td>
					<select name="saleState" id="saleState">
					</select>
					<a id="hidden" style="display:none;" href="거래후기" onclick="window.open(this.href, '_blank', 'width=가로사이즈px,height=세로사이즈px,toolbars=no,scrollbars=no'); return false;">거래후기 남기기</a>
				</td>
			</tr>
			<tr>
				<td width="300px;">아이디</td>
				<td width="500px;">
					<input type="text" id="memId" value="${loginUser.getId()}" readonly="readonly" style="border: none;">
					<input type="text" id="dongName" style="display: none;" value="${sale.dongne1.name}">
					<input type="text" id="naeName" style="display: none;" value="${sale.dongne2.name}">
				</td>
					
			</tr>
			<tr>
				<td>동네</td>
				<td>
					<div id="add_location" class="s-inner">
						<select name="dongne1.id" id="dongne1" >
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
				<td>대표 사진<br>*대표사진은1장만 추가가능</td>
				<td>
					<div id="thumFileArea">
						<input type="file" name="thum" id="thumImgInput" accept="image/*" onchange="handleThumImgs()"/>
						<img id="productImg1">
						<div id="preview"></div>
						<c:forEach items="${flist }" var="flist" begin="0" end="0">
							<div id="preview2">
							<c:if test="${ not empty thumImg.thumName}">
								<a href="<%=request.getContextPath()%>/joongoSale/pic/delete?id=${param.id }&fileName=${flist.fileName}" id="sale_pic_delete_btn" class="checkThum"><img src="<%=request.getContextPath()%>/resources/${thumImg.thumName}"></a></c:if>
							</div>
					
						</c:forEach>
					</div>
				</td>
			</tr>
			
			<tr>
				<td>사진<br>*사진 클릭시삭제가능</td>
				<td>
					<div id="fileArea">
						<input multiple="multiple" type="file" name="file" id="imgInput" />
						<div id="preview1"></div>
					<c:forEach items="${flist }" var="flist" begin="1">
						<div id="preview2"><a href="<%=request.getContextPath()%>/joongoSale/pic/delete?id=${param.id }&fileName=${flist.fileName}" id="sale_pic_delete_btn"><img alt="상품사진" src="<%=request.getContextPath()%>/resources/${flist.fileName}"></a></div>
					</c:forEach>
					</div>
				</td>
			</tr>
			<tr>
			<tr>	
				<td>카테고리</td>
				<td>
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
				<td><textarea class="content" name="content" id="content">${sale.content }</textarea>
			</tr>
			
		 	<tr>
				<td colspan="2">
					<input type="submit" id="update" value="글 수정하기">
				</td>
			</tr>
		</table>
		</form>
		</article>
	
	</div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>