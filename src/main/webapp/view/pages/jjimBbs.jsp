<%@ page import="javax.security.auth.Subject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.JjimDAO"%>
<%@ page import="bbs.Jjim"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>강남대학교 중고장터</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/reset.css?v=1.0">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/jjimBbs.css?v=1.0">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/favicon/flat-design-touch.png">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
</head>
<body>
	<%
		String userID = (String) session.getAttribute("userID");
		if (userID == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}

		JjimDAO jjimDAO = new JjimDAO();
		ArrayList<Bbs> list = jjimDAO.getList(userID, pageNumber);
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
					href="${pageContext.request.contextPath}/view/pages/MyPage.jsp"><img
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
				<a href="MainPage.jsp"><img
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
				<li><a
					href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">메인홈</a></li>
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
				<a href="MainPage.jsp"><img
					src="${pageContext.request.contextPath}/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>

		<section class="content_search">
			<div class="content_row_2">
				<form class="search" method="post"
					action="${pageContext.request.contextPath}/view/pages/searchedBbs.jsp">
					<input type="text" name="searchWord" placeholder="검색어를 입력해주세요."
						class="text">
					<button type="submit" class="search_check">
						<img
							src="${pageContext.request.contextPath}/images/s_images/search-line.png"
							style="width: 20px; height: 20px;">
					</button>
				</form>
			</div>
		</section>

		<section class="content_section">
			<div class="content_article">
				<a href="Board.jsp" id="writeArticleButton">새글을 작성해주세요.<img
					src="${pageContext.request.contextPath}/images/s_images/pen-nib-line.png"
					class="writeimg"></a>
			</div>

			<%
				BbsDAO bbsDAO = new BbsDAO();
					for (int i = 0; i < list.size(); i++) {
			%>
			<div style="text-align: center; border: 1px solid #dddddd">
				<div class="comment">
					<a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>">
						<div align="left" class="bbstitle">
							<%=list.get(i).getBbsTitle()%>
						</div>
						<div align="left" class="bbscontent">
							<%=list.get(i).getBbsContent()%>
							<p>
								가격:
								<%=list.get(i).getCost()%>원
							</p>
						</div>
						<div align="left" class="bbsdate">
							<%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13)
							+ ":" + list.get(i).getBbsDate().substring(14, 16)%>
							<b>| 작성자:</b>
							<%=list.get(i).getUserName()%>
						</div>
					</a>
				</div>
			</div>
			<%
				}
			%>
		</section>

		<footer class="pagination_footer">
			<div class="pagination">
				<%
					if (pageNumber > 1) {
				%>
				<a href="jjimBbs.jsp?pageNumber=<%=pageNumber - 1%>" class="prev">이전</a>
				<%
					}
						if (jjimDAO.nextPage(userID, pageNumber)) {
				%>
				<a href="jjimBbs.jsp?pageNumber=<%=pageNumber + 1%>" class="next">다음</a>
				<%
					}
				%>
			</div>
		</footer>
	</div>
	<%
		}
	%>
</body>
</html>
