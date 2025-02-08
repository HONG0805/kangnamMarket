<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>강남대학교 중고장터 회원가입</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/reset.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/SignUp.css?v=1.0">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/favicon/flat-design-touch.png">
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
</style>
<script type="text/javascript">
	function validate() {
		var userID = document.getElementById("my_id");
		var userPassword = document.getElementById("my_password");
		var userEmail = document.getElementById("my_email");
		var userName = document.getElementById("my_name");
		var userNickName = document.getElementById("my_nickname");

		var arrNum1 = new Array();
		var arrNum2 = new Array();

		//아이디, 패스워드 값 데이터 정규화
		var regul1 = /^[a-zA-Z0-9]{8,20}$/;
		//이메일 정규화
		var regul2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
		// 이름 정규화
		var regul3 = /^[가-힝a-zA-Z]{2,}$/;

		if ((userID.value) == "") {
			alert("아이디를 입력하지 않았습니다.");
			userID.focus();
			return false;
		}
		//아이디 유효성 검사
		if (!check(regul1, userID, "아이디는 8~20자의 대소문자와 숫자로만 입력 가능합니다.")) {
			return false;
		}

		if ((userPassword.value) == "") {
			alert("비밀번호를 입력해 주세요");
			userPassword.focus();
			return false;
		}
		if (!check(regul1, userPassword, "비밀번호는 8~20자의 대소문자와 숫자로만 입력 가능합니다.")) {
			return false;
		}

		if ((userEmail.value) == "") {
			alert("이메일을 입력해 주세요");
			userEmail.focus();
			return false;
		}
		if (!check(regul2, userEmail, "이메일을 잘못 입력 했습니다.")) {
			return false;
		}

		if ((userName.value) == "") {
			alert("이름을 입력해 주세요");
			userName.focus();
			return false;
		}
		if (!check(regul3, userName, "이름이 잘못 되었습니다.")) {
			return false;
		}

		if ((userNickName.value) == "") {
			alert("닉네임을 입력해 주세요");
			userNickName.focus();
			return false;
		}
		if (!check(regul3, userNickName, "닉네임이 잘못 되었습니다.")) {
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
	<div id="wrap">
		<header class="header">
			<h1>
				<a href="${pageContext.request.contextPath}/view/pages/Login.jsp">Kangnam
					University</a>
			</h1>
			<div>
				<h3>
					<a href="${pageContext.request.contextPath}/view/pages/Login.jsp">중고장터</a>
				</h3>
			</div>
		</header>

		<section class="sign_section">
			<form name="f"
				action="${pageContext.request.contextPath}/view/actions/SignUp_Action.jsp"
				method="post" onsubmit="return validate()" enctype="text/plain">
				<div class="signup">
					<h2>회원가입</h2>
					<div class="text">아이디</div>
					<div>
						<input type="text" name="userID" id="my_id" placeholder="아이디"
							class="input_text">
					</div>
					<div class="text">
						비밀번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 10px;">비밀번호
							8~20자의 대소문자와 숫자</span>
					</div>
					<div>
						<input type="password" name="userPassword" id="my_password"
							placeholder="비밀번호" class="input_text">
					</div>
					<div class="text">이메일</div>
					<div>
						<input type="text" name="userEmail" id="my_email"
							placeholder="이메일@example.com" class="input_text">
					</div>
					<div class="text">이름</div>
					<div>
						<input type="text" name="userName" id="my_name" placeholder="이름"
							class="input_text">
					</div>
					<div class="signbtn">
						<input type="submit" class="bt_signup" value="회원가입">
					</div>
				</div>
			</form>
		</section>

	</div>
</body>
</html>
