package chat;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint("kangnamM/Chat")
public class ChatWebSocket {

	// 연결된 모든 클라이언트를 관리하는 Set
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());

	// 클라이언트가 연결될 때 호출
	@OnOpen
	public void onOpen(Session session) {
		clients.add(session);
		System.out.println("New connection: " + session.getId());
	}

	// 클라이언트가 메시지를 보낼 때 호출
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		System.out.println("Message from " + session.getId() + ": " + message);

		// 모든 클라이언트에게 메시지 전달
		synchronized (clients) {
			for (Session client : clients) {
				if (!client.equals(session)) { // 보내는 클라이언트를 제외한 모든 클라이언트에게 메시지 전송
					client.getBasicRemote().sendText(message);
				}
			}
		}
	}

	// 클라이언트 연결이 종료될 때 호출
	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("Connection closed: " + session.getId());
	}

	// 클라이언트에서 오류가 발생할 때 호출
	@OnError
	public void onError(Session session, Throwable throwable) {
		System.out.println("Error: " + throwable.getMessage());
	}
}
