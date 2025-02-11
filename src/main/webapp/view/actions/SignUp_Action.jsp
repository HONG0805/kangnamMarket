<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userName" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>SignUp_Action</title>
</head>
<body>
	<%
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		String userEmail = request.getParameter("userEmail");
		String userName = request.getParameter("userName");

		System.out.println("------------------------");
		System.out.println("userID: " + userID);
		System.out.println("userPassword: " + userPassword);
		System.out.println("userEmail: " + userEmail);
		System.out.println("userName: " + userName);
		System.out.println("------------------------");

		// 빈 값 또는 null 체크
		if (userID == null || userID.trim().isEmpty() || userPassword == null || userPassword.trim().isEmpty()
				|| userEmail == null || userEmail.trim().isEmpty() || userName == null
				|| userName.trim().isEmpty()) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('빈칸을 확인해 주세요');");
			script.println("location.href='" + request.getContextPath() + "/view/pages/SignUp.jsp';");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('서버오류')");
				script.println("history.back()");
				script.println("</script>");
			} else if (result == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 아이디가 존재합니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입을 축하드립니다.')");
				script.println("location.href = '" + request.getContextPath() + "/view/pages/Login.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>
