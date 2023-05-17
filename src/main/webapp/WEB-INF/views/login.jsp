<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% if(request.getAttribute("msg") != null) { %>
<script>
  alert('변경되었습니다.');
</script>
<% } %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge; chrome=1">
    <title>MAETRESS</title>
    <meta name="description" content="3D 전략 슈팅 게임! 매트리스! 네오와 모피어스는 나오지 않는다!" />
    <link rel="shortcut icon" href="resources/img/titleLogo.png" />
    <link rel="stylesheet" href="resources/css/login.css" type="text/css" />
    <link rel="stylesheet" href="resources/css/default.css" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="resources/js/login.js" type="text/javascript"></script>
  </head>

  <body>
    <header>
      <div class="logo">
        <a href="/" class="home"><img src="resources/img/logo.png" height="150px"/></a>
      </div>
    </header>

    <div id="body-wrapper">
      <div id="body-content">
        <form action="/try-login" method="post" class="container">
          <input type="text" name="id" id="id" placeholder="아이디" />
          <input type="password" name="pw" id="pw" placeholder="비밀번호" />
          <div class="wrapper">
            <input type="checkbox" name="remember" id="remember" />
            <label for="remember">로그인 유지</label>
          </div>
          <c:if test="${not empty error}">
          <div class="wrapper" style="margin-bottom:-10px;">
            <span>${error}</span>
          </div>
          </c:if>
          <button type="submit" id="login">로그인</button><br><br>

          <button type="button" onclick="location.href='/find?F_State=idFind'" id="find">ID/PW 찾기</button>
          <button type="button" onclick="location.href='/join'" id="join">회원가입</button>
        </form>
      </div>

      <%@include file="include/footer.jsp"%>
    </div>
  </body>
</html>
