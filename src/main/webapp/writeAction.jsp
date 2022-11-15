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
	BbsDAO bbsDAO = new BbsDAO();
	Bbs bbs = new Bbs();
	bbs.setBbsID(bbsDAO.getNext());
	int bbsID = bbs.getBbsID();
	String directory = application.getRealPath("/upload/" + bbsID + "/");
	
	File targetDir = new File(directory);
	if (!targetDir.exists()) {
		targetDir.mkdirs();
	}
	int maxSize = 1024 * 1024 * 500;
	String realFolder="";
	String encType = "utf-8";

	MultipartRequest multi = null;		
	multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());

	String fileName = multi.getOriginalFileName("file");
	String fileRealName = multi.getFilesystemName("file");

	String bbsTitle = multi.getParameter("bbsTitle");
	String bbsContent = multi.getParameter("bbsContent");
	bbs.setBbsTitle(bbsTitle);
	bbs.setBbsContent(bbsContent);

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
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
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
