<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/resources/include/header.jsp" %>

<script>
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	$("select[name='deliveryKind']").change(function(){
		if ($(this).val() == "무료배송"){
			$("input[name='deliveryCondition']").val("0").attr("disabled", true);
			$("input[name='deliveryPrice']").val("0").attr("disabled", true);
		} else if ($(this).val() == "유료배송"){
			$("input[name='deliveryCondition']").val("0").attr("disabled", true);
			$("input[name='deliveryPrice']").val("").attr("disabled", false);
		} else {
			$("input[name='deliveryCondition']").val("").attr("disabled", false);
			$("input[name='deliveryPrice']").val("").attr("disabled", false);
		}
	})
	
	/*$("#pdt_write_btn").click(function(e){
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
			$("input[name='price']").focus();
			
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
		
		$("form[name='pdtWrite']").submit()
	})*/
})
</script>


<div id="subContent">
	<h2 id="subTitle">쇼핑몰 상품 추가</h2>
	<div id="pageCont" class="s-inner">
		<div class="mall_pdt_write">
			<form name="pdtWrite" action="<%=request.getContextPath() %>/mall/product/write" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" >
				<ul>
					<li>
						<p>멍</p>
						<div>
							<select name="dogCate">
								<option value="">카테고리를 선택해주세요.</option>
								<c:forEach items="${dogCate}" var="list">
									<option value="${list.id}">${list.name}</option>
								</c:forEach>
							</select>
						</div>
					</li>
					<li>
						<p>냥</p>
						<div>
							<select name="catCate">
								<option value="">카테고리를 선택해주세요.</option>
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
							<input type="radio" name="saleYn" value="y" checked> 판매
							<input type="radio" name="saleYn" value="n"> 품절
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
								<option value="조건부 무료배송">조건부 무료배송</option>
								<option value="무료배송">무료배송</option>
								<option value="유료배송">유료배송</option>
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
							<input type="text" name="deliveryPrice">
						</div>
					</li>
					<li>
						<p>상품 썸네일 이미지</p>
						<div>
							<input multiple="multiple" type="file" name="thumb_file">
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
				
				<input type="submit" id="pdt_write_btn" value="전송">
			</form>
		</div>
	</div>
</div>

<jsp:include page="/resources/include/footer.jsp"/>