package com.study.rbac.controller;

import com.study.rbac.pojo.AjaxResult;
import com.study.rbac.pojo.Member;
import com.study.rbac.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 控制页面跳转的Controller
 * @author 左想
 */
@Controller
public class DispatcherController {

    @Autowired
    private ManagerService managerService;

    /**
     * 去登陆页面
     * @return
     */
    @RequestMapping("/login")
    public String login(){
        return "login";
    }


    /**
     * 登陆查询
     * @param member
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping("/doAjaxLogin")
    public Object doAjaxLogin(Member member, HttpSession session){
        AjaxResult result = new AjaxResult();
        Member mem = managerService.query4Login(member);
        if(mem != null){
            session.setAttribute("loginUser",mem.getUsername());
            result.setSuccess(true);
        }else{
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 去注册页面
     * @return
     */
    @RequestMapping("/register")
    public String toRegpage(){
        return "register";
    }

    /**
     * 注册功能
     * @return
     */
    @ResponseBody
    @RequestMapping("/member")
    public Object doRegister(Member member){
        AjaxResult result = new AjaxResult();
        List<Member> members = managerService.queryByUsernameAndEmail(member.getUsername(), member.getPassword());
        if(!members.isEmpty()){
            result.setSuccess(false);
        }else{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            member.setCreatetime(sdf.format(new Date()));
            member.setUpdatetime(sdf.format(new Date()));
            managerService.insert4Register(member);
            result.setSuccess(true);
        }
        return result;
    }

    /**
     * 去main页面
     * @return
     */
    @RequestMapping("/main")
    public String main(){
        return "main";
    }

    /**
     * 登出功能
     * @param session
     * @return
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        //session.removeAttribute("loginUser");
        session.invalidate();
        return "redirect:login";
    }
}
