package Maetress.mail.controller;

import Maetress.entity.*;
import Maetress.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    UserRepository userRepository;

    @PostMapping("/try-login")
    public String tryLogin(HttpSession session, HttpServletResponse response, @RequestParam("id") String id,
                           @RequestParam("pw") String pw, @RequestParam(value = "remember", defaultValue="false") boolean checked,
                           RedirectAttributes redirectAttributes) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        User user = userRepository.findByUserId(id);
        if(user == null || !user.getUserPw().equals(pw)) {
            redirectAttributes.addFlashAttribute("error", "로그인 실패");
            return "redirect:/login";
        }
        session.setAttribute("userInfo", user);
        if(checked) {
            Cookie loginCookie = new Cookie("loginCookie", user.getUserId());
            loginCookie.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(loginCookie);
        }
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        session.invalidate();
        Cookie loginCookie = new Cookie("loginCookie", null);
        loginCookie.setMaxAge(0);
        response.addCookie(loginCookie);
        return "redirect:/";
    }

}
