<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<script src="/resources/js/admin_notice.js" type="text/javascript"></script>
<script>
	var noticeId = new URL(window.location.href).searchParams.get("id");
	console.log("noticeId: " + noticeId);
	
	$(document).ready(function() {
		document.title += ' - 공지사항 수정';
		
	});

	$(function() {
		$("#modifyBtn").click(function(e) {
			e.preventDefault();
			modifyNoticeForm();
		});

	});


	function modifyNoticeForm() {
		var form = $("#noticeForm")[0];
		var formData = new FormData(form);

		console.log(form);
		console.log(formData);

		$.ajax({
			url : "/admin/notice/" + noticeId,
			type : "POST",
			enctype : "multipart/form-data",
			data : formData,
			contentType : false,
			processData : false,
			cache : false,
			success : function(data) {
				console.log(data);
				alert("수정이 완료되었습니다.");
				location.href = "/admin/notice/list";
			},
			error : function(e) {
				alert("글을 수정하는 도중 에러가 발생했습니다.");
				console.log(e);
			}
		})
	}
</script>
<div class="card shadow mb-4" style="width: 920px;">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">
             	공지사항 글쓰기
            </div>
			<div class="float-right">
				<button class="btn btn-sm btn-secondary" name="clearBtn" onclick="setClear()">초기화</button>
				<a href="/admin/notice/list" class="btn btn-sm btn-primary" id="toList"><span class="text">목록</span></a>
			</div>
		</h6>
		<!-- <h6 class="m-1 font-weight-bold text-primary" style="line-height: 16px; font-size: 1.3em">
		
			예약 내역
			<a href="#" id="deleteSelected"class="btn btn-danger btn-sm" style="float: right;"><span class="text">삭제</span></a>
			<a href="#" id="addNew" class="btn btn-success btn-sm" style="float: right;  margin-right: 10px;"><span class="text">등록</span></a>
			<a href="#" id="selectAll" class="btn btn-secondary btn-sm" style="float: right;  margin-right: 10px;"><span class="text">전체선택</span></a>
			<a href="#" id="deselect" class="btn btn-outline-secondary btn-sm" style="float: right;  margin-right: 10px;"><span class="text">선택해제</span></a>
		</h6> -->
	</div>
	<!-- card-body -->
	<div class="card-body p-5">
		<form autocomplete="off" name="noticeForm" id="noticeForm" enctype="multipart/form-data" method="post" action="/admin/notice/${notice.id }">
			<div class="form-group row">
				<input type="hidden" name="id" value="${notice.id }">
				<input type="hidden" name="writer.id" value="${notice.writer.id }">
				<label class="col-2 col-form-label font-weight-bold">제목</label>
				<div class="col-10">
					<input type="text" class="form-control" name="title" value="${notice.title }"><br>
					<div class="ml-4">
						<c:choose>
							<c:when test="${notice.noticeYn eq 'y' }">
								<input type="checkbox" class="form-check-input" value="y" name="noticeYn" checked>
							</c:when>
							<c:otherwise>
								<input type="checkbox" class="form-check-input" value="y" name="noticeYn">
							</c:otherwise>
						</c:choose>
						<label class="form-check-label" for="noticeYn">중요공지(상단 노출 여부)</label>
					</div>
				</div>
			</div>
			<div class="spacing"></div>
			<div class="form-group row">
				<label class="col-2 col-form-label font-weight-bold">내용</label>
				<div class="col-10">
					<textarea class="form-control" name="contents" style="min-height: 520px; overflow-y: hidden; resize: none;">${notice.contents }</textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-2 col-form-label font-weight-bold">첨부파일</label>
				<div class="col-10">
					<div class="col-auto row m-0 p-0 mb-3">
						<div class="col-10 form-control mr-2" id="file-name-box">
							<c:if test="${notice.noticeFile ne null}">${notice.noticeFile }</c:if>
							<c:if test="${notice.noticeFile eq null}">파일 없음</c:if>
						</div>
						<label class="col input-file-btn mb-0" for="uploadImage">업로드</label>
						<input type="file" class="form-control mb-3" id="uploadImage" name="uploadImage" accept="image/jpeg, image/jpg, image/png" style="display: none;">
						<input type="hidden" id="isChanged" name="isChanged" value="false">
					</div>
					 <div class="row col-auto">
					 	<div class="thumb-box">
					 		<c:choose>
					 			<c:when test="${notice.noticeFile ne null }">
								<img src="/resources/upload/notice/${notice.id }/${notice.noticeFile}" class="thumb image-uploaded"/>
								<a href="javascript:" class="image-delete-btn" style="display:block;"><span class="image-delete-btn-span">첨부 이미지 삭제</span></a>
								</c:when>
						 		<c:otherwise>
									<img src="/resources/upload/notice/${notice.id }/${notice.noticeFile}" class="thumb image-null"/>
									<a href="javascript:" class="image-delete-btn" style="display:none;"><span class="image-delete-btn-span">첨부 이미지 삭제</span></a>
						 		</c:otherwise>
					 		</c:choose>
						</div>
					</div>
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm" style="text-align: right;">
					<button type="button" class="btn btn-secondary" name="clearBtn" onclick="setClear()">초기화</button>
					<input type="submit" class="btn btn-primary" id="modifyBtn" value="수정">
					<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
				</div>
			</div>
		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>