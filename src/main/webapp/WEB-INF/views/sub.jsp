<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>당근멍캣</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
	<script src="${pageContext.request.contextPath}/js/jquery-1.12.4.min.js" type="text/javascript" ></script>
	<script src="${pageContext.request.contextPath}/js/common.js" type="text/javascript" ></script>
</head>
<body>


<div id="wrap">

<header id="header">
	<div class="s-inner">
		<h1 id="logo"><a href="#">당근멍캣</a></h1>

		<div class="h_search">
			<input type="text" class="text">
			<input type="submit" class="btn">
		</div>

		<ul class="h_util">
			<li><a href="#">로그인</a></li>
			<li><a href="#">회원가입</a></li>
			<li><a href="#">장바구니</a></li>
		</ul>

		<div class="h_search_btn"><span class="text_hidden">검색</span></div>
		<div id="menuToggle">
			<span class="t"></span>
			<span class="m"></span>
			<span class="b"></span>
		</div>
	</div>
	<nav id="gnb">
		<div>
			<ul>
				<li><a href="#">로그인</a></li>
				<li><a href="#">회원가입</a></li>
				<li><a href="#">장바구니</a></li>
			</ul>
		</div>
		<ul>
			<li><a href="#">중고</a></li>
			<li class="depth2"><a href="#">멍</a>
				<ul>
					<li><a href="#">사료</a></li>
					<li><a href="#">배변패드</a></li>
					<li><a href="#">간식</a></li>
					<li><a href="#">장남감</a></li>
					<li><a href="#">영양제</a></li>
				</ul>
			</li>
			<li class="depth2"><a href="#">냥</a>
				<ul>
					<li><a href="#">사료</a></li>
					<li><a href="#">배변패드</a></li>
					<li><a href="#">간식</a></li>
					<li><a href="#">장남감</a></li>
					<li><a href="#">영양제</a></li>
				</ul>
			</li>
			<li><a href="#">커뮤니티</a></li>
			<li><a href="#">공지사항</a></li>
		</ul>
	</nav>
</header>

<div id="subContent">
	<h2 id="subTitle">중고</h2>
	<div id="pageCont" class="s-inner">
		내용내용
	</div>
</div>

<footer id="footer">
	<ul class="f_util">
		<li><a href="#">이용약관</a></li>
		<li><a href="#">개인정보취급방침</a></li>
		<li><a href="#">중고멍캣</a></li>
	</ul>
	<ul class="f_info">
		<li>중고멍캣</li>
		<li>대표자 : 드릉드릉</li>
		<li>주소 : 대구광역시 서구</li>
		<li>전화 : 010-0000-0000</li>
		<li>이메일 : test@test.com</li><br>
		<li>개인정보관리책임자 : 홍길동</li>
		<li>사업자등록번호 : 123-45-67890</li>
		<li>통신판매업 : 제 2020-대구서구-0005 호</li><br>
		<li class="copy">Copyright ⓒ 중고멍캣.All reserved.</li>
	</ul>
</footer>

</div>

</body>
</html>