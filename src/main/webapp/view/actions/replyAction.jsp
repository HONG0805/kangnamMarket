<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="reply.ReplyDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");

	// 로그인된 사용자 확인
	String userID = (String) session.getAttribute("userID");
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용해주세요.');");
		script.println("location.href='" + request.getContextPath() + "/view/pages/Login.jsp';");
		script.println("</script>");
		return;
	}

	// 게시글 ID 가져오기
	String bbsIDStr = request.getParameter("bbsID");
	String replyContent = request.getParameter("replyContent");

	if (bbsIDStr == null || bbsIDStr.isEmpty() || replyContent == null || replyContent.trim().isEmpty()) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('댓글 내용을 입력해주세요.');");
		script.println("history.back();");
		script.println("</script>");
		return;
	}

	int bbsID = Integer.parseInt(bbsIDStr);

	// 댓글 DAO를 사용하여 댓글 추가
	ReplyDAO replyDAO = new ReplyDAO();
	int result = replyDAO.write(bbsID, replyContent, userID);

	if (result == 1) {
		response.sendRedirect(request.getContextPath() + "/view/pages/view.jsp?bbsID=" + bbsID);
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('댓글 작성에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
	}
%>
