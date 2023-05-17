<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="Maetress.entity.Tank" %>

<% request.getParameter("UTF-8"); %>

<%
    String[] tankImage = {"T95 H", "T95 M", "T95 L", "Panzer4 H", "Panzer4 M", "Panzer4 L", "M4A3 H", "M4A3 M", "M4A3 L", "SmallTank"};
    Double maxAtk = Double.parseDouble(request.getAttribute("atk").toString()) * 0.01;
    Double maxDef = Double.parseDouble(request.getAttribute("def").toString()) * 0.01;
    Double maxSpeed = Double.parseDouble(request.getAttribute("speed").toString()) * 0.01;
    Tank tank = (Tank) request.getAttribute("tank");
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
        <link rel="stylesheet" href="resources/css/gameinfo.css" type="text/css" />
        <link rel="stylesheet" href="resources/css/default.css" type="text/css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="resources/js/common.js" type="text/javascript"></script>
    </head>

    <body>
        <%@include file="include/header.jsp"%>

        <div id="body-wrapper">
            <div id="body-content">
                <section>
                    <div id="GameInfo_Container">
                        <div id="GameInfo_Content">
                            <h1><%=tank.getTankName()%></h1>
                            <div id="GameInfo_Board">
                                <table id="GameInfo_Table" border="2">
                                    <tr>
                                        <td class="GameInfo_Title">외형</td>
                                        <td class="GameInfo_Title">탱크명</td>
                                        <td class="GameInfo_Exp"><%=tank.getTankName()%></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="5"><img src="resources/img/Tank_<%=tankImage[tank.getTankNo() - 1]%>.jpg" width="500" height="350"></td>
                                        <td class="GameInfo_Title">공격력</td>
                                        <td class="GameInfo_Bar"><img src="resources/img/Bar_Atk.png" style="height:50px; width:<%=tank.getTankAtk() / maxAtk%>%;"></td>
                                    </tr>
                                    <tr>
                                        <td class="GameInfo_Title">방어력</td>
                                        <td class="GameInfo_Bar"><img src="resources/img/Bar_Shield.png" style="height:50px; width:<%=tank.getTankDef() / maxDef%>%;"></td>
                                    </tr>
                                    <tr>
                                        <td class="GameInfo_Title">기동력</td>
                                        <td class="GameInfo_Bar"><img src="resources/img/Bar_Move.png" style="height:50px; width:<%=tank.getTankSpeed() / maxSpeed%>%;"></td>
                                    </tr>
                                    <tr>
                                        <td class="GameInfo_Title">중량</td>
                                        <td class="GameInfo_Exp"><%=tank.getTankType()%></td>
                                    </tr>
                                    <tr>
                                        <td class="GameInfo_Title">사용 포탄</td>
                                        <td class="GameInfo_Exp"><%=tank.getTankBName()%></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" class="GameInfo_Title">설명</td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" class="GameInfo_Exp"><%=tank.getTankBContent()%></td>
                                    </tr>
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
