<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="Maetress.entity.QnaBoard" %>
<%@ page import="Maetress.board.PageCreator" %>

<% request.getParameter("UTF-8"); %>

<%
    PageCreator pc = (PageCreator) request.getAttribute("pageCount");

    String seTitle = "";
    String seWriter = "";

    if (request.getParameter("condition") != null)
    {
        if (request.getParameter("condition").equals("제목")) seTitle = "selected";
        else if (request.getParameter("condition").equals("작성자")) seWriter = "selected";
    }

    List<QnaBoard> qnaList = (List<QnaBoard>) request.getAttribute("qnaList");

    SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<% if (session.getAttribute("userInfo") == null) { %>
<script>
    alert('로그인 시 이용 가능합니다.');
    history.back();
</script>
<% } %>

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
                            <form method=get action="qna">
                                <select name="condition">
                                    <option <%=seTitle%>>제목</option>
                                    <option <%=seWriter%>>작성자</option>
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
                            <h1 style="margin-top:15px;">Q & A</h1>
                            <div class="OpenBoard_Board">
                                <input type="button" value="글 쓰기" onclick="location.href='insertqna?Q_State=insert'" style="float:right;"><br>
                                <TABLE class="OpenBoard_Table" border="2">
                                    <thead bgcolor="#d5d5d5">
                                    <th width="40">번호</th>
                                    <th>제목</th>
                                    <th width="140">작성자</th>
                                    <th width="150">작성시간</th>
                                    </thead>
                                    <tbody>
                                    <% for(int i = 0; i < qnaList.size(); i++) {
                                        QnaBoard qna = qnaList.get(i);
                                    %>
                                    <tr>
                                        <td><%=qna.getQnaNo()%></td>
                                        <td>
                                            <a href="qnacontent?q_no=<%=qna.getQnaNo()%>&Q_State=comment">
                                                <%=qna.getQnaTitle()%>
                                            </a>
                                            &nbsp;
                                            <% if (qna.getQnaSecret().equals("true")) { %>
                                                <img src="resources/img/Lock.png" width="15" height="15"/>
                                            <% } %>
                                        </td>
                                        <td><%=qna.getQnaWriter()%></td>
                                        <td><%=dateformat.format(qna.getQnaTime()) %></td>
                                    </tr>
                                    <%} %>
                                    </tbody>
                                </TABLE>
                            </div>

                            <div id="Board_PNPage">
                                <% if(pc.isPrev()) { %>
                                    <a href="qna?page=<%=pc.getBeginPage() - 1%>&page=<%=pc.getPaging().getPage()%>&countPerPage=<%=pc.getPaging().getCountPerPage()%>">이전</a>
                                <% } %>

                                <% for (int num = pc.getBeginPage(); num <= pc.getEndPage(); num++) { %>
                                    <a href="qna<%=pc.makeURI(num)%>"><%=num%></a>
                                <% } %>

                                <% if(pc.isNext()) { %>
                                    <a href="qna?page=<%=pc.getEndPage() + 1%>&page=<%=pc.getPaging().getPage()%>&countPerPage=<%=pc.getPaging().getCountPerPage()%>">다음</a>
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