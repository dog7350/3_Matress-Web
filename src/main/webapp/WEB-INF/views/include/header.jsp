<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="Maetress.entity.User" %>

<%
    User emp = null;
    if(session.getAttribute("userInfo") != null) emp = (User) session.getAttribute("userInfo");
%>

<nav class="navbar">
    <a href="/" class="home"><img src="resources/img/logo.png" height="50px"/></a>
    <div class="dropdown">
        <button class="dropbtn">
            매트리스 정보
            <img src="resources/img/dropdown.png" height="8px"/>
        </button>
        <ul class="dropdown-content">
            <li><a href="tankinfo">탱크 정보</a></li>
            <li><a href="iteminfo">아이템 정보</a></li>
            <li><a href="playinfo">플레이 정보</a></li>
        </ul>
    </div>
    <a href="rankboard?page=1" class="navbtn">랭크</a>
    <a href="openboard?page=1" class="navbtn">자유 게시판</a>
    <a href="PNpage" class="navbtn">패치 노트</a>
    <a href="https://drive.google.com/drive/folders/1dwimXgJJuOaCmZq4UaqUgKldLIhyUFcO?usp=sharing" class="navbtn">다운로드</a>
    <a href="qna" class="navbtn">고객문의</a>
    <% if (emp != null && emp.getUserAdmin().equals("o")) { %>
    <a href="adminpage?A_State=user" class="navbtn">관리자 페이지</a>
    <% } %>
    <% if (session.getAttribute("userInfo") == null) { %>
    <a href="/join" class="join">회원가입</a>
    <a href="/login" class="login">로그인</a>
    <% } else { %>
    <a href="/logout" class="logout">로그아웃</a>
    <a href="/mypage" class="logout">마이페이지</a>
    <% } %>
</nav>
