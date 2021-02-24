<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
<script>
	$(document).ready(function() {
		document.title += ' - 회원 목록';
	});
	
	
	$(function() {
		loadSelectBoxes();
		
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
		/* $("#startDate").change(function(){
			console.log("startDate: " + this.value);
			$("#endDate").datepicker({
				startDate: $("#startDate").val()
			});
		}); */
		
		
		$("select[name=grade]").change(function(){
			document.searchForm.submit();
		});

		$("select[name=dongne1]").change(function(){
			$("select[name=dongne2]").val("");
			document.searchForm.submit();
		});
		
		$("select[name=dongne2]").change(function(){
			document.searchForm.submit();
		});
		
		$("#selbox-dongne1").on("change", function(){
			var dongne1 = this.value;
			if(dongne1 == "") {
				resetDongne2SelectBox();
				$("#selbox-dongne2").prop("disabled", true);
			} else {
				loadDongne2List(this.value);
			}
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
		
	})
	
	
	 
	
	function loadSelectBoxes() {
		// 회원 등급 불러오기
		$.ajax({
			url: "/api/grade",
			type: "get",
			dataType: "json",
			success: function(data) {
				appendGradeSelectBox(data);
			},
			error: function(error) {
				console.log("failed to load grades");
				console.log(error);
			}
		});
		
		// 동네1 목록 불러오기
		$.ajax({
			url: "/dongne1",
			type: "get",
			dataType: "json",
			success: function(data) {
				appendDongne1SelectBox(data);
			},
			error: function(error) {
				console.log("failed to load dongne1 options");
				console.log(error);
			}
		});
	}
	
	function loadDongne2List(dongne1) {
		$.ajax({
			url: "/dongne2/" + dongne1,
			type: "get",
			dataType: "json",
			success: function(data) {
				appendDongne2SelectBox(data);
				
				var thisUrlStr = window.location.href;
				var thisUrl = new URL(thisUrlStr);

				var dongne2 = thisUrl.searchParams.get("dongne2");
				if(!dongne2) {
				} else if(dongne2.length != 0) {
					$("select[name=dongne2]").val(dongne2);
				}
			},
			error: function(error) {
				console.log("failed to load dongne2 options");
				console.log(error);
			}
		});
	}

	function resetDongne2SelectBox() {
		$("#selbox-dongne2").html("<option value=''>전체</option>");
	}
	
	function appendDongne1SelectBox(data) {
		var options = "";
		$.each(data, function(idx, item) {
			options += "<option value='" + item.id + "'>" + item.name + "</option>";			
		});
		$("#selbox-dongne1").append(options);
		setFilteringPaging();
	}
	
	function appendDongne2SelectBox(data) {
		var options = "";
		$.each(data, function(idx, item) {
			options += "<option value='" + item.id + "'>" + item.name + "</option>";			
		});
		resetDongne2SelectBox();
		$("#selbox-dongne2").prop("disabled", false);
		$("#selbox-dongne2").append(options);
	}
	
	function appendGradeSelectBox(data) {
		var options = "";
		$.each(data, function(idx, item) {
			options += "<option value='" + item.code + "'>" + item.name + "</option>";			
		});
		$("#selbox-grade").append(options);
	}
	
	function setFilteringPaging() {
		
		var thisUrlStr = window.location.href;
		var thisUrl = new URL(thisUrlStr);

		console.log("setFilteringPaging!");
		console.log(thisUrlStr);
		
		var perPageNum = thisUrl.searchParams.get("perPageNum");
		var grade = thisUrl.searchParams.get("grade");
		var dongne1 = thisUrl.searchParams.get("dongne1");
		var searchType = thisUrl.searchParams.get("searchType");
		var keyword = thisUrl.searchParams.get("keyword");
		var startDate = thisUrl.searchParams.get("startDate");
		var endDate = thisUrl.searchParams.get("endDate");
		
		
		if(perPageNum != null) {
			$("select[name=perPageNum]").val(perPageNum);
		}
		if(!searchType) {
		} else if(searchType.length != 0) {
			$("select[name=searchType]").val(searchType);
			$("input[name=keyword]").val(keyword);
		}
		if(!grade) {
		} else if(grade.length != 0) {
			$("select[name=grade]").val(grade);
		}
		if(!dongne1) {
		} else if(dongne1.length != 0) {
			$("select[name=dongne1]").val(dongne1);
			loadDongne2List(dongne1);
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
             	회원 목록
            </div>
				<!-- <button id="addNew" class="btn btn-success btn-sm" style="float: right;">등록</button> -->
				<button id="deselectAll" class="btn btn-outline-secondary btn-sm" style="float: right;  margin-right: 10px;">선택해제</button>
				<button id="selectAll" class="btn btn-secondary btn-sm" style="float: right;  margin-right: 10px;">전체선택</button>
	           	<button id="deleteSelected"class="btn btn-danger btn-sm" style="float: right; margin-right: 10px;">예약 취소</button>
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
	<div class="card-body">
		<div class="table-responsive">
			<!-- bootStrap table wrapper-->
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<!-- 테이블 상단 필터링 시작 -->
				<form autocomplete="off" action="/admin/member/list" name="searchForm">
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
								  <span class="btn btn-sm btn-outline-secondary active" style="cursor: default;">가입일 기준</span>
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
										<label class="input-group-text" for="sorter">등급</label>
									</div>
									<select id="selbox-grade" name="grade" aria-controls="dataTable" class="custom-select custom-select-sm">
										<option selected value="">전체</option>
									</select>
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-sm input-group-prepend">
										<label class="input-group-text" for="dongne">동네</label>
									</div>
									<select id="selbox-dongne1" name="dongne1" aria-controls="dataTable" class="custom-select custom-select-sm">
										<option selected value="">전체</option>
									</select>
									<select id="selbox-dongne2" name="dongne2" aria-controls="dataTable" class="custom-select custom-select-sm" disabled>
										<option selected value="">전체</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-12 col-md-4 p-0">
							<div id="dataTable_filter" class="dataTables_filter" style="float: right;">
								<select class="custom-select custom-select-sm" name="searchType" style="width: 80px;">
									<option value="">기준</option>
									<option value="id">아이디</option>
									<option value="nickname">닉네임</option>
									<option value="name">이름</option>
									<option value="email">이메일</option>
									<option value="phone">연락처</option>
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
				<table class="table table-bordered text-center text-gray-700" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th width="50px"></th>
							<th>아이디</th>
							<th>닉네임</th>
							<th>이름</th>
							<th>이메일</th>
							<th>연락처</th>
							<th>내 동네</th>
							<th>등급</th>
							<th>마일리지</th>
							<th>가입일</th>
							<th>상태</th>
							<th style="width: 100px; min-width:100px; max-width:100px;">상세보기</th>
							<th style="width: 180px; min-width:180px; max-width:180px;"></th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list }">
						<javatime:setZoneId value="Asia/Bangkok" />
						<tr>
							<td colspan="12" style="height: 80px; vertical-align: middle;">해당 조건에 부합하는 회원이 존재하지 않습니다.</td>
						</tr>
						</c:if>
						<c:forEach var="member" items="${list }">
						<tr>
							<td>
								<input type="checkbox" class="ckbox" value="${member.id }">
							</td>
							<td>${member.id }</td>
							<td>${member.nickname }</td>
							<td>${member.name }</td>
							<td>${member.email}</td>
							<td>${member.phone}</td>
							<td>${member.dongne1.name } ${member.dongne2.name }</td>
							<td>${member.grade.name}</td>
							<td>${member.mileage}</td>
							<td><javatime:format value="${member.regdate }" pattern="yyyy-MM-dd"/></td>
							<td>${member.useYn eq "y" ? "" : "탈퇴"}</td>
							<td>
								<a href="#" class="btn bg-gray-200 btn-sm detailViewButton"><span class="text-gray-800">회원 정보</span></a>
							</td>
							<td>
								<a href="#" class="btn bg-warning btn-sm bookingToOrderButton"><span class="text-gray-800">주문내역</span></a>
								<a href="#" class="btn btn-danger btn-sm deleteButton" ><span class="text">커뮤니티</span> </a>
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
										<a href="/admin/member/list?${pageMaker.makeSearch(pageMaker.startPage-pageMaker.cri.perPageNum)}">
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
										<a href="/admin/member/list?${pageMaker.makeSearch(pageMaker.cri.page - 1) }">
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
											<a href="/admin/member/list${pageMaker.makeSearch(idx)}">${idx}</a>
										</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<div class="paging-line">
								<c:choose>
									<c:when test="${pageMaker.cri.page lt pageMaker.lastPage }">
										<a href="/admin/member/list${pageMaker.makeSearch(pageMaker.cri.page + 1) }">
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
										<a href="/admin/member/list${pageMaker.makeSearch(pageMaker.endPage + 1) }" >
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
				<%-- <div class="row">
					<div class="col-sm-12 col-md-12" style="text-align: center;">
						<div class="dataTables_info paging-line">
							<!-- << -->
							<div class="paging-line">
								<c:if test="${paging.startPage > 1}">
									<a href="bookingList.do?nowPage=${paging.startPage -1}&cntPerPage=${paging.cntPerPage}&startDate=${startDate }&endDate=${endDate}&sorter=${sorter}&designer=${designer }&where=${where }&query=${query}">
										<i class="fas fa-angle-double-left"></i>
									</a>
								</c:if>
								<c:if test="${paging.startPage == 1}">
									<i class="fas fa-angle-double-left"></i>
								</c:if>
							</div>
							
							<!-- 이전페이지 -->
							<c:choose>
								<c:when test="${paging.nowPage > 1}">
									<div class="paging-line">
										<a href="bookingList.do?nowPage=${paging.nowPage-1}&cntPerPage=${paging.cntPerPage}&startDate=${startDate }&endDate=${endDate}&sorter=${sorter}&designer=${designer }&where=${where }&query=${query}"><i class="fas fa-angle-left"></i></a>
									</div>
								</c:when>
								<c:when test="${paging.nowPage == 1}">
									<div class="paging-line">
										<i class="fas fa-angle-left"></i>
									</div>
								</c:when>
							</c:choose>
							
							<!-- 페이지 숫자 -->
							<c:if test="${paging.total eq 0 }">
								<div class="paging-line text-primary" style="font-weight: 1000;">1</div>
							</c:if>
							<c:forEach begin="${paging.startPage}" end="${paging.endPage }" var="p">
								<c:choose>
									<c:when test="${p == paging.nowPage }">
										<div class="paging-line text-primary" style="font-weight: 1000;">${p}</div>
									</c:when>
									<c:when test="${p != paging.nowPage }">
										<div class="paging-line" style="font-weight: 600;">
										<a href="bookingList.do?nowPage=${p}&cntPerPage=${paging.cntPerPage}&startDate=${startDate }&endDate=${endDate}&sorter=${sorter}&designer=${designer }&where=${where }&query=${query}">${p}</a></div>
									</c:when>
								</c:choose>
							</c:forEach>
							
							
							
							<!-- 다음페이지 -->
							<c:choose>
								<c:when test="${paging.nowPage < paging.lastPage}">
									<div class="paging-line">
										<a href="bookingList.do?nowPage=${paging.nowPage+1}&cntPerPage=${paging.cntPerPage}&startDate=${startDate }&endDate=${endDate}&sorter=${sorter}&designer=${designer }&where=${where }&query=${query}"><i class="fas fa-angle-right"></i></a>
									</div>
								</c:when>
								<c:when test="${paging.nowPage >= paging.lastPage}">
									<div class="paging-line">
										<i class="fas fa-angle-right"></i>
									</div>	
								</c:when>
							</c:choose>	
							
							<!-- >> -->
							<c:if test="${paging.endPage < paging.lastPage }">
								<div class="paging-line">
								<a href="bookingList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&startDate=${startDate }&endDate=${endDate}&sorter=${sorter}&designer=${designer }&where=${where }&query=${query}">
									<i class="fas fa-angle-double-right"></i></a>
								</div>
							</c:if>
							<c:if test="${paging.endPage == paging.lastPage }">
								<div class="paging-line">
									<i class="fas fa-angle-double-right"></i>
								</div>
							</c:if>
						
						</div>
					</div>
				</div> --%>
				<!-- 페이징 -->
			</div>
			<!-- bootStrap table wrapper-->
		</div>
		<!-- tableRespnsible -->
	</div>
	<!-- cardBody-->
	<div class="card-footer">
		<%-- <div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">
			전체 ${paging.total }개 중 ${paging.cntPerPage*(paging.nowPage-1) + 1} - ${paging.nowPage > (paging.total/paging.cntPerPage) ? (paging.nowPage-1)*paging.cntPerPage + paging.total%paging.cntPerPage : paging.nowPage*paging.cntPerPage}
		</div> --%>
	</div>
</div>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>