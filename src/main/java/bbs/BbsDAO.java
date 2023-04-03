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
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 작성일자 메소드
	// 글 작성 현재 날짜와 시간을 출력해주는 매소드
	public String getDate() {
		String sql = "SELECT NOW()";
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			rs = pst.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}

	// 게시글 번호 부여 메소드
	// 상위 게시글번호를 구해서 그 게시글 번호에 1을 더한 새로 작성되는 게시글의 새 번호를 부여함
	public int getNext() {
		String sql = "SELECT bbsID FROM bbs ORDER BY bbsID DESC";
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			rs = pst.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	// 글작성 메소드
	public int write(String bbsTitle, String userNickName, String bbsContent, int cost) {
		String sql = "INSERT INTO bbs VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setInt(1, getNext());
			pst.setString(2, bbsTitle);
			pst.setString(3, userNickName);
			pst.setString(4, getDate());
			pst.setString(5, bbsContent);
			pst.setInt(6, 1);// 글의 유호번호
			pst.setInt(7, cost);
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	// 게시글 리스트 메소드
	public ArrayList<Bbs> getList(int pageNumber) {
		String sql = "SELECT * FROM bbs WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pst.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserNickName(rs.getString(3));
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

	// 페이징 처리 메소드
	public boolean nextPage(int pageNumber) {
		String sql = "SELECT * FROM bbs WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pst.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public Bbs getBbs(int bbsID) {
		String sql = "SELECT * FROM bbs WHERE bbsID = ?";
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setInt(1, bbsID);
			rs = pst.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserNickName(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setCost(rs.getInt(7));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 게시물 검색 메소드
	public ArrayList<Bbs> getSearchedList(int pageNumber, String searchWord) {
		int no2 = 0;
		if (getNext() > pageNumber * 10) {
			no2 = pageNumber * 10;
		} else {
			no2 = getNext();
		}
		int no1 = (pageNumber - 1) * 10 + 1;
		String sql = "select * from (select row_number() over (order by bbsDate desc) NUM, A.* from bbs A where bbsavailable=1 and bbstitle like'%"
				+ searchWord
				+ "%' order by bbsDate desc)bbs_a where NUM between "
				+ no1
				+ " and "
				+ no2;
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			rs = pst.executeQuery(sql);
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(2));
				bbs.setBbsTitle(rs.getString(3));
				bbs.setUserNickName(rs.getString(4));
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

	//
	public boolean searchedNextPage(int pageNumber, String searchWord) {
		try {
			if (getSearchedNext(searchWord) > (pageNumber) * 10) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	//
	public int getSearchedNext(String searchWord) {
		String SQL = "select NUM from (select row_number() over (order by bbsDate desc) NUM, A.* from bbs A where bbsavailable=1 and bbsTitle like '%"+searchWord+"%' order by NUM desc)bbs_a";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 게시글 수정 메소드
	public int update(int bbsID, String bbsTitle, String bbsContent, int cost) {
		String sql = "UPDATE bbs SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, bbsTitle);
			pst.setString(2, bbsContent);
			pst.setInt(3, bbsID);
			pst.setInt(4, cost);
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 게시글 삭제 메소드
	public int delete(int bbsID) {
		String sql = "UPDATE bbs SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setInt(1, bbsID);
			return pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}
