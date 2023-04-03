<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="file.FileDAO"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%> 
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<jsp:setProperty name="bbs" property="cost" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>loginAction</title>
</head>
<body>
	<%
	/*
	String realFolder = "";
	String saveFolder = "bbsUpload";
	String encType = "utf-8";
	int maxSize = 5 * 1024 * 1024;

	ServletContext context = this.getServletContext();
	realFolder = context.getRealPath(saveFolder);
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, policy);

	String fileName = multi.getFilesystemName("fileName");
	String bbsTitle = multi.getParameter("bbsTitle");
	String bbsContent = multi.getParameter("bbsContent");

	bbs.setBbsTitle(bbsTitle);
	bbs.setBbsContent(bbsContent);
	*/

	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 이후 이용 가능합니다.')");
		script.println("location.href = 'Login.jsp'");
		script.println("</script>");
	} else {
		if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('빈칸을 확인해 주세요')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent(), bbs.getCost());
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
		script.println("location.href ='MainPage.jsp'");
		script.println("</script>");
			}
		}
	}
	%>
</body>
</html>
