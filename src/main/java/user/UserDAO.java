package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private String userID;
	private String userPassword;
	private String userEmail;
	private String userName;
	private String userNickName;

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

	// 중복여부확인
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
	public int join(UserDAO userDAO) {
		if (!ID_Check(userDAO.getUserID()))
			return 0;

		try {
			PreparedStatement pst = con.prepareStatement("INSERT INTO user VALUES (?,?,?,?,?)");
			pst.setString(1, userDAO.getUserID());
			pst.setString(2, userDAO.getUserPassword());
			pst.setString(3, userDAO.getUserEmail());
			pst.setString(4, userDAO.getUserName());
			pst.setString(5, userDAO.getUserNickName());
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	// 아이디 찾기
	public String findId(String userEmail, String userName) {
		String id = null;
		try {
			String sql = "SELECT userID" + "FORM user" + "WHERE userEmail = ? and" + "userName = ?";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, userEmail);
			pst.setString(2, userName);

			rs = pst.executeQuery();

			if (rs.next()) {
				id = rs.getString("user.userID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}

	// 비밀번호 찾기
	public String findPw(String userID, String userEmail, String userName) {
		String pw = null;
		try {
			String sql = "SELECT userPassword" + "FORM user" + "WHERE userID=? and" + "userEmail=? and"
					+ "userName = ?";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, userID);
			pst.setString(2, userEmail);
			pst.setString(3, userName);

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				pw = rs.getString("user.userPassword");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pw;
	}
	
	//유저 데이터 가져오기
	public UserDAO getUser(String userID) {
		try {
			PreparedStatement pst = con.prepareStatement("SELECT * FROM user WHERE userID = ?");
			pst.setString(1, userID);
			rs = pst.executeQuery();
			if (rs.next()) {
				UserDAO userDAO = new UserDAO();
				userDAO.setUserID(rs.getString(1));
				userDAO.setUserPassword(rs.getString(2));
				userDAO.setUserEmail(rs.getString(3));
				userDAO.setUserName(rs.getString(4));
				userDAO.setUserNickName(rs.getString(5));
				return userDAO;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
}
