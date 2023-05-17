package Maetress.mail.controller;

import Maetress.entity.*;
import Maetress.mail.*;
import Maetress.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class FindController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    private JavaMailSender mailSender;

    @PostMapping("/find-id")
    public String findId(@RequestParam("name") String name, @RequestParam("email") String email,
                         RedirectAttributes redirectAttributes) {
        User user = userRepository.findByUserEmail(email);
        String message;
        if(user != null && user.getUserName().equals(name)) {
            message = "아이디: " + user.getUserId();
        }
        else {
            message = "정보가 일치하지 않습니다.";
        }
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/find?F_State=idResult";
    }

    @PostMapping("/find-pw")
    public String findPw(@RequestParam("id") String id, @RequestParam("email") String email,
                         RedirectAttributes redirectAttributes, HttpSession session,
                         HttpServletRequest request) throws Exception {
        User user = userRepository.findByUserId(id);
        String message;
        String url = request.getRequestURL().substring(0, request.getRequestURL().length() - request.getRequestURI().length());
        if(user != null && user.getUserEmail().equals(email)) {
            String key = new TempKey().getKey(10, false);
            MailHandler mailHandler = new MailHandler(mailSender);
            mailHandler.setSubject("[MAETRESS] 비밀번호 변경 링크");
            mailHandler.setText(new StringBuffer().append("<h1>[MAETRESS] 비밀번호 변경 링크</h1>")
                    .append("<a href='" + url + "/change-pw?token=" + key + "'>비밀번호 변경 링크</a>").toString());
            mailHandler.setFrom("maetress.login@gmail.com", "MAETRESS");
            mailHandler.setTo(email);
            mailHandler.send();
            String[] tokenList = {id, key};
            session.setAttribute("pwToken", tokenList);
            message = "비밀번호 변경 링크를 이메일로 전송했습니다.";
        }
        else {
            message = "정보가 일치하지 않습니다.";
        }
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/find?F_State=pwResult";
    }

    @PostMapping("/postChangePw")
    public String postChangePw(HttpServletRequest request) {
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        userRepository.updateUser(pw, id);

        request.setAttribute("msg", "msg");

        return "redirect:/login";
    }
}
