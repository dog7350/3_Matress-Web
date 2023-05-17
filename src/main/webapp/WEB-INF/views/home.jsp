<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="Maetress.entity.Board" %>
<%@ page import="Maetress.entity.UserRank" %>

<%
    List<Board> normalBoards = (List<Board>) request.getAttribute("normalBoards");
    List<Board> noticeBoards = (List<Board>) request.getAttribute("noticeBoards");
    List<UserRank> rankList = (List<UserRank>) request.getAttribute("rankList");

    int normalCount = 0;
    if(normalBoards.size() < 10) normalCount = normalBoards.size();
    else normalCount = 10;

    int rankCount = 0;
    if(rankList.size() < 15) rankCount = rankList.size();
    else rankCount = 15;

    SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
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
        <link rel="stylesheet" href="resources/css/default.css" type="text/css" />
        <link rel="stylesheet" href="resources/css/main.css" type="text/css" />
        <link rel="stylesheet" href="resources/css/Rolling.css" type="text/css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="resources/js/common.js" type="text/javascript"></script>
        <script src="resources/js/Rolling.js" type="text/javascript"></script>
    </head>

    <body>
        <%@include file="include/header.jsp"%>

        <div id="body-wrapper">
            <div id="body-content">
                <div id="Main_Base">
                    <div id="Main_Content">
                        <div id="Main_Top">
                            <div class="RollingContainer">
                                <button type="button" id="prev"><img src="resources/img/Left_Button_Out.png" onmouseover="changeover(this, 'Left_Button')" onmouseout="changeout(this, 'Left_Button')"></button>
                                <button type="button" id="next"><img src="resources/img/Right_Button_Out.png" onmouseover="changeover(this, 'Right_Button')" onmouseout="changeout(this, 'Right_Button')"></button>
                                <div class="RollingDiv">
                                    <ul class="RollingBanner">
                                        <li><a href="#"><img src="resources/img/Rolling1.png" width="1500px" height="100%"></a></li>
                                        <li><a href="#"><img src="resources/img/Rolling2.png" width="1500px" height="100%"></a></li>
                                        <li><a href="#"><img src="resources/img/Rolling3.png" width="1500px" height="100%"></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div id="Main_Bottom">
                            <div id="Bottom_Left">
                                <div id="Left_Top">
                                    <div class="Main_Content_Title">공지사항</div>

                                    <table class="Main_Content_Table">
                                        <thead>
                                        <th>제목</th>
                                        <th width="100">작성자</th>
                                        <th width="100">작성시간</th>
                                        <th width="60">조회수</th>
                                        </thead>

                                        <tbody>
                                        <% for (int i = 0; i < noticeBoards.size(); i++) { %>
                                        <tr>
                                            <td>
                                                <a href="contentboard?b_no=<%=noticeBoards.get(i).getBoardNo()%>">
                                                    <%=noticeBoards.get(i).getBoardTitle()%>
                                                </a>
                                            </td>
                                            <td><%=noticeBoards.get(i).getUserId()%>
                                            </td>
                                            <td><%=dateformat.format(noticeBoards.get(i).getBoardTime())%>
                                            </td>
                                            <td><%=noticeBoards.get(i).getBoardInquiry()%>
                                            </td>
                                        </tr>
                                        <% } %>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="Left_Bottom">
                                    <div class="Main_Content_Title">자유게시판</div>

                                    <table class="Main_Content_Table">
                                        <thead>
                                        <th>제목</th>
                                        <th width="100">작성자</th>
                                        <th width="100">작성시간</th>
                                        <th width="60">조회수</th>
                                        </thead>

                                        <tbody>
                                        <% for (int i = 0; i < normalCount; i++) { %>
                                        <tr>
                                            <td>
                                                <a href="contentboard?b_no=<%=normalBoards.get(i).getBoardNo()%>">
                                                    <%=normalBoards.get(i).getBoardTitle()%>
                                                </a>
                                            </td>
                                            <td><%=normalBoards.get(i).getUserId()%>
                                            </td>
                                            <td><%=dateformat.format(normalBoards.get(i).getBoardTime())%>
                                            </td>
                                            <td><%=normalBoards.get(i).getBoardInquiry()%>
                                            </td>
                                        </tr>
                                        <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div id="Bottom_Right">
                                <div class="Main_Content_Title">랭크 TOP 15</div>

                                <table class="Main_Content_Table">
                                    <thead>
                                    <th>랭킹</th>
                                    <th>아이디</th>
                                    <th>MMR</th>
                                    </thead>

                                    <tbody>
                                    <% for (int i = 0; i < rankCount; i++) { %>
                                    <tr>
                                        <td><%=rankList.get(i).getRn()%>
                                        </td>
                                        <td><%=rankList.get(i).getRankId()%>
                                        </td>
                                        <td><%=rankList.get(i).getRankMmr()%>
                                        </td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%@include file="include/footer.jsp"%>
        </div>
    </body>
</html>