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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/reset.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/update.css">
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
	const btn_board = document.getElementById('btn_board');
	const bbsTitle = document.getElementById('bbs_title').value;
	const bbsContent = document.getElementById('bbs_content').value;
	const cost = document.getElementById('bbs_cost').value;

	if (bbsTitle.length > 0 && bbsContent.length > 0 && cost.length > 0) {
		btn_board.disabled = false;
		btn_board.classList.add('active');
	} else {
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
			script.println("location.href='${pageContext.request.contextPath}/Login.jsp'");
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
			script.println("location.href='${pageContext.request.contextPath}/MainPage.jsp'");
			script.println("</script>");
		}

		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserName())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='${pageContext.request.contextPath}/MainPage.jsp'");
			script.println("</script>");
		}
	%>
	<div id="wrap">
		<section class="info_section">
			<ul class="info_list">
				<li><a href="${pageContext.request.contextPath}/view/pages/jjimBbs.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">찜목록</a></li>
				<li><a href="${pageContext.request.contextPath}/view/pages/MyPage.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a href="${pageContext.request.contextPath}/view/pages/Logout.jsp"><img
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

		<section class="board_section">
			<form method="post"
				action="${pageContext.request.contextPath}/view/actions/updateAction.jsp?bbsID=<%=bbsID%>">
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
