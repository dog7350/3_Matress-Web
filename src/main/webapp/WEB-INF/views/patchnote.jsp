<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="Maetress.entity.User" %>
<%@ page import="Maetress.entity.PatchNote" %>

<% request.getParameter("UTF-8"); %>

<%
    String admin = "x";
    if (session.getAttribute("userInfo") != null) {
        User user = (User) session.getAttribute("userInfo");
        admin = user.getUserAdmin();
    }

    SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    List<PatchNote> patchNotes = (List<PatchNote>) request.getAttribute("patchNotes");
    String patchState = request.getParameter("P_State");
%>

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
                <div style="padding-left: 10px;">
                    <h1>패치 노트</h1>
                    <% if(patchState == null && admin.equals("o")) { %>
                    <form class="ReplyForm" method="post" action="noteinsert">
                        제목 : <input type="text" name="noteTitle" style="width:990px; margin-bottom: 5px;"/>
                        <textarea cols="145" rows="10" name="noteContent" style="margin-right:15px; resize:none;"></textarea>
                        <input type="submit" value="작성" style="position:absolute; width:50px; height:48px; font-size:15pt;">
                    </form>
                    <% } else if(patchState != null && admin.equals("o")) {
                        PatchNote modNote = (PatchNote) request.getAttribute("modNote");
                        modNote.setPatchContent(modNote.getPatchContent().replace("<br>", "\r\n"));
                    %>
                    <form class="ReplyForm" method="post" action="notemodify?p_no=<%=modNote.getPatchNo()%>&ti=<%=modNote.getPatchTime()%>">
                        제목 : <input type="text" name="noteTitle" value="<%=modNote.getPatchTitle()%>" />
                        <textarea cols="145" rows="10" name="noteContent" style="margin-right:15px; resize:none;"><%=modNote.getPatchContent()%></textarea>
                        <input type="submit" value="수정" style="position:absolute; width:50px; height:48px; font-size:15pt;">
                    </form>
                    <% } %>

                    <% for(int i = 0; i < patchNotes.size(); i++) {
                        PatchNote note = patchNotes.get(i);
                        note.setPatchContent(note.getPatchContent().replace("\r\n", "<br>"));
                    %>
                    <div class="Reply_Body">
                        <div class="Reply_head">
                            <span style="font-weight:bold;">제목 : <%=note.getPatchTitle()%></span>
                            <span style="disply:inline-block; color:gray; font-size:9pt;"><%=dateformat.format(note.getPatchTime()) %></span>
                        </div>
                        <div class="Reply_btn">
                            <% if(admin.equals("o")) { %>
                            <input type="button" value="수정" onclick="if(confirm('수정하시겠습니까?')) {location.href='notemodifymove?p_no=<%=note.getPatchNo()%>&P_State=modify'}">
                            <input type="button" value="삭제" onclick="if(confirm('삭제하시겠습니까?')) {location.href='deletenote?p_no=<%=note.getPatchNo()%>'}">
                            <% } %>
                        </div>

                        <div class="Reply_content">
                            <%=note.getPatchContent() %>
                        </div>
                    </div>
                    <%} %>
                </div>
            </div>

            <%@include file="include/footer.jsp"%>
        </div>
    </body>
</html>
