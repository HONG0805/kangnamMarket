<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>아이디/비밀번호 찾기</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/reset.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/PwSearch_success.css">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/favicon/flat-design-touch.png">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
</style>
<script type="text/javascript">
	
</script>
</head>

<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String userID = request.getParameter("userID");
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");

		UserDAO dao = new UserDAO();
		String userPW = dao.findPw(userID, userName, userEmail);
	%>

	<%
		if (userPW != null) {
	%>
	<form name="pwsearch" method="post"
		action="${pageContext.request.contextPath}/view/pages/ChangePW_1.jsp">
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

			<section class="idsearch_section">
				<div class="idsearch_success">
					<h2>비밀번호 결과</h2>
					<div class="IDresult">회원님의 비밀번호를 변경하셔야 합니다.</div>
					<div class="btn_IDsearch">
						<input type="hidden" name="userID" value="<%=userID%>"> <input
							type="hidden" name="userPW" value="<%=userPW%>"> <input
							type="submit" id="btnChangePw" class="loginbtn" value="비밀번호 변경"
							onclick="location.href='${pageContext.request.contextPath}/view/pages/ChangePW_1.jsp'" />
					</div>
				</div>

			</section>
		</div>
	</form>
	<%
		} else {
	%>
	<div id="wrap">
		<header class="header">
			<h1>Kangnam University</h1>
			<div>
				<h3>중고장터</h3>
			</div>
		</header>

		<section class="idsearch_section">
			<div class="idsearch_success">
				<h2>비밀번호 결과</h2>
				<h4>등록된 정보가 없습니다.</h4>
				<div>
					<input type="button" id="btnPwSearch" class="loginbtn" value="다시찾기"
						onclick="location.href='${pageContext.request.contextPath}/view/pages/PwSearch.jsp'" />
				</div>
				<div>
					<input type="button" id="btnSignUp" class="loginbtn" value="회원가입"
						onclick="location.href='${pageContext.request.contextPath}/view/pages/SignUp.jsp'" />
				</div>
			</div>
		</section>
	</div>
	<%
		}
	%>

</body>
</html>
