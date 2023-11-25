<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>강남대학교 중고장터 내 정보</title>
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

.info_section {
	order: 1;
	width: 100%;
	background: white;
	border-bottom: 1px solid black;
}

.info_list {
	display: flex;
}

.info_list li {
	width: 33.33%;
	text-align: center;
	font-weight: bold;
}

.info_list li a {
	display: block;
	padding: 15px 0;
	padding: 0.938rem 0;
	cursor: pointer;
}

.info_list img {
	vertical-align: middle;
	margin: 2px;
}

.header {
	display: flex;
	order: 2;
	flex-direction: column;
	position: relative;
	width: 100%;
}

.logo {
	order: 1;
	width: 100%;
	padding: 30px 0;
	padding: 1.875rem 0;
	font-size: 1.188rem;
	font-size: 1.188rem;
	line-height: 21px;
	line-height: 1.313rem;
	text-align: center;
	text-transform: uppercase;
}

.logo a {
	font-size: 20px;
}

#logo_1 {
	color: #4f94e4;
}

.logo img {
	vertical-align: middle;
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

.signup {
	border: 1px solid #1289dd;
	border-radius: 10px;
	padding: 20px;
}

.board_section {
	width: 100%;
	order: 3;
	padding: 10px;
	padding: 0.625rem;
	order: 3;
	text-align: center;
}

.category_div {
	width: 70%;
	display: inline-block;
	padding: 10px;
	padding: 0.625rem;
	border: 2px solid #4f94e4;
	border-radius: 10px;
	margin: 10px;
	padding: 10px;
}

.article_content {
	width: 70%;
	display: inline-block;
	height: 350px;
	padding: 10px;
	padding: 0.625rem;
	border: 2px solid #4f94e4;
	border-radius: 10px;
	margin: 10px;
}

textarea {
	width: 100%;
	height: 100%;
}

input {
	width: 100%;
	height: 100%;
}

.title {
	border: 0;
	font-weight: bold;
	font-size: 13px;
	outline: none;
}

.btn_div {
	width: 70%;
	display: inline-block;
}

.board_btn {
	width: 100%;
	text-align: center;
	color: #ffffff;
	border-radius: 5px;
	padding: 10px;
	padding: 0.625rem;
	font-weight: bold;
}

.folder_images {
	width: 70%;
	text-align: center;
	padding: 10px;
	border: 2px solid black;
	border-radius: 10px;
}

form button {
	background-color: rgba(0, 147, 245, 0.5);
}

form button.active {
	background-color: rgba(0, 147, 245);
}

.loginbtn {
	width: 90%;
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
	.header {
		flex-direction: row;
		height: 180px;
	}
	.logo {
		position: absolute;
		top: 0;
		left: 0;
		z-index: 10;
		width: 100%;
		padding: 0;
		text-align: center;
		left: 0;
	}
	.logo a {
		display: flex;
		align-items: center;
		padding: 50px;
		padding: 3.125rem;
		font-size: 40px;
		justify-content: center;
	}
	#wrap {
		flex-flow: row wrap;
	}
}

/* PC용 CSS */
@media all and (min-width:1200px) {
	/* 기본 CSS */
	#wrap {
		position: relative;
		width: 50%;
	}
	.info_section {
		order: 0;
		position: absolute;
		top: 70px;
		top: 4.375rem;
		right: 30px;
		right: 1.875rem;
		z-index: 30;
		width: auto;
		border-bottom: 0;
	}
	.info_list li {
		width: auto;
		margin-left: 30px;
		margin-left: 1.25rem;
		font-weight: bold;
	}
	.info_list li a {
		padding: 0;
	}
	.info_list a {
		align-items: center;
	}
	.info_list img {
		vertical-align: middle;
		margin: 2px;
	}
	.header {
		order: 1;
		justify-content: flex-end;
		position: static;
		height: 200px;
	}
	.logo {
		float: left;
		width: 70%;
	}
	.logo a {
		font-size: 30px;
		padding: 50px 0;
		padding: 3.125rem 0;
		justify-content: flex-start
	}
	#logo_1 {
		color: #4f94e4;
	}
	.logo img {
		vertical-align: middle;
	}
}
</style>
<script type="text/javascript">

window.addEventListener('keyup', ()=>{
	const btn_board = document.getElementById('btn_board');
	const bbsTitle = document.getElementById('bbs_title').value;
    const bbsContent = document.getElementById('bbs_content').value;
    const cost = document.getElementById('bbs_cost').value
    
    if(bbsTitle.length > 0 && bbsContent.length >0 && cost.length >0){
    	btn_board.disabled = false;
    	btn_board.classList.add('active');
    }else{
    	btn_board.disabled = true;
    	btn_board.classList.remove('active');
    }
})

</script>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href='Login.jsp'");
		script.println("</script>");
	}
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}

	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='MainPage.jsp'");
		script.println("</script>");
	}

	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserNickName())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href='MainPage.jsp'");
		script.println("</script>");
	}
	%>
	<div id="wrap">
		<section class="info_section">
			<ul class="info_list">
				<li><a href="jjimBbs.jsp"><img
						src="images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">찜목록</a></li>
				<li><a href="MyPage.jsp"><img
						src="images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a href="Logout.jsp"><img
						src="images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그아웃</a></li>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="MainPage.jsp"><img src="images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>

		<section class="board_section">
			<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>">
				<div class="category_div">
					<input type="text" autocapitalize="off" placeholder="제목을 입력해 주세요."
						class="title" id="bbs_title" name="bbsTitle" maxlength="50"
						value="<%=bbs.getBbsTitle()%>">
				</div>
				<input type="file" name="uploadFile" class="folder_images">
				<div class="category_div">
					<input type="number" name="cost" class="title"
						placeholder="가격을 입력해 주세요." maxlength="50" id="bbs_cost"
						name="cost" value="<%=bbs.getCost()%>">
				</div>
				<div class="article_content">
					<textarea autocapitalize="off" placeholder="글을 작성해 주세요."
						class="title" id="bbs_content" name="bbsContent" maxlength="2048"><%=bbs.getBbsContent()%></textarea>
				</div>
				<div class="btn_div">
					<button type="submit" class="board_btn" id="btn_board" disabled>수정하기
					</button>

				</div>
			</form>
		</section>

	</div>
</body>
</html>