<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

.header {
	display: flex;
	flex-direction: column;
	order: 1;
	width: 100%;
	align-items: center;
}

.header h1 {
	width: 100%;
	padding: 100px 30px 30px 30px;
	text-align: center;
	font-size: 30px;
}

.header h3 {
	width: 100%;
	text-align: center;
	font-size: 14px;
}

.login_section {
	display: flex;
	order: 2;
	padding-top: 80px;
	width: 100%;
	flex-direction: column;
	align-items: center;
}

.login_section div {
	display: block;
	border: 1px solid #a7a7a7;
	padding: 10px;
	border-radius: 5px;
	margin: 5px;
	font-weight: bold;
	font-size: 14px;
}

.login_section input {
	float: right;
	border: none;
	font-size: 12px;
	color: #a7a7a7;
	margin-left: 10px;
	width: 180px;
}

.btnsection {
	display: flex;
	order: 3;
	width: 100%;
	padding: 10px;
	align-items: center;
	justify-content: center;
}

.btn_login {
	width: 270px;
	text-align: center;
	color: #ffffff;
	background: #4d90de;
	border-radius: 5px;
	float: right;
	cursor: pointer;
	padding: 10px;
}

.login_section_1 {
	display: flex;
	order: 4;
	padding: 5px;
	width: 100%;
	order: 4;
	align-items: center;
	justify-content: center;
}

.login_section_1 div {
	text-align: center;
	border: 1px solid #a7a7a7;
	border-radius: 5px;
	padding: 10px;
	font-size: 12px;
}

.changepw_div {
	float: left;
	margin-right: 15px;
}

.signup_div {
	float: left;
}

/* 태블릿용 CSS */
@media all and (min-width:768px) {
	.header h1 {
		font-size: 50px;
	}
	.header h3 {
		font-size: 30px;
	}
	.btn_login {
		width: 260px;
	}
}

/* PC용 CSS */
@media all and (min-width:1200px) {
	/* 기본 CSS */
	#wrap {
		position: relative;
		width: 50%;
	}
	.header h1 {
		width: 100%;
		padding: 150px 30px 30px 30px;
		text-align: center;
		font-size: 60px;
	}
	.header h3 {
		width: 100%;
		text-align: center;
		font-size: 28px;
	}
	.btnsection {
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.btn_login {
		display: flex;
		width: 260px;
		justify-content: center;
	}
	.login_section_1 {
		display: flex;
		width: 100%;
		align-items: center;
		justify-content: center;
	}
}
</style>
</head>
<body>
	<div id="wrap">
		<header class="header">
			<h1>Kangnam University</h1>
			<div>
				<h3>중고장터</h3>
			</div>
		</header>

		<section class="login_section">
			<form action="/login.jsp" method="post">
				<div>
					아이디 &nbsp;&nbsp;&nbsp;| <input type="text" name="id" id="userid"
						placeholder="아이디를 입력해주세요.">
				</div>
				<div>
					비밀번호 | <input type="text" name="pw" id="userpw"
						placeholder="비밀번호를 입력해주세요.">
				</div>
				<a href="" onclick="submitForm();" class="btn_login">로그인</a>
				</form>
		</section>
		<section class="login_section_1">
			<div class="changepw_div">
				<a href="IdPwSearch.jsp">아이디/비밀번호 찾기</a>
			</div>
			<div class="signup_div">
				<a href="SignUp.jsp">회원가입</a>
			</div>
		</section>
	</div>
</body>
</html>