<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Maetress.entity.User" %>

<%
    request.getParameter("UTF-8");
    User user = (User) session.getAttribute("userInfo");
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge; chrome=1" />
    <title>MAETRESS</title>
    <meta name="description" content="3D 전략 슈팅 게임! 매트리스! 네오와 모피어스는 나오지 않는다!" />
    <link rel="shortcut icon" href="resources/img/titleLogo.png" />
    <link rel="stylesheet" href="resources/css/common.css" type="text/css" />
    <link rel="stylesheet" href="resources/css/default.css" type="text/css" />
    <link rel="stylesheet" href="resources/css/payment.css" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="resources/js/common.js" type="text/javascript"></script>
    <script src="resources/js/payment.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
  </head>

  <body>
    <%@include file="include/header.jsp"%>

    <div id="body-wrapper">
      <div id="body-content">
        <div id="payment-container">
            <p style="font-weight:bold">현재 캐시 : <%=user.getUserCash()%><br><br>충전할 금액</p>
            <div>
                <label class="box-radio-input"><input type="radio" name="amount" value="1000" class="amount" checked/><span>1,000캐시<br>1,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="amount" value="2000" class="amount"/><span>2,000캐시<br>2,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="amount" value="5000" class="amount"/><span>5,000캐시<br>5,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="amount" value="10000" class="amount"/><span>10,000캐시<br>10,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="amount" value="20000" class="amount"/><span>20,000캐시<br>20,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="amount" value="50000" class="amount"/><span>50,000캐시<br>50,000원</span></label>
            </div>
            <p style="font-weight:bold; margin-top:30px;">결제 방법</p>
            <div>
                <label class="box-radio-input"><input type="radio" name="payment-method" value=0 class="method" checked/><span>카카오페이</span></label>
                <label class="box-radio-input"><input type="radio" name="payment-method" value=1 class="method"/><span>페이코</span></label>
                <label class="box-radio-input"><input type="radio" name="payment-method" value=2 class="method"/><span>카드결제</span></label>
            </div>
        </div>
        <div class="center">
            <button type="button" class="btn" onclick="payment()">충 전 하 기</button>
        </div>
      </div>

      <%@include file="include/footer.jsp"%>
    </div>
  </body>
</html>
