<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	 $.get(contextPath+"/admin/mileage/write", function(json){
		
		}
	 });
	
	$("#mileage_update_btn").click(function(e){
		e.preventDefault();
		
		if($("input[name='member.id']").val() == "") {
			alert("회원 이름을 입력해주세요.")
			$("input[name='member.id']").focus();
			
			return false;
		}
		
		if($("input[name='content']").val() == "") {
			alert("적립 내용을 입력해주세요.")
			$("input[name='content']").focus();
			
			return false;
		}
		
		if($("input[name='mileage']").val() == "") {
			alert("적립 금액을 입력해주세요.")
			$("input[name='mileage']").focus();
			
			return false;
		}
		
		if (confirm("정말 수정하시겠습니까?") == true){
		} else{
		    return false;
		}
		
		
		var modiList = {
			id : $('#id').val(),	
			member : {
				id : $('#memId').val()
			},
			order : {
				id : $('#odId').val()
			},
			content : $('#content').val(),
			mileage : $('#mileage').val()
		};
		
		alert(JSON.stringify(modiList));

		
		$.ajax({
			url: contextPath + "/admin/mileage/update",
			type: "POST",
			contentType:"application/json; charset=UTF-8",
			dataType: "json",
			cache : false,
			data : JSON.stringify(modiList),
			beforeSend : function(xhr)
	        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success: function() {
				alert('완료되었습니다.');
				window.location.replace(contextPath+"/admin/mileage/list");
			},
			error: function(request,status,error){
				alert('에러!!!!' + request.status+request.responseText+error);
			}
		});
		console.log(contextPath+"/admin/mileage/update");	
		
		
	})
	
})
</script>


<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">마일리지 등록</div>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body mall_adm_list">
		<div class="mall_pdt_write">
			<form name="mileAdd" action="/admin/mileage/write" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
				<ul>
					<li>
						<p>주문번호</p>
						<div>
							<input type="text" id="odId" name="order.id" value="${mileage.order.id}">
						</div>
					</li>
					<li>
						<p>회원 아이디</p>
						<div>
							<select name="member.id" id="member">
								<option value="0">회원을 선택하세요.</option>
								<option value="1">모든 회원</option>
							</select>
						</div>
					</li>
					<li>
						<p>적립 내용</p>
						<div>
							<input type="text" id="content" name="content" value="${mileage.content}">
						</div>
					</li>
					<li>
						<p>적립 금액</p>
						<div>
							<input type="text" id="mileage" name="mileage" value="${mileage.mileage}">
						</div>
					</li>
				</ul>
				<a href="#" class="history_back_btn fr ml5">목록</a>
				<input type="submit" id="mileage_update_btn" value="수정">
			</form>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>