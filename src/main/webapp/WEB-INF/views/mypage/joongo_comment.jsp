<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>


<script>
$(function(){
	$(".review_delete").click(function(){
		if (confirm("정말 삭제하시겠습니까?") == true){
			var deleteReview = {
		    	id : $(this).data("id"),
		    }
			
			$.ajax({
	         type: "post",
	         url : "/joongo/review/delete",
	         contentType : "application/json; charset=utf-8",
	         cache : false,
	         dataType : "json",
	         data : JSON.stringify(deleteReview),
	         beforeSend : function(xhr){
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	         },
	         success:function(){
	            alert("리뷰가 삭제됐습니다.");
	            location.reload();
	         },
	         error: function(request,status,error){
	            alert('에러' + request.status+request.responseText+error);
	         }
	      })
		}
	})
})
</script>

<div id="subContent">
	<div id="pageCont" class="s-inner">
		<div class="joongo_comment" id="joongo_comment">
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
                     	<li><a href="/joongoSale/detailList?id=${commentList.sale.id}">제품 보러 가기</a></li>
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
                      <p><a href="/mypage/joongo/comment${pageMaker.makeQuery(pageMaker.startPage - 1)}&memId=${loginUser.id}">이전</a></p>
                </c:if> 
               <ul>
               
                 <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
                   <li><a href="/mypage/joongo/comment${pageMaker.makeQuery(idx)}&memId=${loginUser.id}">${idx}</a></li>
                 </c:forEach>
               </ul>
               
                 <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                   <p><a href="/mypage/joongo/comment${pageMaker.makeQuery(pageMaker.endPage + 1)}&memId=${loginUser.id}">다음</a></p>
                 </c:if> 
            </div>
         </c:forEach>
      </div>
	</div>
</div>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>