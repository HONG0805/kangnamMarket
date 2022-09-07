<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

.signbtn {
	width : 100%;
	color: white;
	padding: 5px;
	margin-top: 20px;
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
}
form button {
    background-color: rgba(0, 147, 245, 0.5);
}

form button.active{
    background-color: rgba(0, 147, 245);
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

window.addEventListener('keyup', ()=>{
	const signbtn = document.getElementById('signbtn');
	const userName = document.getElementById("userName").value;
    const userId = document.getElementById('userID').value;
    const userEmail = document.getElementById('userEmail').value;
    if(userName.length > 0 && userId.length >0 && userEmail.length >0){
        signbtn.disabled = false;
        signbtn.classList.add('active');
    }else{
        signbtn.disabled = true;
        signbtn.classList.remove('active');
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

		<section class="sign_section">
		<form name ="pwsearch" method ="post">
			<div class="signup">
				<h2>비밀번호 찾기</h2>
				<div class="text">이름</div>
				<div>
					<input id="userName" name="name" placeholder="이름" class="input_text">
				</div>
				<div class="text">아이디</div>
				<div>
					<input id="userID" name="id" placeholder="아이디" class="input_text">
				</div>
				<div class="text">이메일</div>
				<div>
					<input id="userEmail" name="mail" placeholder="이메일@example.com"
						class="input_text">
				</div>
				<div>
					<button type="submit" id="signbtn" class="signbtn" disabled>비밀번호 찾기</button>
				</div>
			</div>
			</form>
		</section>
	</div>
</body>
</html>