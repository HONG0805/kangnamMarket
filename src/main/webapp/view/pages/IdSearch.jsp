<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	href="${pageContext.request.contextPath}/CSS/IdSearch.css">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/favicon/flat-design-touch.png">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript">
        window.addEventListener('keyup', () => {
            const signbtn = document.getElementById('signbtn');
            const userName = document.getElementById('name').value;
            const userEmail = document.getElementById('email').value;
            if(userName.length > 0 && userEmail.length > 0) {
                signbtn.disabled = false;
                signbtn.classList.add('active');
            } else {
                signbtn.disabled = true;
                signbtn.classList.remove('active');
            }
        });

        function id_search() {
            var frm = document.idsearch;
            if (frm.userName.value.length < 1) {
                alert("이름을 입력해주세요");
                return;
            }

            frm.method = "post";
            frm.action = "${pageContext.request.contextPath}/IdSearch_success.jsp";
            frm.submit();
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
			<form name="idsearch" method="post">
				<div class="signup">
					<h2>아이디 찾기</h2>
					<div class="text">이름</div>
					<div>
						<input id="name" name="userName" placeholder="이름"
							class="input_text">
					</div>
					<div class="text">이메일</div>
					<div>
						<input id="email" name="userEmail" placeholder="이메일@example.com"
							class="input_text">
					</div>
					<div>
						<input type="button" id="signbtn" class="signbtn" value="아이디 찾기"
							onClick="id_search()" disabled>
					</div>
				</div>
			</form>
		</section>
	</div>
</body>
</html>
