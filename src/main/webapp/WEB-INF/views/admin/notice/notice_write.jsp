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
	$(document).ready(function() {
		document.title += ' - 공지사항 글쓰기';
		
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
				}
			} else {
				console.log('이미지 파일이 아닙니다.');
			}
		});
		
	  	// 파일 제거시 썸네일 해제
		document.querySelector('.delbtn').addEventListener('click', function(e){
			let delbtn = e.target;
			let preview = delbtn.previousElementSibling;
			preview.src = ''; // 썸네일 이미지 src 데이터 해제
			document.querySelector('.delbtn').style.display = 'none';
		});
		
	});

	$(function() {
		/* 기간 설정 관련 */
		$("#startDate").datepicker({
			format : "yyyy-mm-dd",
			endDate : '0d',
			language : "ko",
			todayBtn : "linked",
			clearBtn : true,
			autoClose : true,
		}).on("changeDate", function(selected) {
			var startDate = new Date(selected.date.valueOf());
			$("#endDate").datepicker("setStartDate", startDate);
		}).on("clearDate", function(selected) {
			$("#endDate").datepicker("setStartDate", null);
		});

		$("#endDate").datepicker({
			format : "yyyy-mm-dd",
			endDate : '0d',
			language : "ko",
			todayBtn : "linked",
			clearBtn : true,
			autoClose : true
		}).on("changeDate", function(selected) {
			var endDate = new Date(selected.date.valueOf());
			$("#startDate").datepicker("setEndDate", endDate);
		}).on("clearDate", function(selected) {
			$("#startDate").datepicker("setEndDate", null);
		});

		$("#endDate").datepicker("update", dateToString(new Date()));

		$("select[name=noticeYn]").change(function() {
			document.searchForm.submit();
		});

		$(".dateBtn").not("#aMonthBtn").click(function() {
			setDateValue($(this).val() - 1);
		});

		$("#allBtn").click(function() {
			$("#startDate").datepicker('setDate', null);
			$("#endDate").datepicker('setDate', null);
		});

		$("#aMonthBtn").click(function() {
			var today = new Date();
			var wantDate = new Date();
			wantDate.setMonth(wantDate.getMonth() - 1);
			wantDate.setDate(wantDate.getDate() + 1);

			$("#endDate").datepicker("update", dateToString(today));
			$("#startDate").datepicker("update", dateToString(wantDate));
		});

		$("select[name=perPageNum]").change(function() {
			document.searchForm.submit();
		});

		$("#searchBtn").click(
				function(e) {
					if ($("select[name=searchType]").val() == undefined
							|| $("input[name=keyword]").val() == "") {
						e.preventDefault();
					}
				});
	})

	$(function() {
		$("#writeBtn").click(function(e) {
			e.preventDefault();
			uploadNoticeForm();
		});

	});

	function setFilteringPaging() {

		var thisUrlStr = window.location.href;
		var thisUrl = new URL(thisUrlStr);

		console.log("setFilteringPaging!");
		console.log(thisUrlStr);

		var perPageNum = thisUrl.searchParams.get("perPageNum");
	}

	function uploadNoticeForm() {
		var form = $("#noticeForm")[0];
		var formData = new FormData(form);

		console.log(form);
		console.log(formData);

		$.ajax({
			url : "/admin/notice",
			type : "post",
			enctype : "multipart/form-data",
			data : formData,
			contentType : false,
			processData : false,
			cache : false,
			success : function(id) {
				/* if(confirm("작성 완료. 확인하시겠습니까?") == true) {
					location.href = "/notice/"
				} */
				console.log("성공! " + id);
				location.href = "/admin/notice/list";
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
		<form autocomplete="off" action="/admin/notice/write" method="post" name="noticeForm" id="noticeForm" enctype="multipart/form-data">
			<input type="hidden" name="guestId" value="">
			<input type="hidden" name="bookNo" value="">
			<div class="form-group row">
				<input type="hidden" name="writer.id" value="${loginUser.id }">
				<label for="inputEmail3" class="col-3 col-form-label font-weight-bold">제목</label>
				<div class="col-9">
					<input type="text" class="form-control" name="title"><br>
					<div class="ml-4">
						<input type="checkbox" class="form-check-input" value="y" name="noticeYn"><label class="form-check-label" for="noticeYn">중요공지(상단 노출 여부)</label>
					</div>
				</div>
			</div>
			<div class="spacing"></div>
			<div class="form-group row">
				<label for="inputEmail3" class="col-3 col-form-label font-weight-bold">내용</label>
				<div class="col-9">
					<textarea class="form-control" name="contents" style="min-height: 520px; overflow-y: hidden; resize: none;"></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label for="inputEmail3" class="col-3 col-form-label font-weight-bold">첨부파일</label>
				<div class="col-9">
					<input type="file" class="form-control mb-3" id="uploadImage" name="uploadImage" accept="image/jpeg, image/jpg, image/png">
					 <div class="row col-auto">
					 	<div class="thumb-box">
							<img src="" class="thumb image-null"/>
							<a href="javascript:" class="image-delete-btn"><span class="image-delete-btn-span">첨부 이미지 삭제</span></a>
						</div>
					</div>
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm" style="text-align: right;">
					<button type="button" class="btn btn-secondary" name="clearBtn" onclick="setClear()">초기화</button>
					<input type="submit" class="btn btn-primary" id="writeBtn" value="등록">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</div>
			</div>
		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>