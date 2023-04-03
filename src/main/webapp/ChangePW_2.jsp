<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>비밀번호 변경</title>
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

div.signup>h2 {
	font-size: 20px;
	margin-bottom: 10px;
}

div.signup>div.text {
	font-size: 14px;
	margin-top: 8px;
	margin-bottom: 4px;
}

.signup {
	border: 1px solid #1289dd;
	border-radius: 10px;
	padding: 20px;
}

input::placeholder {
	color: #a7a7a7;
}

.input_text {
	border: 1px solid #a6a6a6;
	border-radius: 5px;
	font-size: 14px;
	width: 250px;
	padding: 5px;
	margin-bottom: 4px;
}

.loginbtn {
	width : 90%;
	color: white;
	padding: 5px;
	border-radius: 5px;
	margin: 20px 5px 5px 5px;
	font-weight: bold;
	text-align: center;
	background-color: rgba(0, 147, 245);
	font-size: 10px;
}

.signbtn {
	width: 95%;
	background: #1289dd;
	color: white;
	padding: 5px;
	margin-top: 20px;
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
	cursor: pointer;
	background: #1289dd;
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
	div.signup>h2 {
		font-size: 30px;
		margin-bottom: 20px;
	}
	div.signup>div.text {
		font-size: 20px;
		margin-top: 14px;
		margin-bottom: 3px;
	}
	.input_text {
		font-size: 18px;
		width: 300px;
	}
	.signbtn {
		font-size: 20px;
	}
	#wrap {
		flex-flow: row wrap;
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
	.sign_section {
		padding: 80px;
	}
	.signup {
		padding: 40px;
	}
}
</style>
<script type="text/javascript">
	function validate() {
		var newPW = document.getElementById("new_pw");
		var newPWCK = document.getElementById("new_pwck");

		var arrNum1 = new Array();
		var arrNum2 = new Array();

		//아이디, 패스워드 값 데이터 정규화
		var regul1 = /^[a-zA-Z0-9]{8,20}$/;

		if ((newPW.value) == "" && (newPWCK.value) == "") {
			alert("빈칸을 입력해 주세요");
			return false;
		}
		if (!check(regul1, newPW, "비밀번호는 8~20자의 대소문자와 숫자로만 입력 가능합니다.")) {
			return false;
		}
		if (newPW.value != newPWCK.value) {
			alert("새로운 비밀번호가 일치하지 않습니다.");
			return false;
		}
		function check(re, what, message) {
			if (re.test(what.value)) {
				return true;
			}
			alert(message);
			what.value = "";
			what.focus();
		}
	}
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
				<li><a href="jjimBbs.jsp"><img
						src="images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">찜목록</a></li>
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
				<li><a href="jjimBbs.jsp"><img
						src="images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">찜목록</a></li>
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
		<section class="sign_section">
			<form name="chagnepw" action="ChangePW_success.jsp" method="post"
				onsubmit="return validate()" enctype="text/pain">
				<div class="signup">
					<input type="hidden" name="userID" value="<%=userID%>">
					<h2>비밀번호 변경</h2>
					<div class="text">현재 비밀번호</div>
					<div>
						<input type="password" name="userPW" placeholder="현재 비밀번호"
							class="input_text">
					</div>
					<div class="text">
						새 비밀번호&nbsp;&nbsp;<span style="font-size: 10px;">영문, 숫자,
							특문이 2종류 이상 조합된 8~20자</span>
					</div>
					<div>
						<input type="password" name="newPw" id="new_pw"
							placeholder="새 비밀번호" class="input_text">

					</div>
					<div>
						<input type="password" name="newPwCheck" id="new_pwck"
							placeholder="새 비밀번호 확인" class="input_text">
					</div>
					<div>
						<input type="submit" id="btnChangePw" class="signbtn"
							value="비밀번호 변경" />
					</div>
				</div>
			</form>
		</section>
		<%
		}
		%>

	</div>
</body>
</html>