<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.JjimDAO"%>
<%@ page import="bbs.Jjim"%>
<%@ page import="reply.Reply"%>
<%@ page import="reply.ReplyDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>강남대학교 중고장터 내 정보</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/reset.css?v=3">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/view.css">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/favicon/flat-design-touch.png">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style></style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}

		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}

		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='${pageContext.request.contextPath}/view/pages/MainPage.jsp'");
			script.println("</script>");
		}

		Bbs bbs = new BbsDAO().getBbs(bbsID);
		Reply reply = new ReplyDAO().getReply(bbsID);
	%>
	<div id="wrap">
		<%
			if (userID == null) {
		%>
		<section class="info_section">
			<ul class="info_list">
				<li><a
					href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">메인홈</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Login.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Login.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그인</a></li>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
					src="${pageContext.request.contextPath}/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>
		<section class="sign_section">
			<div class="signup">
				<h2>로그인 후 이용가능 합니다.</h2>
				<div>
					<input type="button" id="btnPwSearch" class="loginbtn" value="로그인"
						onclick="location.href='${pageContext.request.contextPath}/view/pages/Login.jsp'" />
				</div>
				<div>
					<input type="button" id="btnSignUp" class="loginbtn" value="회원가입"
						onclick="location.href='${pageContext.request.contextPath}/view/pages/SignUp.jsp'" />
				</div>
			</div>
		</section>

		<%
			} else {
		%>
		<section class="info_section">
			<ul class="info_list">
				<li><a
					href="${pageContext.request.contextPath}/view/pages/jjimBbs.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-bell-3917226.png"
						style="width: 30px; height: auto;" alt="">찜목록</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/MyPage.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-id-badge-3914510.png"
						style="width: 30px; height: auto;" alt="">내정보</a></li>
				<li><a
					href="${pageContext.request.contextPath}/view/pages/Logout.jsp"><img
						src="${pageContext.request.contextPath}/images/s_images/free-icon-font-comments-5074600.png"
						style="width: 30px; height: auto;" alt="">로그아웃</a></li>
			</ul>
		</section>

		<header class="header">
			<h1 class="logo">
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"><img
					src="${pageContext.request.contextPath}/images/s_images/마크.png"
					style="width: 98px; height: auto;" alt=""> <span id="logo_1">강남대학교</span>
					중고장터</a>
			</h1>
		</header>

		<section class="board_section">
			<div class="category_div">
				<p>
					작성자 :
					<%=bbs.getUserName()%></p>
				<p>
					작성일자 :
					<%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
						+ bbs.getBbsDate().substring(14, 16) + "분"%></p>
				<p style="font-size: 30px; font-weight: bold;">
					<%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
						.replaceAll("\n", "<br>")%>
				</p>
				<p style="font-size: 15px; font-weight: bold;">
					가격:
					<%=bbs.getCost()%>원
				</p>
				<p>
					<%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
						.replaceAll("\n", "<br>")%>
				</p>

				<div class="button_group">
					<%
						JjimDAO jjimDAO = new JjimDAO();
							ArrayList<Jjim> list1 = jjimDAO.getJjim(userID, bbsID);
							if (list1.isEmpty()) {
					%>
					<button class="jjimbtn"
						onclick="location.href='${pageContext.request.contextPath}/view/utils/jjimAction.jsp?bbsID=<%=bbsID%>'">찜하기</button>
					<%
						} else {
					%>
					<button class="jjimbtn"
						onclick="location.href='${pageContext.request.contextPath}/view/utils/jjimAction.jsp?bbsID=<%=bbsID%>'">찜해제</button>
					<%
						}
					%>
					<button class="chatbtn"
						onclick="if (confirm('채팅을 하시겠습니까?')) { location.href='${pageContext.request.contextPath}/view/pages/Chat.jsp?bbsID=<%=bbsID%>'; }">
						채팅하기</button>


				</div>
			</div>
		</section>


		<section class="reply_section">
			<table class="table-striped">
				<thead>
					<tr>
						<th colspan="3" class="reply_title">댓글</th>
					</tr>
				</thead>
				<tbody>
					<%
						ReplyDAO replyDAO = new ReplyDAO();
							ArrayList<Reply> list = replyDAO.getList(bbsID, pageNumber);
							for (int i = 0; i < list.size(); i++) {
					%>
					<tr class="reply_tr">
						<td style="text-align: left; width: 80%;"><p
								style="font-weight: bold;">
								작성자:
								<%=list.get(i).getUserID()%></p>
							<p style="font-size: 12px;">
								작성일:
								<%
								java.sql.Timestamp replyDate = list.get(i).getReplyDate();
										String formattedDate = (replyDate != null)
												? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(replyDate)
												: "날짜 없음";
							%>
								<%=formattedDate%>
							</p>
							<p><%=list.get(i).getReplyContent()%></p></td>
						<%
							if (list.get(i).getUserID() != null && list.get(i).getUserID().equals(userID)) {
						%>
						<td style="text-align: center;"><a
							onclick="return confirm('정말로 삭제하시겠습니까?')"
							href="${pageContext.request.contextPath}/view/actions/reply_deleteAction.jsp?bbsID=<%=bbsID%>&replyID=<%=list.get(i).getReplyID()%>"
							class="reply_delete">삭제</a></td>
						<%
							} else {
						%>
						<td style="text-align: center;">*</td>
						<%
							}
						%>
					</tr>
					<%
						}
					%>

				</tbody>
			</table>
		</section>
		<section class="reply_section_1">
			<form method="post" style="width: 400px;"
				action="${pageContext.request.contextPath}/view/actions/replyAction.jsp?bbsID=<%=bbsID%>">
				<div class="table-striped_1">
					<textarea placeholder="댓글을 입력하세요." name="replyContent"
						maxlength="2048" class="textarea_css"></textarea>
					<input type="submit" class="reply_btn" value="댓글입력">
				</div>
			</form>
		</section>

		<section class="board_section_1">
			<div class="btn_div">
				<%
					if (userID != null && userID.equals(bbs.getUserName())) {
				%>
				<a
					href="${pageContext.request.contextPath}/view/pages/update.jsp?bbsID=<%=bbsID%>"
					class="btn_primary">수정</a> <a
					onclick="return confirm('정말로 삭제하시겠습니까?')"
					href="${pageContext.request.contextPath}/view/actions/deleteAction.jsp?bbsID=<%=bbsID%>"
					class="btn_primary">삭제</a> <a
					href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"
					class="back_list">목록</a>
				<%
					} else {
				%>
				<a href="${pageContext.request.contextPath}/view/pages/MainPage.jsp"
					class="back_list">목록</a>
				<%
					}
				%>
			</div>
		</section>
	</div>
	<%
		}
	%>
</body>
</html>
