<%@ page import="javax.security.auth.Subject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
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
	href="${pageContext.request.contextPath}/CSS/MainPage.css?v=1.0">

<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/favicon/flat-design-touch.png">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
</style>
</head>
<body>
	<%
		String userID = (String) session.getAttribute("userID");
		int pageNumber = request.getParameter("pageNumber") != null
				? Integer.parseInt(request.getParameter("pageNumber"))
				: 1;
		String searchWord = request.getParameter("searchWord") != null ? request.getParameter("searchWord") : "";
	%>

	<div id="wrap">
		<section class="info_section">
			<ul class="info_list">
				<%
					if (userID == null) {
				%>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px;" alt="찜목록">메인홈</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Login.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px;" alt="내정보">내정보</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Login.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px;" alt="로그인">로그인</a></li>
				<%
					} else {
				%>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/jjimBbs.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px;" alt="찜목록">찜목록</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/MyPage.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px;" alt="내정보">내정보</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Logout.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px;" alt="로그아웃">로그아웃</a></li>
				<%
					}
				%>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
					src="${pageContext.request.contextPath}/images/s_images/마크.png"
					style="width: 98px;" alt="로고"> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>

		<%
			if (userID == null) {
		%>
		<section class="sign_section">
			<div class="signup">
				<h2>로그인 후 이용가능 합니다.</h2>
				<div>
					<input type="button" class="loginbtn" value="로그인"
						onclick="location.href='${pageContext.request.contextPath}/view/pages/Login.jsp'" />
				</div>
				<div>
					<input type="button" class="loginbtn" value="회원가입"
						onclick="location.href='${pageContext.request.contextPath}/view/pages/SignUp.jsp'" />
				</div>
			</div>
		</section>
		<%
			} else {
		%>
		<section class="content_search">
			<div class="content_row_2">
				<form class="search" method="post"
					action="${pageContext.request.contextPath}/view/pages/searchedBbs.jsp">
					<input type="text" name="searchWord" placeholder="검색어를 입력해주세요."
						class="text" value="<%=searchWord%>">
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
				<a href="${pageContext.request.contextPath}/view/pages/Board.jsp"
					id="writeArticleButton">새글을 작성해주세요.<img
					src="${pageContext.request.contextPath}/images/s_images/pen-nib-line.png"
					class="writeimg"></a>
			</div>

			<%
				BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getSearchedList(pageNumber, searchWord); 
					for (Bbs bbs : list) {
			%>
			<div style="border: 1px solid #dddddd">
				<div class="comment">
					<a
						href="${pageContext.request.contextPath}/view/pages/view.jsp?bbsID=<%=bbs.getBbsID()%>">
						<div class="bbstitle"><%=bbs.getBbsTitle()%></div>
						<div class="bbscontent">
							<%=bbs.getBbsContent()%>
							<p>
								가격:
								<%=bbs.getCost()%>원
							</p>
						</div>
						<div class="bbsdate">
							<%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + ":"
							+ bbs.getBbsDate().substring(14, 16)%>
							<b>| 작성자:</b>
							<%=bbs.getUserName()%>
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
					if (pageNumber != 1) {
				%>
				<a
					href="${pageContext.request.contextPath}/view/pages/MainPage.jsp?pageNumber=<%=pageNumber - 1%>&searchWord=<%=searchWord%>"
					class="prev">이전</a>
				<%
					}
				%>
				<%
					if (bbsDAO.searchedNextPage(pageNumber, searchWord)) {
				%>
				<a
					href="${pageContext.request.contextPath}/view/pages/MainPage.jsp?pageNumber=<%=pageNumber + 1%>&searchWord=<%=searchWord%>"
					class="next">다음</a>
				<%
					}
				%>
			</div>
		</footer>
		<%
			}
		%>
	</div>
</body>
</html>
