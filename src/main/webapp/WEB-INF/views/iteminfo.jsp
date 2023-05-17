<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="Maetress.entity.Item" %>

<% request.getParameter("UTF-8"); %>

<%
    List<Item> itemList = (List<Item>) request.getAttribute("itemList");
    String[] itemImage = {"DoubleShot", "PowerUP", "Heist", "Repair", "Smoke", "Invisible", "Spy"};
    String[] itemNames = {"더블샷", "파워샷", "헤이스트", "수리도구", "연막탄", "중장갑", "스파이"};
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
                <section>
                    <div id="OpenBoard_Container">
                        <div class="OpenBoard_Content">
                            <h1 style="margin-top:15px;">아이템 정보</h1>
                            <div class="OpenBoard_Board">
                                <table class="OpenBoard_Table" border="2">
                                    <thead bgcolor="#d5d5d5">
                                    <th width="150">아이템 이름</th>
                                    <th>아이템 효과</th>
                                    <th width="140">가격</th>
                                    </thead>
                                    <tbody>
                                        <% for(int i = 0; i < itemList.size(); i++) { %>
                                        <tr>
                                            <td>
                                                <img src="resources/img/Item_<%=itemImage[i]%>.png" width="130" height="90"/> <br>
                                                <%=itemNames[i]%>
                                            </td>
                                            <td style="font-size: 20pt;"><%=itemList.get(i).getItemContent()%></td>
                                            <td style="font-size: 20pt;"><%=itemList.get(i).getItemMoney()%></td>
                                        </tr>
                                        <% } %>
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
