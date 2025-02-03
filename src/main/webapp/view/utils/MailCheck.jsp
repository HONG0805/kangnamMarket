<%@page import="javax.security.auth.Subject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>이메일 인증</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/CSS/reset.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/MailCheck.css">
<link rel="shortcut icon"
	href="<%=request.getContextPath()%>/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="<%=request.getContextPath()%>/images/favicon/flat-design-touch.png">
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<style>
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<div id="wrap">
		<%
			if (userID == null) {
		%>
		<section class="info_section">
			<ul class="info_list">
				<li><a href="<%=request.getContextPath()%>/jjimBbs.jsp"><img
						src="<%=request.getContextPath()%>/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">찜목록</a></li>
				<li><a href=""><img
						src="<%=request.getContextPath()%>/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a href="<%=request.getContextPath()%>/Login.jsp"><img
						src="<%=request.getContextPath()%>/images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그인</a></li>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="<%=request.getContextPath()%>/MainPage.jsp"><img
					src="<%=request.getContextPath()%>/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>
		<section class="sign_section">
			<div class="signup">
				<h2>로그인 후 이용가능 합니다.</h2>
				<div>
					<input type="button" id="btnPwSearch" class="loginbtn" value="로그인"
						onclick="location.href='<%=request.getContextPath()%>/Login.jsp'" />
				</div>
				<div>
					<input type="button" id="btnSignUp" class="loginbtn" value="회원가입"
						onclick="location.href='<%=request.getContextPath()%>/SignUp.jsp'" />
				</div>
			</div>
		</section>
		<%
			} else {
		%>
		<section class="info_section">
			<ul class="info_list">
				<li><a href="<%=request.getContextPath()%>/jjimBbs.jsp"><img
						src="<%=request.getContextPath()%>/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">찜목록</a></li>
				<li><a href="<%=request.getContextPath()%>/MyPage.jsp"><img
						src="<%=request.getContextPath()%>/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a href="<%=request.getContextPath()%>/Logout.jsp"><img
						src="<%=request.getContextPath()%>/images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그아웃</a></li>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="<%=request.getContextPath()%>/MainPage.jsp"><img
					src="<%=request.getContextPath()%>/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>

		<section class="sign_section">
			<div class="signup">
				<h2>학교 이메일 인증</h2>
				<div class="text">이메일</div>
				<div>
					<input name="mail" placeholder="이메일을 입력하세요.(@kangnam.ac.kr)"
						class="input_text">
				</div>
				<div class="signbtn">이메일 인증</div>
			</div>
		</section>
	</div>
	<%
		}
	%>
</body>
</html>
