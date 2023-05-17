package Maetress.mail.controller;

import Maetress.entity.*;
import Maetress.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class GameInfoController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    EnbRepository enbRepository;

    @Autowired
    TankRepository tankRepository;

    @Autowired
    ItemRepository itemRepository;

    @GetMapping("/playinfo")
    public String playinfo() {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        return "playinfo";
    }

    @GetMapping("/tankinfo")
    public String tankinfo(HttpServletRequest request) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        return "tankinfo";
    }

    @GetMapping("/gameinfo")
    public String gameinfo(HttpServletRequest request) {
        int tno = Integer.parseInt(request.getParameter("tno"));

        String atk = enbRepository.findEnbValue("stat_max_atk");
        request.setAttribute("atk", atk);
        String def = enbRepository.findEnbValue("stat_max_def");
        request.setAttribute("def", def);
        String speed = enbRepository.findEnbValue("stat_max_speed");
        request.setAttribute("speed", speed);

        Tank tank = tankRepository.findOneTank(tno);
        request.setAttribute("tank", tank);

        return "gameinfo";
    }

    @GetMapping("/iteminfo")
    public String iteminfo(HttpServletRequest request) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();
        List<Item> itemList = itemRepository.allItem();
        request.setAttribute("itemList", itemList);

        return "iteminfo";
    }
}
