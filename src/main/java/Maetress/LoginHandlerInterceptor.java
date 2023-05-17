package Maetress;

import Maetress.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginHandlerInterceptor implements HandlerInterceptor {

    @Autowired
    UserRepository userRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        HttpSession session = request.getSession();
        if (session.getAttribute("userInfo") == null) {
            Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
            if(loginCookie != null) {
                session.setAttribute("userInfo", userRepository.findByUserId(loginCookie.getValue()));
            }
        }
        return true;
    }
}
