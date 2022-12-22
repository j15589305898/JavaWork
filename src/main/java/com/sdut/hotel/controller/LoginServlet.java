package com.sdut.hotel.controller;

import com.sdut.hotel.pojo.User;
import com.sdut.hotel.service.IUserService;
import com.sdut.hotel.service.impl.UserServiceImpl;
import com.sdut.hotel.utils.JSONResult;
import com.sdut.hotel.utils.JSONUtil;
import org.springframework.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//Create by IntelliJ IDEA.
//Have a good day!
//User: jiruichang
//Date: 2022/12/22
//Time: 19:43
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private IUserService userService = new UserServiceImpl();
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        switch (method) {
            case "login":
                login(req, resp);
                break;
            case "logout":
                logout(req, resp);
                break;
        }
    }


    private void login(HttpServletRequest req, HttpServletResponse resp) {
        System.out.println("LoginServlet.login");
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        String code = req.getParameter("code");

        HttpSession session = req.getSession();
        String codeInSession = (String) session.getAttribute("codeInSession");
        if (StringUtils.isEmpty(code) || !codeInSession.equalsIgnoreCase(code)){
            JSONUtil.obj2Json(JSONResult.error("验证码为空或错误"),resp);
            return;
        }

        User user = userService.login(name,password);
        if(user != null){
            JSONUtil.obj2Json(JSONResult.ok("登录成功"),resp);
        }else {
            JSONUtil.obj2Json(JSONResult.error("用户名或密码错误"),resp);
        }
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) {
        System.out.println("LoginServlet.logout");
    }


}
