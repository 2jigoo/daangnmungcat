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
		
	/* 글쓴 시간 가져오기
	var inDate = document.getElementById('regdate').innerHTML;
	
	// KST를 빼면 new Date()에서 시간 읽는 거 가능해진다..
	afterStr = inDate.split('KST');
	var testDate = afterStr[0]+afterStr[1];
	var writeNow = new Date(testDate);
	
	 */
	
	// timeBefore(writeNow) : writeNow - 변환할 날짜 객체
	//var timeBeforeRes = timeBefore(writeNow);
	//document.getElementsByClassName("lastTime")[0].innerHTML = timeBeforeRes;
	
	var regdate = document.getElementById('regdate').innerHTML;
	var writeNow = dayjs(regdate).toDate();
	document.getElementsByClassName("lastTime")[0].innerHTML = timeBefore(writeNow);
	
	// 댓글 쓰기
	var contextPath = "<%=request.getContextPath()%>";
	$(".comment_write_btn").click(function(){
		if ($(".comment_member_id").val() == ""){
			alert("회원만 댓글쓰기가 가능합니다.")
			return false;
		}
		
		if($(".comment_content").val() == ""){
			alert("댓글내용을 입력해주세요.");
			return false;
		}
		
		var addComment = {
			sale : {
				id : $(".comment_sale_id").val()
			},
			member : {
				id : $(".comment_member_id").val()
			},
			content : $(".comment_content").val()
		}
		$.ajax({
			type: "post",
			url : contextPath+"/joongo/comment/write",
			contentType : "application/json; charset=utf-8",
			cache : false,
			dataType : "json",
			data : JSON.stringify(addComment),
			beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(){
				location.reload();
			},
			error: function(request,status,error){
				alert('에러' + request.status+request.responseText+error);
			}
		})
	})
	
	$('#btnLike').on("click", function(json){
		
	})
	
	$(".joongo_comment .info .comment_btn").one("click", function(){
		var comment_wrap = '<div class="comment_write">';
		comment_wrap += '<input type="hidden" value="'+ $(".comment_write .comment_sale_id").val() +'" class="comment_sale_id2">';
		comment_wrap += '<input type="hidden" value="${loginUser.id}" class="comment_member_id2">';
		comment_wrap += '<input type="hidden" value="'+ $(this).parent("ul").parent("div").parent("li").data("id") +'" class="comment_saleComment_id2">';
		comment_wrap += '<input type="hidden" value="'+ $(this).parent("ul").parent("div").parent("li").find(".name").text() +'" class="comment_tabMember_id2">';
		comment_wrap += '<textarea placeholder="댓글내용을 입력해주세요" class="comment_content2"></textarea>';
		comment_wrap += '<input type="button" value="등록" class="comment_write_btn2 btn">'
		comment_wrap += '</div>'
		$(this).parent("ul").parent("div").parent("li").append(comment_wrap)
	})
	
	$(".joongo_comment .info .update_btn").one("click", function(){
		var comment_wrap = '<div class="comment_write">';
		comment_wrap += '<input type="hidden" value="'+ $(this).parent("ul").parent("div").parent("li").data("id") +'" class="comment_sale_id">';
		comment_wrap += '<textarea placeholder="댓글내용을 입력해주세요" class="comment_content">';
		comment_wrap += $(this).parent("ul").parent("div").parent("li").find(".content").text().split('<br/>').join("\r\n");
		comment_wrap += '</textarea>';
		comment_wrap += '<input type="button" value="수정" class="comment_update btn">'
		comment_wrap += '</div>';
		$(this).parent("ul").parent("div").parent("li").append(comment_wrap)
	})
	
	$(".joongo_comment .info .delete_btn").click(function(){
		var deleteComment = {
			id : $(this).parent("ul").parent("div").parent("li").data("id")
		}
		console.log(deleteComment)
		$.ajax({
			type: "post",
			url : contextPath+"/joongo/comment/delete",
			contentType : "application/json; charset=utf-8",
			cache : false,
			dataType : "json",
			data : JSON.stringify(deleteComment),
			beforeSend : function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(){
				alert("삭제됐습니다.")
				location.reload();
			},
			error: function(request,status,error){
				alert('에러' + request.status+request.responseText+error);
			}
		})
	})
	
});

$(document).on("click", ".comment_write_btn2", function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	console.log($(this).closest(".comment_write").find(".comment_member_id2").val())
	if ($(this).closest(".comment_write").find(".comment_member_id2").val() == ""){
		alert("회원만 댓글쓰기가 가능합니다.")
		return false;
	}
	if ($(this).closest(".comment_write").find(".comment_content2").val() == ""){
		alert("댓글내용을 입력해주세요.")
		return false;
	}
	
	var addComment = {
		sale : {
			id : $(this).closest(".comment_write").find(".comment_sale_id2").val()
		},
		member : {
			id : $(this).closest(".comment_write").find(".comment_member_id2").val()
		},
		saleComment : {
			id : $(this).closest(".comment_write").find(".comment_saleComment_id2").val()
		},
		tagMember : {
			id : $(this).closest(".comment_write").find(".comment_tabMember_id2").val()
		},
		content : $(this).closest(".comment_write").find(".comment_content2").val()
	}
	console.log(addComment)
	$.ajax({
		type: "post",
		url : contextPath+"/joongo/comment/write",
		contentType : "application/json; charset=utf-8",
		cache : false,
		dataType : "json",
		data : JSON.stringify(addComment),
		beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(){
			location.reload();
		},
		error: function(request,status,error){
			alert('에러' + request.status+request.responseText+error);
		}
	})
});

$(document).on("click", ".comment_update", function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	if ($(this).closest(".comment_write").find(".comment_content").val() == ""){
		alert("댓글내용을 입력해주세요.")
		return false;
	}
	
	var updateComment = {
		id : $(this).closest(".comment_write").find(".comment_sale_id").val(),
		content : $(this).closest(".comment_write").find(".comment_content").val()
	}
	console.log(updateComment)
	$.ajax({
		type: "post",
		url : contextPath+"/joongo/comment/update",
		contentType : "application/json; charset=utf-8",
		cache : false,
		dataType : "json",
		data : JSON.stringify(updateComment),
		beforeSend : function(xhr){   
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(){
			alert("수정됐습니다.")
			location.reload();
		},
		error: function(request,status,error){
			alert('에러' + request.status+request.responseText+error);
		}
	})
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
				<div id="dongnename">${list.dongne1.name} ${list.dongne2.name}</div>
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
			· <div class="lastTime"></div> <div class="regdate" id="regdate">${list.regdate }</div> 
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
						<p class="section_location">${mlist.dongne1.name} ${mlist.dongne2.name}</p>
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

<div class="joongo_comment s-inner" id="joongo_comment">
	<p class="tit">댓글</p>
	<ul class="joongo_comment_list">
		<c:forEach items="${commentList}" var="commentList">
		<c:if test="${empty commentList.saleComment.id}">
		<li data-id="${commentList.id}">
		</c:if>
		<c:if test="${not empty commentList.saleComment.id}">
		<li class="reply" data-id="${commentList.id}">
		</c:if>
			<div class="user">
				<p class="img"></p>
				<p class="name">${commentList.member.id}</p>
			</div>
			<pre class="content">${commentList.content}</pre>
			<div class="info">
				<p class="date">${commentList.regdate}</p>
				<ul>
					<li class="comment_btn">답글쓰기</li>
					<c:if test="${loginUser.id == commentList.member.id}">
					<li class="update_btn">수정</li>
					<li class="delete_btn">삭제</li>
					</c:if>
				</ul>
			</div>
		</li>
		</c:forEach>
		<c:if test="${empty commentList}">
		<li class="no_comment">
			등록된 댓글이 없습니다.
		</li>
		</c:if>
	</ul>
	
	<c:forEach items="${list}" var="list">
		<div class="board_page">
		    <c:if test="${pageMaker.prev}">
				    <p><a href="<%=request.getContextPath()%>/detailList${pageMaker.makeQuery(pageMaker.startPage - 1)}&id=${list.id}#joongo_comment">이전</a></p>
		    </c:if> 
			<ul>
			
			  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    <li><a href="<%=request.getContextPath()%>/detailList${pageMaker.makeQuery(idx)}&id=${list.id}#joongo_comment">${idx}</a></li>
			  </c:forEach>
			</ul>
			
			  <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    <p><a href="<%=request.getContextPath()%>/detailList${pageMaker.makeQuery(pageMaker.endPage + 1)}&id=${list.id}#joongo_comment">다음</a></p>
			  </c:if> 
		</div>
	</c:forEach>
	
	<div class="comment_write">
		<c:forEach items="${list}" var="list">
			<input type="hidden" value="${list.id}" class="comment_sale_id">
		</c:forEach>
		<input type="hidden" value="${loginUser.id}" class="comment_member_id">
		<textarea placeholder="댓글내용을 입력해주세요" class="comment_content"></textarea>
		<input type="button" value="등록" class="comment_write_btn btn">
	</div>
</div>

</div>
</article>
<jsp:include page="/resources/include/footer.jsp"/>