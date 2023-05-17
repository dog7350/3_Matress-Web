<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="Maetress.entity.QnaBoard" %>
<%@ page import="Maetress.entity.User" %>

<% request.getParameter("UTF-8"); %>

<%
    User user = (User) session.getAttribute("userInfo");
    String id = user.getUserId();
    String admin = user.getUserAdmin();
    String qnaState = request.getParameter("Q_State");

    QnaBoard qna = null;
    List<QnaBoard> qnaList = null;

    if (qnaState.equals("comment")) {
        qna = (QnaBoard) request.getAttribute("qna");
        qnaList = (List<QnaBoard>) request.getAttribute("qnaList");
    }

    SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<% if (session.getAttribute("userInfo") == null) { %>
<script>
    alert('로그인 시 이용 가능합니다.');
    history.back();
</script>
<% } %>

<% if (qnaState.equals("comment") && qna.getQnaSecret().equals("true")) {
    if (user.getUserAdmin().equals("o")) { }
    else if (qna.getQnaWriter().equals(user.getUserId())) { }
    else { %>
<script>
    alert('관리자와 작성자만 확인 가능합니다.');
    history.back();
</script>
<% } } %>

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
        <link rel="stylesheet" href="resources/css/search.css" type="text/css" />
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
                            <h1 style="margin-top:15px;">Q & A</h1>
                            <% if(qnaState.equals("comment")) { %>
                            <div class="Board_Top">
                                <div id="Board_C_Id">작성자 : <%=qna.getQnaWriter()%></div> |
                                <div id="Board_C_Time">작성 시간 : <%=dateformat.format(qna.getQnaTime()) %></div>
                                <% if(admin.equals("o")) { %>
                                <input type="button" value="삭제" onclick="if(confirm('삭제하시겠습니까?')) {location.href='deleteqna?q_no=<%=qna.getQnaNo()%>'}">
                                <%	} %>
                                <br>
                                <div id="Board_C_Title">제목 : <%=qna.getQnaTitle()%></div>
                            </div>

                            <div class="Board_Body">
                                <div id="Board_C_Content"><%=qna.getQnaContent()%></div>
                            </div>
                            <% } %>

                            <% if (qnaState.equals("insert")) { %>
                            <form class="ReplyForm" method="post" action="saveqna">
                                제목 : <input type="text" name="qnaTitle" style="width:900px; margin-bottom: 5px;"/>
                                <label>비밀글<input type="checkbox" name="qnaSecret" value="Secret"></label>
                                <textarea cols="145" rows="30" name="qnaContent" style="margin-right:15px; resize:none;"></textarea>
                                <input type="submit" value="작성" style="position:absolute; width:50px; height:48px; font-size:15pt;">
                                <input type="hidden" name="id" value="<%=id%>">
                            </form>
                            <% } else if (qna.getQnaWriter().equals(user.getUserId()) || user.getUserAdmin().equals("o")){ %>
                            <form class="ReplyForm" method="post" action="commentqna?q_no=<%=qna.getQnaNo()%>">
                                <textarea cols="145" rows="3" name="qnaContent" style="margin-right:15px; resize:none;"></textarea>
                                <input type="submit" value="작성" style="position:absolute; width:50px; height:48px; font-size:15pt;">
                                <input type="hidden" name="id" value="<%=id%>">
                            </form>
                            <% } %>

                            <% if(qnaState.equals("comment")) { %>
                            <div class="AnswerDiv">
                                <div class="Answer">
                                    <% for(int i = 0; i < qnaList.size(); i++) {
                                            QnaBoard an_q = qnaList.get(i);
                                            if(an_q.getQnaCommenter().equals("admin")) {
                                        %>
                                        <div class="ADMIN_A">
                                            <span style="font-size:9pt; color:gray;">(<%=an_q.getQnaTime()%>)</span>
                                            <span style="font-weight:bold;">관리자</span> : <%=an_q.getQnaContent()%>
                                        </div><br>
                                        <% } else { %>
                                        <div class="USER_A">
                                            <%=an_q.getQnaContent()%> : <span style="font-weight:bold;"><%=an_q.getQnaCommenter()%></span>
                                            <span style="font-size:9pt; color:gray;">(<%=an_q.getQnaTime()%>)</span>
                                        </div><br>
                                        <% } %>
                                    <% } %>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </section>
            </div>

            <%@include file="include/footer.jsp"%>
        </div>
    </body>
</html>
