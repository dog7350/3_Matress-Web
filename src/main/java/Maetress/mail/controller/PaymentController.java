package Maetress.mail.controller;

import Maetress.entity.User;
import Maetress.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class PaymentController {

    @Autowired
    UserRepository userRepository;

    @GetMapping("/payment")
    public String payment(HttpSession session) {
        if(session.getAttribute("userInfo") == null) {
            return "redirect:/login";
        }
        return "payment";
    }

    @GetMapping("/payment/complete")
    public @ResponseBody void charge(int amount, HttpSession session) {
        String id = ((User) session.getAttribute("userInfo")).getUserId();
        User user = userRepository.findByUserId(id);
        user.setUserCash(user.getUserCash() + amount);
        userRepository.save(user);

        session.removeAttribute("userInfo");
        user = userRepository.findByUserId(id);
        session.setAttribute("userInfo", user);
    }

}
