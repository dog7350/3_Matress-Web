package Maetress.mail.controller;

import Maetress.board.*;
import Maetress.entity.*;
import Maetress.repository.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class AdminController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    BoardRepository boardRepository;

    @Autowired
    CommentRepository commentRepository;

    // return "redirect:/";
    @GetMapping("/adminpage")
    public String adminpage(SearchVO search, HttpServletRequest request) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        int listSize = 0;
        String A_State = "";
        List<User> users = null;
        List<Board> boards = null;
        List<Comment> replys = null;
        String keyword = "";
        String condition = "";
        if (request.getParameter("keyword") != null) keyword = request.getParameter("keyword");
        if (request.getParameter("condition") != null) condition = request.getParameter("condition");

        if (condition.equals("회원")) {
            users = userRepository.adminUserId(keyword, search.getPage(), search.getCountPerPage());
            listSize = userRepository.adminUserIdCount(keyword);
            request.setAttribute("users", users);
            A_State = "user";
        }
        else if (condition.equals("게시글")) {
            boards = boardRepository.adminBoardId(keyword, search.getPage(), search.getCountPerPage());
            listSize = boardRepository.adminBoardIdCount(keyword);
            request.setAttribute("boards", boards);
            A_State = "board";
        }
        else if (condition.equals("댓글")) {
            replys = commentRepository.adminReplyId(keyword, search.getPage(), search.getCountPerPage());
            listSize = commentRepository.adminReplyIdCount(keyword);
            request.setAttribute("replys", replys);
            A_State = "reply";
        }
        else {
            users = userRepository.adminAllUser(search.getPage(), search.getCountPerPage());
            listSize = userRepository.adminAllUserCount();
            request.setAttribute("users", users);
            A_State = "user";
        }

        PageCreator pc = new PageCreator();
        pc.setPaging(search);
        pc.setArticleTotalCount(listSize);
        request.setAttribute("pageCount", pc);

        request.setAttribute("A_State", A_State);
        request.setAttribute("keyword", keyword);
        request.setAttribute("condition", condition);

        return "adminpage";
    }

    @GetMapping("/adminuserdelete")
    public String adminuserdelete(HttpServletRequest request) {
        String id = request.getParameter("id");
        userRepository.deleteUser(id);

        return "redirect:/adminpage?A_State=user";
    }

    @GetMapping("/adminboarddelete")
    public String adminboarddelete(HttpServletRequest request) {
        int b_no = Integer.parseInt(request.getParameter("b_no"));
        boardRepository.deleteBoard(b_no);

        return "redirect:/adminpage?A_State=user";
    }

    @GetMapping("/adminreplydelete")
    public String adminreplydelete(HttpServletRequest request) {
        int b_no = Integer.parseInt(request.getParameter("b_no"));
        int c_no = Integer.parseInt(request.getParameter("c_no"));
        commentRepository.replydelete(c_no, b_no);

        return "redirect:/adminpage?A_State=user";
    }
}
