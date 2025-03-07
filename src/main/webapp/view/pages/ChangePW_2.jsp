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
	href="${pageContext.request.contextPath}/CSS/ChangePW_2.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/reset.css">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/favicon/flat-design-touch.png">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript">
	function validate() {
		var newPW = document.getElementById("new_pw");
		var newPWCK = document.getElementById("new_pwck");

		//아이디, 패스워드 값 데이터 정규화
		var regul1 = /^(?=(.*[a-zA-Z]){1,})(?=(.*\d){1,})(?=(.*[!@#$%^&*()_+={}\[\]:;"'<>,.?/\\|-]){1,}).{8,20}$/;

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
				<li><a
					href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">메인홈</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Login.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Login.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그인</a></li>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
					src="${pageContext.request.contextPath}/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>
		<section class="sign_section">
			<div class="signup">
				<h2>로그인 후 이용가능 합니다.</h2>
				<div>
					<input type="button" id="btnPwSearch" class="loginbtn" value="로그인"
						onclick="location.href='${pageContext.request.contextPath}/view/pages/Login.jsp'" />
				</div>
				<div>
					<input type="button" id="btnSignUp" class="loginbtn" value="회원가입"
						onclick="location.href='${pageContext.request.contextPath}/view/pages/SignUp.jsp'" />
				</div>
			</div>
		</section>
		<%
			} else {
		%>
		<section class="info_section">
			<ul class="info_list">
				<li><a
					href="${pageContext.request.contextPath}/view/pages/jjimBbs.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">찜목록</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/MyPage.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Logout.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그아웃</a></li>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
					src="${pageContext.request.contextPath}/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>
		<section class="sign_section">
			<form name="changePw"
				action="${pageContext.request.contextPath}/view/actions/ChangePW_success.jsp"
				method="post" onsubmit="return validate()"
				enctype="application/x-www-form-urlencoded">
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
							특문이 1종류 이상 조합된 8~20자</span>
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
