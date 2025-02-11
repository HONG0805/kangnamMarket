package chat;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChatDAO {
	private Connection con;

	public ChatDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "1248";
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 메시지 저장 메서드
	public void saveMessage(String userID, String message) {
		String query = "INSERT INTO chat_messages (userID, message) VALUES (?, ?)";
		try (PreparedStatement statement = con.prepareStatement(query)) {
			statement.setString(1, userID);
			statement.setString(2, message);
			statement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 메시지 불러오기 메서드
	public List<String> getMessages() {
		List<String> messages = new ArrayList<>();
		String query = "SELECT userID, message, timestamp FROM chat_messages ORDER BY timestamp DESC";
		try (Statement statement = con.createStatement(); ResultSet resultSet = statement.executeQuery(query)) {
			while (resultSet.next()) {
				String message = resultSet.getString("userID") + ": " + resultSet.getString("message");
				messages.add(message);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return messages;
	}
}
