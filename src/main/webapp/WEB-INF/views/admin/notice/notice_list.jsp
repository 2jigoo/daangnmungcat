<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<script>
	$(function() {
		$(document).ready(function() {
			document.title += ' - 공지사항 목록';
			setFilteringPaging();
		});
		
		/* 기간 설정 관련 */
		$("#startDate").datepicker({
			format: "yyyy-mm-dd",
			endDate: '0d',
			language: "ko",
			todayBtn: "linked",
			clearBtn: true,
			autoClose: true,
		}).on("changeDate", function(selected) {
			var startDate = new Date(selected.date.valueOf());
			$("#endDate").datepicker("setStartDate", startDate);
		}).on("clearDate", function(selected) {
			$("#endDate").datepicker("setStartDate", null);
		});

		$("#endDate").datepicker({
			format: "yyyy-mm-dd",
			endDate: '0d',
			language: "ko",
			todayBtn: "linked",
			clearBtn: true,
			autoClose: true
		}).on("changeDate", function(selected) {
			var endDate = new Date(selected.date.valueOf());
			$("#startDate").datepicker("setEndDate", endDate);
		}).on("clearDate", function(selected) {
			$("#startDate").datepicker("setEndDate", null);
		});
		
		$("#endDate").datepicker("update", dateToString(new Date()));
		
		$("select[name=noticeYn]").change(function(){
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
		
		$("select[name=perPageNum]").change(function(){
			document.searchForm.submit();
		});
		
		$("#searchBtn").click(function(e) {
			if($("select[name=searchType]").val() == undefined || $("input[name=keyword]").val() == "") {
				e.preventDefault();
			}
		});

		$("#selectAll").click(function() {
			$(".ckbox").prop("checked", true);
		});

		$("#deselectAll").click(function() {
			$(".ckbox").prop("checked", false);
		});
		
	})
	
	function setFilteringPaging() {
		
		var thisUrlStr = window.location.href;
		var thisUrl = new URL(thisUrlStr);

		console.log("setFilteringPaging!");
		console.log(thisUrlStr);
		
		var perPageNum = thisUrl.searchParams.get("perPageNum");
		var searchType = thisUrl.searchParams.get("searchType");
		var keyword = thisUrl.searchParams.get("keyword");
		var startDate = thisUrl.searchParams.get("startDate");
		var endDate = thisUrl.searchParams.get("endDate");
		var noticeYn = thisUrl.searchParams.get("noticeYn");
		
		console.log(startDate);
		console.log(endDate);
		
		if(perPageNum != null) {
			$("select[name=perPageNum]").val(perPageNum);
		}
		if(!searchType) {
		} else if(searchType.length != 0) {
			$("select[name=searchType]").val(searchType);
			$("input[name=keyword]").val(keyword);
		}
		if(!noticeYn) {
		} else if(noticeYn.length != 0) {
			$("select[name=noticeYn]").val(noticeYn);
		}
		if(!startDate) {
		} else if(startDate.length != 0) {
			$("#startDate").datepicker("update", startDate);
		}
		if(!endDate) {
		} else if(endDate.length != 0) {
			$("#endDate").datepicker("update", endDate);
		}
	}
	
	function setDateValue(days) {
		var today = new Date();
		var wantDate = new Date();
		wantDate.setDate(wantDate.getDate() - days);
		
		$("#endDate").datepicker("update", dateToString(today));
		$("#startDate").datepicker("update", dateToString(wantDate));
	};

	function dateToString(date) {
		var year = date.getFullYear(); 
		var month = new String(date.getMonth()+1); 
		var day = new String(date.getDate()); 

		// 한자리수일 경우 0을 채워준다. 
		if(month.length == 1){ 
		  month = "0" + month; 
		} 
		if(day.length == 1){ 
		  day = "0" + day; 
		} 
		
		return year + "-" + month + "-" + day;
	};
	
</script>
<!-- Page Heading -->
<!--<h1 class="h3 mb-2 text-gray-800 font-weight">목록 템플릿</h1>
<p class="mb-4">
	여기에 간단한 설명 추가해주세요. 이렇게 링크도 달아도 됩니다.
	<a target="_blank" href="https://datatables.net">링크</a>
</p> -->

<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">
             	공지사항 목록
            </div>
            	<a href="/admin/notice/write" id="addBtn" class="btn btn-success btn-sm" style="float: right;  margin-right: 10px;"><span class="text">등록</span></a>
				<button id="deselectAll" class="btn btn-outline-secondary btn-sm" style="float: right;  margin-right: 10px;">선택해제</button>
				<button id="selectAll" class="btn btn-secondary btn-sm" style="float: right;  margin-right: 10px;">전체선택</button>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="table-responsive">
			<!-- bootStrap table wrapper-->
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<!-- 테이블 상단 필터링 시작 -->
				<form autocomplete="off" action="/admin/notice/list" name="searchForm">
					<div class="row m-0 mb-2">
						<div class="col-sm-12 col-md-12 p-0">
							<div class="form-inline justify-content-center">
								<i class="far fa-calendar-alt mr-3" style="font-size: 22px;"></i>
								<div class="input-group input-group-sm mr-3">
									<div class="input-group-prepend">
										<input type="text" class="form-control" id="startDate" name="startDate" style="width: 120px;" placeholder="시작일">
									</div>
									<div class="input-group-prepend">
										<label class="input-group-text">~</label>
									</div>
									<div class="input-group-prepend">
										<input type="text" class="form-control" id="endDate" name="endDate" style="width: 120px;" placeholder="종료일">
									</div>
								</div>
								<button type="submit" class="form-control btn-primary btn-sm" id="dateBtn">조회</button>
							</div>
						</div>
					</div>
					<div class="row m-0">
						<div class="col-sm-12 col-md-12 p-0">
							<div class="form-inline justify-content-center" style="height: 32px;">
								<div class="btn-group btn-group-sm" role="group" aria-label="Basic example">
								  <span class="btn btn-sm btn-outline-secondary active" style="cursor: default;">작성일 기준</span>
								  <button type="button" class="btn btn-sm btn-outline-secondary dateBtn" id="allBtn">전체</button>
								  <button type="button" class="btn btn-sm btn-outline-secondary dateBtn" value="1" id="todayBtn">오늘</button>
								  <button type="button" class="btn btn-sm btn-outline-secondary dateBtn" value="7" id="aWeekBtn">1주</button>
								  <button type="button" class="btn btn-sm btn-outline-secondary dateBtn" value="14" id="twoWeeksBtn">2주</button>
								  <button type="button" class="btn btn-sm btn-outline-secondary dateBtn" value="31" id="aMonthBtn">1개월</button>
								</div>
							</div>
						</div>
					</div>
					<hr>
					<div class="row m-0 mb-2">
						<div class="col-sm-12 col-md-8 p-0">
							<div class="dataTables_length form-inline" id="dataTable_length">
								<div class="input-group input-group-sm mr-3">
									<select name="perPageNum" aria-controls="dataTable" class="custom-select custom-select-sm">
										<option value="10">10줄 보기</option>
										<option value="25">25줄 보기</option>
										<option value="50">50줄 보기</option>
										<option value="100">100줄 보기</option>
									</select>
								</div>
								<div class="input-group input-group-sm mr-3">
									<div class="input-group-sm input-group-prepend">
										<label class="input-group-text" for="state">상태</label>
									</div>
									<select id="selbox-state" name="noticeYn" aria-controls="dataTable" class="custom-select custom-select-sm">
										<option selected value="">전체</option>
										<option value="y">중요</option>
										<option value="n">일반</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-12 col-md-4 p-0">
							<div id="dataTable_filter" class="dataTables_filter" style="float: right;">
								<select class="custom-select custom-select-sm" name="searchType" style="width: 80px;">
									<option value="">기준</option>
									<option value="title">제목</option>
									<option value="contents">내용</option>
									<option value="writer">작성자</option>
								</select>
								<label>
									<input type="search" name="keyword" class="form-control form-control-sm" placeholder="" aria-controls="dataTable">
								</label>
								<input type="submit" class="btn btn-primary btn-sm" value="검색" id="searchBtn"></input>
								<input type="hidden" name="page" value="1">
							</div>
						</div>
					</div>
				</form>
				<!-- 테이블 상단 필터링 끝 -->
				<!-- 테이블 시작 -->
				<table class="table table-bordered text-center text-gray-700 padding-sm middle" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th width="50px"></th>
							<th width="120px">글번호</th>
							<th width="80px">공지</th>
							<th>제목</th>
							<th width="180px">작성자</th>
							<th width="180px">작성일</th>
							<th style="width: 104px; min-width:104px; max-width:104px;">상세보기</th>
							<th style="width: 180px; min-width:180px; max-width:180px;"></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list }">
						<javatime:setZoneId value="Asia/Bangkok" />
						<tr>
							<td colspan="13" style="height: 80px; vertical-align: middle;">해당 조건에 부합하는 공지사항이 존재하지 않습니다.</td>
						</tr>
						</c:if>
						<c:forEach var="notice" items="${list }">
						<tr>
							<td>
								<input type="checkbox" class="ckbox" value="${notice.id }">
							</td>
							<td>${notice.id }</td>
							<td>${notice.noticeYn eq "y" ? "!" : "일반" }</td>
							<td style="text-align: left;">${notice.title }</td>
							<td>${notice.writer.nickname }(${notice.writer.id })</td>
							<td><javatime:format value="${notice.regdate }" pattern="yyyy-MM-dd HH:mm"/></td>
							<td>
								<a href="/notice/view?id=${notice.id}" target="_blank" class="btn bg-gray-200 btn-sm detailViewButton"><span class="text-gray-800">보기</span></a>
							</td>
							<td>
								<a href="/admin/notice/modify?id=${notice.id}" class="btn bg-warning btn-sm"><span class="text-gray-800">수정</span></a>
								<a href="/admin/notice/delete?id=${notice.id}" class="btn btn-danger btn-sm deleteButton" ><span class="text">삭제</span></a>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 테이블 끝 -->
				
				<!-- 페이징 시작 -->
				<div class="row">
					<div class="col-sm-12 col-md-12" style="text-align: center;">
						<div class="dataTables_info">
							<div class="paging-line">
								<c:choose>
									<c:when test="${pageMaker.startPage lt pageMaker.cri.page and pageMaker.startPage ne 1}">
										<a href="/admin/notice/list?${pageMaker.makeSearch(pageMaker.startPage-pageMaker.cri.perPageNum)}">
											<i class="fas fa-angle-double-left"></i>
										</a>
									</c:when>
									<c:otherwise>
										<i class="fas fa-angle-double-left"></i>
									</c:otherwise>
								</c:choose>
							</div>
								
							<div class="paging-line">
								<c:choose>
									<c:when test="${pageMaker.cri.page gt 1 }">
										<a href="/admin/notice/list?${pageMaker.makeSearch(pageMaker.cri.page - 1) }">
											<i class="fas fa-angle-left"></i>
										</a>
									</c:when>
									<c:otherwise>
										<i class="fas fa-angle-left"></i>
									</c:otherwise>
								</c:choose>
							</div>
							<c:if test="${pageMaker.endPage eq 0 }">
								<div class="paging-line text-primary" style="font-weight: 1000;">1</div>
							</c:if>
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage }" var="idx">
								<c:choose>
									<c:when test="${pageMaker.cri.page eq idx }">
										<div class="paging-line text-primary" style="font-weight: 1000;">${idx }</div>
									</c:when>
									<c:otherwise>
										<div class="paging-line" style="font-weight: 600;">
											<a href="/admin/notice/list${pageMaker.makeSearch(idx)}">${idx}</a>
										</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<div class="paging-line">
								<c:choose>
									<c:when test="${pageMaker.cri.page lt pageMaker.lastPage }">
										<a href="/admin/notice/list${pageMaker.makeSearch(pageMaker.cri.page + 1) }">
											<i class="fas fa-angle-right"></i>
										</a>
									</c:when>
									<c:otherwise>
										<i class="fas fa-angle-right"></i>
									</c:otherwise>
								</c:choose>
							</div>
							
							<div class="paging-line">
								<c:choose>
									<c:when test="${pageMaker.next eq true}">
										<a href="/admin/notice/list${pageMaker.makeSearch(pageMaker.endPage + 1) }" >
											<i class="fas fa-angle-double-right"></i>
										</a>
									</c:when>
									<c:otherwise>
										<i class="fas fa-angle-double-right"></i>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
				<!-- 페이징 -->
			</div>
			<!-- bootStrap table wrapper-->
		</div>
		<!-- tableRespnsible -->
	</div>
	<!-- cardBody-->
	<div class="card-footer">
		<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">
			<c:choose>
				<c:when test="${empty list }">
					전체 0개		
				</c:when>
				<c:otherwise>
					전체 ${pageMaker.totalCount }개 중 ${pageMaker.cri.pageStart + 1} - ${pageMaker.cri.page >= pageMaker.lastPage ? pageMaker.cri.pageStart + pageMaker.totalCount%pageMaker.cri.perPageNum : pageMaker.cri.pageStart + pageMaker.cri.perPageNum}
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>