<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>loginAction</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 이후 이용 가능합니다.')");
			script.println("location.href = '" + request.getContextPath() + "/view/pages/Login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='" + request.getContextPath() + "/view/pages/MainPage.jsp'");
			script.println("</script>");
		}

		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserName())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='" + request.getContextPath() + "/view/pages/MainPage.jsp'");
			script.println("</script>");
		} else {
			String bbsTitle = request.getParameter("bbsTitle");
			String bbsContent = request.getParameter("bbsContent");
			if (bbsTitle.equals("") || bbsContent.equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('빈칸을 확인해 주세요')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int cost = Integer.parseInt(request.getParameter("cost"));
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"),
						request.getParameter("bbsContent"), cost);
				//데이터베이스 오류
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글작성에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					//글쓰기가 정상적으로 작성되면 게시판 메인으로 이동
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = '" + request.getContextPath() + "/view/pages/MainPage.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>
