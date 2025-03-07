<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="chat.ChatDAO"%>
<!-- ChatDAO import 추가 -->
<%@ page import="java.util.List"%>
<!-- List import 추가 -->
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
	href="${pageContext.request.contextPath}/CSS/MyPage.css?v=3.0">
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
		request.setCharacterEncoding("UTF-8");
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		User user = new User();
		ChatDAO chatDAO = new ChatDAO(); // ChatDAO 객체 생성

		// 사용자의 채팅방 목록을 가져오기 위한 코드
		List<Integer> chatRooms = null; // Integer로 타입 변경
		if (userID != null) {
			chatRooms = chatDAO.getJoinedRooms(userID); // 사용자의 채팅방 리스트를 가져오는 메소드 호출
		}
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
					href="${pageContext.request.contextPath}/view/pages/Login.jsp"><img
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
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
					src="${pageContext.request.contextPath}/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>

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
		<section class="info_section">
			<ul class="info_list">
				<li><a
					href="${pageContext.request.contextPath}/view/pages/jjimBbs.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">찜목록</a></li>
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
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
					src="${pageContext.request.contextPath}/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>

		<section class="my_section">
			<div class="my_info">
				<h1>내 정보</h1>
				<a href="${pageContext.request.contextPath}/view/pages/Logout.jsp"
					class="logout">로그아웃</a>
			</div>
			<div class="my_profile">
				<img
					src="${pageContext.request.contextPath}/images/s_images/user-line.png">
				<h3><%=userID%></h3>
				<p><%=user.getUserName()%></p>
				<p>학교/학번</p>
			</div>
		</section>

		<section class="my_section_1">
			<h2>계정</h2>
			<a href="${pageContext.request.contextPath}/view/utils/MailCheck.jsp"
				class="item">이메일 인증</a> <a
				href="${pageContext.request.contextPath}/view/pages/ChangePW_2.jsp"
				class="item">비밀번호 변경</a>
		</section>

		<section class="chat_rooms_section">
			<h2>내 채팅방</h2>
			<%
				if (chatRooms != null && !chatRooms.isEmpty()) {
						for (Integer chatRoom : chatRooms) {
			%>
			<div class="chat_room_item">
				<p><%=chatRoom%></p>
				<a
					href="<%=request.getContextPath() + "/view/pages/Chat.jsp?roomID=" + chatRoom%>">채팅방
					입장</a>
			</div>
			<%
				}
					} else {
			%>
			<p>채팅방이 없습니다.</p>
			<%
				}
			%>
		</section>
		<%
			}
		%>

	</div>
</body>
</html>
