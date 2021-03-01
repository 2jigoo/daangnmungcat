<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ include file="/resources/include/header.jsp" %>

<style>

   #section_img {
      position: relative;
      margin-bottom: 10px;      
      text-align:center;      
   }
   
   #img_slider {
      postition: relative;
   }
   
   #section_div_img {
      margin: 0 auto;
   }
   
   
   #section_profile_img img {
      border-radius: 50px;
      width: 50px;
      height: 50px;

   }
   
   #section_profile #section_profile_img {
      width: 50px;
      height: 50px;
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
       font-size: 14px;
       line-height: 1.46;
       letter-spacing: -0.6px;
       color: #212529;
   }
   
   #section_description #description_title {
       margin-top: 30px;
       font-size: 26px;
    }
    
    #section_description #description_sub {
       margin-top: 20px;
       /* font-size: 13px; */
       line-height: 1.46;
       letter-spacing: -0.6px;
       color: #868e96;
       padding-bottom:5px;
	}
    
	#section_description #description_content {
	    margin-bottom: 30px;
	    margin-top: 12px;
		padding-top:10px;
	}
	 
	#section_description #description_count {
		font-size: 14px;
	    line-height: 1.46;
	    letter-spacing: -0.6px;
	    color: #868e96;
	    padding-bottom: 30px;
	    border-bottom: 1px solid #e9ecef;
	}
	
	#section_buttons {
		padding-top: 10px;
		padding-bottom: 5px;
		border-bottom: 1px solid #e9ecef;
	}
	
	#section_buttons img {
		padding: 8px;
	}
	
	.lastTime {
		display: inline-block;
	}
	
	#product_list {
		border-bottom: 1px solid #e9ecef;
	}
	
	#product_list > span {
		display: block;
		margin: 30px 0;
		font-weight: 500;
		font-size: 1.25em;
	}
	
	.go_to_chat_btn {
		cursor: pointer;
		width: calc(100% - 70px);
		padding: 14px 0;
		float: right;
	    background: #ff7e15;
	    color: #fff;
	    border-radius: 4px;
	    font-size: 16px;
	    font-weight: 600;
	}
   
   /* section_goods 부분 */

         .section_goods_cl {overflow:hidden; margin-bottom: 50px;}
         .section_goods_cl > li {float:left; width:calc(25% - 15px); margin-right:20px;}
		 .section_goods_cl > li:nth-of-type(4n) {margin-right:0;}
		 .section_goods_cl > li:nth-of-type(4) ~ li {margin-top:40px;}
         .section_goods_cl > li.no_date {float:none; width:100%; padding:100px 0; text-align:center;}
         .section_goods_cl .section_img {width:100%; height:285px; border:1px solid #ddd; margin-bottom:20px; background:#fff; text-align:center;}
         .section_goods_cl .section_img img {max-width:100%; max-height:100%;  }
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
            .product_list > li:nth-of-type(even) {margin-right:0;}
            .product_list > li:nth-of-type(4) ~ li, .product_list > li:nth-child(2) ~ li {margin-top:5%;}
            .product_list .img {height:40vw;}
         }
         
         #description_title  a{
         	float: right;
         	padding-right: 10px;
		    line-height: 40px;
		    margin-left: 8px;
		    padding: 0 10px;
		    background: #353535;
		    color: #fff;
		    border-radius: 4px;
		    font-size: 16px;
         }
         
       	 #description_title #delBtn {
		    background: #ff7e15;;
         }
         
         
         /* 이미지 슬라이드 */
         .swiper-slide {
            height: 400px;
         }

         .swiper-slide img {
             max-width: 80%;
             max-height: 80%;
             min-width: 60%;
             min-height: 80%;
         }
         
         
   
</style>
<script type="text/javascript">

$(document).ready(function(){
	
	$("#delBtn").click(function(){
		if (confirm("정말 삭제하시겠습니까??") == true){
		} else{
		    return false;
		}
	})
	
	   
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
	   document.getElementById('regdate').style.display='none';
	   
   
	   $("#saleState").val("${sale.saleState.code}").prop("selected", true);
	   
	   $("#saleState").on("change", function() {
		  var originalState = "${sale.saleState.code}"; 
		  var state = $("#saleState option:selected").text();
		  var changeStateCode = $("#saleState option:selected").val();
		  
		  console.log(JSON.stringify({saleState: {label: state}}));
		  if(confirm(state + "(으)로 변경하시겠습니까?") == true) {
			  $.ajax({
				  type: "put",
			         url : "/joongo/sale/${sale.id}/state",
			         contentType : "application/json; charset=utf-8",
			         cache : false,
			         data : JSON.stringify({member: {id: "${loginUser.id}"}, saleState: {code: changeStateCode}}),
			         dataType : "json",
			         success: function(data){
			        	alert("변경되었습니다.");	
			            location.reload();
			         },
			         error: function(e){
			        	 alert("판매상태를 변경하는 중 에러가 발생했습니다.");
			        	 console.log(e);
			         }
			  });
		  } else {
			  $("#saleState").val("${sale.saleState.code}").prop("selected", true);
		  }
	   });
	   
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
   });

   $('#btnLike').on("click", function(json){
      
   });
   
   $(".joongo_comment .info .comment_btn").one("click", function(){
      var comment_wrap = '<div class="comment_write">';
      comment_wrap += '<input type="hidden" value="'+ $(".comment_write .comment_sale_id").val() +'" class="comment_sale_id2">';
      comment_wrap += '<input type="hidden" value="${loginUser.id}" class="comment_member_id2">';
      comment_wrap += '<input type="hidden" value="'+ $(this).parent("ul").parent("div").parent("li").data("id") +'" class="comment_saleComment_id2">';
      if ($(this).parent("ul").parent("div").parent("li").hasClass("reply")){
         comment_wrap += '<input type="hidden" value="'+ $(this).parent("ul").parent("div").parent("li").find(".name").text() +'" class="comment_tabMember_id2">';
      } else {
         comment_wrap += '<input type="hidden" value="" class="comment_tabMember_id2">';
      }
      comment_wrap += '<textarea placeholder="댓글내용을 입력해주세요" class="comment_content2"></textarea>';
      comment_wrap += '<input type="button" value="등록" class="comment_write_btn2 btn">'
      comment_wrap += '</div>'
      $(this).parent("ul").parent("div").parent("li").append(comment_wrap)
   });
   
   $(".joongo_comment .info .update_btn").one("click", function(){
      var comment_wrap = '<div class="comment_write">';
      comment_wrap += '<input type="hidden" value="'+ $(this).parent("ul").parent("div").parent("li").data("id") +'" class="comment_sale_id">';
      comment_wrap += '<textarea placeholder="댓글내용을 입력해주세요" class="comment_content">';
      comment_wrap += $(this).parent("ul").parent("div").parent("li").find(".content").text().split('<br/>').join("\r\n");
      comment_wrap += '</textarea>';
      comment_wrap += '<input type="button" value="수정" class="comment_update btn">'
      comment_wrap += '</div>';
      $(this).parent("ul").parent("div").parent("li").append(comment_wrap)
   });
   
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
   });
   
      
      var swiper = new Swiper('.swiper-container', {
            slidesPerView: 1, // 보일 갯수
            spaceBetween: 30, // 이미지 간 간격(px)
            // 도트
            pagination: { 
               el: '.swiper-pagination',
               clickable: true,
            },
            // 좌우 화살표
            navigation: {
               nextEl: '.swiper-button-next',
               prevEl: '.swiper-button-prev',
            },
         });

   
   
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

<c:if test="${loginUser eq null}">
$(document).on("click", ".go_to_chat_btn", function(e) {
   e.preventDefault();
   alert("로그인 후 이용해주세요.");
});
</c:if>
</script>

<div id="subContent">
	<h2 id="subTitle">중고판매글 상세보기</h2>
		<div id="pageCont" class="s-inner">
			<input id ="id" type="hidden" value="${sale.member.id }"> 
			<section id="section_img">
		         <div class="swiper-container">
		         	<div class="swiper-wrapper">
		            	<c:forEach items="${flist }" var="flist">
		                	<div class="swiper-slide"><img alt="프로필" src="<%=request.getContextPath() %>/resources/${flist.fileName}"></div>
		               	</c:forEach>
		            </div>
		            <!-- 도트 -->
		            <div class="swiper-pagination"></div>
		            
		            <!-- 좌우 화살표 -->
		            <div class="swiper-button-next"></div>
		            <div class="swiper-button-prev"></div>
		         </div>
		      </section>
	      
		      <section id="section_profile">
		         <a id="section_profile_link" href="#">
		            <div>
		               <div id="section_profile_img">
		                        <img alt="프로필" src="<%=request.getContextPath() %>/resources/${sale.member.profilePic}">
		               </div>
		               <div id="section_profile_left">
		                  <div id="nickname" >${sale.member.nickname} ${sale.member.grade }</div>
		                  <div id="dongnename">${sale.dongne1.name} ${sale.dongne2.name}</div>	
		               </div>
		            </div>
		         </a>
		         <a href="/joongo/review/list?memId=${sale.member.id}">거래후기 보기</a>
		      </section>
		      
		      <section id="section_description">
		         <div id="description_title">
		         	<span style="font-weight: 600;">
		         		<c:if test="${sale.saleState.code eq 'SOLD_OUT' }">
		         			<span style="color:lightslategray">${sale.saleState.label }</span>
		         		</c:if>
		         		<c:if test="${sale.saleState.code eq 'RESERVED' }">
		         			<span style="color:seagreen">${sale.saleState.label }</span>
		         		</c:if>
		         		${sale.title }
	         		</span>
			        <span style="float: right;">	
			         	<c:if test="${loginUser.getId() eq sale.member.id}">
			         		<select name="saleState" id="saleState" selected="selected">
				         		<c:forEach var="saleState" items="${saleStateList }">
									<option value="${saleState.code }">${saleState.label }</option>
								</c:forEach>
							</select>
			         		<a href="<%=request.getContextPath()%>/joongoSale/modiList?id=${sale.id}">수정</a>
							<a id="delBtn" href="<%=request.getContextPath()%>/joongoSale/delete?id=${sale.id}">삭제</a>
						</c:if>
					</span>
		         </div> 
		         <div id="description_sub">
		         	<c:choose>
		         		<c:when test="${sale.dogCate eq 'y' and sale.catCate eq 'y' }">멍냥</c:when>
		         		<c:when test="${sale.dogCate eq 'y' }">멍</c:when>
		         		<c:otherwise>냥</c:otherwise>
		         	</c:choose>
		            · <div class="lastTime"></div> <div class="regdate" id="regdate">${sale.regdate }</div> 
		         </div>
		         <h3>
		            <c:if test="${sale.price eq 0 }" >무료 나눔</c:if>
		            <c:if test="${sale.price ne 0 }"> ${sale.price }원</c:if>
		         </h3>
		         
		         <div id="description_content">
		            ${sale.content }
		         </div>
		      
		         <div id="description_count"> 
		            관심 ${sale.heartCount} 채팅 ${sale.chatCount} 조회${sale.hits } 
		         </div>
		         
		      </section>
		      <section id="section_buttons">
		         <div>
		            <c:choose>
		               <c:when test="${sale.hearted eq false}">
		                  <a href="<%=request.getContextPath()%>/heart?id=${sale.id}">
		                  <img src="<%=request.getContextPath()%>/resources/images/icon_big_empty_heart.png"/></a>
		               </c:when>
		               <c:otherwise>
		                  <a href="<%=request.getContextPath()%>/heartNo?id=${sale.id}">
		                  <img src="<%=request.getContextPath()%>/resources/images/icon_big_heart.png"/></a>
		               </c:otherwise>
		            </c:choose>
		            <a href="<%=request.getContextPath()%>/go-to-chat?id=${sale.id}">
		               <button class="go_to_chat_btn" type="button">채팅으로 거래하기</button>
		            </a>
		         </div>
		      </section>
		      
		      	<c:if test="${mlist.size() ne 0}">
		      		<section id="section_goods">
			         <div id = "product_list">
		             	<span>${sale.member.nickname }님의 판매 상품</span>
			            <ul class="section_goods_cl">
			               <c:forEach items="${mlist }" var="mlist">
			                  <li>
			                     <a href="<%=request.getContextPath()%>/joongoSale/detailList?id=${mlist.id}">
			                        <div class="section_img"><img src="<%=request.getContextPath()%>/resources/${mlist.thumImg}"></div>
			                        <div class="section_txt">
			                           <p class="section_location">${mlist.dongne1.name} ${mlist.dongne2.name}</p>
			                           <p class="section_subject">${mlist.title}</p>
			                           <p class="section_price">
			                           <span>
			                              <c:if test="${mlist.price eq 0 }" >무료 나눔</c:if>
			                              <c:if test="${mlist.price ne 0 }"> ${mlist.price }원</c:if>
			                           </span>
			                           </p>
			                           <ul>
			                              <li class="section_heart">${mlist.heartCount}</li>
			                              <li class="section_chat">${mlist.chatCount}</li>
			                           </ul>
			                        </div>   
			                       </a>   
			                 	</li>
			               </c:forEach>
			            </ul>
			         </div>
			      </section>
		      	</c:if>
		      
		      <div class="joongo_comment s-inner" id="joongo_comment">
		         <p class="tit">댓글 ${commentList.size() }</p>
		         <ul class="joongo_comment_list">
		            <c:forEach items="${commentList}" var="commentList">
		               <c:if test="${empty commentList.saleComment.id}">
		               <li data-id="${commentList.id}">
		               </c:if>
		               <c:if test="${not empty commentList.saleComment.id}">
		               <li class="reply" data-id="${commentList.saleComment.id}">
		               </c:if>
		                  <div class="user">
		                     <p class="img">
		                        <c:if test="${empty commentList.member.profilePic}">
		                           <img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
		                        </c:if>
		                        <c:if test="${not empty commentList.member.profilePic}">
		                           <img src="<%=request.getContextPath()%>/resources/${commentList.member.profilePic}">
		                        </c:if>
		                     </p>
		                     <p class="name">${commentList.member.id}</p>
		                  </div>
		                  <c:if test="${not empty commentList.tagMember.id}">
		                     <p class="tag">@${commentList.tagMember.id} </p>
		                  </c:if>
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
		            <input type="hidden" value="${sale.id}" class="comment_sale_id">
		            <input type="hidden" value="${loginUser.id}" class="comment_member_id">
		            <textarea placeholder="댓글내용을 입력해주세요" class="comment_content"></textarea>
		            <input type="button" value="등록" class="comment_write_btn btn">
		         </div>
		      </div>
		   
	</div>
</div>
<jsp:include page="/resources/include/footer.jsp"/>