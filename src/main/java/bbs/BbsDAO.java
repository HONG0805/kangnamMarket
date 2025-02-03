package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection con;
	private ResultSet rs;

	public BbsDAO() {
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

	// 게시글 조회
	public Bbs getBbs(int bbsID) {
		String sql = "SELECT bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable, cost "
				+ "FROM bbs WHERE bbsID = ?";
		Bbs bbs = null;
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setInt(1, bbsID);
			rs = pst.executeQuery();
			if (rs.next()) {
				bbs = new Bbs();
				bbs.setBbsID(rs.getInt("bbsID"));
				bbs.setBbsTitle(rs.getString("bbsTitle"));
				bbs.setUserName(rs.getString("userID"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setBbsContent(rs.getString("bbsContent"));
				bbs.setBbsAvailable(rs.getInt("bbsAvailable"));
				bbs.setCost(rs.getInt("cost"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bbs;
	}

	// 날짜 가져오기
	public String getDate() {
		String sql = "SELECT NOW()";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			rs = pst.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 오류 발생 시 빈 문자열 반환
	}

	// 다음 게시글 ID 구하기
	public int getNext() {
		String sql = "SELECT bbsID FROM bbs ORDER BY bbsID DESC";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			rs = pst.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 게시글이면 1을 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 오류 발생 시 -1 반환
	}

	// 글 작성
	public int write(String bbsTitle, String userID, String bbsContent, int cost) {
		String sql = "INSERT INTO bbs (bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable, cost) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setInt(1, getNext());
			pst.setString(2, bbsTitle);
			pst.setString(3, userID); // userID 저장
			pst.setString(4, getDate());
			pst.setString(5, bbsContent);
			pst.setInt(6, 1); // 게시글 활성화
			pst.setInt(7, cost);
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 오류 발생 시 -1 반환
	}

	// 게시글 리스트 가져오기
	public ArrayList<Bbs> getList(int pageNumber) {
		String sql = "SELECT bbs.bbsID, bbs.bbsTitle, bbs.userID, u.userName, bbs.bbsDate, bbs.bbsContent, bbs.bbsAvailable, bbs.cost "
				+ "FROM bbs bbs " + "JOIN user u ON bbs.userID = u.userID " + "WHERE bbs.bbsAvailable = 1 "
				+ "ORDER BY bbs.bbsID DESC LIMIT ?, 10"; // pageNumber에 맞게 LIMIT 처리
		ArrayList<Bbs> list = new ArrayList<>();
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			// (pageNumber - 1) * 10은 첫 번째 게시글 번호로 시작하도록 offset 설정
			pst.setInt(1, (pageNumber - 1) * 10);
			rs = pst.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserName(rs.getString(4)); // userName을 userNickName에 매핑
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsContent(rs.getString(6));
				bbs.setBbsAvailable(rs.getInt(7));
				bbs.setCost(rs.getInt(8));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 게시글 수정
	public int update(int bbsID, String bbsTitle, String bbsContent, int cost) {
		String sql = "UPDATE bbs SET bbsTitle = ?, bbsContent = ?, cost = ? WHERE bbsID = ?";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setString(1, bbsTitle);
			pst.setString(2, bbsContent);
			pst.setInt(3, cost);
			pst.setInt(4, bbsID);
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 오류 발생 시 -1 반환
	}

	// 게시글 삭제
	public int delete(int bbsID) {
		String sql = "UPDATE bbs SET bbsAvailable = 0 WHERE bbsID = ?";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setInt(1, bbsID);
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 오류 발생 시 -1 반환
	}

	// 검색된 게시글 리스트 가져오기
	public ArrayList<Bbs> getSearchedList(int pageNumber, String searchWord) {
		String sql = "SELECT bbs.bbsID, bbs.bbsTitle, bbs.userID, u.userName, bbs.bbsDate, bbs.bbsContent, bbs.bbsAvailable, bbs.cost "
				+ "FROM bbs bbs " + "JOIN user u ON bbs.userID = u.userID "
				+ "WHERE (bbs.bbsTitle LIKE ? OR bbs.bbsContent LIKE ?) AND bbs.bbsAvailable = 1 "
				+ "ORDER BY bbs.bbsID DESC LIMIT ?, 10"; // 검색 결과에 대해 페이지네이션 처리
		ArrayList<Bbs> list = new ArrayList<>();
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setString(1, "%" + searchWord + "%");
			pst.setString(2, "%" + searchWord + "%");
			pst.setInt(3, (pageNumber - 1) * 10); // 페이지네이션을 위한 offset 설정
			rs = pst.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserName(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsContent(rs.getString(6));
				bbs.setBbsAvailable(rs.getInt(7));
				bbs.setCost(rs.getInt(8));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 검색 결과에서 다음 페이지가 있는지 확인
	public boolean searchedNextPage(int pageNumber, String searchWord) {
		String sql = "SELECT COUNT(*) FROM bbs WHERE (bbsTitle LIKE ? OR bbsContent LIKE ?) AND bbsAvailable = 1";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			pst.setString(1, "%" + searchWord + "%");
			pst.setString(2, "%" + searchWord + "%");
			rs = pst.executeQuery();
			if (rs.next()) {
				int totalRows = rs.getInt(1);
				return totalRows > pageNumber * 10; // 검색 결과에 대해 페이지 번호 처리
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// 페이지가 존재하는지 확인
	public boolean nextPage(int pageNumber) {
		String sql = "SELECT COUNT(*) FROM bbs WHERE bbsAvailable = 1";
		try (PreparedStatement pst = con.prepareStatement(sql)) {
			rs = pst.executeQuery();
			if (rs.next()) {
				int totalRows = rs.getInt(1);
				return totalRows > pageNumber * 10; // 페이지 번호에 따른 추가 글이 존재하는지 확인
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// 자원 해제
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (con != null)
				con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
