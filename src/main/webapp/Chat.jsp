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
<title>강남대학교 중고장터</title>
<link rel="stylesheet" type="text/css" href="CSS/reset.css">
<link rel="stylesheet" type="text/css" href="">
<link rel="shortcut icon" href="images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="images/favicon/flat-design-touch.png">
<script src="js/jquery.min.js"></script>
<style>
/* ëª¨ë°ì¼ì© CSS */
/* ê¸°ë³¸ CSS */
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

.logo img {
	vertical-align: middle;
}

.logo a {
	font-size: 20px;
}

#logo_1 {
	color: #4f94e4;
}

.content_categories {
	width: 100%;
	order: 3;
	padding: 10px;
	padding: 0.625rem;
	order: 3;
}

.content_search {
	width: 100%;
	order: 4;
	padding: 10px;
	padding: 0.625rem;
}

.content_row_1>div.category_selected {
	padding: 10px;
	cursor: pointer;
	display: inline-block;
}

.content_row_1>div.category {
	padding: 10px;
	cursor: pointer;
	display: inline-block;
}

.content_row_2>form.search {
	padding: 10px;
	border: 2px solid #1289dd;
	border-radius: 10px/10px;
	background: transparent url(/images/s_images/search-line.png) no-repeat
		right 10px center;
}

.search_check {
	float: right;
}

.content_row_2>form.search>input.text {
	height: 20px;
	border: 0;
	width: 80%;
	color: #292929;
	font-size: 14px;
	background-color: transparent;
	outline: none;
}

.content_section {
	order: 5;
	width: 100%;
	padding: 10px;
	padding: 0.625rem;
}

.comment {
	padding: 5px;
}

.bbstitle {
	width: 60%;
	margin: 15px 0px 15px 10px;
	font-weight: bold;
	font-size: 20px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.bbscontent {
	width: 60%;
	margin: 15px 0px 15px 10px;
	color: gray;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.bbsdate {
	width: 100%;
	font-size: 12px;
	margin: 10px;
}

#writeArticleButton {
	display: block;
	border: 2px solid #d6d6d6;
	color: #a6a6a6;
	box-sizing: border-box;
	cursor: text;
	height: 50px;
	padding: 10px;
	font-size: 18px;
	margin-bottom: 5px;
	font-weight: bold;
	line-height: 26px;
}

.writeimg {
	float: right;
	filter: opacity(0.5) drop-shadow(0 0 0 #d6d6d6);
}

div.content_article>article {
	margin-bottom: -1px;
	box-sizing: border-box;
	border: 1px solid #e3e3e3;
	background-color: white;
}

div.content_article>article>a.article {
	display: block;
	padding: 15px;
	padding: 0.9375rem;
	cursor: pointer;
}

.pagination_footer {
	order: 6;
	width: 100%;
	margin-bottom: 100px;
	box-sizing: border-box;
}

div.pagination>a.prev {
	float: left;
	padding: 10px;
	margin-left: 20px;
	border: 2px solid #1289dd;
	font-size: 14px;
	border-radius: 15px;
	cursor: pointer;
}

div.pagination>a.next {
	float: right;
	padding: 10px;
	margin-right: 20px;
	border: 2px solid #1289dd;
	font-size: 14px;
	border-radius: 15px;
	cursor: pointer;
}

div.pagination>img {
	vertical-align: middle;
}

.sign_section {
	display: flex;
	flex-direction: column;
	flex-direction: row;
	justify-content: center;
	width: 100%;
	order: 2;
	padding: 30px;
	width: 100%;
}

.signup {
	border: 1px solid #1289dd;
	border-radius: 10px;
	padding: 20px;
}

.loginbtn {
	width: 90%;
	color: white;
	padding: 5px;
	border-radius: 5px;
	margin: 20px 5px 5px 5px;
	font-weight: bold;
	text-align: center;
	background-color: rgba(0, 147, 245);
	font-size: 10px;
}

/* 테블릿 CSS */
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
	}
	.logo a {
		display: flex;
		align-items: center;
		padding: 50px;
		padding: 3.125rem;
		font-size: 40px;
		justify-content: center;
	}
	.content_categories {
		padding: 10px;
		padding: 0.625rem;
	}
	.content_row_1>div.category_selected {
		padding: 10px;
		cursor: pointer;
		display: inline-block;
	}
	.content_row_1>div.category {
		padding: 10px;
		cursor: pointer;
		display: inline-block;
	}
	.content_search {
		padding: 10px;
		padding: 0.625rem;
	}
	/* ê¸°ë³¸ CSS */
	#wrap {
		flex-flow: row wrap;
	}
}

/* PC CSS */
@media all and (min-width:1200px) {
	.info_section {
		order: 0;
		position: absolute;
		top: 70px;
		top: 4.375rem;
		right: 30px;
		right: 1.875rem;
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
		justify-content: flex-start;
		padding: 50px 0;
		padding: 3.125rem 0;
	}
	#logo_1 {
		color: #4f94e4;
	}
	.logo img {
		vertical-align: middle;
	}
	.content_categories {
		width: 40%;
		padding: 20px;
		padding: 1.25rem;
	}
	.content_search {
		width: 60%;
		padding: 20px;
		padding: 1.25rem;
	}
	.content_row_1>div.category_selected {
		padding: 10px;
		cursor: pointer;
		display: inline-block;
	}
	.content_row_1>div.category {
		padding: 10px;
		cursor: pointer;
		display: inline-block;
	}
	.content_row_2>form.search {
		width: 70%;
		float: right;
		border: 2px solid #1289dd;
		float: right;
	}
	.content_section {
		order: 5;
		width: 100%;
		padding: 20px;
		padding: 1.25rem;
	}
	.loginbtn {
		font-size: 15px;
	}

	/* ê¸°ë³¸ CSS */
	#wrap {
		position: relative;
		width: 50%;
	}
}
</style>
<script type="text/javascript">
	var websocket = new WebSocket("ws://localhost:8080/wsocket");
	var line = 0;
	websocket.onopen = function(message) {
		document.getElementById("state").innerHTML = "소켓 시작";
	}
	websocket.onclose = function(message) {
	}
	websocket.onerror = function(message) {
	}
	websocket.onmessage = function(message) {
		if (++line % 20 == 0) {
			line = 0;
			document.getElementById("chat").value = "";
		}

		document.getElementById("chat").value = document.getElementById("chat").value
				+ "\n" + message.data;
	}

	function sendmessage() {
		msg = "[${sessionScope.id}]" + document.getElementById("send").value;
		websocket.send(msg);
 
		document.getElementById("send").value = "";
		/*
		//	나의 메시지
		document.getElementById("chat").value = 
			document.getElementById("chat").value + "\n"+msg; 
		 */
	}
	function keypress() {
		var keycode = event.keyCode;

		if (keycode == 13)
			sendmessage();
	}

	/*
	 function submitFunction() {
	 var chatName = $('#chatName').val();
	 var chatContent = $('#chatContent').val();
	 $.ajax({
	 type : "POST",
	 url : "./chatSubmitServlet",
	 data : {
	 chatName : chatNaem,
	 chatContent : chatContent
	 },
	 success : function (result) {
	 if(result == 1){
	 alert("전송에 성공했습니다.");
	 }else if(result ==0){
	 alert("이름과 내용을 정확히 입력하세요.");
	 }else{
	 alert("데이터베이스 오류가 발생했습니다.");
	 }
	 }
	 });
	 $('#chatContent').val('');
	 }
	 */
</script>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
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
				<li><a href=""><img
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
		<section class="sign_section">
			<div class="signup">
				<h2>로그인 후 이용가능 합니다.</h2>
				<div>
					<input type="button" id="btnPwSearch" class="loginbtn" value="로그인"
						onclick="location.href='Login.jsp'" />
				</div>
				<div>
					<input type="button" id="btnSignUp" class="loginbtn" value="회원가입"
						onclick="location.href='SignUp.jsp'" />
				</div>
			</div>
		</section>
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

		<section class="chat_section">
			<div>강남채팅</div>
		</section>
	</div>
	<%
	}
	%>

</body>
</html>