package chat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ChatDAO {
	private Connection con;

	public ChatDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "1248";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Chat> getChatList(String nowTime){
		ArrayList<Chat> chatList = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sql = "SELET * FROM CHAT WHERE chatTime > ? ORDER BY chatTime";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1,nowTime);
			rs = pst.executeQuery();
			chatList = new ArrayList<Chat>();
			while(rs.next()) {
				Chat chat = new Chat();
				chat.setChatName(rs.getString("chatName"));
				chat.setChatContent(rs.getString("chatContent"));
				chat.setChatTime(rs.getString("chatTime"));
				chatList.add(chat);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)rs.close();
				if(pst != null)pst.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	
	public int submit(String chatName, String chatContent) {
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sql = "INSERT INTO CHAT VALUES (?, ?, now())";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, chatName);
			pst.setString(1, chatContent);
			return pst.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)rs.close();
				if(pst != null)pst.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
}
