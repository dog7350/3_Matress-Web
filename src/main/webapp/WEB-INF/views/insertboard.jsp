<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="Maetress.entity.User" %>

<% request.getParameter("UTF-8"); %>

<%
    User user = (User) session.getAttribute("userInfo");
    String uid = "";
    String uadmin = "";

    if (user != null)
    {
        uid = user.getUserId();
        uadmin = user.getUserAdmin();
    }
%>

<% if (session.getAttribute("userInfo") == null) { %>
<script>
    alert('로그인 시 이용 가능합니다.');
    history.back();
</script>
<% } %>

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
        <link rel="stylesheet" href="resources/css/openboard_insert.css" type="text/css" />
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
                            <h1 style="margin-top:15px;">자유 게시판</h1>
                            <div class="formdiv">
                                <form id="boardform" method="post" action="saveboard">
                                    <% if(uadmin.equals("o")) {%>
                                    제목 : <input type="text" size="88" name="BoardTitle">
                                    <select name="B_Notice" style="font-size:16pt;">
                                        <option>일반</option>
                                        <option>공지</option>
                                    </select>
                                    <%} else { %>
                                    제목 : <input type="text" size=95 name="BoardTitle">
                                    <%} %>
                                    <textarea cols="104" rows="100" name="BoardContent"></textarea><br>
                                    <input type="button" value="취소" onclick="history.back()">
                                    <input type="submit" value="완료">
                                    <input type="hidden" name="BoardWriter" value="<%=uid%>">
                                </form>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

            <%@include file="include/footer.jsp"%>
        </div>
    </body>
</html>
