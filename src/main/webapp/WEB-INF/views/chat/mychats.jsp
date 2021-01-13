<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="javatime" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/resources/include/header.jsp"/>
<style>
	article {
		margin : 0 auto;
	}
	
	#article {
		padding-left: 20%;
		padding-right: 20%;
	    margin: 60px 0;
	}

	img {
	    border: 0;
	    font-size: 0;
	    vertical-align: top;
    }
    
	.section_chat {
		margin-bottom: 24px;
	}
	
	.section_chat .section_chat_profile_img {
	    width: 60px;
	    height: 60px;
	    display: inline-block;
	}
	
	.section_chat_profile_img img {
	    border-radius: 60px;
	    width: 60px;
	    height: 60px;
	}

	.section_chat .section_chat_link{
	   	display : block;
	   	padding-bottom: 30px;
	   	position : relative;
	    border-bottom: 1px solid #e9ecef;
	}
	
	.section_chat .section_chat_left {
	    display: inline-grid;
   		margin-left: 10px;
	}

	.section_chat .section_chat_left .user_info {
		    font-size: 14px;
   			/* font-weight: 600; */
    		line-height: 1.5;
    		/* letter-spacing: -0.6px; */
    		color: #9e9e9e;
	}
	
	.section_chat .section_chat_left .user_info .nickname {
		    font-size: 16px;
   			font-weight: 600;
    		line-height: 1.5;
    		/* letter-spacing: -0.6px; */
    		color: #212529;
	}
	
	.section_chat .section_chat_left .dongnename {
	    font-size: 16px;
   		line-height: 2;
    	/* letter-spacing: -0.6px; */
    	color: #212529;
	}
	
	.section_chat .section_chat_left .message {
	
	}
</style>
<div>
	<article>
		<div id="article">
			<c:forEach items="${list }" var="chat">
				<section class="section_chat">
					<a id="section_chat_link" href="#">
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
								${chat.sale.dongne2} / <javatime:format value="${chat.latestDate }" pattern="yyyy-MM-dd HH:mm:ss" />
							</div>
							<div class="dongnename">${chat.messages[0].content }</div>
						</div>		
					</a>
				</section>
			</c:forEach>
		
		<%-- <tr>
				<td>${chat.id }</td>
				<td>${chat.sale.id }</td>
				<td>아직${chat.sale.thumImage }</td>
				<td>${chat.sale.title }</td>
				<td>${chat.sale.member.id }</td>
				<td>${chat.buyer.id }</td>
				<td>${chat.regdate }</td>
				<td><javatime:format value="${chat.latestDate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td><javatime:format value="${chat.messages[0].regdate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr> --%>
		</div>
	</article>
</div>
<jsp:include page="/resources/include/footer.jsp"/>