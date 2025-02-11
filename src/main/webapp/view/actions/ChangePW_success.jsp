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
		String newPW = request.getParameter("newPw");
		
		System.out.println("-----------------");
		System.out.println("userID: " + userID);
		System.out.println("userPW: " + userPW);
		System.out.println("-----------------");


		// 세션에서 로그인 상태 확인
		if (session.getAttribute("userID") != null) {
			session.removeAttribute("userID");
		}

		UserDAO dao = new UserDAO();

		// 로그인 확인
		if (dao.login(userID, userPW) == 1) {
			boolean flag = dao.changePassword(userID, newPW);
			PrintWriter script = response.getWriter();
			if (flag) {
				script.println("<script>");
				script.println("alert('비밀번호가 정상적으로 변경되었습니다.');");
				script.println("location.href='" + request.getContextPath() + "/view/pages/Login.jsp';");
				script.println("</script>");
			} else {
				script.println("<script>");
				script.println("alert('비밀번호 변경에 실패했습니다.');");
				script.println("location.href='" + request.getContextPath() + "/view/pages/Login.jsp';");
				script.println("</script>");
			}
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 실패: 아이디 또는 비밀번호가 잘못되었습니다.');");
			script.println("location.href='" + request.getContextPath() + "/view/pages/Login.jsp';");
			script.println("</script>");
		}
	%>
</body>
</html>
