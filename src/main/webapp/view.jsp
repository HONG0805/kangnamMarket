<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="reply.Reply"%>
<%@ page import="reply.ReplyDAO"%>
<%@ page import="java.util.ArrayList"%>
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

p {
	margin: 10px;
	overflow: hidden;
	word-wrap: break-word;
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
	order: 2;
}

.board_section_1 {
	width: 100%;
	order: 4;
}

.category_div {
	padding: 20px;
	border-radius: 5px;
	border: 2px solid #4f94e4;
}

.btn_primary {
	float: left;
	margin: 5px;
	padding: 10px;
	border-radius: 5px;
	border: 2px solid black;
	background: #d6d6d6;
	color: white;
	font-weight: bold;
}

.back_list {
	float: right;
	margin: 5px;
	padding: 10px;
	border-radius: 5px;
	border: 2px solid black;
	background: #d6d6d6;
	color: white;
	font-weight: bold;
	padding: 10px;
}

.reply_section {
	order: 3;
	width: 100%;
	margin-bottom: 100px;
}

.table-striped {
	text-align: center;
	width: 100%;
}

.reply_title {
	background-color: #4f94e4;
	border-radius: 5px;
	text-align: center;
	padding: 10px;
	width: 100%;
	color: white;
}

.form-control {
	width: 95%;
	border-radius: 5px;
	border: 2px solid #4f94e4;
	border-radius: 5px;
}

.reply_btn {
	padding: 5px;
	margin: 5px;
	text-align: center;
	float: right;
	font-weight: bold;
	border-radius: 5px;
	background-color: #4f94e457;
	color: black;
	float: right;
	font-weight: bold;
	border-radius: 5px;
	background-color: #4f94e457;
	color: black;
	width: 70%;
}

.reply_tr td {
	width: 100%;
	border: 1px solid #4f94e4;
	border-radius: 5px;
	padding: 10px;
	overflow: hidden;
	text-overflow: ellipsis;
}

.reply_td_font {
	font-size: 11px;
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
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}

	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='MainPage.jsp'");
		script.println("</script>");
	}

	Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>
	<div id="wrap">
		<%
		if (userID == null) {
		%>
		<section class="info_section">
			<ul class="info_list">
				<li><a href=""><img
						src="images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">알림</a></li>
				<li><a href=""><img
						src="images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a href="Login.jsp"><img
						src="images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그인</a></li>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="MainPage.jsp"><img src="images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>
		<section class="sign_section">
			<div class="signup">
				<h2>로그인 후 이용가능 합니다.</h2>
				<div>
					<input type="button" id="btnPwSearch" class="loginbtn" value="로그인"
						onclick="location.href='Login.jsp'" />
				</div>
				<div>
					<input type="button" id="btnSignUp" class="loginbtn" value="회원가입"
						onclick="location.href='SignUp.jsp'" />
				</div>
			</div>
		</section>

		<%
		} else {
		%>
		<section class="info_section">
			<ul class="info_list">
				<li><a href=""><img
						src="images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">알림</a></li>
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
			<div class="category_div">
				<p>
					작성자 :
					<%=bbs.getUserNickName()%></p>
				<p>
					작성일자 :
					<%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
		+ bbs.getBbsDate().substring(14, 16) + "분"%></p>
				<p style="font-size: 30px; font-weight: bold;"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n",
		"<br>")%></p>
			
				<p><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n",
		"<br>")%></p>
			</div>
		</section>

		<section class="reply_section">
			<form method="post" action="replyAction.jsp?bbsID=<%=bbsID%>">
				<table class="table-striped">
					<thead>
						<tr>
							<th colspan="3" class="reply_title">댓글</th>
						</tr>
					</thead>
					<tbody>

						<%
						ReplyDAO replyDAO = new ReplyDAO();
						ArrayList<Reply> list = replyDAO.getList(bbsID, pageNumber);
						for (int i = list.size() - 1; i >= 0; i--) {
						%>

						<tr class="reply_tr">
							<td style="text-align: left;"><%=list.get(i).getReplyContent()%></td>
							<td style="text-align: right;"><%=list.get(i).getUserID()%>
								<a href="reply_deleteAction.jsp?bbsID=<%=bbsID%>"
								class="reply_btn ">삭제</a></td>
						</tr>

						<%
						}
						%>
						<td><textarea type="text" class="form-control"
								placeholder="댓글을 입력하세요." name="replyContent" maxlength="2048"></textarea>
						</td>
						<td><input type="submit" class="reply_btn" value="댓글입력"></td>

					</tbody>
				</table>

			</form>
		</section>

		<section class="board_section_1">
			<div class="btn_div">
				<%
				if (userID != null && userID.equals(bbs.getUserNickName())) {
				%>
				<a href="update.jsp?bbsID=<%=bbsID%>" class="btn_primary">수정</a> <a
					onclick="return confirm('정말로 삭제하시겠습니까?')"
					href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn_primary">삭제</a>
				<a href="MainPage.jsp" class="back_list">목록</a>
				<%
				}
				%>
			</div>
		</section>
	</div>
	<%
	}
	%>
</body>
</html>
