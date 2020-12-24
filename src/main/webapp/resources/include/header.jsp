<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>당근멍캣</title>
	<link rel="stylesheet" href="<c:url value="/resources/css/common.css"/>">
	<script src="<c:url value="/resources/js/jquery-1.12.4.min.js" />" type="text/javascript" ></script>
	<script src="<c:url value="/resources/js/common.js" />" type="text/javascript" ></script>
</head>
<body>
<div id="wrap">

<header id="header">
	<div class="s-inner">
		<h1 id="logo"><a href="<c:url value="/" />">당근멍캣</a></h1>

		<div class="h_search">
			<input type="text" class="text">
			<input type="submit" class="btn">
		</div>
		${loginUser }
		<c:if test="${loginUser eq null}">
		<ul class="h_util">
			<li><a href="login">로그인</a></li>
			<li><a href="signup">회원가입</a></li>
			<li><a href="#">장바구니</a></li>
		</ul>
		</c:if>
		<c:if test="${loginUser ne null}">
			<ul class="h_util">
			<li><a href="#">${member.getId()}님 안녕하세요.</a></li>
			<li><a href="#">마이페이지</a></li>
			<li><a href="logout">로그아웃</a></li>
			</ul>
		</c:if>

		<div class="h_search_btn"><span class="text_hidden">검색</span></div>
		<div id="menuToggle">
			<span class="t"></span>
			<span class="m"></span>
			<span class="b"></span>
		</div>
	</div>
	<nav id="gnb">
		<div>
			<c:if test="${loginUser eq null}">
			<ul>
				<li><a href="login">로그인</a></li>
				<li><a href="signup">회원가입</a></li>
				<li><a href="#">장바구니</a></li>
			</ul>
			</c:if>
			<c:if test="${loginUser ne null}">
			<ul>
				<li><a href="#">${member.getId()}님</a></li>
				<li><a href="#">마이페이지</a></li>
				<li><a href="logout">로그아웃</a></li>
			</ul>
			</c:if>
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