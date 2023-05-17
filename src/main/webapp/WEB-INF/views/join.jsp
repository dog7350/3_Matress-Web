<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <a href="/" class="home">MAETRESS</a>
      </div>
    </header>

    <div id="body-wrapper">
      <div id="body-content">
        <form action="/try-join" method="post" class="container">
          <span class="label">아이디</span>
          <input type="text" name="id" id="id" placeholder="아이디" onblur="checkId()" />
          <span id="idmsg" class="msg"></span>
          <span class="label">이름</span>
          <input type="text" name="name" id="name" placeholder="이름" onblur="checkName()" />
          <span id="namemsg" class="msg"></span>
          <span class="label">이메일</span>
          <div class="centered">
            <input type="text" name="email" id="email" placeholder="이메일" onblur="checkEmail()" />
          </div>
          <div class="right">
            <button type="button" onclick="sendEmail()" class="code-button" id="send">인증코드 전송</button>
          </div>
          <div id="code-box">
            <div class="centered">
              <input type="text" name="code" id="code" placeholder="인증코드" />
            </div>
            <div class="right">
              <button type="button" onclick="verifyCode()" class="code-button" id="verify">인증코드 확인</button>
            </div>
          </div>
          <span id="emailmsg" class="msg"></span>
          <span class="label">비밀번호</span>
          <input type="password" name="pw" id="pw" placeholder="비밀번호" onblur="checkPw(false)" />
          <input type="password" name="pwcheck" id="pwcheck" placeholder="비밀번호 확인" onblur="checkPw(true)" />
          <span id="pwmsg" class="msg"></span>

          <button type="submit" id="join">회원가입</button>
        </form>
      </div>

      <%@include file="include/footer.jsp"%>
    </div>
  </body>
</html>
