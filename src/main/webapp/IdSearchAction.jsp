<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
	String userName = request.getParameter("userName");
	String userEmail = request.getParameter("userEmail");
	
	UserDAO dao = new UserDAO();
	String id = dao.findId(userEmail, userName);

	request.setAttribute("id", id);
	if (id == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('정보가 일치하지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'IdSearch_success.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>