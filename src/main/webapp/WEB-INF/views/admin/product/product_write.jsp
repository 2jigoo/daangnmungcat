<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/admin/include/header.jsp" %>

<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	$("#pdt_write_btn").click(function(e){
		e.preventDefault();
		
		if ($("select[name='dogCate']").val() == "" && $("select[name='catCate']").val() == ""){
			alert("상품 카테고리를 한개 이상 선택해주세요.")
			return false;
		}
		
		if ($("input[name='name']").val() == ""){
			alert("상품명을 입력해주세요.");
			$("input[name='name']").focus();
			
			return false;
		}
		
		if ($("input[name='price']").val() == ""){
			alert("금액을 입력해주세요.");
			$("input[name='price']").focus();
			
			return false;
		}
		
		if ($("input[name='stock']").val() == ""){
			alert("재고를 입력해주세요.");
			$("input[name='stock']").focus();
			
			return false;
		}
		
		if ($("select[name='deliveryKind']").val() == "조건부 무료배송"){
			if($("input[name='deliveryCondition']").val() == "") {
				alert("조건 금액을 입력해주세요.")
				$("input[name='deliveryCondition']").focus();
				
				return false;
			}
			if($("input[name='deliveryPrice']").val() == "") {
				alert("배송비를 입력해주세요.")
				$("input[name='deliveryPrice']").focus();
				
				return false;
			}
		}
		
		if (confirm("상품을 등록하시겠습니까?") == true){
		} else{
		    return false;
		}
		
		$("form[name='pdtWrite']").submit()
	})
})

$(document).on("change", "select[name='deliveryKind']", function(){
	var idx = $("select[name='deliveryKind'] option").index($("select[name='deliveryKind'] option:selected"))
	
	if (idx == 0){
		$("input[name='deliveryPrice']").val("${deliveryList.get(0).price}")
	} else if (idx == 1){
		$("input[name='deliveryPrice']").val("${deliveryList.get(1).price}")
	} else {
		$("input[name='deliveryPrice']").val("${deliveryList.get(2).price}")
	}
	
	if ($(this).val() == "무료배송"){
		$("input[name='deliveryCondition']").val("0").attr("disabled", true);
	} else {
		$("input[name='deliveryCondition']").val("").attr("disabled", false);
	}
})
</script>


<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
			<div class="mt-2 float-left">상품 추가</div>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="mall_pdt_write">
			<form name="pdtWrite" action="/admin/product/write" method="post" enctype="multipart/form-data" accept-charset="utf-8">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
				<ul>
					<li>
						<p>멍</p>
						<div>
							<select name="dogCate.id">
								<c:forEach items="${dogCate}" var="list">
									<option value="${list.id}">${list.name}</option>
								</c:forEach>
							</select>
						</div>
					</li>
					<li>
						<p>냥</p>
						<div>
							<select name="catCate.id">
								<c:forEach items="${catCate}" var="list">
									<option value="${list.id}">${list.name}</option>
								</c:forEach>
							</select>
						</div>
					</li>
					<li>
						<p>상품명</p>
						<div>
							<input type="text" name="name">
						</div>
					</li>
					<li>
						<p>가격</p>
						<div>
							<input type="text" name="price">
						</div>
					</li>
					<li>
						<p>내용</p>
						<div>
							<textarea name="content"></textarea>
						</div>
					</li>
					<li>
						<p>판매여부</p>
						<div>
							<input type="radio" name="saleYn" value="Y" checked> 판매
							<input type="radio" name="saleYn" value="N"> 품절
						</div>
					</li>
					<li>
						<p>재고</p>
						<div>
							<input type="text" name="stock">
						</div>
					</li>
					<li>
						<p>배송비 종류</p>
						<div>
							<select name="deliveryKind">
								<c:forEach items="${deliveryList}" var="deliveryList">
									<option value="${deliveryList.name}">${deliveryList.name}</option>
								</c:forEach>
							</select>
						</div>
					</li>
					<li>
						<p>조건 금액</p>
						<div>
							<input type="text" name="deliveryCondition">
						</div>
					</li>
					<li>
						<p>배송비</p>
						<div>
							<input type="text" name="deliveryPrice" value="${deliveryList.get(0).price}" disabled="disabled">
						</div>
					</li>
					<li>
						<p>상품 썸네일 이미지</p>
						<div>
							<input multiple="multiple" type="file" name="thumbFile" accept="image/*">
						</div>
					</li>
					<li>
						<p>상품 상세 이미지</p>
						<div>
							<input multiple="multiple" type="file" name="file">
							<input multiple="multiple" type="file" name="file">
						</div>
					</li>
				</ul>
				
				<a href="#" class="history_back_btn fr ml5">목록</a>
				<input type="submit" id="pdt_write_btn" value="전송">
			</form>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/admin/include/footer.jsp" %>