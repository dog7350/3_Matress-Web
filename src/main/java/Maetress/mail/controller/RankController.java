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
public class RankController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    UserRankRepository userRankRepository;

    @GetMapping("/rankboard")
    public String rankboard(SearchVO search, HttpServletRequest request) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        String keyword = "";
        String condition = "";
        if(request.getParameter("keyword") != null) keyword = request.getParameter("keyword");
        if (request.getParameter("condition") != null) condition = request.getParameter("condition");

        List<UserRank> rankList = null;
        int listSize = 0;

        if(!keyword.equals("") && condition.equals("아이디")) {
            rankList = userRankRepository.findUserRankId(keyword, search.getPage(), search.getCountPerPage());
            listSize = 1;
        }
        else if (!keyword.equals("") && condition.equals("순위")){
            rankList = userRankRepository.findUserRank(Integer.parseInt(keyword), search.getPage(), search.getCountPerPage());
            listSize = 1;
        }
        else {
            rankList = userRankRepository.findUserList(search.getPage(), search.getCountPerPage());
            listSize = userRankRepository.findUserListCount();
        }

        request.setAttribute("rankList", rankList);

        PageCreator pc = new PageCreator();
        pc.setPaging(search);
        pc.setArticleTotalCount(listSize);
        request.setAttribute("pageCount", pc);

        request.setAttribute("keyword", keyword);
        request.setAttribute("condition", condition);

        return "rankboard";
    }
}
