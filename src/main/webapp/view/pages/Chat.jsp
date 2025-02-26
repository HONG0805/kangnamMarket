<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="chat.ChatDAO"%>
<%@ page import="java.util.List"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>강남대학교 중고장터</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/reset.css?v=2.0">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/Chat.css?v=7.0" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/favicon/flat-design-touch.png">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

    var websocket;
    var line = 0;
    var userID = "<%=session.getAttribute("userID") != null ? session.getAttribute("userID") : ""%>";
	var roomId = <%=request.getParameter("roomID") != null ? Integer.parseInt(request.getParameter("roomID")) : -1%>;

	if (userID === "") {
		alert("로그인 후 이용 가능합니다.");
		window.location.href = "${pageContext.request.contextPath}/view/pages/Login.jsp";
	} else {
		websocket = new WebSocket("ws://localhost:8080/kangnamM/Chat/" + roomId
				+ "?userID=" + userID); // roomId 사용
	}

	websocket.onopen = function(message) {
		console.log("WebSocket 연결 되었습니다.");
	}

	websocket.onclose = function(message) {
		console.log("WebSocket 연결이 종료되었습니다.");
	}

	websocket.onerror = function(event) {
		console.error("WebSocket 오류 발생:", event);
	}

	websocket.onmessage = function(message) {
		var chatBox = document.getElementById("chat");
		if (++line % 20 == 0) {
			line = 0;
			chatBox.value = "";
		}
		chatBox.value += "\n" + message.data;
		chatBox.scrollTop = chatBox.scrollHeight; // 자동 스크롤
	}

	function sendmessage() {
		if (websocket.readyState === WebSocket.OPEN) {
			var msg = escapeHtml(document.getElementById("send").value);

			$
					.ajax({
						url : '${pageContext.request.contextPath}/view/actions/ChatAction.jsp', // 실제 처리할 JSP 경로
						type : 'POST',
						data : {
							roomId : roomId,
							userID : userID,
							message : msg
						},
						success : function(response) {
							websocket.send(msg); // 서버 처리 후 메시지를 웹소켓으로 전송
							document.getElementById("send").value = ""; // 입력란 초기화
						},
						error : function() {
							alert("서버와 연결할 수 없습니다.");
						}
					});
		} else {
			console.warn("WebSocket 연결이 닫혀 있습니다.");
			alert("WebSocket 연결이 닫혀 있습니다. 페이지를 새로고침하세요.");
		}
	}

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
		// 로그인 상태 확인
		String userID = (String) session.getAttribute("userID");
		if (userID == null) {
	%>
	<div id="wrap">
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
				// 메시지 목록을 가져오기
				int roomId = Integer.parseInt(request.getParameter("roomID"));
				ChatDAO chatDAO = new ChatDAO();
				List<String> messages = chatDAO.getMessages(roomId); // 채팅방의 모든 메시지 가져오기
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
    <div id="chat" class="chat_container">
        <%
            String currentUserID = (String) session.getAttribute("userID"); // 현재 로그인한 사용자 ID 가져오기
            
            for (String message : messages) {
                String[] parts = message.split(" ", 2); 
                String senderID = parts[0]; 
                String chatMessage = parts[1]; 
                
                // 보낸 사람이 현재 로그인한 사용자라면 오른쪽 정렬
                String cssClass = senderID.equals(currentUserID) ? "my-message" : "other-message";
        %>
            <div class="<%= cssClass %>">
                <strong><%= senderID %></strong> <%= chatMessage %>
            </div>
        <%
            }
        %>
    </div>
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
