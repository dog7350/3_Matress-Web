<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String F_State = "";
    if (request.getAttribute("F_State") != null) {
        F_State = request.getAttribute("F_State").toString();
    }
%>

<% request.getParameter("UTF-8"); %>

<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge; chrome=1">
        <title>MAETRESS</title>
        <meta name="description" content="3D 전략 슈팅 게임! 매트리스! 네오와 모피어스는 나오지 않는다!" />
        <link rel="shortcut icon" href="resources/img/titleLogo.png" />
        <link rel="stylesheet" href="resources/css/common.css" type="text/css" />
        <link rel="stylesheet" href="resources/css/default.css" type="text/css" />
        <link rel="stylesheet" href="resources/css/find.css" type="text/css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="resources/js/find.js" type="text/javascript"></script>
    </head>

    <body>
    <%@include file="include/header.jsp"%>

    <div id="body-wrapper">
        <div id="body-content">
            <div id="Find_Base">
                <div id="Find_Content">
                    <table id="Find_Table">
                        <thead>
                            <% if(F_State.equals("idFind") || F_State.equals("idResult")) { %>
                            <th><input type="button" value="아이디" style="width:100%; background-color:transparent; color:white;" onclick="location.href='/find?F_State=idFind'"/></th>
                            <th><input type="button" value="비밀번호" style="width:100%; background-color:white;" onclick="location.href='/find?F_State=pwFind'"/></th>
                            <% } else if(F_State.equals("pwFind") || F_State.equals("pwResult")) { %>
                            <th><input type="button" value="아이디" style="width:100%; background-color:white;" onclick="location.href='/find?F_State=idFind'"/></th>
                            <th><input type="button" value="비밀번호" style="width:100%; background-color:transparent; color:white;" onclick="location.href='/find?F_State=pwFind'"/></th>
                            <% } %>
                        </thead>

                        <tbody>
                            <tr>
                                <td colspan="2">
                                    <% if(F_State.equals("idFind")) { %>
                                    <form id="Find_Form" method="post" action="/find-id">
                                        <input type="text" name="name" placeholder="이름"><br>
                                        <input type="text" name="email" placeholder="이메일"><br>
                                        <input type="submit" value="아이디 찾기">
                                    </form>
                                    <% } else if(F_State.equals("pwFind")) { %>
                                    <form id="Find_Form" method="post" action="/find-pw">
                                        <input type="text" name="id" placeholder="아이디"><br>
                                        <input type="text" name="email" placeholder="이메일"><br>
                                        <input type="submit" value="비밀번호 변경" onclick="disable(this)" >
                                    </form>
                                    <% } else if(F_State.equals("idResult") || F_State.equals("pwResult")) { %>
                                        <c:if test="${not empty message}">
                                        <span>${message}</span>
                                        </c:if>
                                        <c:if test="${empty message}">
                                        <span>잘못된 접근입니다.</span>
                                        </c:if>
                                    <% } %>
                               </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%@include file="include/footer.jsp"%>
    </div>
    </body>
</html>