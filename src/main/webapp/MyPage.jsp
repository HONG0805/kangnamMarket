<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>강남대학교 중고장터 내 정보</title>
<link rel="stylesheet" type="text/css" href="CSS/reset.css">
<link rel="stylesheet" type="text/css" href="">
<link rel="shortcut icon" href="images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="images/favicon/flat-design-touch.png">
<script src="js/jquery.min.js"></script>
<style>
/* 모바일용 CSS */
/* 기본 CSS */
#wrap {
	display: flex;
	flex-flow: column nowrap;
	width: 80%;
	margin: 0 auto;
	max-width: 1200px;
}

#wrap section {
	box-sizing: border-box;
}

.info_section {
	order: 1;
	width: 100%;
	background: white;
	border-bottom: 1px solid black;
}

.info_list {
	display: flex;
}

.info_list li {
	width: 33.33%;
	text-align: center;
	font-weight: bold;
}

.info_list li a {
	display: block;
	padding: 15px 0;
	padding: 0.938rem 0;
	cursor: pointer;
}

.info_list img {
	vertical-align: middle;
	margin: 2px;
}

.header {
	display: flex;
	order: 2;
	flex-direction: column;
	position: relative;
	width: 100%;
}

.logo {
	order: 1;
	width: 100%;
	padding: 30px 0;
	padding: 1.875rem 0;
	font-size: 1.188rem;
	font-size: 1.188rem;
	line-height: 21px;
	line-height: 1.313rem;
	text-align: center;
	text-transform: uppercase;
}

.logo a {
	font-size: 20px;
}

#logo_1 {
	color: #4f94e4;
}

.logo img {
	vertical-align: middle;
}

div.my_info {
	display: flex;
	padding: 10px;
	padding: 0.625rem;
}

.my_section {
	order: 2;
	position: relative;
	width: 100%;
	padding: 10px;
	padding: 0.625rem;
	border: 1px solid #1289dd;
	border-radius: 10px/10px;
}

.my_section h1 {
	flex: auto;
	font-size: 18px;
	line-height: 26px;
	font-weight: bold;
}

div.my_info>a.logout {
	color: white;
	background: #4fa2e4;
	padding: 8px;
	border-radius: 10px;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
}

div.my_profile {
	margin: 0 18px 14px 18px;
	position: relative;
	padding-left: 72px;
}

div.my_profile img {
	display: block;
	position: absolute;
	left: 0;
	border-radius: 10px;
	width: 54px;
	height: 54px;
}

div.my_profile h3 {
	line-height: 20px;
	font-size: 14px;
	font-weight: blod;
}

div.my_profile p {
	line-height: 18px;
	font-size: 12px;
}

.my_section_1 {
	order: 3;
	position: relative;
	width: 100%;
	padding: 10px;
	padding: 0.625rem;
	border: 1px solid #1289dd;
	border-radius: 10px/10px;
	margin-top: 20px;
}

.my_section_1 h2 {
	padding: 12px 24px;
	flex: auto;
	font-size: 18px;
	line-height: 26px;
	font-weight: bold;
}

.item {
	padding: 12px 24px;
	display: block;
	line-height: 24px;
	word-wrap: break-word;
	font-size: 16px;
	cursor: pointer;
}

/* 태블릿용 CSS */
@media all and (min-width:768px) {
	.header {
		flex-direction: row;
		height: 180px;
	}
	.logo {
		position: absolute;
		top: 0;
		left: 0;
		z-index: 10;
		width: 100%;
		padding: 0;
		text-align: center;
		left: 0;
	}
	.logo a {
		display: flex;
		align-items: center;
		padding: 50px;
		padding: 3.125rem;
		font-size: 40px;
		justify-content: center;
	}
	#wrap {
		flex-flow: row wrap;
	}
	.my_section {
		order: 2;
		margin: 0 auto;
		position: relative;
		display: flex;
		flex-direction: column;
		width: 500px;
	}
	.my_section_1 {
		order: 3;
		margin: 0 auto;
		position: relative;
		display: flex;
		flex-direction: column;
		margin-top: 20px;
		width: 500px;
	}
}

/* PC용 CSS */
@media all and (min-width:1200px) {
	/* 기본 CSS */
	#wrap {
		position: relative;
		width: 50%;
	}
	.info_section {
		order: 0;
		position: absolute;
		top: 70px;
		top: 4.375rem;
		right: 30px;
		right: 1.875rem;
		z-index: 30;
		width: auto;
		border-bottom: 0;
	}
	.info_list li {
		width: auto;
		margin-left: 30px;
		margin-left: 1.25rem;
		font-weight: bold;
	}
	.info_list li a {
		padding: 0;
	}
	.info_list a {
		align-items: center;
	}
	.info_list img {
		vertical-align: middle;
		margin: 2px;
	}
	.header {
		order: 1;
		justify-content: flex-end;
		position: static;
		height: 200px;
	}
	.logo {
		float: left;
		width: 70%;
	}
	.logo a {
		font-size: 30px;
		padding: 50px 0;
		padding: 3.125rem 0;
		justify-content: flex-start
	}
	#logo_1 {
		color: #4f94e4;
	}
	.logo img {
		vertical-align: middle;
	}
	.my_section {
		order: 2;
		margin: 0 auto;
		position: relative;
		display: flex;
		flex-direction: column;
		width: 500px;
	}
	.my_section_1 {
		order: 3;
		margin: 0 auto;
		position: relative;
		display: flex;
		flex-direction: column;
		margin-top: 20px;
		width: 500px;
	}
	div.my_info>h1 {
		font-size: 22px;
		font-weight: bold;
	}
}
</style>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	User user = new User();
	
	%>
	<div id="wrap">
		<%
		if (userID == null) {
		%>
		<section class="info_section">
			<ul class="info_list">
				<li><a href=""><img
						src="images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">알림</a></li>
				<li><a href="MyPage.jsp"><img
						src="images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a href="Login.jsp"><img
						src="images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그인</a></li>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="MainPage.jsp"><img src="images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>

		<%
		} else {
		%>
		<section class="info_section">
			<ul class="info_list">
				<li><a href=""><img
						src="images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">알림</a></li>
				<li><a href="MyPage.jsp"><img
						src="images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a href="Logout.jsp"><img
						src="images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그아웃</a></li>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="MainPage.jsp"><img src="images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>
		<%
		}
		%>

		<section class="my_section">
			<div class="my_info">
				<h1>내 정보</h1>
				<a href="Logout.jsp" class="logout">로그아웃</a>
			</div>
			<div class="my_profile">
				<img src="images/s_images/user-line.png">
				<h3><%=userID %></h3>
				<p><%=user.getUserName() %></p>
				<p>학교/학번</p>
			</div>
		</section>
		<section class="my_section_1">
			<h2>계정</h2>
			<a href="MailCheck.jsp" class="item">이메일 인증</a> <a
				href="NickName.jsp" class="item">닉네임 변경</a> <a href="ChangePW_2.jsp"
				class="item">비밀번호 변경</a>
		</section>
	</div>
</body>
</html>