<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>강남대학교 중고장터</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/reset.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/Login.css">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.ico">
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/favicon/flat-design-touch.png">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
</style>
<script type="text/javascript">

window.addEventListener('keyup', ()=> {
	const loginbtn = document.getElementById('loginbtn');
	console.log(loginbtn);
	const userId = document.getElementById('user_id').value;
    const userPw = document.getElementById('user_pw').value;
    console.log("userId : ", userId);
    console.log("userPw : ", userPw);
    if(userPw.length > 0 && userId.length >0 ){
        loginbtn.disabled = false;
        loginbtn.classList.add('active');
    }else{
        loginbtn.disabled = true;
        loginbtn.classList.remove('active');
    }
});

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

		<section class="login_section">
			<form action="${pageContext.request.contextPath}/view/actions/loginAction.jsp"
				class="login_form" method="post">
				<div class="input_box">
					아이디 &nbsp;&nbsp;&nbsp;| <input type="text" name="userID"
						id="user_id" placeholder="아이디를 입력해주세요.">
				</div>
				<div class="input_box">
					비밀번호 | <input type="password" name="userPassword" id="user_pw"
						placeholder="비밀번호를 입력해주세요.">
				</div>
				<div>
					<button type="submit" id="loginbtn" class="btn_login" disabled>로그인</button>
				</div>
			</form>
		</section>
		<section class="login_section_1">
			<div class="changepw_div">
				<a href="${pageContext.request.contextPath}/view/pages/IdSearch.jsp">아이디찾기</a>
			</div>
			<div class="changepw_div">
				<a href="${pageContext.request.contextPath}/view/pages/PwSearch.jsp">비밀번호찾기</a>
			</div>
			<div class="signup_div">
				<a href="${pageContext.request.contextPath}/view/pages/SignUp.jsp">회원가입</a>
			</div>
		</section>
		<%
			} else {
		%>
		<header class="header">
			<h1>
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp">Kangnam
					University</a>
			</h1>
			<div>
				<h3>
					<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp">중고장터</a>
				</h3>
			</div>
		</header>

		<section class="login_section">
			<form action="${pageContext.request.contextPath}/view/actions/loginAction.jsp"
				class="login_form" method="post">
				<div class="input_box">
					아이디 &nbsp;&nbsp;&nbsp;| <input type="text" name="userID"
						id="user_id" placeholder="아이디를 입력해주세요.">
				</div>
				<div class="input_box">
					비밀번호 | <input type="password" name="userPassword" id="user_pw"
						placeholder="비밀번호를 입력해주세요.">
				</div>
				<div>
					<button type="submit" id="loginbtn" class="btn_login" disabled>로그인</button>
				</div>
			</form>
		</section>
		<section class="login_section_1">
			<div class="changepw_div">
				<a href="${pageContext.request.contextPath}/view/pages/IdSearch.jsp">아이디찾기</a>
			</div>
			<div class="changepw_div">
				<a href="${pageContext.request.contextPath}/view/pages/PwSearch.jsp">비밀번호찾기</a>
			</div>
			<div class="signup_div">
				<a href="${pageContext.request.contextPath}/view/pages/SignUp.jsp">회원가입</a>
			</div>
		</section>
		<%
			}
		%>
	</div>
</body>
</html>
