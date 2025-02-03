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

		// 세션에서 로그인 상태 확인
		if (session.getAttribute("userID") != null) {
			session.removeAttribute("userID");
		}

		UserDAO dao = new UserDAO();

		// 로그인 확인
		if (dao.login(userID, userPW) == 1) {
			boolean flag = dao.changePassword(userID, newPw);
			PrintWriter script = response.getWriter();
			if (flag) {
				// 비밀번호 변경 성공 시
				script.println("<script>");
				script.println("alert('비밀번호가 정상적으로 변경되었습니다.');");
				script.println("location.href='" + request.getContextPath() + "/view/pages/Login.jsp';");
				script.println("</script>");
			} else {
				// 비밀번호 변경 실패 시
				script.println("<script>");
				script.println("alert('비밀번호 변경에 실패했습니다.');");
				script.println("location.href='" + request.getContextPath() + "/view/pages/Login.jsp';");
				script.println("</script>");
			}
		}
	%>
</body>
</html>
