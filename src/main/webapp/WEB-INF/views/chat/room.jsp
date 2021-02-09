<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<jsp:include page="/resources/include/header.jsp"/>
<script src="${pageContext.request.contextPath }/resources/js/stomp.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sockjs.min.js"></script>
<script>
	var contextPath = "${pageContext.request.contextPath }";
	
	var chatId = ${chat.id};
	var memberId = "${loginUser.id}";
	var memberNickname = "${loginUser.nickname}";
	
	var page = 1;
	var perPage = 20;
	
	$(document).ready(function(){
		
		/* 글쓴 시간 비교시간 변경 */
		var regdate = document.getElementsByClassName("regdate");
		$.each(regdate, function(idx, item) {
			var writeNow = dayjs(item.innerText).format("YYYY년 M월 D일 h:mm");
		 	item.innerHTML = writeNow;
		});
		
		connect();
		messageForm.addEventListener('submit', sendMessage, true);
		
		$("#chat-loading-btn").click(function() {
			$.ajax({
				url: "/api/chat/message",
				type: "get",
				data: {id: chatId, page: ++page},
				/* beforeSend : function(xhr){xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");}, */
				dataType: "json",
				success: function(data) {
					console.log(data);
					console.log(data.length);
					if(data.length != 0) {
						var li_str = "";
						
						$.each(data, function(idx, msg) {
							if (msg.member.id == memberId) {
								// 나
								li_str += "<li class='chat-message me' msg_id='" + msg.id + "' sender='" + msg.member.id + "'>";
								li_str += "<div class='chat-message me bubble'><p>";
								if(msg.content != null) {
									li_str += msg.content;
								} else {
									li_str += "<img src='" + contextPath + "/" + msg.image + "'>";
								}
								li_str += "</p><span class='read_yn' read_yn='" + msg.readYn + "'>";
								li_str += (msg.readYn == 'y' ? "읽음" : "읽지 않음") + "</span>";
								li_str += "<span class='regdate' regdate='" + msg.regdate + "'>" + dayjs(msg.regdate).format("YYYY년 M월 D일 h:mm") + "</span></div></li>";
							} else {
								// 너
								li_str += "<li class='chat-message you' msg_id='" + msg.id + "' sender='" + msg.member.id +"'>";
								li_str += "<div class='chat-message you profile_img'>";
								li_str += "<a href='" + contextPath + "/member/profile?id=" + msg.member.id + "'>";
								li_str += "<img alt='개인프로필' src='" + contextPath + "/resources/" + msg.member.profilePic + "'>";
								li_str += "</a></div>";
								li_str += "<div class='chat-message you bubble'><span class='nickname'>" + msg.member.nickname + "</span>";
								if(msg.content != null) {
									li_str += msg.content;
								} else {
									li_str += "<img src='" + contextPath + "/" + msg.image + "'>";
								}
								li_str += "</p>";
								li_str += "<span class='regdate' regdate='" + msg.regdate + "'>" + dayjs(msg.regdate).format("YYYY년 M월 D일 h:mm") + "</span></div></li>";
							}
						});
						
						console.log(li_str);
						$(".loading-btn").after(li_str);
						
						if(data.length < perPage) {
							$("#chat-loading-btn").remove();
						}
					} else {
						$("#chat-loading-btn").remove();
					}
				}
			});
		});
		
		
		$("#sold-out-btn").click(function() {
			if (confirm("거래완료 처리하시겠습니까?") == true) {
				var url = "/chat/" + chatId + "/sold-out";
				$.ajax({
					url: url,
					type: "post",
					dataType: "json",
					success: function(data) {
						if(memberId == "${chat.buyer.id}") {
							if(confirm("지금 바로 거래 후기를 남기시겠습니까?") == true) {
								location.href = "/joongo/review/write?saleId=" + data;
							}
						} else {
							alert("거래가 완료되었습니다!");
						}
					},
					error: function(e) {
						console.log(e);
						alert(JSON.parse(e.responseText));
					}
				});
			};
		});
		
		$("#write-review-btn").click(function() {
			if (confirm("해당 판매글에 대한 후기를 남기시겠습니까?") == true) {
				location.href = "/joongo/review/write?saleId=${chat.sale.id}";
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
			        	<c:if test="${chat.sale.member.id eq loginUser.id }">
			        		<a href="${pageContext.request.contextPath }/member/profile?id=${chat.sale.member.id}">
								${chat.sale.member.nickname }
							</a>
						</c:if>
						<c:if test="${chat.buyer.id eq loginUser.id }">
							<a href="${pageContext.request.contextPath }/member/profile?id=${chat.buyer.nickname }">
								${chat.buyer.nickname }
							</a>
						</c:if>
					</h2>
				</div>
					
				<div class="chat-header" style="display: flex;">
					<div style="float: left;width: calc(100% - 120px);text-align: left;">
						<a href="/joongoSale/detailList?id=${chat.sale.id }">
  						<div style="display: inline-block; margin-right: 10px;">
  							<c:if test="${chat.sale.thumImg eq null }">
  								<img src="/resources/images/no_image.jpg" width="80px">
  							</c:if>
  							<c:if test="${chat.sale.thumImg ne null }">
  								<img src="/resources/${chat.sale.thumImg }" width="80px">
  							</c:if>
							
			 		   	</div>
					    <div style="display: inline-grid">
							[${chat.sale.saleState.label }] ${chat.sale.title }
							<span class="dongne">${chat.sale.dongne2.dongne1.name } ${chat.sale.dongne2.name}</span>
							<c:choose>
								<c:when test="${chat.sale.price eq 0}">무료나눔</c:when>
								<c:otherwise>${chat.sale.price}원</c:otherwise>
							</c:choose>
					    </div>
						</a>
					</div>
					<div style="float:  right; width: 120px; margin: auto 0;">
						<c:choose>
							<c:when test="${chat.sale.saleState.code ne 'SOLD_OUT'}">
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
		        	<c:if test="${chat.messages.size() eq 20}">
			        	<li class="chat-message loading-btn" id="chat-loading-btn">
			        		<div class="chat-message">더 읽어오기</div>
			        	</li>
		        	</c:if>
		        	<c:forEach items="${chat.messages }" var="msg">
		        	<c:choose>
			        	<c:when test="${msg.member.id eq loginUser.id }">
							<c:set var="sender" value="me" />
						</c:when>
						<c:otherwise>
							<c:set var="sender" value="you" />
						</c:otherwise>
					</c:choose>
					<li class="chat-message ${sender }" msg_id="${msg.id }" sender="${msg.member.id }">
						<!-- <i style="background-color: rgb(57, 187, 176);">*</i> -->
							<c:choose>
								<c:when test="${sender eq 'you' }">
									<div class="chat-message ${sender } profile_img">
										<a href="${pageContext.request.contextPath }/member/profile?id=${msg.member.id}">
										<c:choose>
											<c:when test="${msg.member.profilePic eq null}">
												<img alt="기본프로필" src="<%=request.getContextPath() %>/resources/images/default_user_image.png">
											</c:when>
											<c:otherwise>
												<img alt="개인프로필" src="<%=request.getContextPath() %>/resources/upload/profile/${msg.member.profilePic}">
											</c:otherwise>
										</c:choose>
										</a>
									</div>
								</c:when>
								<c:otherwise>
									<!-- 내가 보낸 메시지 -->
								</c:otherwise>
							</c:choose>
						<div class="chat-message ${sender } bubble">
							<c:if test="${sender eq 'you' }">
								<span class="nickname">${msg.member.nickname }</span>
							</c:if>
							<c:if test="${msg.image ne null}">
								<img class="img-file" src="<%=request.getContextPath() %>/resources/upload/chat/${chat.id}/${msg.image }">
							</c:if>
							<p>${msg.content }</p>
							<c:if test="${sender eq 'me' }">
								<span class="read_yn" read_yn="${msg.readYn }">
									<c:if test="${msg.readYn eq 'y' }">읽음</c:if>
									<c:if test="${msg.readYn eq 'n' }">읽지 않음</c:if>
								</span>
							</c:if>
							<span class="regdate" regdate="${msg.regdate }"> ${msg.regdate } </span>
						</div>
					</li>
					</c:forEach>
		        </ul>
		        <form id="messageForm" name="messageForm" method="post" enctype="multipart/form-data">
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
	<%-- <article>
		<div id="article">
			<section class="section_chat">
				${chat.sale.title } <br>
				${chat.sale.saleState.label } <br>
				${chat.sale.price } <br>
				<hr>
				<c:forEach items="${chat.messages }" var="msg">
					${msg.member.id } <br>
					${msg.member.nickname } <br>
					${msg.content } <br>			
					<javatime:format value="${msg.regdate }" pattern="yyyy-MM-dd HH:mm:ss" /> <br>			
					${msg.image } <br>			
					${msg.readYn } <br>					
					<br>
				</c:forEach>
			</section>
		</div>
	</article> --%>
	
</div>
<script src="${pageContext.request.contextPath }/resources/js/chat_stomp.js"></script>
<jsp:include page="/resources/include/footer.jsp"/>