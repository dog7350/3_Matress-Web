<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<% request.getParameter("UTF-8"); %>

<% String[] tank = {"T95 H", "T95 M", "T95 L", "Panzer4 H", "Panzer4 M", "Panzer4 L", "M4A3 H", "M4A3 M", "M4A3 L", "SmallTank"}; %>

<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge; chrome=1">
        <title>MAETRESS</title>
        <meta name="description" content="3D 전략 슈팅 게임! 매트리스! 네오와 모피어스는 나오지 않는다!" />
        <link rel="shortcut icon" href="resources/img/titleLogo.png" />
        <link rel="stylesheet" href="resources/css/common.css" type="text/css" />
        <link rel="stylesheet" href="resources/css/tankinfo.css" type="text/css" />
        <link rel="stylesheet" href="resources/css/default.css" type="text/css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="resources/js/common.js" type="text/javascript"></script>
    </head>

    <body>
        <%@include file="include/header.jsp"%>

        <div id="body-wrapper">
            <div id="body-content">
                <section>
                    <div id="TankInfo_Container">
                        <div id="TankInfo_Content">
                            <h1>탱크 목록</h1>
                            <div id="TankInfo_Board">
                                <table id="TankInfo_Table" border="2">
                                    <% for(int i = 0; i < 10; i += 5) { %>
                                    <tr>
                                        <td style="font-size: 15pt; font-weight: bold">외형</td>
                                        <td><a href="gameinfo?tno=<%=i + 1%>"><img src="resources/img/Tank_<%=tank[i]%>.jpg" width="300" height="150"></a></td>
                                        <td><a href="gameinfo?tno=<%=i + 2%>"><img src="resources/img/Tank_<%=tank[i + 1]%>.jpg" width="300" height="150"></a></td>
                                        <td><a href="gameinfo?tno=<%=i + 3%>"><img src="resources/img/Tank_<%=tank[i + 2]%>.jpg" width="300" height="150"></a></td>
                                        <td><a href="gameinfo?tno=<%=i + 4%>"><img src="resources/img/Tank_<%=tank[i + 3]%>.jpg" width="300" height="150"></a></td>
                                        <td><a href="gameinfo?tno=<%=i + 5%>"><img src="resources/img/Tank_<%=tank[i + 4]%>.jpg" width="300" height="150"></a></td>
                                    </tr>
                                    <tr>
                                        <td style="font-size: 15pt; font-weight: bold">탱크 이름</td>
                                        <td><a href="gameinfo?tno=<%=i + 1%>"><%=tank[i]%></a></td>
                                        <td><a href="gameinfo?tno=<%=i + 2%>"><%=tank[i + 1]%></a></td>
                                        <td><a href="gameinfo?tno=<%=i + 3%>"><%=tank[i + 2]%></a></td>
                                        <td><a href="gameinfo?tno=<%=i + 4%>"><%=tank[i + 3]%></a></td>
                                        <td><a href="gameinfo?tno=<%=i + 5%>"><%=tank[i + 4]%></a></td>
                                    </tr>
                                    <% } %>
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
