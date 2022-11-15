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

.IDresult {
	font-weight: bold;
	color: gray;
}

.header h3 {
	width: 100%;
	text-align: center;
	font-size: 14px;
}

.idsearch_section {
	display: flex;
	flex-direction: column;
	flex-direction: row;
	justify-content: center;
	order: 2;
	padding: 50px;
	width: 100%;
}

div.idsearch_success>h2 {
	font-size: 25px;
	margin-bottom: 10px;
}

div.idsearch_success>div.text {
	font-size: 14px;
	margin-top: 8px;
	margin-bottom: 4px;
}

.idsearch_success {
	border: 1px solid #1289dd;
	border-radius: 10px;
	padding: 20px;
}

input::placeholder {
	color: #a7a7a7;
	font-style: italic;
	font-size: 15px;
	vertical-align: middle;
}

.input_text {
	border: 1px solid #a6a6a6;
	border-radius: 5px;
	font-size: 14px;
	width: 200px;
	padding: 5px;
}

.btn_IDsearch{
	display: flex;
	justify-content: center;
}

.loginbtn {
	width : 100%;
	color: white;
	padding: 5px;
	border-radius: 5px;
	margin: 20px 5px 5px 5px;
	font-weight: bold;
	text-align: center;
	background-color: rgba(0, 147, 245);
	font-size: 10px;
}

/* 태블릿용 CSS */
@media all and (min-width:768px) {
	.header h1 {
		font-size: 50px;
	}
	.header h3 {
		font-size: 30px;
	}
	div.idsearch_success>h2 {
		font-size: 30px;
		margin-bottom: 20px;
	}
	div.idsearch_success>div.text {
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
	.loginbtn {
		font-size: 14px;
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
	.idsearch_section {
		padding: 80px;
	}
	.idsearch_success {
		padding: 40px;
	}
	.loginbtn {
		font-size: 14px;
	}
}
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
	<form name="pwsearch" method="post" action="ChangePW_1.jsp">
		<div id="wrap">
			<header class="header">
				<h1><a href="Login.jsp">Kangnam University</a></h1>
				<div>
					<h3><a href="Login.jsp">중고장터</a></h3>
				</div>
			</header>

			<section class="idsearch_section">
				<div class="idsearch_success">
					<h2>비밀번호 결과</h2>
					<div class="IDresult">회원님의 비밀번호를 변경하셔야 합니다.</div>
					<div class="btn_IDsearch">
						<input type="hidden" name="userID" value="<%=userID%>"> 
						<input type="hidden" name="userPW" value="<%=userPW%>"> 
						<input type="submit" id="btnChangePw" class="loginbtn" value="비밀번호 변경"
							onclick="location.href='ChangePW_1.jsp'" />
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
						onclick="location.href='PwSearch.jsp'" />
				</div>
				<div>
					<input type="button" id="btnSignUp" class="loginbtn" value="회원가입"
						onclick="location.href='SignUp.jsp'" />
				</div>
			</div>
		</section>
	</div>
	<%
	}
	%>

</body>
</html>