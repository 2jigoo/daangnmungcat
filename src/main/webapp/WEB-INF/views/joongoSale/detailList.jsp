<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ include file="/resources/include/header.jsp" %>

<style>

	article {
		margin : 0 auto;
	}
	
	#article{
		margin: 8% 0;
	}

	#section_img {
		position: relative;
		margin-bottom: 10px;   	
		text-align:center;		
	}
	
	#img_slider {
		postition: relative;
	}
	
	#section_div_img{
		margin: 0 auto;
	}
	
	
	#section_profile_img img
		{
		border-radius: 50px;
		width:40px;
		height:40px;

	}
	
	#section_profile, #section_description, #section_buttons, #section_goods{
		padding-left: 20%;
	}
	
	#section_profile #section_profile_img 
		{
		width:40px;
		height:40px;
		display: inline-block;
	}
	
	#section_profile #section_profile_link{
	   	display : block;
	   	padding-bottom: 30px;
	   	position : relative;
	    border-bottom: 1px solid #e9ecef;
	}
	
	#section_profile #section_profile_left {
	    display: inline-grid;
   		margin-left: 10px;
	}

	#section_profile #section_profile_left #nickname {
		    font-size: 15px;
   			font-weight: 600;
    		line-height: 1.5;
    		letter-spacing: -0.6px;
    		color: #212529;
	}
	
	#section_profile #section_profile_left #dongnename {
	    font-size: 13px;
   		 line-height: 1.46;
    	letter-spacing: -0.6px;
    	color: #212529;
	}
	
	#section_description #description_title {
    	margin-top : 50px;
    	font-size:35px;
    }
    
    #section_description #description_sub {
        margin-top: 4px;
	    font-size: 13px;
	    line-height: 1.46;
	    letter-spacing: -0.6px;
	    color: #868e96;
	    padding-bottom:5px;
	}
    
    #section_description #description_content {
	    font-size: 20px;
	    margin-bottom: 16px;
	    margin-top: 8px;
		padding-top:10px;
	}
    
    #section_description #description_count {
		font-size: 13px;
	    line-height: 1.46;
	    letter-spacing: -0.6px;
	    color: #868e96;
	   	padding-bottom: 30px;
	    border-bottom: 1px solid #e9ecef;
   	}

    #section_buttons {
	   	padding-top: 10px;
	   	padding-bottom: 5px;
   	}
	
	.lastTime {
		display: inline-block;
		color: #992124;
	}
	
	#product_list {
		width: 10%;
	}
	
</style>
<script type="text/javascript">

$(document).ready(function(){
	
	//현재시간가져오기
	var now = new Date();
	console.log(now);
		
	
	//글쓴시간 가져오기
	
	var inDate = document.getElementById('regdate').innerHTML;
	console.log("inDate >> " + inDate);
	
	
	//KST를 빼면 new Date()에서 시간 읽는거 가능해진다..
	afterStr = inDate.split('KST');
	console.log(afterStr)
	var testDate = afterStr[0]+afterStr[1]
	
	var writeNow = new Date(testDate);
	console.log(writeNow)
	
	
	//현재시간이랑 글쓴시간 비교
	var minus;
	
	if(now.getFullYear() > writeNow.getFullYear()){
		minus= now.getFullYear() - writeNow.getFullYear();
		 document.getElementsByClassName("lastTime")[0].innerHTML = minus+"년 전";
		 console.log(minus+"년 전");
	}else if(now.getMonth() > writeNow.getMonth()){
        //년도가 같을 경우 달을 비교해서 출력
        minus= now.getMonth()-writeNow.getMonth();
        document.getElementsByClassName("lastTime")[0].innerHTML = minus+"달 전";
        console.log(minus+"달 전");
    }else if(now.getDate() > writeNow.getDate()){
   	//같은 달일 경우 일을 계산
        minus= now.getDate()-writeNow.getDate();
        document.getElementsByClassName("lastTime")[0].innerHTML = minus+"일 전";
        console.log(minus+"일 전");
    }else if(now.getDate() == writeNow.getDate()){
    //당일인 경우에는 
        var nowTime = now.getTime();
        var writeTime = writeNow.getTime();
        if(nowTime>writeTime){
        //시간을 비교
            sec = parseInt(nowTime - writeTime) / 1000;
            day  = parseInt(sec/60/60/24);
            sec = (sec - (day * 60 * 60 * 24));
            hour = parseInt(sec/60/60);
            sec = (sec - (hour*60*60));
            min = parseInt(sec/60);
            sec = parseInt(sec-(min*60));
            if(hour>0){
            //몇시간전인지
                document.getElementsByClassName("lastTime")[0].innerHTML = hour+"시간 전";
                console.log(hour+"시간 전");
            }else if(min>0){
            //몇분전인지
                document.getElementsByClassName("lastTime")[0].innerHTML = min+"분 전";
                console.log(min+"분 전");
            }else if(sec>0){
            //몇초전인지 계산
                document.getElementsByClassName("lastTime")[0].innerHTML = sec+"초 전";
                console.log(sec+"초 전");
            }
        }
    }
	
	
});

</script>
<article>
<div id="article">
<c:forEach items="${list}" var="list">
<input id ="id" type="hidden" value="${list.id }"> 
<section id="section_img">
	<div class="img_slider">
		<img src="<c:url value="/resources/images/sProduct_img1.png" />" id="section_div_img">
		${list.thumImg }
	</div>
</section>
<section id="section_profile">
	<a id="section_profile_link" href="#">
		<div>
			<div>
				${list.member.grade } ${list.member.profilePic}
			</div>
			<div id="section_profile_img">
				<img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
			</div>
			<div id="section_profile_left">
				<div id="nickname">${list.member.id}</div>
				<div id="dongnename">${list.dongne1.dong1Name} ${list.dongne2.dong2Name}</div>
			</div>		
		</div>
	</a>
</section>

<section id="section_description">
		<h1 id="description_title">${list.title }</h1>
		<div id="description_sub">
			<c:if test="${list.dogCate == 'y'}">강아지 카테고리</c:if>
			<c:if test="${list.dogCate == 'n'}"></c:if>
			<c:if test="${list.catCate == 'y'}">고양이 카테고리</c:if>
			<c:if test="${list.catCate == 'n'}"></c:if> 
			· <div class="lastTime"></div> <div id="regdate">${list.regdate }</div> 
		</div>
		<h2>${list.price }원</h2>
		
		<div id="description_content">
			${list.content }
		</div>
	
		<div id="description_count"> 
			관심 ${list.heartCount} 채팅 ${list.chatCount} 조회${list.hits } 
		</div>
	
</section>
	<section id="section_buttons">
		<div>
			<button type="button"><img src="/resources/images/ico_heart.png" alt="하트"></button>
			<input type="button" value="대화로 문의하기" style="width:80%;">
		</div>
	</section>

	<section id="section_goods">
		
		<div id = "product_list">
		<ul class="product_list s-inner">
		
		
		<c:if test = "${emptylist eq 'ok'}">
				<p>이 판매자의 다른 중고 상품이 없습니다.</p>
		</c:if>
		
		<c:if test = "${emptylist ne 'ok'}" >	
				<p>이 판매자의 다른 중고상품들 입니다.</p>
		<c:forEach items="${mlist }" var="mlist">
						<!--원글 id랑 mlist.id랑 같으면 mlist.안보이게 하기 -->
						<c:if test="${param.id eq mlist.id }">
						</c:if>
			<li>
						
						 <c:if test="${param.id ne mlist.id }">
						<a href="<%=request.getContextPath()%>/detailList?id=${mlist.id}&memId=${mlist.member.id}">
						<div class="img"><img src="<c:url value="/resources/images/mProduct_img1.png" />"></div>
					<div class="txt">
				<%-- 		<p>${mlist.id }</p> --%>
						<p class="location">${mlist.dongne1.dong1Name} ${mlist.dongne2.dong2Name}</p>
						<p class="subject">${mlist.title}</p>
						<p class="price"><span>${mlist.price}</span>원</p>
						<ul>
							<li class="heart">${mlist.heartCount}</li>
							<li class="chat">${mlist.chatCount}</li>
						</ul>
					</div>	
						</a>	
					</c:if>
			</li>
			</c:forEach>
			</c:if>
		</ul>
		</div>
	</section>
</c:forEach>
</div>
</article>
<jsp:include page="/resources/include/footer.jsp"/>