<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String userID = request.getParameter("userID");
	String userPW = request.getParameter("userPW");
	String newPw = request.getParameter("newPw");
	
	if (session.getAttribute("userID") != null) {
		session.removeAttribute("userID");
	}
	UserDAO dao = new UserDAO();
	if (dao.login(userID, userPW) == 1) {
		boolean flag = dao.changePassword(userID, newPw);
		if (flag) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 정상적으로 변경되었습니다.')");
			script.println("location.href='Login.jsp'");
			script.println("</script>");
		} else  {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 변경에 실패했습니다.')");
			script.println("location.href='Login.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>
