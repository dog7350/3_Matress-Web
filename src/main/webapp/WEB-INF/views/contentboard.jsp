<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="Maetress.entity.User" %>
<%@ page import="Maetress.entity.Board" %>
<%@ page import="Maetress.entity.Comment" %>

<% request.getParameter("UTF-8"); %>

<%
    User user = null;
    String id = "";
    String admin = "";
    if (session.getAttribute("userInfo") != null) {
        user = (User) session.getAttribute("userInfo");
        id = user.getUserId();
        admin = user.getUserAdmin();
    }
    else {
%>
        <script>
            alert('로그인 시 이용 가능합니다.');
            history.back();
        </script>
<%
    }
    Board board = (Board) request.getAttribute("board");
    board.setBoardContent(board.getBoardContent().replace("\r\n", "<br>"));

    SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    List<Comment> rpList = (List<Comment>) request.getAttribute("reply");
    String replyState = (String) request.getParameter("R_State");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge; chrome=1">
        <title>MAETRESS</title>
        <meta name="description" content="3D 전략 슈팅 게임! 매트리스! 네오와 모피어스는 나오지 않는다!" />
        <link rel="shortcut icon" href="resources/img/titleLogo.png" />
        <link rel="stylesheet" href="resources/css/common.css" type="text/css" />
        <link rel="stylesheet" href="resources/css/openboard.css" type="text/css" />
        <link rel="stylesheet" href="resources/css/default.css" type="text/css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="resources/js/common.js" type="text/javascript"></script>
    </head>

    <body>
        <%@include file="include/header.jsp"%>

        <div id="body-wrapper">
            <div id="body-content">
                <section>
                    <div id="OpenBoard_Container">
                        <div class="OpenBoard_Content">
                            <div class="Board_Top">
                                <div id="Board_C_Id">작성자 : <%=board.getUserId() %></div> |
                                <div id="Board_C_Time">작성 시간 : <%=dateformat.format(board.getBoardTime()) %></div> |
                                <div id="Board_C_Inquiry">조회수 : <%=board.getBoardInquiry() %></div> |
                                <div id="Board_C_Report">신고수 : <%=board.getBoardReport() %></div>
                                <% if(user != null && (admin.equals("o") || board.getUserId().equals(id))) { %>
                                <input type="button" value="수정" onclick="if(confirm('수정하시겠습니까?')) {location.href='modifyopenboard?b_no=<%=board.getBoardNo()%>'}">
                                <input type="button" value="삭제" onclick="if(confirm('삭제하시겠습니까?')) {location.href='deleteboard?b_no=<%=board.getBoardNo()%>'}"> |
                                <%	} %>
                                <input type="button" value="신고" onclick="if(confirm('신고하시겠습니까?')) {location.href='reportboard?b_no=<%=board.getBoardNo()%>&rep=<%=board.getBoardReport()%>&ti=<%=board.getBoardTime()%>'}"><br>
                                <div id="Board_C_Title">제목 : <%=board.getBoardTitle() %></div>
                            </div>

                            <div class="Board_Body">
                                <div id="Board_C_Content"><%=board.getBoardContent()%></div>
                            </div>

                            <% if(replyState == null) { %>
                            <form class="ReplyForm" method="post" action="replyinsert?&b_no=<%=board.getBoardNo()%>">
                                <textarea cols="145" rows="3" name="ReplyContent" style="margin-right:15px; resize:none;"></textarea>
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="submit" value="작성" style="position:absolute; width:50px; height:48px; font-size:15pt;">
                            </form>
                            <% } else {
                                int c_no = Integer.parseInt((String)request.getParameter("c_no"));
                                Comment rep = (Comment) request.getAttribute("modReply");
                                rep.setCmtContent(rep.getCmtContent().replace("<br>", "\r\n"));
                            %>
                            <form class="ReplyForm" method="post" action="replymodify?b_no=<%=board.getBoardNo()%>&c_no=<%=rep.getCmtNo()%>&ti=<%=rep.getCmtTime()%>">
                                <textarea cols="145" rows="3" name="ReplyContent" style="margin-right:15px; resize:none;"><%=rep.getCmtContent()%></textarea>
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="submit" value="수정" style="position:absolute; width:50px; height:48px; font-size:15pt;">
                            </form>
                            <% } %>

                            <% for(int i = 0; i < rpList.size(); i++) {
                                Comment rep = rpList.get(i);
                                rep.setCmtContent(rep.getCmtContent().replace("\r\n", "<br>"));
                            %>
                            <div class="Reply_Body">
                                <div class="Reply_head">
                                    <span style="font-weight:bold;">작성자 : <%=rep.getUserId() %></span>
                                    <span style="disply:inline-block; color:gray; font-size:9pt;"><%=dateformat.format(rep.getCmtTime()) %></span>
                                </div>
                                <div class="Reply_btn">
                                    <% if(user != null && (admin.equals("o") || rep.getUserId().equals(id))) { %>
                                    <input type="button" value="수정" onclick="if(confirm('수정하시겠습니까?')) {location.href='replymodifymove?b_no=<%=board.getBoardNo() %>&R_State=modify&c_no=<%=rep.getCmtNo() %>'}">
                                    <input type="button" value="삭제" onclick="if(confirm('삭제하시겠습니까?')) {location.href='deletereply?b_no=<%=board.getBoardNo()%>&c_no=<%=rep.getCmtNo()%>'}"> |
                                    <% } %>
                                    <input type="button" value="신고" onclick="if(confirm('신고하시겠습니까?')) {location.href='reportreply?b_no=<%=board.getBoardNo()%>&c_no=<%=rep.getCmtNo()%>&ti=<%=rep.getCmtTime()%>&rp=<%=rep.getCmtReport()%>'}">
                                </div>

                                <div class="Reply_content">
                                    <%=rep.getCmtContent() %>
                                </div>
                            </div>
                            <%} %>
                        </div>
                    </div>
                </section>
            </div>

            <%@include file="include/footer.jsp"%>
        </div>
    </body>
</html>