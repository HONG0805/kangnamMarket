<%@page import="javax.security.auth.Subject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
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
	href="${pageContext.request.contextPath}/CSS/Chat.css?v=4.0" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/favicon/flat-design-touch.png">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
</style>
<script type="text/javascript">
    var websocket;
    var line = 0;
    var userID = "<%=session.getAttribute("userID") != null ? session.getAttribute("userID") : ""%>";

	// WebSocket 서버 주소 동적으로 처리
	if (userID === "") {
		alert("로그인 후 이용 가능합니다.");
		window.location.href = "${pageContext.request.contextPath}/view/pages/Login.jsp";
	} else {
		websocket = new WebSocket("ws://localhost:8080/Chat");
	}

	// WebSocket 연결 성공 시
	websocket.onopen = function(message) {
		document.getElementById("state").innerHTML = "소켓 시작";
	}

	// WebSocket 연결 종료 시
	websocket.onclose = function(message) {
		console.log("WebSocket 연결이 종료되었습니다.");
	}

	// WebSocket 오류 발생 시
	websocket.onerror = function(event) {
		console.error("WebSocket 오류 발생:", event);
	}

	// WebSocket 메시지 수신 시 처리
	websocket.onmessage = function(message) {
		var chatBox = document.getElementById("chat");

		if (++line % 20 == 0) {
			line = 0;
			chatBox.value = "";
		}

		chatBox.value += "\n" + message.data;
		chatBox.scrollTop = chatBox.scrollHeight; // 자동 스크롤
	}

	// 메시지 전송 함수
	function sendmessage() {
		if (websocket.readyState === WebSocket.OPEN) {
			var msg = "[" + userID + "] "
					+ escapeHtml(document.getElementById("send").value);
			websocket.send(msg);
			document.getElementById("send").value = ""; // 입력란 초기화
		} else {
			console.warn("WebSocket 연결이 닫혀 있습니다.");
			alert("WebSocket 연결이 닫혀 있습니다. 페이지를 새로고침하세요.");
		}
	}

	// 엔터 키로 메시지 전송
	function keypress(event) {
		var keycode = event.keyCode || event.which;
		if (keycode === 13) { // Enter키
			sendmessage();
		}
	}

	// XSS 방지를 위한 HTML 이스케이프 처리
	function escapeHtml(str) {
		return str.replace(/[&<>"']/g, function(match) {
			const escape = {
				'&' : '&amp;',
				'<': '&lt;',
                '>' : '&gt;',
				'"' : '&quot;',
				"'" : '&#039;'
			};
			return escape[match];
		});
	}
</script>
</head>
<body>
	<%
		String userID = (String) session.getAttribute("userID");
	%>
	<div id="wrap">
		<%
			if (userID == null) {
		%>
		<section class="info_section">
			<ul class="info_list">
				<li><a
					href="${pageContext.request.contextPath}/view/pages/MainPage.jsp">
						<img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">메인홈
				</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Login.jsp">
						<img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보
				</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Login.jsp">
						<img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그인
				</a></li>
			</ul>
		</section>
		<header class="header">
			<h1 class="logo">
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp">
					<img
					src="${pageContext.request.contextPath}/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터
				</a>
			</h1>
		</header>
		<section class="sign_section">
			<div class="signup">
				<h2>로그인 후 이용가능 합니다.</h2>
				<div>
					<input type="button" id="btnPwSearch" class="loginbtn" value="로그인"
						onclick="location.href='${pageContext.request.contextPath}/view/pages/Login.jsp'" />
				</div>
				<div>
					<input type="button" id="btnSignUp" class="loginbtn" value="회원가입"
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
					href="${pageContext.request.contextPath}/view/pages/jjimBbs.jsp">
						<img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">찜목록
				</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/MyPage.jsp">
						<img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보
				</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Logout.jsp">
						<img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그아웃
				</a></li>
			</ul>
		</section>
		<header class="header">
			<h1 class="logo">
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp">
					<img
					src="${pageContext.request.contextPath}/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터
				</a>
			</h1>
		</header>
		<section class="chat_section">
			<h2>채팅</h2>
			<textarea id="chat" class="chatform" readonly></textarea>
		</section>

		<section class="chat_section_1">
			<div>
				<input type="text" class="inputchat" id="send"
					placeholder="메시지를 입력하세요" onkeypress="keypress(event)" />
				<button class="chat_btn" onclick="sendmessage()">전송</button>
			</div>
		</section>
		<%
			}
		%>
	</div>
</body>
</html>
