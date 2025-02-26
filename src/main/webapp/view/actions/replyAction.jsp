<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="chat.ChatDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 로그인된 사용자 확인
	String userID = (String) session.getAttribute("userID");
	if (userID == null) {
		// 로그인되지 않은 경우, 로그인 페이지로 리다이렉트
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용해주세요.');");
		script.println("location.href='" + request.getContextPath() + "/view/pages/Login.jsp';");
		script.println("</script>");
		return;
	}

	// 게시물 ID 가져오기
	String bbsIDStr = request.getParameter("bbsID");
	if (bbsIDStr == null || bbsIDStr.isEmpty()) {
		// 게시물 ID가 없는 경우, 오류 메시지 출력
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근입니다.');");
		script.println("history.back();");
		script.println("</script>");
		return;
	}

	int bbsID = Integer.parseInt(bbsIDStr);

	// 채팅방 생성
	ChatDAO chatDAO = new ChatDAO();
	int roomID = chatDAO.createChatRoom(bbsID, userID);

	// 채팅방 생성 성공 시 채팅 페이지로 리다이렉트
	if (roomID != -1) {
		String url = request.getContextPath() + "/view/pages/Chat.jsp?roomID=" + roomID;
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='" + url + "';");
		script.println("</script>");
	} else {
		// 채팅방 생성 실패 시 오류 메시지 출력
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('채팅방 생성에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
	}
%>
