package chat;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChatDAO {
	private Connection con;
	private final String dbURL = "jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
	private final String dbID = "root";
	private final String dbPassword = "1248";

	// 생성자 - DB 연결 설정
	public ChatDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int createChatRoom(int bbsID, String userID) {
		String query = "SELECT * FROM chatroom WHERE bbsID = ? AND (user_1_id = ? OR user_2_id = ?)";
		try (PreparedStatement pstmt = con.prepareStatement(query)) {
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, userID);
			pstmt.setString(3, userID);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				// 채팅방이 이미 존재하면 해당 채팅방의 roomID 반환
				return rs.getInt("roomID");
			} else {
				// 채팅방이 존재하지 않으면 새 채팅방 생성
				query = "INSERT INTO chatroom (bbsID, user_1_id, user_2_id) VALUES (?, ?, ?)";
				try (PreparedStatement insertPstmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
					insertPstmt.setInt(1, bbsID);
					insertPstmt.setString(2, userID);

					// 게시물 작성자 ID를 `user_2_id`로 설정
					String bbsUserID = getBbsUserID(bbsID); // 게시물의 작성자 ID를 가져오는 방법을 구현
					if (bbsUserID == null) {
						return -1; // 작성자 ID가 없으면 채팅방을 만들지 않음
					}
					insertPstmt.setString(3, bbsUserID);
					insertPstmt.executeUpdate();

					ResultSet generatedKeys = insertPstmt.getGeneratedKeys();
					if (generatedKeys.next()) {
						return generatedKeys.getInt(1); // 생성된 roomID 반환
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1; // 오류 발생 시 -1 반환
	}

	// 게시물 작성자의 userID를 가져오는 메소드 구현
	private String getBbsUserID(int bbsID) {
		String query = "SELECT userID FROM bbs WHERE bbsID = ?";
		try (PreparedStatement pstmt = con.prepareStatement(query)) {
			pstmt.setInt(1, bbsID);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString("userID"); // 게시물 작성자 ID 반환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null; // 작성자 ID를 찾지 못한 경우
	}

	// 메시지 전송
	public String sendMessage(int roomID, String userID, String message) {
		String query = "INSERT INTO message (roomID, userID, message, created_at) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
		try (PreparedStatement pstmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
			pstmt.setInt(1, roomID);
			pstmt.setString(2, userID);
			pstmt.setString(3, message);
			pstmt.executeUpdate();

			// 생성된 메시지의 시간 가져오기
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				// 생성된 메시지의 시간 조회
				String timeQuery = "SELECT created_at FROM message WHERE messageID = ?";
				try (PreparedStatement timeStmt = con.prepareStatement(timeQuery)) {
					timeStmt.setInt(1, rs.getInt(1));
					ResultSet timeRs = timeStmt.executeQuery();
					if (timeRs.next()) {
						return timeRs.getString("created_at"); // 생성된 시간 반환
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null; // 오류 발생 시 null 반환
	}

	// 채팅방 메시지 조회
	public List<String> getMessages(int roomId) {
		List<String> messages = new ArrayList<>();
		String sql = "SELECT userID, message, created_at FROM message WHERE roomID = ? ORDER BY created_at ASC";

		try (PreparedStatement stmt = con.prepareStatement(sql)) {
			stmt.setInt(1, roomId);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				String userID = rs.getString("userID");
				String message = rs.getString("message");
				String createdAt = rs.getString("created_at"); // created_at 가져오기
				messages.add("\n\n" + " (" + createdAt + ") " + "\n" + userID + " : "+ "\n\n" + message); // 메시지 형식
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return messages;
	}

}
