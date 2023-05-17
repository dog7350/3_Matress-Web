<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="Maetress.entity.UserRank" %>
<%@ page import="Maetress.board.PageCreator" %>

<% request.getParameter("UTF-8"); %>

<%
    PageCreator pc = (PageCreator) request.getAttribute("pageCount");

    List<UserRank> rankList = (List<UserRank>) request.getAttribute("rankList");

    String seId = "";
    String seRank = "";
    if(request.getParameter("condition") != null) {
        if (request.getParameter("condition").equals("아이디")) seId = "selected";
        else if (request.getParameter("condition").equals("순위")) seRank = "selected";
    }
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
                    <div id="Search">
                        <div id="SearchForm">
                            <form method=get action="rankboard">
                                <select name="condition">
                                    <option <%=seId%>>아이디</option>
                                    <option <%=seRank%>>순위</option>
                                </select>
                                <div id="SearchBar">
                                    <% if (request.getParameter("keyword") != null) { %>
                                    <input type="text" name="keyword" placeholder="아이디 입력" value="<%=request.getParameter("keyword")%>">
                                    <% } else { %>
                                    <input type="text" name="keyword" placeholder="아이디 입력">
                                    <% } %>
                                    <input type="submit" value=" ">
                                </div>
                            </form>
                        </div>
                    </div>

                    <div id="OpenBoard_Container">
                        <div class="OpenBoard_Content">
                            <h1 style="margin-top:15px;">랭킹</h1>
                            <div class="OpenBoard_Board" style="width:900px;">
                                <table class="OpenBoard_Table" border="2" style="width:900px;">
                                    <thead bgcolor="#d5d5d5">
                                    <th width="60">순위</th>
                                    <th>아이디</th>
                                    <th width="140">MMR</th>
                                    <th width="150">소지금</th>
                                    </thead>
                                    <tbody>
                                    <% for(int i = 0; i < rankList.size(); i++) { %>
                                    <tr>
                                        <td><%=rankList.get(i).getRn()%></td>
                                        <td>
                                            <a href="#">
                                                <%=rankList.get(i).getRankId()%>
                                            </a>
                                        </td>
                                        <td><%=rankList.get(i).getRankMmr()%></td>
                                        <td><%=rankList.get(i).getRankMoney()%></td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <div id="Board_PNPage">
                                <% if(pc.isPrev()) { %>
                                <a href="rankboard?page=<%=pc.getBeginPage() - 1%>&page=<%=pc.getPaging().getPage()%>&countPerPage=<%=pc.getPaging().getCountPerPage()%>">이전</a>
                                <% } %>

                                <% for (int num = pc.getBeginPage(); num <= pc.getEndPage(); num++) { %>
                                <a href="rankboard<%=pc.makeURI(num)%>"><%=num%></a>
                                <% } %>

                                <% if(pc.isNext()) { %>
                                <a href="rankboard?page=<%=pc.getEndPage() + 1%>&page=<%=pc.getPaging().getPage()%>&countPerPage=<%=pc.getPaging().getCountPerPage()%>">다음</a>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

            <%@include file="include/footer.jsp"%>
        </div>
    </body>
</html>