<%@ page import="Maetress.entity.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String id = "";
    boolean valid = false;
    String token = request.getParameter("token");
    String[] sessionToken = (String[]) session.getAttribute("pwToken");
    if (session.getAttribute("userInfo") != null) {
        if (token != null) { %>
        <script>
            alert('잡았다! 요놈!');
        </script>
<%      } else {
            User user = (User) session.getAttribute("userInfo");
            id = user.getUserId();
            valid = true;
        }
    } else if (sessionToken != null && token.equals(sessionToken[1])) {
        id = sessionToken[0];
        valid = true;
    } else { %>
    <script>
        alert('잡았다! 요놈!');
    </script>
<% } %>

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
    </head>

    <body>
        <%@include file="include/header.jsp"%>

        <div id="body-wrapper">
            <div id="body-content">
                <div id="Find_Base">
                    <div id="Find_Content">
                        <table id="Find_Table">
                            <tbody>
                                <tr>
                                    <td colspan="2">
                                        <% if (valid) { %>
                                        <form id="Find_Form" method="post" action="postChangePw">
                                            <input type="password" name="pw" placeholder="비밀번호"><br>
                                            <input type="password" name="pwCheck" placeholder="비밀번호 확인"><br>
                                            <input type="submit" value="비밀번호 변경" id="submit">
                                            <input type="hidden" name="id" value="<%=id%>">
                                        </form>
                                        <% } else { %>
                                        <span>잘못된 접근입니다.</span>
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

<script>
    $(document).ready(function () {
      $("#submit").click(function () {
        var form = document.getElementById("Find_Form");
        var pw = document.getElementsByName("pw");
        var pwCheck = document.getElementsByName("pwCheck");

        if(pw[0].value == "") {
            alert("비밀번호를 입력해주세요.");
            return false;
        } else if (pw[0].value != pwCheck[0].value) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
      });
    });
</script>