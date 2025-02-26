package chat;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import chat.ChatDAO; // ChatDAO를 import

@ServerEndpoint("/Chat/{roomId}") // 채팅방을 roomId를 기준으로 구분
public class ChatWebSocket {

	// 채팅방 ID별로 사용자 세션을 관리하는 Map
	private static final Map<String, Map<String, Session>> roomChats = new HashMap<>();
	private Session session;
	private String userID;
	private String roomId;

	private static ChatDAO chatDAO = new ChatDAO(); // ChatDAO 객체 생성

	@OnOpen
	public void onOpen(@PathParam("roomId") String roomId, Session session) {
		this.session = session;
		this.roomId = roomId;

		// 세션에서 userID 추출 (Query Parameter로 전달된 userID를 가져옴)
		this.userID = session.getRequestParameterMap().get("userID").get(0);

		// 채팅방 ID별로 채팅방 관리
		roomChats.putIfAbsent(roomId, new HashMap<>());
		roomChats.get(roomId).put(userID, session);

		System.out.println(userID + "님이 채팅방 " + roomId + "에 접속했습니다.");
	}

	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		System.out.println("메시지 수신: " + message);

		// 로그인 상태 체크
		if (userID == null || userID.isEmpty()) {
			// 로그인하지 않은 경우 알림 메시지 전송
			session.getBasicRemote().sendText("로그인 후 채팅을 이용할 수 있습니다.");
			return;
		}

		// DB에 메시지 저장 (채팅방 ID, 사용자 ID, 메시지 내용)
		String createdAt = chatDAO.sendMessage(Integer.parseInt(roomId), userID, message);

		// 해당 채팅방의 모든 사용자에게 메시지 전송
		for (Session client : roomChats.get(roomId).values()) {
			if (client.isOpen()) {
				// 메시지 형식: userID (시간): 메시지
				String formattedMessage = " (" + createdAt + ") " + "\n" + userID + " : " + "\n\n" + message;
				client.getBasicRemote().sendText(formattedMessage);
			}
		}
	}

	@OnClose
	public void onClose() {
		if (roomChats.get(roomId) != null) {
			roomChats.get(roomId).remove(userID);
			System.out.println(userID + "님이 채팅방 " + roomId + "에서 나갔습니다.");
		}
	}

	@OnError
	public void onError(Session session, Throwable throwable) {
		System.out.println("WebSocket 오류 발생: " + throwable.getMessage());
	}
}
