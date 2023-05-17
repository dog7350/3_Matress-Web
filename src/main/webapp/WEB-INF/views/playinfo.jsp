<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<% request.getParameter("UTF-8"); %>

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
        <link rel="stylesheet" href="resources/css/default.css" type="text/css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="resources/js/common.js" type="text/javascript"></script>
    </head>

    <body>
        <%@include file="include/header.jsp"%>

        <div id="body-wrapper">
            <div id="body-content">
                <section>
                    <div id="OpenBoard_Container">
                        <div class="OpenBoard_Content">
                            <h1 style="margin-top:15px;">조작 방법</h1>
                            <div class="OpenBoard_Board" style="width:1300px;">
                                <table class="OpenBoard_Table" border="2" style="width:1300px; font-size:20pt;">
                                    <thead bgcolor="#d5d5d5">
                                        <th width="300">목적</th>
                                        <th width="300">조작법</th>
                                        <th>설명</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>탱크 이동</td>
                                            <td>방향키(↑, ←, ↓, →)</td>
                                            <td>이동 게이지를 소모하여 이동</td>
                                        </tr>
                                        <tr>
                                            <td>공격</td>
                                            <td>Space Bar</td>
                                            <td>공격 횟수를 1 소모하여 게이지를 채워 공격</td>
                                        </tr>
                                        <tr>
                                            <td>포탑 조정</td>
                                            <td>W, A, S, D</td>
                                            <td>포탑 회전 및 포탑 각도 조절</td>
                                        </tr>
                                        <tr>
                                            <td>1인칭 카메라 조절</td>
                                            <td>Z, X, C, V</td>
                                            <td>1인칭 카메라 거리 및 각도 조절</td>
                                        </tr>
                                        <tr>
                                            <td>1인칭 카메라 리셋</td>
                                            <td>B</td>
                                            <td>1인칭 카메라를 기본값으로 초기화</td>
                                        </tr>
                                        <tr>
                                            <td>카메라 변경</td>
                                            <td>LeftControl</td>
                                            <td>1인칭 카메라와 탑뷰 카메라 전환</td>
                                        </tr>
                                        <tr>
                                            <td>탑뷰 카메라 이동</td>
                                            <td>J, K, L, I</td>
                                            <td>탑뷰 카메라 이동</td>
                                        </tr>
                                        <tr>
                                            <td>탑뷰 카메라 줌</td>
                                            <td>U, O</td>
                                            <td>탑뷰 카메라 확대 · 축소</td>
                                        </tr>
                                        <tr>
                                            <td>탑뷰 카메라 리셋</td>
                                            <td>P</td>
                                            <td>탑뷰 카메라를 기본값으로 초기화</td>
                                        </tr>
                                        <tr>
                                            <td>턴 넘김</td>
                                            <td>TAB</td>
                                            <td>자신의 턴을 넘김</td>
                                        </tr>
                                        <tr>
                                            <td>아이템 사용</td>
                                            <td>1, 2</td>
                                            <td>아이템 슬롯에 있는 아이템 사용</td>
                                        </tr>
                                        <tr>
                                            <td>채팅</td>
                                            <td>Enter</td>
                                            <td>채팅 활성화 및 채팅 전송</td>
                                        </tr>
                                        <tr>
                                            <td>방 나가기</td>
                                            <td>ESC</td>
                                            <td>방 나가기</td>
                                        </tr>
                                    </tbody>
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
