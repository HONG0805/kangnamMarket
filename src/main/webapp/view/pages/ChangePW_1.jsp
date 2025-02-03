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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/ChangePW_1.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/reset.css">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript">
	function validate() {
		var newPW = document.getElementById("new_pw");
		var newPWCK = document.getElementById("new_pwck");

		var regul1 = /^[a-zA-Z0-9]{8,20}$/;

		if (newPW.value == "" || newPWCK.value == "") {
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
			return false;
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
	<form name="changePw"
		action="${pageContext.request.contextPath}/view/actions/ChangePW_success.jsp"
		method="post" onsubmit="return validate()">
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

					<input type="submit" id="btnChangePw" class="signbtn"
						value="비밀번호 변경" />
				</div>
			</section>
		</div>
	</form>
</body>
</html>
