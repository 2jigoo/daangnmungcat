<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<style>
	#uploadImage {
		cursor: pointer;
	    border-radius: 8px;
	    overflow: hidden;
	    border: 1px solid lightgray;
	}

	.input-file-btn {
		height: auto;
		padding: 6px;
		background-color:#FF6600;
		border-radius: 4px;
		color: white;
		cursor: pointer;
		text-align: center;
	}

	.thumb-box {
		position: relative;
	}
	
	.image-null {
		display: none;
	}
	
	.image-uploaded {
		width: 200px;
	}
	
	.image-delete-btn {
		display: none;
		background: url(/resources/images/delete_image.svg);
		background-size: contain;
	    background-repeat: no-repeat;
	    position: absolute;
	    top: 0px;
	    right: 0px;
	    width: 32px;
	    height: 32px;
	}
	
	.image-delete-btn-span {
		position: absolute;
	    width: 1px;
	    height: 1px;
	    padding: 0;
	    margin: -1px;
	    overflow: hidden;
	    clip: rect(0,0,0,0);
	    border: 0;
	}
</style>
<script>
	var noticeId = new URL(window.location.href).searchParams.get("id");
	console.log(noticeId);
	
	$(document).ready(function() {
		document.title += ' - 공지사항 수정';
		
		$("#noticeForm").on("keyup", "textarea", function(e) {
		    $(this).css("height", "auto");
		    $(this).height(this.scrollHeight);
		  });
		
	  	$("table").find("textarea").keyup();
	  	
	  	// 파일 등록시 썸네일 등록
		document.getElementById('uploadImage').addEventListener('change', function(e) {
			let elem = e.target;
			if (validateType(elem.files[0])) {
				let preview = document.querySelector('.thumb');
				preview.classList.remove("image-null");
				preview.src = URL.createObjectURL(elem.files[0]); //파일 객체에서 이미지 데이터 가져옴.
				preview.classList.add("image-uploaded");
				document.querySelector('.image-delete-btn').style.display = 'block'; // 이미지 삭제 링크 표시
				preview.onload = function() {
					URL.revokeObjectURL(preview.src); //URL 객체 해제
					document.querySelector('#file-name-box').innerHTML = elem.files[0].name; // 이름 박스에 파일 이름 표시
					document.querySelector('#isChanged').value = 'true';
				}
			} else {
				console.log('이미지 파일이 아닙니다.');
			}
		});
		
	  	// 파일 제거시 썸네일 해제
		document.querySelector('.image-delete-btn').addEventListener('click', function(e){
			let delbtn = e.target;
			let preview = delbtn.previousElementSibling;
			console.log(preview);
			preview.src = ''; // 썸네일 이미지 src 데이터 해제
			document.querySelector('.image-delete-btn').style.display = 'none';
			deleteImageFile();
		});
		
	});

	$(function() {
		$("#modifyBtn").click(function(e) {
			e.preventDefault();
			console.log("눌렸다");
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
			type : "PUT",
			enctype : "multipart/form-data",
			data : formData,
			contentType : false,
			processData : false,
			cache : false,
			success : function(data) {
				console.log(data);
				/* if(confirm("작성 완료. 확인하시겠습니까?") == true) {
					location.href = "/notice/"
				} */
				// console.log("성공! " + id);
				// location.href = "/admin/notice/list";
			},
			error : function(e) {
				console.log(e);
			}
		})
	}

	//이미지 객체 타입으로 이미지 확장자 밸리데이션
	var validateType = function(img){
		return (['image/jpeg','image/jpg','image/png'].indexOf(img.type) > -1);
	}
	
	var validateName = function(fname) {
		let extensions = [ 'jpeg', 'jpg', 'png' ];
		let fparts = fname.split('.');
		let fext = '';

		if (fparts.length > 1) {
			fext = fparts[fparts.length - 1];
		}

		let validated = false;

		if (fext != '') {
			extensions.forEach(function(ext) {
				if (ext == fext) {
					validated = true;
				}
			});
		}

		return validated;
	}
	
	function deleteImageFile() {
		var agent = navigator.userAgent.toLowerCase();
		console.log("실행되지?");		
		
		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
		    $("#uploadImage").replaceWith($("#uploadImage").clone(true));
		}else{
		    $("#uploadImage").val("");
		}
		
		document.querySelector('#file-name-box').innerHTML = '파일 없음'; // file-name-box 초기화
		document.querySelector('#isChanged').value = 'true';
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
		<form autocomplete="off" name="noticeForm" id="noticeForm" enctype="multipart/form-data">
			<input type="hidden" name="guestId" value="">
			<input type="hidden" name="bookNo" value="">
			<div class="form-group row">
				<input type="hidden" name="writer.id" value="${notice.writer.id }">
				<label class="col-3 col-form-label font-weight-bold">제목</label>
				<div class="col-9">
					<input type="text" class="form-control" name="title" value="${notice.title }"><br>
					<div class="ml-4">
						<input type="checkbox" class="form-check-input" value="${notice.noticeYn }" name="noticeYn"><label class="form-check-label" for="noticeYn">중요공지(상단 노출 여부)</label>
					</div>
				</div>
			</div>
			<div class="spacing"></div>
			<div class="form-group row">
				<label class="col-3 col-form-label font-weight-bold">내용</label>
				<div class="col-9">
					<textarea class="form-control" name="contents" style="min-height: 520px; overflow-y: hidden; resize: none;">${notice.contents }</textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-3 col-form-label font-weight-bold">첨부파일</label>
				<div class="col-9">
					<div class="col-auto row m-0 p-0 mb-3">
						<div class="col-10 form-control mr-2" id="file-name-box">${notice.noticeFile }</div>
						<label class="col input-file-btn mb-0" for="uploadImage">업로드</label>
						<input type="file" class="form-control mb-3" id="uploadImage" name="uploadImage" accept="image/jpeg, image/jpg, image/png" style="display: none;">
						<input type="hidden" id="isChanged" name="isChanged" value="false">
					</div>
					 <div class="row col-auto">
					 	<div class="thumb-box">
							<img src="/resources/upload/notice/${notice.id }/${notice.noticeFile}" class="thumb image-uploaded"/>
							<a href="javascript:" class="image-delete-btn" style="display:block;"><span class="image-delete-btn-span">첨부 이미지 삭제</span></a>
						</div>
					</div>
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm" style="text-align: right;">
					<button type="button" class="btn btn-secondary" name="clearBtn" onclick="setClear()">초기화</button>
					<input type="submit" class="btn btn-primary" id="modifyBtn" value="수정">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</div>
			</div>
		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>