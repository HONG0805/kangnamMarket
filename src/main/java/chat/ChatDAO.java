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
	public String getBbsUserID(int bbsID) {
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

	// 채팅방의 roomID를 이용해 해당 게시글(bbsID)을 가져오는 메서드
	public int getBbsIDByRoomID(int roomID) {
		String query = "SELECT bbsID FROM chatroom WHERE roomID = ?";
		try (PreparedStatement pstmt = con.prepareStatement(query)) {
			pstmt.setInt(1, roomID);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt("bbsID"); // 해당 roomID의 게시글 ID 반환
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1; // 찾을 수 없는 경우 -1 반환
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
	public List<String> getMessages(int roomId, String userID) {
		List<String> messages = new ArrayList<>();
		String sql = "SELECT userID, message, created_at FROM message WHERE roomID = ? ORDER BY created_at ASC";

		try (PreparedStatement stmt = con.prepareStatement(sql)) {
			stmt.setInt(1, roomId);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				String senderID = rs.getString("userID");
				String message = rs.getString("message");

				// 메시지의 전송자에 따라서 CSS 클래스 구분
				String cssClass = senderID.equals(userID) ? "my-message" : "other-message";

				// HTML 특수 문자를 엔터티로 변환하여 XSS 방지
				message = escapeHtml(message);

				// 메시지 포맷팅
				String formattedMessage = senderID + " : " + message;
				messages.add(formattedMessage + "|" + cssClass); // 메시지와 CSS 클래스 정보를 함께 저장
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return messages;
	}

	// 사용자가 참여한 채팅방 목록 조회
	public List<Integer> getJoinedRooms(String userID) {
		List<Integer> roomIds = new ArrayList<>();
		String sql = "SELECT DISTINCT roomID FROM message WHERE userID = ?";

		try (PreparedStatement stmt = con.prepareStatement(sql)) {
			stmt.setString(1, userID);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				int roomId = rs.getInt("roomID");
				roomIds.add(roomId);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return roomIds;
	}

	public String escapeHtml(String str) {
		if (str == null) {
			return null;
		}
		// HTML 특수 문자를 엔티티로 변환
		return str.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'",
				"&#039;");
	}

}
