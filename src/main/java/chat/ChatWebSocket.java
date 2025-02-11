package chat;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.concurrent.CopyOnWriteArrayList;

@ServerEndpoint("/Chat")
public class ChatWebSocket {

    // WebSocket 세션들을 저장하는 리스트
    private static CopyOnWriteArrayList<Session> sessions = new CopyOnWriteArrayList<>();

    // 클라이언트가 연결되었을 때 호출되는 메서드
    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        System.out.println("새로운 클라이언트 연결됨: " + session.getId());
    }

    // 클라이언트가 메시지를 보냈을 때 호출되는 메서드
    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("받은 메시지: " + message);
        
        // 연결된 모든 클라이언트에게 메시지 전송
		for (Session s : sessions) {
			if (s.isOpen()) {
                try {
                    s.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // 클라이언트가 연결을 종료했을 때 호출되는 메서드
    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        System.out.println("클라이언트 연결 종료: " + session.getId());
    }

    // WebSocket 오류가 발생했을 때 호출되는 메서드
    @OnError
    public void onError(Session session, Throwable error) {
        error.printStackTrace();
    }
}
