package Maetress.mail.controller;

import Maetress.board.*;
import Maetress.entity.*;
import Maetress.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.List;

@Controller
public class BoardController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    BoardRepository boardRepository;

    @Autowired
    CommentRepository commentRepository;

    @GetMapping("/openboard")
    public String boardlist(SearchVO search, HttpServletRequest request) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        int listSize = 0;
        int noticeSize = 0;
        List<Board> normalBoards = null;
        List<Board> noticeBoards = null;

        String keyword = "";
        String condition = "";
        if (request.getParameter("keyword") != null) keyword = request.getParameter("keyword");
        if (request.getParameter("condition") != null) condition = request.getParameter("condition");

        if (!keyword.equals("") && condition.equals("제목")) {
            normalBoards = boardRepository.findBoardTitle(keyword, search.getPage(), search.getCountPerPage());
            listSize = boardRepository.findBoardTitleCount(keyword);
        }
        else if (!keyword.equals("") && condition.equals("작성자")) {
            normalBoards = boardRepository.findBoardWriter(keyword, search.getPage(), search.getCountPerPage());
            listSize = boardRepository.findBoardWriterCount(keyword);
        }
        else if (!keyword.equals("") && condition.equals("제목+내용")) {
            normalBoards = boardRepository.findBoardTitleOrBoardContent(keyword, keyword, search.getPage(), search.getCountPerPage());
            listSize = boardRepository.findBoardTitleOrBoardContentCount(keyword, keyword);
        }
        else {
            normalBoards = boardRepository.findBoardList(search.getPage(), search.getCountPerPage());
            listSize = boardRepository.findBoardListCount();
        }

        noticeBoards = boardRepository.findNoticeBoard();
        noticeSize = boardRepository.findNoticeBoardCount();

        request.setAttribute("normalBoards", normalBoards);
        request.setAttribute("noticeBoards", noticeBoards);

        PageCreator pc = new PageCreator();
        pc.setPaging(search);
        pc.setArticleTotalCount(listSize + noticeSize);
        request.setAttribute("pageCount", pc);

        request.setAttribute("keyword", keyword);
        request.setAttribute("condition", condition);

        return "openboard";
    }

    @GetMapping("/contentboard")
    public String contentboard(HttpServletRequest request, HttpServletResponse response) {
        String R_State = null;
        if (request.getParameter("R_State") != null) {
            R_State = request.getParameter("R_State");
            int rep_b_no = Integer.parseInt(request.getParameter("b_no"));
            int rep_c_no = Integer.parseInt(request.getParameter("c_no"));

            Comment modReply = commentRepository.findReplyBoardNo(rep_c_no, rep_b_no);
            request.setAttribute("modReply", modReply);
            request.setAttribute("c_no", rep_c_no);
        }
        request.setAttribute("R_State", R_State);

        List<Comment> reply = null;
        reply = commentRepository.findByBoardNo(Integer.parseInt(request.getParameter("b_no")));
        request.setAttribute("reply", reply);

        Board board = boardRepository.findByBoardNo(Integer.parseInt(request.getParameter("b_no")));
        request.setAttribute("board", board);

        String cook = request.getHeader("Cookie");
        Boolean ckFlag = false;
        if(cook != null) {
            Cookie[] cookies = request.getCookies();
            for(Cookie c : cookies) {
                if(c.getName().equals(request.getParameter("b_no"))) {
                    ckFlag = true;
                }
            }

            if (ckFlag == false) {
                Cookie cookie = new Cookie(request.getParameter("b_no"), request.getParameter("b_no"));
                cookie.setMaxAge(60 * 60);
                response.addCookie(cookie);
                boardRepository.inquiryboard(board.getBoardTime(), board.getBoardInquiry() + 1, board.getBoardNo());
            }
        }

        return "contentboard";
    }

    // 목록
    @GetMapping("/insertopenboard")
    public String insertopenboard() { return "insertboard"; }

    @PostMapping("/saveboard")
    public String saveboard(HttpServletRequest request) {
        String title = request.getParameter("BoardTitle");
        String id = request.getParameter("BoardWriter");
        String content = request.getParameter("BoardContent");
        String not = request.getParameter("B_Notice");

        if (not != null && not.equals("공지")) not = "yes";
        else not = "no";

        boardRepository.insertBoard(id, title, content, not);

        return "redirect:/openboard";
    }


    @GetMapping("/modifyopenboard")
    public String modifyopenboard(HttpServletRequest request) {
        Board board = boardRepository.findByBoardNo(Integer.parseInt(request.getParameter("b_no")));
        request.setAttribute("board", board);

        return "modifyboard";
    }

    @PostMapping("/modifyboard")
    public String modifyboard(HttpServletRequest request) {
        int b_no = Integer.parseInt(request.getParameter("b_no"));
        String title = request.getParameter("BoardTitle");
        String content = request.getParameter("BoardContent");
        Timestamp time = Timestamp.valueOf(request.getParameter("BoardTime"));
        String not = request.getParameter("B_Notice");

        if (not != null && not.equals("공지")) not = "yes";
        else not = "no";

        boardRepository.updateBoard(title, content, time, not, b_no);

        return "redirect:/contentboard?b_no=" + b_no;
    }


    @GetMapping("/deleteboard")
    public String deleteboard(HttpServletRequest request) {
        int b_no = Integer.parseInt(request.getParameter("b_no"));
        boardRepository.deleteBoard(b_no);

        return "redirect:/openboard";
    }

    @GetMapping("/reportboard")
    public String reportboard(HttpServletRequest request, HttpServletResponse response) {
        int b_no = Integer.parseInt(request.getParameter("b_no"));
        int report = Integer.parseInt(request.getParameter("rep"));
        Timestamp time = Timestamp.valueOf(request.getParameter("ti"));

        String cook = request.getHeader("Cookie");
        Boolean ckFlag = false;
        if(cook != null) {
            Cookie[] cookies = request.getCookies();
            for(Cookie c : cookies) {
                if(c.getName().equals("repBoard_" + request.getParameter("b_no"))) {
                    ckFlag = true;
                }
            }

            if (ckFlag == false) {
                Cookie cookie = new Cookie("repBoard_" + request.getParameter("b_no"), "repBoard_" + request.getParameter("b_no"));
                cookie.setMaxAge(60 * 60 * 24);
                response.addCookie(cookie);
                boardRepository.reportBoard(time, report + 1, b_no);
            }
        }

        return "redirect:/contentboard?b_no=" + b_no;
    }
    // Board CRUD

    @PostMapping("/replyinsert")
    public String replyinsert(HttpServletRequest request) {
        int b_no = Integer.parseInt(request.getParameter("b_no"));
        String id = request.getParameter("id");
        String content = request.getParameter("ReplyContent");

        commentRepository.replyinsert(b_no, id, content);

        return "redirect:/contentboard?b_no=" + b_no;
    }

    @GetMapping("/replymodifymove")
    public String replymodifymove(HttpServletRequest request) {
        int b_no = Integer.parseInt(request.getParameter("b_no"));
        String R_State = request.getParameter("R_State");
        int c_no = Integer.parseInt(request.getParameter("c_no"));

        return "redirect:/contentboard?b_no=" + b_no + "&R_State=" + R_State + "&c_no=" + c_no;
    }

    @PostMapping("/replymodify")
    public String replymodify(HttpServletRequest request) {
        int b_no = Integer.parseInt(request.getParameter("b_no"));
        int c_no = Integer.parseInt(request.getParameter("c_no"));
        Timestamp time = Timestamp.valueOf(request.getParameter("ti"));
        String content = request.getParameter("ReplyContent");

        commentRepository.replyupdate(content, time, c_no, b_no);

        return "redirect:/contentboard?b_no=" + b_no;
    }

    @GetMapping("/deletereply")
    public String deletereply(HttpServletRequest request) {
        int b_no = Integer.parseInt(request.getParameter("b_no"));
        int c_no = Integer.parseInt(request.getParameter("c_no"));

        commentRepository.replydelete(c_no, b_no);

        return "redirect:/contentboard?b_no=" + b_no;
    }

    @GetMapping("/reportreply")
    public String reportreply(HttpServletRequest request, HttpServletResponse response) {
        int b_no = Integer.parseInt(request.getParameter("b_no"));
        int c_no = Integer.parseInt(request.getParameter("c_no"));
        Timestamp time = Timestamp.valueOf(request.getParameter("ti"));
        int rp = Integer.parseInt(request.getParameter("rp"));

        String cook = request.getHeader("Cookie");
        Boolean ckFlag = false;
        if(cook != null) {
            Cookie[] cookies = request.getCookies();
            for(Cookie c : cookies) {
                if(c.getName().equals("repReply_" + request.getParameter("b_no") + "C" + request.getParameter("c_no"))) {
                    ckFlag = true;
                }
            }

            if (ckFlag == false) {
                Cookie cookie = new Cookie("repReply_" + request.getParameter("b_no") + "C" + request.getParameter("c_no"), "repReply_" + request.getParameter("b_no") + "C" + request.getParameter("c_no"));
                cookie.setMaxAge(60 * 60 * 24);
                response.addCookie(cookie);
                commentRepository.replyreport(time, rp + 1, c_no, b_no);
            }
        }

        return "redirect:/contentboard?b_no=" + b_no;
    }
}
