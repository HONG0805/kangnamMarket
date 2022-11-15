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
	width: 200px;
	padding: 5px;
	margin-bottom: 4px;
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
	.header h1 {
		font-size: 50px;
	}
	.header h3 {
		font-size: 30px;
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
	request.setCharacterEncoding("UTF-8");
	String userID = request.getParameter("userID");
	String userPW = request.getParameter("userPW");
	%>
	<form name="chagnepw" action="ChangePW_success.jsp" method="post"
		onsubmit="return validate()" enctype="text/pain">
		<div id="wrap">
			<header class="header">
				<h1>
					<a href="Login.jsp">Kangnam University</a>
				</h1>
				<div>
					<h3>
						<a href="Login.jsp">중고장터</a>
					</h3>
				</div>
			</header>

			<section class="sign_section">
				<div class="signup">
					<h2>비밀번호 변경</h2>
					<input type="hidden" name="userID" value="<%=userID%>"> <input
						type="hidden" name="userPW" value="<%=userPW%>">
					<div class="text">
						새 비밀번호&nbsp;&nbsp;<span style="font-size: 10px;">영문, 숫자,
							특문이 2종류 이상 조합된 8~20자</span>
					</div>
					<div>
						<input type="password" id="new_pw" name="newPw"
							placeholder="새 비밀번호" class="input_text">

					</div>
					<div>
						<input type="password" id="new_pwck" name="newPwCheck"
							placeholder="새 비밀번호 확인" class="input_text">
					</div>

					<input type="submit" id="btnChangePw" class="signbtn" value="비밀번호 변경" />
				</div>
			</section>
		</div>
	</form>
</body>
</html>