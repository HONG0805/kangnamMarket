package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class JjimDAO {

	private Connection conn;
	private ResultSet rs;

	public JjimDAO() {
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

	public ArrayList<Bbs> getList(String userID, int pageNumber) {
		String SQL = "SELECT b.bbsID, b.bbsTitle, u.userName, b.bbsDate, b.bbsContent, b.bbsAvailable, b.cost "
				+ "FROM BBS b " + "JOIN user u ON b.userID = u.userID "
				+ "WHERE b.bbsID IN (SELECT bbsID FROM jjim WHERE userID = ?) " + "ORDER BY b.bbsID DESC "
				+ "LIMIT ?, 10"; // 한 번에 10개의 게시물만 가져옵니다.

		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); // 첫 번째 ?는 userID
			pstmt.setInt(2, (pageNumber - 1) * 10); // 두 번째 ?는 LIMIT 시작 위치, 페이지 번호를 고려하여 계산

			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserName(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setCost(rs.getInt(7));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int write(String userID, int bbsID) {
		String SQL = "INSERT INTO jjim VALUES(?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, userID);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 찜 추가 실패
	}

	public ArrayList<Jjim> getJjim(String userID, int bbsID) {
		String SQL = "SELECT * FROM jjim WHERE userID = ? AND bbsID = ?";
		ArrayList<Jjim> list = new ArrayList<Jjim>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, bbsID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Jjim jjim = new Jjim();
				jjim.setBbsID(rs.getInt(1));
				jjim.setUserID(rs.getString(2));
				list.add(jjim);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int delete(String userID, int bbsID) {
		String SQL = "DELETE FROM jjim WHERE bbsID = ? AND userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 찜 삭제 실패
	}
}
