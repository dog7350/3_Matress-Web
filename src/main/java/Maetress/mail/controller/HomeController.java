package Maetress.mail.controller;

import Maetress.entity.*;
import Maetress.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class HomeController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    BoardRepository boardRepository;

    @Autowired
    UserRankRepository userRankRepository;

    @GetMapping("/")
    public String home(HttpServletRequest request, HttpSession session) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
        if(loginCookie != null) {
            session.setAttribute("userInfo", userRepository.findByUserId(loginCookie.getValue()));
        }

        List<Board> normalBoards = boardRepository.findMainBoardList();
        List<Board> noticeBoards = boardRepository.findNoticeBoard();
        List<UserRank> rankList = userRankRepository.findMainUserList();

        request.setAttribute("normalBoards", normalBoards);
        request.setAttribute("noticeBoards", noticeBoards);
        request.setAttribute("rankList", rankList);

        return "home";
    }

    @GetMapping("/login")
    public String login(HttpSession session) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();
        if(session.getAttribute("userInfo") != null) {
            return "redirect:/";
        }
        return "login";
    }

    @GetMapping("/join")
    public String join() {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        return "join";
    }

    @GetMapping("/find")
    public String find(HttpServletRequest request) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        String F_State = request.getParameter("F_State");
        request.setAttribute("F_State", F_State);

        return "find";
    }

    @GetMapping("/userpay")
    public String userpay(HttpServletRequest request, HttpSession session) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        String id = request.getParameter("id");
        String pw = request.getParameter("pw");

        User user = userRepository.findByUserId(id);
        if(user == null || !user.getUserPw().equals(pw)) { return "redirect:/login"; }
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("userInfo", user);

        return "redirect:/payment";
    }

    @GetMapping("/mypage")
    public String mypage(HttpSession session) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        if(session.getAttribute("userInfo") == null) return "login";

        return "mypage";
    }

    @GetMapping("/mypagedelete")
    public String mypagedelete(HttpServletRequest request, HttpSession session) {
        String id = request.getParameter("id");
        userRepository.deleteUser(id);
        session.removeAttribute("userInfo");

        return "redirect:/";
    }

    @GetMapping("/change-pw")
    public String changePw() {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        return "changePw";
    }
}
