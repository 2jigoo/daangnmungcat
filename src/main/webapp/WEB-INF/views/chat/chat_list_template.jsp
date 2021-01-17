<c:forEach items="${list }" var="chat">
	<section class="section_chat">
		<a id="section_chat_link" href="${pageContext.request.contextPath }/chat/${chat.id} ">
			<div class="section_chat_profile_img">
				<c:choose>
					<c:when test="${chat.sale.member.profilePic eq null}">
						<img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
					</c:when>
					<c:otherwise>
						<img alt="개인프로필" src="<%=request.getContextPath() %>/resources/upload/profile/${chat.sale.member.profilePic}">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="section_chat_left">
				<div class="user_info" >
					<span class="nickname">
						<c:choose>
							<c:when test="${chat.buyer.id eq loginUser.id }">
								${chat.sale.member.nickname }
							</c:when>
							<c:otherwise>
								${chat.buyer.nickname }
							</c:otherwise>
						</c:choose>
					</span>
					${chat.sale.dongne2.dongne1.name } ${chat.sale.dongne2.name}
					/ <span class="regdate" regdate="${chat.latestDate }"> ${chat.latestDate }</span>
				</div>
				<div class="dongnename">${chat.messages[0].content }</div>
			</div>		
		</a>
	</section>
</c:forEach>