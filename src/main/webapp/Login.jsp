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
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
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
	font-size: 15px;
	margin-left: 10px;
	width: 180px;
}

input::placeholder {
	color: #a7a7a7;
	font-style: italic;
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
	width: 100%;
	text-align: center;
	color: #ffffff;
	border-radius: 5px;
	padding: 10px;
	font-weight: bold;
}
form button {
    background-color: rgba(0, 147, 245, 0.5);
}

form button.active{
    background-color: rgba(0, 147, 245);
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
<script type="text/javascript">

window.addEventListener('keyup', ()=>{
	const loginbtn = document.getElementById('loginbtn');
	console.log(loginbtn);
	const userId = document.getElementById('user_id').value;
    const userPw = document.getElementById('user_pw').value;
    console.log("userId : ", userId);
    console.log("userPw : "+userPw);
    if(userPw.length > 0 && userId.length >0 ){
        loginbtn.disabled = false;
        loginbtn.classList.add('active');
    }else{
        loginbtn.disabled = true;
        loginbtn.classList.remove('active');
    }
})

</script>
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
			<form action="loginAction.jsp" class="login_form" method="post">
				<div class="input_box">
					아이디 &nbsp;&nbsp;&nbsp;| <input type="text" name="userID" id="user_id"
						placeholder="아이디를 입력해주세요.">
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
				<a href="IdSearch.jsp">아이디찾기</a>
			</div>
			<div class="changepw_div">
				<a href="PwSearch.jsp">비밀번호찾기</a>
			</div>
			<div class="signup_div">
				<a href="SignUp.jsp">회원가입</a>
			</div>
		</section>
	</div>
</body>

</html>