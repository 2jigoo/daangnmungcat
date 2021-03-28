<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script>
	var pathname;
	var profileUrl;
	
	$(function(){
		$(document).ready(function(){
			setFilteringPaging();
			profileUrl = pathname.substring(0, pathname.lastIndexOf("/"));
			
			<c:if test="${loginUser.id eq member.id }">
				/* modal event listner */
				const modal = document.getElementById("modal")
				
				function modalOn() {
				    modal.style.display = "flex"
				}
				function isModalOn() {
				    return modal.style.display === "flex"
				}
				function modalOff() {
				    modal.style.display = "none"
				}
				
				// 특정 버튼을 누르면 모달창이 켜지게 하기
				const btnModal = document.getElementById("btn-modal")
				btnModal.addEventListener("click", e => {
				    modalOn()
				})
				
				//모달창의 클로즈(x) 버튼을 누르면 모달창이 꺼지게 하기
				const closeBtn = modal.querySelector(".close-area")
				closeBtn.addEventListener("click", e => {
				    modalOff()
				})
				
				// 모달창이 켜진 상태에서 ESC 버튼을 누르면 모달창이 꺼지게 하기
				window.addEventListener("keyup", e => {
				    if(isModalOn() && e.key === "Escape") {
				        modalOff()
				    }
				})
				
				$("#modal_submit").click(function(e) {
					e.preventDefault();
					modifyProfile();
				});
			
				// 파일 등록시 썸네일 등록
				document.getElementById('uploadImage').addEventListener('change', function(e) {
					let elem = e.target;
					if (validateType(elem.files[0])) {
						let preview = document.querySelector('.thumb');
						preview.src = URL.createObjectURL(elem.files[0]); //파일 객체에서 이미지 데이터 가져옴.
						document.querySelector('.image-delete-btn').style.display = 'block'; // 이미지 삭제 링크 표시
						preview.onload = function() {
							URL.revokeObjectURL(preview.src); //URL 객체 해제
							document.querySelector('#isChanged').value = 'true';
						}
					} else {
						console.log('이미지 파일이 아닙니다.');
					}
				});
				
				// 파일 제거시 썸네일 해제
				document.querySelector('.image-delete-btn').addEventListener('click', function(e){
					let preview = document.querySelector('.thumb');
					preview.src = '/resources/images/default_user_image.png'; // 썸네일 이미지 src 데이터 해제
					document.querySelector('.image-delete-btn').style.display = 'none';
					deleteImageFile();
				});
			</c:if>
		});
		
		$(".member_info img, .profile_menu .back_btn, #subTitle").click(function() {
			location.href = profileUrl;
		});
		
		
		$(".review_delete").click(function(){
			if (confirm("정말 삭제하시겠습니까?") == false) return;
			
			var deleteReview = {id : $(this).data("id")};
			
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
		});
		
		$("select[name=writer]").change(function() {
			var reviewForm = document.reviewForm;
			reviewForm.target = pathname;
			reviewForm.submit();
		});
		
	})
	
	function setFilteringPaging() {
		var thisUrl = new URL(window.location.href);
		pathname = thisUrl.pathname;
		
		var writer = thisUrl.searchParams.get("writer");
		$("select[name=writer]").val(writer);
	}
	
</script>

<div id="subContent">
	<div id="pageCont" class="s-inner">
		<h2 id="subTitle">프로필</h2>
		<div class="member_info">
			<div class="img_box">
				<c:if test="${empty member.profilePic}">
					<img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
				</c:if>
				<c:if test="${not empty member.profilePic}">
					<img src="/resources/${member.profilePic}">
				</c:if>
			</div>
			<div class="txt_box">
				<p class="name">${member.nickname } <span>${member.dongne1.name } ${member.dongne2.name } ${member.grade.name }</span>
					<c:if test="${loginUser.id eq member.id }"><a href="/profile/edit"><span class="btn">프로필 수정</span></a></c:if>
				</p>
				<p class="bio">
					<c:choose>
						<c:when test="${not empty member.profileText }">
							${member.profileText }
						</c:when>
						<c:otherwise>
							<span class="none">인삿말이 없습니다</span>
						</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
		<div class="profile_menu">
			<a href="/profile/${member.id }/joongo"><div class="menu">판매상품</div></a><a href="/profile/${member.id }/review"><div class="menu selected">받은 거래후기</div></a>
			<span class="back_btn">프로필 메인</span>
		</div>
		<div class="profile_section">
			<form name="reviewForm" method="get">
				<select name="writer">
					<option value="all" selected>전체</option>
					<option value="seller">판매자 후기</option>
					<option value="buyer">구매자 후기</option>
				</select>
			</form>
			<div class="title">
				후기 ${reviewList.size() }
			</div>
			<ul class="joongo_review_list">
				<c:choose>
					<c:when test="${empty reviewList}">
						<li class="no_board">
	               			등록된 후기가 없습니다.
	          			</li>
					</c:when>
					<c:otherwise>
						<c:forEach items="${reviewList}" var="review">
							<li>
								<div class="user">
								   <p class="img">
								      <c:if test="${empty review.writer.profilePic}">
								         <img alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
								      </c:if>
								      <c:if test="${not empty review.writer.profilePic}">
								         <img src="/resources/${review.writer.profilePic}">
								      </c:if>
								   </p>
								   <p class="name">${review.writer.nickname }<span>${review.writer.dongne1.name} ${review.writer.dongne2.name}</span></p>
								</div>
								<div class="content_box">
									<div class="star_box star_box_data" data-star="${review.rating}">
										<span class="star star_left"></span>
										<span class="star star_right"></span>
										
										<span class="star star_left"></span>
										<span class="star star_right"></span>
										
										<span class="star star_left"></span>
										<span class="star star_right"></span>
										
										<span class="star star_left"></span>
										<span class="star star_right"></span>
										
										<span class="star star_left"></span>
										<span class="star star_right"></span>
									</div>
									<pre class="content">${review.content }</pre>
									<div class="info">
									   <p class="date"><javatime:format value="${review.regdate }" pattern="yyyy-MM-dd"/> </p>
									   <c:if test="${loginUser.id == review.writer.id }">
									   <ul>
									      <li><a href="/joongo/review/update?id=${review.id}">수정</a></li>
									      <li><a class="review_delete" data-id="${review.id}">삭제</a></li>
									   </ul>
									   </c:if>
									</div>
								</div>
							</li>
							</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</div>

<c:if test="${loginUser.id eq member.id }">
	<div id="modal" class="modal-overlay" style="display: none;">
        <div class="modal-window">
            <div class="title">
                <h2>프로필 수정</h2>
                <div class="close-area">X</div>
            </div>
            <div class="content">
                <form name="profile_edit" id="profile_edit" autocomplete="off" enctype="multipart/form-data">
                    <div class="img_box">
	                	<label class="input_file_btn" for="uploadImage">
							<c:if test="${empty member.profilePic}">
								<img class="thumb" alt="기본프로필" src="https://d1unjqcospf8gs.cloudfront.net/assets/users/default_profile_80-7e50c459a71e0e88c474406a45bbbdce8a3bf2ed4f2efcae59a064e39ea9ff30.png">
							</c:if>
							<c:if test="${not empty member.profilePic}">
								<img class="thumb" src="/resources/${member.profilePic}">
							</c:if>
	                    </label>
                    </div>
                    <div class="btn image-delete-btn" style="width: 140px; text-align: center;">프로필 사진 삭제</div>
                    <input type="file" class="hidden" name="uploadImage" id="uploadImage" accept="image/jpeg, image/jpg, image/png">
                    <input type="hidden" id="isChanged" name="isChanged" value="false">
                    <input type="hidden" name="id" value="${member.id }">
                    <input class="input_row" type="text" name="nickname" value="${member.nickname }" placeholder="닉네임">
                    <textarea class="input_row" name="profileText"  placeholder="소개말을 입력해주세요">${member.profileText }</textarea>
                </form>
            </div>
            <div class="bottom"><submit class="btn" id="modal_submit">프로필 수정</submit></div>
        </div>
    </div>
</c:if>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>