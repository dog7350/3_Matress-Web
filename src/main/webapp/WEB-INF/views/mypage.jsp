<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="Maetress.entity.User" %>

<%
    request.getParameter("UTF-8");
    User user = (User) session.getAttribute("userInfo");
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
                            <div class="OpenBoard_Board" style="width:500px; top:300px;">
                                <p style="font-weight:bold; font-size:30px;">마이페이지</p>
                                <table class="OpenBoard_Table" border="2" style="width:500px; font-size:15pt;">
                                    <thead bgcolor="#d5d5d5">
                                        <th colspan="3">회원 정보</th>
                                    </thead>

                                    <tbody>
                                        <tr>
                                            <td>아이디</td>
                                            <td colspan="2"><%=user.getUserId()%></td>
                                        </tr>
                                        <tr>
                                            <td>이름</td>
                                            <td colspan="2"><%=user.getUserName()%></td>
                                        </tr>
                                        <tr>
                                            <td>이메일</td>
                                            <td colspan="2"><%=user.getUserEmail()%></td>
                                        </tr>
                                        <tr>
                                            <td>MMR</td>
                                            <td colspan="2"><%=user.getUserMmr()%></td>
                                        </tr>
                                        <tr>
                                            <td>Cash</td>
                                            <td colspan="2"><%=user.getUserCash()%></td>
                                        </tr>
                                        <tr>
                                            <td>Money</td>
                                            <td colspan="2"><%=user.getUserMoney()%></td>
                                        </tr>
                                        <tr>
                                            <td><input type="button" value="결제" style="width:100%; font-size:15pt;" onclick="location.href='/payment'"></td>
                                            <td><input type="button" value="비밀번호 변경" style="width:100%; font-size:15pt;" onclick="location.href='/change-pw'"></td>
                                            <td><input type="button" value="회원 탈퇴" style="width:100%; font-size:15pt;" onclick="if(confirm('탈퇴하시겠습니까?')) {location.href='/mypagedelete?id=<%=user.getUserId()%>'}"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

            <%@include file="include/footer.jsp"%>
        </div>
    </body>
</html>
