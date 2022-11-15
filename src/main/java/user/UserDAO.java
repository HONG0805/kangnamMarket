package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection con;
	private ResultSet rs;

	public UserDAO() {
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

	// 로그인
	public int login(String userID, String userPassword) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT userPassword FROM user WHERE userID = ?");
			pst.setString(1, userID);
			rs = pst.executeQuery();
			if (rs.next()) {
				return rs.getString(1).equals(userPassword) ? 1 : 0;
			} else {
				return -2;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	// ID 중복여부확인
	public boolean ID_Check(String userID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM user WHERE userID = ?");
			pst.setString(1, userID);
			rs = pst.executeQuery();
			if (rs.next()) {
				return false;
			} else {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// 회원가입
	public int join(User User) {
		if (!ID_Check(User.getUserID()))
			return 0;

		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO user VALUES (?,?,?,?,?)");
			pst.setString(1, User.getUserID());
			pst.setString(2, User.getUserPassword());
			pst.setString(3, User.getUserEmail());
			pst.setString(4, User.getUserName());
			pst.setString(5, User.getUserNickName());
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	// 아이디 찾기
	public String findId(String userName, String userEmail) {
		String id = null;
		try {
			String sql = "SELECT userID FROM user WHERE userEmail = ? and userName = ?";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, userEmail);
			pst.setString(2, userName);

			rs = pst.executeQuery();

			if (rs.next()) {
				id = rs.getString("userID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}

	// 비밀번호 찾기
	public String findPw(String userID, String userName, String userEmail) {
		String pw = null;
		try {
			String sql = "SELECT userPassword FROM user WHERE userID=? and userName=? and userEmail=?";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, userID);
			pst.setString(2, userName);
			pst.setString(3, userEmail);

			rs = pst.executeQuery();

			if (rs.next()) {
				pw = rs.getString("userPassword");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pw;
	}
	
	//비밀번호 변경
	public boolean changePassword(String userID, String newPw) {

		boolean flag = false;
		String sql = "UPDATE user SET userPassword=? WHERE userID=?"; 

		PreparedStatement pst = null;

		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, newPw);
			pst.setString(2, userID);

			int i = pst.executeUpdate();

			if(i == 1) {
				flag = true;
			} else {
				flag = false;
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	// 유저 데이터 가져오기
	public User getUser(String userID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM user WHERE userID = ?");
			pst.setString(1, userID);
			rs = pst.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserEmail(rs.getString(3));
				user.setUserName(rs.getString(4));
				user.setUserNickName(rs.getString(5));
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
