package reply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReplyDAO {

	private Connection conn;
	private ResultSet rs;

	public ReplyDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "1248";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Reply> getList(int bbsID, int pageNumber) {
		String SQL = "SELECT * FROM REPLY WHERE replyID<? AND replyAvailable=1 AND bbsID=? ORDER BY replyID DESC LIMIT 10";
		ArrayList<Reply> list = new ArrayList<Reply>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			pstmt.setInt(2, bbsID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Reply reply = new Reply();
				reply.setReplyID(rs.getInt(1));
				reply.setBbsID(rs.getInt(2));
				reply.setReplyContent(rs.getString(3));
				reply.setUserID(rs.getString(4));
				reply.setReplyAvailable(rs.getInt(5));
				reply.setReplyDate(rs.getTimestamp(6));
				list.add(reply);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int getNext() {
		String SQL = "select replyID FROM REPLY ORDER BY replyID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				System.out.println(rs.getInt(1));
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int write(int bbsID, String replyContent, String userID) {
		String SQL = "INSERT INTO REPLY (replyID, bbsID, replyContent, userID, replyAvailable, replyDate) VALUES(?,?,?,?,?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); // replyID
			pstmt.setInt(2, bbsID); // bbsID
			pstmt.setString(3, replyContent); // replyContent
			pstmt.setString(4, userID); // userID
			pstmt.setInt(5, 1); // replyAvailable (활성화)
			pstmt.setString(6, new java.sql.Timestamp(System.currentTimeMillis()).toString());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public Reply getReply(int replyID) {
		String SQL = "SELECT * FROM reply WHERE replyID = ? ORDER BY replyID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, replyID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Reply reply = new Reply();
				reply.setBbsID(rs.getInt(1));
				reply.setReplyID(rs.getInt(2));
				reply.setUserID(rs.getString(3));
				reply.setReplyContent(rs.getString(4));
				reply.setReplyAvailable(rs.getInt(5));
				return reply;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 댓글 삭제
	public int delete(int replyID) {
		String SQL = "UPDATE reply SET replyAvailable = 0 WHERE replyID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, replyID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 댓글 내용 가져오기 (수정용)
	public String getUpdateComment(int replyID) {
		String SQL = "SELECT replyContent FROM reply WHERE replyID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, replyID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	// 댓글 수정
	public int update(int replyID, String replyContent) {
		String SQL = "UPDATE reply SET replyContent = ? WHERE replyID LIKE ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, replyContent);
			pstmt.setInt(2, replyID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
