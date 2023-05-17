var validId = false;
var validName = false;
var validEmail = false;
var validCode = false;
var validPw = false;

$(document).ready(function () {
  $("#join").click(function () {
    var emailMsg = document.getElementById("emailmsg");
    var email = document.getElementById("email");
    checkId();
    checkName();
    if (validEmail == false || validCode == false) {
      emailMsg.innerText = emailMsg.textContent = "이메일 인증을 완료해주세요.";
    }
    checkPw(true);
    if (!(validId && validName && validEmail && validCode && validPw)) {
      return false;
    }
    email.disabled = false;
  });
});

function checkId() {
  var idMsg = document.getElementById("idmsg");
  idMsg.style.display = "block";
  if ($("#id").val().length == 0) {
    idMsg.innerText = idMsg.textContent = "아이디를 입력해주세요.";
    validId = false;
  } else {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function () {
      if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
        if (xmlHttp.responseText == "Existing ID") {
          idMsg.innerText = idMsg.textContent = "이미 사용 중인 아이디입니다.";
          validId = false;
        } else {
          idMsg.innerText = idMsg.textContent = "사용 가능한 아이디입니다.";
          validId = true;
        }
      }
    };
    xmlHttp.open("GET", "/check-id?id=" + $("#id").val(), true);
    xmlHttp.send(null);
  }
}

function checkName() {
  var nameMsg = document.getElementById("namemsg");
  if ($("#name").val().length == 0) {
    nameMsg.style.display = "block";
    nameMsg.innerText = nameMsg.textContent = "이름을 입력해주세요.";
    validName = false;
  } else {
    nameMsg.style.display = "none";
    validName = true;
  }
}

function checkEmail() {
  var emailMsg = document.getElementById("emailmsg");
  emailMsg.style.display = "block";
  if ($("#email").val().length == 0) {
    emailMsg.innerText = emailMsg.textContent = "이메일을 입력해주세요.";
    validEmail = false;
  } else {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function () {
      if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
        if (xmlHttp.responseText == "Invalid Address") {
          emailMsg.innerText = emailMsg.textContent = "유효하지 않은 이메일입니다.";
          validEmail = false;
        } else if (xmlHttp.responseText == "Existing Address") {
          emailMsg.innerText = emailMsg.textContent = "이미 사용 중인 이메일입니다.";
          validEmail = false;
        } else {
          emailMsg.innerText = emailMsg.textContent = "사용 가능한 이메일입니다.";
          validEmail = true;
        }
      }
    };
    xmlHttp.open("GET", "/check-email?email=" + $("#email").val(), true);
    xmlHttp.send(null);
  }
}

function sendEmail() {
  if (validEmail == false) {
    return false;
  }
  var send = document.getElementById("send");
  var email = document.getElementById("email");
  var code = document.getElementById("code-box");
  var emailMsg = document.getElementById("emailmsg");
  send.style.display = "none";
  email.disabled = true;
  email.style.backgroundColor = "#CCC";
  code.style.display = "block";
  var xmlHttp = new XMLHttpRequest();
  xmlHttp.open("GET", "/send-email?email=" + $("#email").val(), true);
  xmlHttp.send(null);
  emailMsg.innerText = emailMsg.textContent = "인증코드를 전송했습니다.";
}

function verifyCode() {
  var code = document.getElementById("code-box");
  var emailMsg = document.getElementById("emailmsg");
  var xmlHttp = new XMLHttpRequest();
  xmlHttp.onreadystatechange = function () {
    if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
      if (xmlHttp.responseText == "Verified") {
        code.style.display = "none";
        emailMsg.innerText = emailMsg.textContent = "이메일 인증을 완료했습니다.";
        validCode = true;
      } else if ($("#code").val().length == 0) {
        emailMsg.innerText = emailMsg.textContent = "인증코드를 입력해주세요.";
      } else {
        emailMsg.innerText = emailMsg.textContent = "인증코드가 일치하지 않습니다.";
      }
    }
  };
  xmlHttp.open("GET", "/verify?code=" + $("#code").val(), true);
  xmlHttp.send(null);
}

function checkPw(check) {
  var pwMsg = document.getElementById("pwmsg");
  if ($("#pw").val().length == 0) {
    pwMsg.style.display = "block";
    pwMsg.innerText = pwMsg.textContent = "비밀번호를 입력해주세요.";
    validPw = false;
  } else if ($("#pwcheck").val().length == 0) {
    if (check) {
      pwMsg.style.display = "block";
      pwMsg.innerText = pwMsg.textContent = "비밀번호를 확인해주세요.";
      validPw = false;
    }
  } else if ($("#pw").val() != $("#pwcheck").val()) {
    pwMsg.style.display = "block";
    pwMsg.innerText = pwMsg.textContent = "비밀번호가 일치하지 않습니다.";
    validPw = false;
  } else {
    pwMsg.style.display = "none";
    validPw = true;
  }
}
