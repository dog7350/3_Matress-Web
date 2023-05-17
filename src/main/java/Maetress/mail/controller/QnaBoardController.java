package Maetress.mail.controller;

import Maetress.board.*;
import Maetress.entity.*;
import Maetress.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class QnaBoardController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    QnaBoardRepository qnaBoardRepository;

    @GetMapping("/qna")
    public String qna(SearchVO search, HttpServletRequest request) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        int listSize = 0;
        List<QnaBoard> qnaList = null;

        String keyword = "";
        String condition = "";
        if (request.getParameter("keyword") != null) keyword = request.getParameter("keyword");
        if (request.getParameter("condition") != null) condition = request.getParameter("condition");

        if (!keyword.equals("") && condition.equals("제목")) {
            qnaList = qnaBoardRepository.qnaTitle(keyword, search.getPage(), search.getCountPerPage());
            listSize = qnaBoardRepository.qnaTitleCount(keyword);
        }
        else if (!keyword.equals("") && condition.equals("작성자")) {
            qnaList = qnaBoardRepository.qnaWriter(keyword, search.getPage(), search.getCountPerPage());
            listSize = qnaBoardRepository.qnaWriterCount(keyword);
        }
        else {
            qnaList = qnaBoardRepository.qnaList(search.getPage(), search.getCountPerPage());
            listSize = qnaBoardRepository.qnaListCount();
        }

        request.setAttribute("qnaList", qnaList);

        PageCreator pc = new PageCreator();
        pc.setPaging(search);
        pc.setArticleTotalCount(listSize);
        request.setAttribute("pageCount", pc);

        request.setAttribute("keyword", keyword);
        request.setAttribute("condition", condition);

        return "qnaboard";
    }

    @GetMapping("/insertqna")
    public String insertqna(HttpServletRequest request) {
        String Q_State = request.getParameter("Q_State");
        request.setAttribute("Q_State", Q_State);

        return "qnacontent";
    }

    @PostMapping("/saveqna")
    public String saveqna(HttpServletRequest request) {
        String writer = request.getParameter("id");
        String title = request.getParameter("qnaTitle");
        String content = request.getParameter("qnaContent");

        String secret = "false";

        if(request.getParameter("qnaSecret") != null) {
            secret = request.getParameter("qnaSecret");
            if (secret.equals("Secret")) secret = "true";
            else secret = "false";
        }

        qnaBoardRepository.insertqna(title, writer, content, secret);

        return "redirect:/qna";
    }

    @GetMapping("/qnacontent")
    public String qnacontent(HttpServletRequest request) {
        String Q_State = request.getParameter("Q_State");
        request.setAttribute("Q_State", Q_State);
        int q_no = Integer.parseInt(request.getParameter("q_no"));

        QnaBoard qna = qnaBoardRepository.findOneQna(q_no);
        List<QnaBoard> qnaList = qnaBoardRepository.findQnaAnswer(q_no);

        request.setAttribute("qna", qna);
        request.setAttribute("qnaList", qnaList);

        return "qnacontent";
    }

    @PostMapping("/commentqna")
    public String commentqna(HttpServletRequest request) {
        int q_no = Integer.parseInt(request.getParameter("q_no"));
        String commenter = request.getParameter("id");
        String content = request.getParameter("qnaContent");
        qnaBoardRepository.answerqna(q_no, commenter, content);

        return "redirect:/qnacontent?q_no=" + q_no + "&Q_State=comment";
    }

    @GetMapping("/deleteqna")
    public String deleteqna(HttpServletRequest request) {
        int q_no = Integer.parseInt(request.getParameter("q_no"));
        qnaBoardRepository.deleteqna(q_no);

        return "redirect:/qna";
    }
}
