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
	}
	
	
	/* section_goods 부분 */

			.section_goods_cl {overflow:hidden;}
			.section_goods_cl > li {float:left;  margin-right:20px;}
			.section_goods_cl > li.no_date {float:none; width:100%; padding:100px 0; text-align:center;}
			.section_goods_cl .section_img {width:100%; height:285px; border:1px solid #ddd; margin-bottom:20px; background:#fff; text-align:center;}
			.section_goods_cl .section_img img {max-width:100%; max-height:100%;}
			.section_goods_cl .section_txt {position:relative; color:#111;}
			.section_goods_cl .section_txt ul {position:absolute; right:0; top:0;}
			.section_goods_cl .section_txt ul li {float:left; margin-left:10px; font-size:0.7em;}
			.section_goods_cl .section_txt ul li.section_heart {background:url(<%=request.getContextPath()%>/resources/images/ico_heart.png) no-repeat left center; padding-left:15px;}
			.section_goods_cl .section_txt ul li.section_chat {background:url(<%=request.getContextPath()%>/resources/images/ico_chat.png) no-repeat left center; padding-left:22px;}
			.section_goods_cl .section_location {font-size:0.85em;}
			.section_goods_cl .section_subject {font-size:1.125em; font-weight:500;}
			.section_goods_cl .section_price {font-size:0.93em; margin-top:10px; padding-top:10px; border-top:1px solid #ddd; text-align:right; letter-spacing:-0.05em;}
			.section_goods_cl .section_price span {font-size:1.5em; font-weight:600;}
			
			@media screen and (max-width:1199px){
				.section_goods_cl {width:100%;}
				.product_list .img {height:22vw}
			}
			
			@media screen and (max-width:1024px){
				.mProduct {padding:11% 0;}
				.mProduct .tit {font-size:2.4em; margin-bottom:6%;}
				.product_list > li {width:calc(25% - 10px); margin-right:13.33px;}
			}
			
			@media screen and (max-width:767px){
				.product_list > li {width:calc(50% - 5px); margin-right:10px;}
				.product_list > li:nth-child(even) {margin-right:0;}
				.product_list > li:nth-child(4) ~ li, .product_list > li:nth-child(2) ~ li {margin-top:5%;}
				.product_list .img {height:40vw;}
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
	
	
	$('#btnLike').on("click", function(json){
		
	});
	
});

</script>
<article>
<div id="article">
<c:forEach items="${list}" var="list">
<input id ="id" type="hidden" value="${list.member.id }"> 
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
				<div id="nickname" >${list.member.id}</div>
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
			<c:choose>
				<c:when test="${isLiked eq 1}">
					<a href="<%=request.getContextPath()%>/heart?id=${list.id}">
					<img src="<%=request.getContextPath()%>/resources/images/icon_big_empty_heart.png"/></a>
				</c:when>
				<c:when test="${isLiked ne 1}">
					<a href="<%=request.getContextPath()%>/heartNo?id=${list.id}">
					<img src="<%=request.getContextPath()%>/resources/images/icon_big_heart.png"/></a>
				</c:when>
			</c:choose>
			
 			<input type="button" value="대화로 문의하기" style="width:80%;">
		</div>
	</section>

	<section id="section_goods">
		
		<div id = "product_list">
		<ul class="section_goods_cl">
		
		
		<c:if test = "${emptylist eq 1}">
				<p>이 판매자의 다른 중고 상품이 없습니다.</p>
		</c:if>
		
		<c:if test = "${emptylist ne 1}" >	
				<p>이 판매자의 다른 중고상품들 입니다.</p>
		<c:forEach items="${mlist }" var="mlist">
						<!--원글 id랑 mlist.id랑 같으면 mlist.안보이게 하기 -->
						<c:if test="${param.id eq mlist.id }">
						</c:if>
			<li>
						
						 <c:if test="${param.id ne mlist.id }">
						<a href="<%=request.getContextPath()%>/detailList?id=${mlist.id}">
						<div class="section_img"><img src="<c:url value="/resources/images/mProduct_img1.png" />"></div>
					<div class="section_txt">
				<%-- 		<p>${mlist.id }</p> --%>
						<p class="section_location">${mlist.dongne1.dong1Name} ${mlist.dongne2.dong2Name}</p>
						<p class="section_subject">${mlist.title}</p>
						<p class="section_price"><span>${mlist.price}</span>원</p>
						<ul>
							<li class="section_heart">${mlist.heartCount}</li>
							<li class="section_chat">${mlist.chatCount}</li>
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