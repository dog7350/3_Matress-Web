<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="Maetress.entity.User" %>
<%@ page import="Maetress.entity.Board" %>
<%@ page import="Maetress.entity.Comment" %>
<%@ page import="Maetress.board.PageCreator" %>

<% request.getParameter("UTF-8"); %>

<%
    PageCreator pc = (PageCreator) request.getAttribute("pageCount");

    String A_State = "";
    if(request.getAttribute("A_State") != null) A_State = (String) request.getAttribute("A_State");

    List<User> users = null;
    List<Board> boards = null;
    List<Comment> replys = null;

    if (A_State.equals("user")) {
        users = (List<User>) request.getAttribute("users");
    }
    else if (A_State.equals("board")) {
        boards = (List<Board>) request.getAttribute("boards");
    }
    else if (A_State.equals("reply")) {
        replys = (List<Comment>) request.getAttribute("replys");
    }

    String seUser = "";
    String seBoard = "";
    String seReply = "";

    if (request.getParameter("condition") != null)
    {
        if (request.getParameter("condition").equals("회원")) seUser = "selected";
        else if (request.getParameter("condition").equals("게시글")) seBoard = "selected";
        else if (request.getParameter("condition").equals("댓글")) seReply = "selected";
    }

    SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
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
                    <div id="Search" style="height:50px;">
                        <div id="SearchForm">
                            <form method=get action="adminpage">
                                <select name="condition">
                                    <option <%=seUser%>>회원</option>
                                    <option <%=seBoard%>>게시글</option>
                                    <option <%=seReply%>>댓글</option>
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

                    <div id="OpenBoard_Container" style="height:700px;">
                        <div class="OpenBoard_Content">
                            <% if (A_State.equals("user")) { %>
                            <h1 style="margin-top:15px;">회원 관리</h1>
                            <div class="OpenBoard_Board">
                                <table class="OpenBoard_Table" border="2">
                                    <thead bgcolor="#d5d5d5">
                                        <th width="140">아이디</th>
                                        <th width="140">이름</th>
                                        <th width="180">이메일</th>
                                        <th width="60">MMR</th>
                                        <th width="140">게임 머니</th>
                                        <th width="140">캐시</th>
                                        <th width="60">탈퇴</th>
                                    </thead>
                                    <tbody>
                                    <% for(int i = 0; i < users.size(); i++) { %>
                                    <tr>
                                        <td><%=users.get(i).getUserId()%></td>
                                        <td><%=users.get(i).getUserName()%></td>
                                        <td><%=users.get(i).getUserEmail()%></td>
                                        <td><%=users.get(i).getUserMmr()%></td>
                                        <td><%=users.get(i).getUserMoney()%></td>
                                        <td><%=users.get(i).getUserCash()%></td>
                                        <td><input type="button" value="탈퇴" style="width:100%;" onclick="location.href='adminuserdelete?id=<%=users.get(i).getUserId()%>'"></td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <% } %>

                            <% if (A_State.equals("board")) { %>
                            <h1 style="margin-top:15px;">게시글 관리</h1>
                            <div class="OpenBoard_Board">
                                <table class="OpenBoard_Table" border="2">
                                    <thead bgcolor="#d5d5d5">
                                        <th>제목</th>
                                        <th width="140">작성자</th>
                                        <th width="60">조회수</th>
                                        <th width="60">신고수</th>
                                        <th width="60">삭제</th>
                                    </thead>
                                    <tbody>
                                    <% for(int i = 0; i < boards.size(); i++) { %>
                                    <tr>
                                        <td>
                                            <a href="contentboard?b_no=<%=boards.get(i).getBoardNo()%>">
                                                <%=boards.get(i).getBoardTitle()%>
                                            </a>
                                        </td>
                                        <td><%=boards.get(i).getUserId()%></td>
                                        <td><%=boards.get(i).getBoardInquiry()%></td>
                                        <td><%=boards.get(i).getBoardReport()%></td>
                                        <td><input type="button" value="삭제" style="width:100%;" onclick="location.href='adminboarddelete?b_no=<%=boards.get(i).getBoardNo()%>'"></td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <% } %>

                            <% if (A_State.equals("reply")) { %>
                            <h1 style="margin-top:15px;">댓글 관리</h1>
                            <div class="OpenBoard_Board">
                                <table class="OpenBoard_Table" border="2">
                                    <thead bgcolor="#d5d5d5">
                                        <th>댓글 내용</th>
                                        <th width="140">작성자</th>
                                        <th width="60">신고수</th>
                                        <th width="60">삭제</th>
                                    </thead>
                                    <tbody>
                                    <% for(int i = 0; i < replys.size(); i++) { %>
                                    <tr>
                                        <td>
                                            <a href="contentboard?b_no=<%=replys.get(i).getBoardNo()%>">
                                                <%=replys.get(i).getCmtContent()%>
                                            </a>
                                        </td>
                                        <td><%=replys.get(i).getUserId()%></td>
                                        <td><%=replys.get(i).getCmtReport()%></td>
                                        <td><input type="button" value="삭제" style="width:100%;" onclick="location.href='adminreplydelete?b_no=<%=replys.get(i).getBoardNo()%>&c_no=<%=replys.get(i).getCmtNo()%>'"></td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <% } %>

                            <div id="Board_PNPage">
                                <% if(pc.isPrev()) { %>
                                <a href="adminpage?page=<%=pc.getBeginPage() - 1%>&page=<%=pc.getPaging().getPage()%>&countPerPage=<%=pc.getPaging().getCountPerPage()%>">이전</a>
                                <% } %>

                                <% for (int num = pc.getBeginPage(); num <= pc.getEndPage(); num++) { %>
                                <a href="adminpage<%=pc.makeURI(num)%>&A_State=<%=A_State%>"><%=num%></a>
                                <% } %>

                                <% if(pc.isNext()) { %>
                                <a href="adminpage?page=<%=pc.getEndPage() + 1%>&page=<%=pc.getPaging().getPage()%>&countPerPage=<%=pc.getPaging().getCountPerPage()%>">다음</a>
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
