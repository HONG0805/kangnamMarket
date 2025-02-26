<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="chat.ChatDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Objects" %>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/chatPopup.css?v=4">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	var websocket;
	var line = 0;
	var userID = "<%=session.getAttribute("userID") != null ? session.getAttribute("userID") : ""%>";
	var roomId = <%=request.getAttribute("roomId") != null? Integer.parseInt(request.getAttribute("roomId").toString()): -1%>;

	// 로그인 확인
	if (userID === "") {
		alert("로그인 후 이용 가능합니다.");
	} else {
		websocket = new WebSocket("ws://localhost:8080/kangnamM/Chat/" + roomId
				+ "?userID=" + userID); // roomId 사용
	}

	websocket.onopen = function(message) {
		console.log("WebSocket 연결 되었습니다.");
	};

	websocket.onclose = function(message) {
		console.log("WebSocket 연결이 종료되었습니다.");
	};

	websocket.onerror = function(event) {
		console.error("WebSocket 오류 발생:", event);
	};

	websocket.onmessage = function(message) {
		var chatBox = document.getElementById("chat");
		if (++line % 20 == 0) {
			line = 0;
			chatBox.value = "";
		}
		chatBox.value += "\n" + message.data;
		chatBox.scrollTop = chatBox.scrollHeight; // 자동 스크롤
	};

	function sendmessage() {
		if (websocket.readyState === WebSocket.OPEN) {
			var msg = escapeHtml(document.getElementById("send").value);

			$
					.ajax({
						url : '${pageContext.request.contextPath}/view/actions/ChatAction.jsp',
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

<!-- 미니 채팅 UI -->
<div id="chatPopup"
	style="display: none; position: absolute; z-index: 1000;">
	<div id="chatList">
		<h3>채팅 목록</h3>
		<ul id="chatRoomList"></ul>
	</div>
	<div id="chat"></div>
	<textarea id="send" placeholder="메시지 입력..."
		onkeydown="if(event.key === 'Enter') sendmessage();"></textarea>
</div>

<!-- 채팅 버튼 -->
<button id="toggleChat">채팅 열기</button>

<script type="text/javascript">
// 채팅창 드래그 기능
	var isDragging = false;
	var offsetX, offsetY; // 드래그 시작 위치

	document.getElementById('chatPopup').addEventListener('mousedown',
			function(e) {
				isDragging = true;
				offsetX = e.clientX - this.getBoundingClientRect().left;
				offsetY = e.clientY - this.getBoundingClientRect().top;
				this.style.cursor = 'grabbing'; // 드래그 중 커서 변경
			});

	document.addEventListener('mousemove', function(e) {
		if (isDragging) {
			var chatPopup = document.getElementById('chatPopup');
			var left = e.clientX - offsetX;
			var top = e.clientY - offsetY;
			var maxLeft = document.body.clientWidth - chatPopup.offsetWidth;
			var maxTop = document.body.clientHeight - chatPopup.offsetHeight;

			left = Math.max(0, Math.min(left, maxLeft));
			top = Math.max(0, Math.min(top, maxTop));

			chatPopup.style.left = left + 'px';
			chatPopup.style.top = top + 'px';
		}
	});

	document.addEventListener('mouseup', function() {
		isDragging = false;
		document.getElementById('chatPopup').style.cursor = 'move'; // 커서 변경
	});

	// 채팅 창 열기/닫기
	document.getElementById("toggleChat").onclick = function(event) {
		var chatPopup = document.getElementById("chatPopup");

		// chatPopup 스타일이 이미 "none"일 경우, "block"으로 전환
		if (chatPopup.style.display === "none"
				|| chatPopup.style.display === "") {
			chatPopup.style.display = "block";
		} else {
			chatPopup.style.display = "none";
		}

		event.stopPropagation(); // 클릭 이벤트가 toggleChat 버튼에 의한 것이면 이벤트 전파를 중지
	};

	// 화면 아무 곳이나 클릭하면 채팅 창 닫기
	document.addEventListener('click', function(event) {
		var chatPopup = document.getElementById("chatPopup");
		var toggleButton = document.getElementById("toggleChat");

		// 클릭된 영역이 채팅창이나 열기 버튼이 아니면 채팅창 닫기
		if (event.target !== chatPopup && event.target !== toggleButton) {
			chatPopup.style.display = "none";
		}
	});

	// 채팅창 내부 클릭 시 이벤트 전파 중지 (채팅창을 클릭해도 닫히지 않도록)
	document.getElementById("chatPopup").addEventListener('click',
			function(event) {
				event.stopPropagation();
			});
	

</script>