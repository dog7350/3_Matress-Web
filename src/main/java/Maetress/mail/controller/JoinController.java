package Maetress.mail.controller;

import Maetress.entity.*;
import Maetress.mail.*;
import Maetress.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class JoinController {

    @Autowired
    UserRepository userRepository;
    @Autowired
    UserTankRepository userTankRepository;
    @Autowired
    private JavaMailSender mailSender;

    @PostMapping("/try-join")
    public String tryJoin(HttpSession session, HttpServletResponse response, @RequestParam("id") String id,
                          @RequestParam("name") String name, @RequestParam("email") String email,
                          @RequestParam("code") String code, @RequestParam("pw") String pw,
                          RedirectAttributes redirectAttributes) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        if(!code.equals(session.getAttribute("verificationKey"))) {
            return "redirect:/";
        }
        User user = User.builder()
                .userId(id)
                .userPw(pw)
                .userName(name)
                .userEmail(email)
                .userMmr(1000)
                .userMoney(5000)
                .userCash(0)
                .userAdmin("x")
                .userConnect("x")
                .build();
        userRepository.save(user);
        int[] basicTanks = {6, 9};
        for(int i = 0; i < 2; i++) {
            UserTank userTank = UserTank.builder()
                    .userId(id)
                    .tankNo(basicTanks[i])
                    .build();
            userTankRepository.save(userTank);
        }

        return "redirect:/login";
    }

    @GetMapping("/check-id")
    @ResponseBody
    public String checkId(@RequestParam("id") String id) {
        User user = userRepository.findByUserId(id);
        if(user != null) {
            return "Existing ID";
        }
        return "Valid ID";
    }

    @GetMapping("/check-email")
    @ResponseBody
    public String checkEmail(@RequestParam("email") String email, HttpSession session) throws Exception {
        try {
            InternetAddress emailAddr = new InternetAddress(email);
            emailAddr.validate();
        } catch (AddressException ex) {
            return "Invalid Address";
        }
        User user = userRepository.findByUserEmail(email);
        if(user != null) {
            return "Existing Address";
        }
        return "Valid Address";
    }
    @GetMapping("/send-email")
    @ResponseBody
    public String sendEmail(@RequestParam("email") String email, HttpSession session) throws Exception {
        String key = new TempKey().getKey(8, false);
        MailHandler mailHandler = new MailHandler(mailSender);
        mailHandler.setSubject("[MAETRESS] 회원가입 인증코드");
        mailHandler.setText(new StringBuffer().append("<h1>[MAETRESS] 회원가입 인증코드</h1>")
                .append("<h2>" + key + "</h2>").toString());
        mailHandler.setFrom("maetress.login@gmail.com", "MAETRESS");
        mailHandler.setTo(email);
        mailHandler.send();
        session.setAttribute("verificationKey", key);
        return "Email Sent";
    }

    @GetMapping("/verify")
    @ResponseBody
    public String verify(@RequestParam("code") String code, HttpSession session) {
        if(code.equals(session.getAttribute("verificationKey"))) {
            return "Verified";
        }
        return "Not Verified";
    }

}
