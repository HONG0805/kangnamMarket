<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, chat.ChatDAO"%>
<%@ page import="javax.servlet.*, javax.servlet.http.*"%>
<%@ page session="true"%>
<%
	// 1. 로그인된 사용자 ID와 게시물 ID 가져오기
	String userID = (String) session.getAttribute("userID");
	if (userID == null) {
		// 로그인되지 않은 경우, 로그인 페이지로 리다이렉트
		out.println("<script>alert('로그인 후 이용해주세요.'); location.href='/view/pages/Login.jsp';</script>");
		return;
	}

	String bbsIDStr = request.getParameter("bbsID");
	if (bbsIDStr == null || bbsIDStr.isEmpty()) {
		// 게시물 ID가 없으면 에러 메시지 출력 후 이전 페이지로 돌아가기
		out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
		return;
	}

	int bbsID = Integer.parseInt(bbsIDStr);

	// 2. ChatDAO 객체 생성 후 채팅방 존재 여부 확인
	ChatDAO chatDAO = new ChatDAO();
	int roomID = chatDAO.createChatRoom(bbsID, userID);

	// 3. 채팅방이 생성되면 채팅 페이지로 리다이렉트
	if (roomID != -1) {
		response.sendRedirect(request.getContextPath() + "/view/pages/Chat.jsp?roomID=" + roomID);
	} else {
		// 채팅방 생성 실패 시 에러 메시지 출력 후 이전 페이지로 돌아가기
		out.println("<script>alert('채팅방 생성에 실패했습니다.'); history.back();</script>");
	}
%>

