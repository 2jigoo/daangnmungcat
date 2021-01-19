<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/resources/include/header.jsp" %>

<script type="text/javascript">
var dongne1Id;
var dongne1Name = "${dongne1Name}"
var pageNum = "${pageMaker.cri.page}"
$(function(){
   
   var contextPath = "<%=request.getContextPath()%>";
   
   $.get(contextPath+"/dongne1", function(json){
	      var datalength = json.length; 
	      if(datalength >= 1){
	         var sCont = "";
	         for(i=0; i<datalength; i++){
	            if (json[i].name == dongne1Name){
	               sCont += '<option value="' + json[i].id + '" selected>';
	               dongne1Id = json[i].id;
	            } else {
	               sCont += '<option value="' + json[i].id + '">';
	            }
	            sCont += json[i].name;
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
	               if (json[i].name == "${dongne2Name}"){
	                  sCont += '<option value="' + json[i].id + '" selected>';
	               } else {
	                  sCont += '<option value="' + json[i].id + '">';
	               }
	               sCont += json[i].name;
	               sCont += '</option>';
	            }
	            $("select[name=dongne2]").append(sCont);   
	         });
	      }
	   }, 50);

   
   $("select[name=dongne1]").change(function(){
      if ($("select[name=dongne1]").val() == "전체 선택"){
         window.location = "<c:url value='/joongo_list/all' />";
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
            console.log(data.address);
            if(confirm("검색된 주소로 검색하시겠습니다? - "+ data.address1+" "+ data.address2) == true){
               window.location=contextPath+"/joongo_list/"+ data.address1 +"/"+ data.address2;
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
    
    
    // page - active
    $(".board_page ul li:eq("+ (pageNum - 1) +")").addClass("active")
    
    $(".dongne_btn").click(function(){
		var dongneData = {
			id: "${loginUser.id}",
			pwd: null,
			name: null,
			nickname: null,
			email: null,
			phone: null,
			dongne1: {
				id : $("select[name='dongne1']").val()
			},
			dongne2: {
				id : $("select[name='dongne2']").val()
			},
			grade:null,
			regdate: null,
			profile_text: null,
			profile_pic:null
		};
		console.log(dongneData);
    	if ($("select[name='dongne1']").val() == "전체 선택" || $("select[name='dongne2']").val() == "동네를 선택하세요"){
    		alert("저장할 동네를 검색해주세요.")
    	} else {
        	if (confirm("내 동네로 설정하시겠습니까? - "+ $("select[name='dongne1'] option:checked").text() +" "+ $("select[name='dongne2'] option:checked").text()) == true){
        		$.ajax({
        			url:contextPath+"/dongneUpdate",
        			type:"post",
        			contentType:"application/json; charset=utf-8",
        			cache:false,
        			dataType: "json",
        			data:JSON.stringify(dongneData),
        			beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
        				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        			},
        			success:function(){
        				alert("수정됐습니다.")
        	        }, 
        	        error: function(request,status,error){
        	        	alert('에러' + request.status+request.responseText+error);
        			}
        		})
        	}
    	}
    	console.log(contextPath+"/dongneUpdate")
    })
});

</script>

<div id="subContent">
	<h2 id="subTitle">중고거래 인기매물</h2>
	<div id="pageCont" class="s-inner">
		<div class="list_top">
			<!-- <button onclick="showData()" class="my_location">내 위치</button> -->
			<button class="my_location">내 위치</button>
			<div>
				<c:if test="${not empty loginUser}">
					<a href="<%=request.getContextPath()%>/joongoSale/addList">글쓰기</a>
				</c:if>	
				<select name="dongne1">
					<option>전체 선택</option>
				</select> 
				<select name="dongne2">
				</select>
				<c:if test="${not empty loginUser}">
					<p class="dongne_btn">내 동네 저장</p>
				</c:if>
			</div>
		</div>
		<div>
			<ul class="product_list s-inner">
				<c:forEach items="${list}" var="list">
				<li><a href="<%=request.getContextPath()%>/detailList?id=${list.id}">
					<div class="img"><img src="<c:url value="/resources/images/mProduct_img1.png" />"></div>
					<div class="txt">
						<p class="location">${list.dongne1.name} ${list.dongne2.name}</p>
						<p class="subject">${list.title}</p>
						<p class="price"><span>
							<c:if test="${list.price eq 0 }" >무료 나눔</c:if>
							<c:if test="${list.price ne 0 }"> ${list.price }원</c:if>
						</span></p>
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
		
		<div class="board_page">
		    <c:if test="${pageMaker.prev}">
		    	<c:choose>
		    		<c:when test="${not empty dongne2Name}">
		    			<p><a href="<%=request.getContextPath()%>/joongo_list/${dongne1Name}/${dongne2Name}${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    		</c:when>
		    		<c:when test="${not empty dongne1Name}">
		    			<p><a href="<%=request.getContextPath()%>/joongo_list/${dongne1Name}${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    		</c:when>
		    		<c:otherwise>
				    	<p><a href="<%=request.getContextPath()%>/joongo_list/all${dongne1Name}${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></p>
		    		</c:otherwise>
		    	</c:choose>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			   <c:choose>
			  		<c:when test="${not empty dongne2Name}">
			  			<li><a href="<%=request.getContextPath()%>/joongo_list/${dongne1Name}/${dongne2Name}${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  		</c:when>
			  		<c:when test="${not empty dongne1Name}">
			  			<li><a href="<%=request.getContextPath()%>/joongo_list/${dongne1Name}${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  		</c:when>
			  		<c:otherwise>
			    	<li><a href="<%=request.getContextPath()%>/joongo_list/all${dongne1Name}${pageMaker.makeQuery(idx)}">${idx}</a></li>
			  		</c:otherwise>
			 		</c:choose>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			   <c:choose>
			  		<c:when test="${not empty dongne2Name}">
			  			<p><a href="<%=request.getContextPath()%>/joongo_list/${dongne1Name}/${dongne2Name}${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  		</c:when>
			  		<c:when test="${not empty dongne1Name}">
			  			<p><a href="<%=request.getContextPath()%>/joongo_list/${dongne1Name}${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  		</c:when>
			  		<c:otherwise>
			    		<p><a href="<%=request.getContextPath()%>/joongo_list/all${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></p>
			  		</c:otherwise>
			 		</c:choose>
			  </c:if> 
		</div>
		
	</div>
</div>


<jsp:include page="/resources/include/footer.jsp"/>