<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="reply.Reply"%>
<%@ page import="reply.ReplyDAO"%>
<%@ page import="java.util.ArrayList"%>
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
			bbsID = Integer.parseInt(request.getParameter("bbsID").trim());
		}

		int replyID = 0;
		if (request.getParameter("replyID") != null) {
			replyID = Integer.parseInt(request.getParameter("replyID"));
		}
		if (replyID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Reply reply = new ReplyDAO().getReply(replyID);
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserName())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='" + request.getContextPath() + "/view/pages/MainPage.jsp'");
			script.println("</script>");
		} else {
			ReplyDAO replyDAO = new ReplyDAO();
			int result = replyDAO.delete(replyID);
			//데이터베이스 오류
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정하기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				//글쓰기가 정상적으로 작성되면 게시판 메인으로 이동
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글을 삭제하였습니다.')");
				script.println("location.href = document.referrer;"); // 이전 페이지로 돌아감
				script.println("</script>");
			}
		}
	%>
</body>
</html>
