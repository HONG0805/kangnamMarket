package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection con;

	public UserDAO() {
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

	// 로그인 (비밀번호 해시 비교)
	public int login(String userID, String userPassword) {
		String sql = "SELECT userPassword FROM user WHERE userID = ?";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setString(1, userID);
			try (ResultSet rs = pst.executeQuery()) {
				if (rs.next()) {
					String dbPassword = rs.getString(1);
					String hashedPassword = SecurityUtil.hashPassword(userPassword);
					System.out.println("DB 비밀번호: " + dbPassword);
					System.out.println("입력한 비밀번호 해시: " + hashedPassword);
					return hashedPassword.equals(dbPassword) ? 1 : 0;
				} else {
					return -2; // 아이디 없음
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return -1; // DB 오류
		}
	}

	// 아이디 중복 확인
	public boolean isIDAvailable(String userID) {
		String sql = "SELECT 1 FROM user WHERE userID = ?";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setString(1, userID);
			try (ResultSet rs = pst.executeQuery()) {
				return !rs.next(); // 중복이면 false, 사용 가능하면 true
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// 회원가입 (비밀번호 암호화 저장)
	public int join(User user) {
		if (!isIDAvailable(user.getUserID()))
			return 0; // 중복된 아이디

		String sql = "INSERT INTO user (userID, userPassword, userEmail, userName) VALUES (?, ?, ?, ?)";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setString(1, user.getUserID());
			pst.setString(2, SecurityUtil.hashPassword(user.getUserPassword()));
			pst.setString(3, user.getUserEmail());
			pst.setString(4, user.getUserName());
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	// 아이디 찾기
	public String findId(String userName, String userEmail) {
		String sql = "SELECT userID FROM user WHERE userEmail = ? AND userName = ?";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setString(1, userEmail);
			pst.setString(2, userName);
			try (ResultSet rs = pst.executeQuery()) {
				if (rs.next()) {
					return rs.getString("userID");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 비밀번호 재설정 (이메일 인증 후 사용)
	public boolean resetPassword(String userID, String userEmail, String tempPassword) {
		String sql = "UPDATE user SET userPassword=? WHERE userID=? AND userEmail=?";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setString(1, SecurityUtil.hashPassword(tempPassword));
			pst.setString(2, userID);
			pst.setString(3, userEmail);
			return pst.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// 비밀번호 변경
	public boolean changePassword(String userID, String newPw) {
		String sql = "UPDATE user SET userPassword=? WHERE userID=?";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			// 해시화된 비밀번호를 설정
			pst.setString(1, SecurityUtil.hashPassword(newPw));
			pst.setString(2, userID);

			// 업데이트된 행 수 확인
			int result = pst.executeUpdate();

			if (result > 0) {
				System.out.println("비밀번호 변경 성공");
				return true;
			} else {
				System.out.println("비밀번호 변경 실패: 변경된 행이 없습니다.");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// 사용자 정보 가져오기
	public User getUser(String userID) {
		String sql = "SELECT * FROM user WHERE userID = ?";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setString(1, userID);
			try (ResultSet rs = pst.executeQuery()) {
				if (rs.next()) {
					User user = new User();
					user.setUserID(rs.getString("userID"));
					user.setUserPassword(rs.getString("userPassword"));
					user.setUserEmail(rs.getString("userEmail"));
					user.setUserName(rs.getString("userName"));
					return user;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 비밀번호 찾기 (아이디, 이름, 이메일로 비밀번호 조회)
	public String findPw(String userID, String userName, String userEmail) {
		String sql = "SELECT userPassword FROM user WHERE userID = ? AND userName = ? AND userEmail = ?";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setString(1, userID);
			pst.setString(2, userName);
			pst.setString(3, userEmail);
			try (ResultSet rs = pst.executeQuery()) {
				if (rs.next()) {
					return rs.getString("userPassword");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 정보가 없으면 null 반환
	}
}
