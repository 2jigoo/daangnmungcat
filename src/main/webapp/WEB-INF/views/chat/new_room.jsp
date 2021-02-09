<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<jsp:include page="/resources/include/header.jsp"/>
<script src="${pageContext.request.contextPath }/resources/js/stomp.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sockjs.min.js"></script>
<script>
	var contextPath = "${pageContext.request.contextPath }";
	
	var isCreated = false;
	var chatId = 0;
	var memberId = "${loginUser.id}";
	var memberNickname = "${loginUser.nickname}";
	
	var page = 1;
	var perPage = 20;
	
	$(document).ready(function(){
		connect_for_new();
		
		var regdate = document.getElementsByClassName("regdate");
		$.each(regdate, function(idx, item) {
			var writeNow = dayjs(item.innerText).format("YYYY년 M월 D일 h:mm");
		 	item.innerHTML = writeNow;
		});
		
		$("#messageForm").on("submit", function(e) {
			e.preventDefault();
			
			var sale = {id: ${sale.id}, member: {id: "${sale.member.id}"}};
			
			if(isCreated == false) {
				$.ajax({
					url: contextPath + "/chat/room",
					type: "post",
					contentType:"application/json;charset=UTF-8",
					data: JSON.stringify(sale),
					dataType: "text",
					success: function(data) {
						console.log(data);
						chatId = data;
						
						subscribe_for_new();
						sendMessage(e);
						messageForm.addEventListener('submit', sendMessage, true);
						isCreated = true;
					},
					error: function(error) {
						console.log(error);
					}
				});
			}
		});
		
		
	});
</script>
<div>
	<article>
		<div id="chat-page">
		    <div class="chat-container">
		        <div class="chat-header">
		            <h2>
						${sale.member.nickname }
					</h2>
		        </div>
		        <div class="chat-header" style="display: flex;">
					<div style="float: left;width: calc(100% - 120px);text-align: left;">
						<a href="/joongoSale/detailList?id=$sale.id }">
  						<div style="display: inline-block; margin-right: 10px;">
  							<c:if test="${sale.thumImg eq null }">
  								<img src="/resources/images/no_image.jpg" width="80px">
  							</c:if>
  							<c:if test="${sale.thumImg ne null }">
  								<img src="/resources/${sale.thumImg }" width="80px">
  							</c:if>
							
			 		   	</div>
					    <div style="display: inline-grid">
							[${sale.saleState.label }] ${sale.title }
							<span class="dongne">${sale.dongne1.name } ${sale.dongne2.name}</span>
							<c:choose>
								<c:when test="${sale.price eq 0}">무료나눔</c:when>
								<c:otherwise>${sale.price}원</c:otherwise>
							</c:choose>
					    </div>
						</a>
					</div>
					<div style="float:  right; width: 120px; margin: auto 0;">
						<c:choose>
							<c:when test="${sale.saleState.code ne 'SOLD_OUT'}">
								<button type="button" id="sold-out-btn" class="chat-btn" style="font-size: 14px;line-height: 20px;padding: 6px 15px;">거래완료</button>
							</c:when>
							<c:otherwise>
								<c:if test="${reviewed ne true }">
									<button type="button" id="write-review-btn" class="chat-btn" style="font-size: 14px;line-height: 20px;padding: 6px 15px;">
										거래 후기
										남기기
									</button>
								</c:if>
							</c:otherwise>
						</c:choose>
				    </div>
		        </div>
		        <div class="connecting">
		          	  연결중...
		        </div>
		        <ul id="messageArea">
		        </ul>
		        <form id="messageForm" name="messageForm">
		            <div class="form-group">
		                <div class="input-group clearfix">
		                    <input type="text" name="content" id="message" placeholder="메시지를 입력하세요." autocomplete="off" class="form-control"/>
		                    <button type="submit" class="chat-btn primary">보내기</button>
		                    <label for="customFile">
		                    	<i class="far fa-image fa-2x" style="margin-left: 10px; line-height: 34px; cursor: pointer;"></i>
		                    </label>
		                    <input type="file" name="imageFile" id="customFile" accept="image/*" style="display:none;" />
		                </div>
		            </div>
		        </form>
		    </div>	
		</div>
	</article>
</div>
<script src="${pageContext.request.contextPath }/resources/js/chat_stomp.js"></script>
<jsp:include page="/resources/include/footer.jsp"/>