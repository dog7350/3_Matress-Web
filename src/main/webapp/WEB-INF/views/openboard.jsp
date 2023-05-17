<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="Maetress.entity.Board" %>
<%@ page import="Maetress.board.PageCreator" %>

<% request.getParameter("UTF-8"); %>

<%
    List<Board> normalBoards = (List<Board>) request.getAttribute("normalBoards");
    List<Board> noticeBoards = (List<Board>) request.getAttribute("noticeBoards");
    PageCreator pc = (PageCreator) request.getAttribute("pageCount");

    String seTitle = "";
    String seWriter = "";
    String seTiCo = "";

    if (request.getParameter("condition") != null)
    {
        if (request.getParameter("condition").equals("제목")) seTitle = "selected";
        else if (request.getParameter("condition").equals("작성자")) seWriter = "selected";
        else if (request.getParameter("condition").equals("제목+내용")) seTiCo = "selected";
    }

    SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
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
                            <form method=get action="openboard">
                                <select name="condition">
                                    <option <%=seTitle%>>제목</option>
                                    <option <%=seWriter%>>작성자</option>
                                    <option <%=seTiCo%>>제목+내용</option>
                                </select>
                                <div id="SearchBar">
                                    <% if (request.getParameter("keyword") != null) { %>
                                        <input type="text" name="keyword" placeholder="검색어 입력" value="<%=request.getParameter("keyword")%>">
                                    <% } else { %>
                                        <input type="text" name="keyword" placeholder="검색어 입력">
                                    <% } %>
                                    <input type="submit" value=" ">
                                </div>
                            </form>
                        </div>
                    </div>

                    <div id="OpenBoard_Container">
                        <div class="OpenBoard_Content">
                            <h1 style="margin-top:15px;">자유 게시판</h1>
                            <div class="OpenBoard_Board">
                                <input type="button" value="글 쓰기" onclick="location.href='insertopenboard'" style="float:right;"><br>
                                <table class="OpenBoard_Table" border="2">
                                    <thead bgcolor="#d5d5d5">
                                        <th width="40">번호</th>
                                        <th>제목</th>
                                        <th width="140">작성자</th>
                                        <th width="150">작성시간</th>
                                        <th width="60">조회수</th>
                                        <th width="60">신고수</th>
                                    </thead>
                                    <tbody>
                                        <% for(int i = 0; i < noticeBoards.size(); i++) { %>
                                            <tr>
                                                <td style="color:red; font-weight: bold;">공지</td>
                                                <td>
                                                    <a href="contentboard?b_no=<%=noticeBoards.get(i).getBoardNo()%>" style="color:red; font-weight: bold; text-decoration: none;">
                                                        <%=noticeBoards.get(i).getBoardTitle()%>
                                                    </a>
                                                </td>
                                                <td><%=noticeBoards.get(i).getUserId()%></td>
                                                <td><%=dateformat.format(noticeBoards.get(i).getBoardTime())%></td>
                                                <td><%=noticeBoards.get(i).getBoardInquiry()%></td>
                                                <td><%=noticeBoards.get(i).getBoardReport()%></td>
                                            </tr>
                                        <% } %>
                                        <% for(int i = 0; i < normalBoards.size(); i++) { %>
                                            <tr>
                                                <td><%=normalBoards.get(i).getBoardNo()%></td>
                                                <td>
                                                    <a href="contentboard?b_no=<%=normalBoards.get(i).getBoardNo()%>">
                                                        <%=normalBoards.get(i).getBoardTitle()%>
                                                    </a>
                                                </td>
                                                <td><%=normalBoards.get(i).getUserId()%></td>
                                                <td><%=dateformat.format(normalBoards.get(i).getBoardTime())%></td>
                                                <td><%=normalBoards.get(i).getBoardInquiry()%></td>
                                                <td><%=normalBoards.get(i).getBoardReport()%></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <div id="Board_PNPage">
                                <% if(pc.isPrev()) { %>
                                    <a href="openboard?page=<%=pc.getBeginPage() - 1%>&page=<%=pc.getPaging().getPage()%>&countPerPage=<%=pc.getPaging().getCountPerPage()%>">이전</a>
                                <% } %>

                                <% for (int num = pc.getBeginPage(); num <= pc.getEndPage(); num++) { %>
                                    <a href="openboard<%=pc.makeURI(num)%>"><%=num%></a>
                                <% } %>

                                <% if(pc.isNext()) { %>
                                    <a href="openboard?page=<%=pc.getEndPage() + 1%>&page=<%=pc.getPaging().getPage()%>&countPerPage=<%=pc.getPaging().getCountPerPage()%>">다음</a>
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