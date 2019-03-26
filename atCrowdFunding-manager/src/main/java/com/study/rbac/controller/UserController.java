package com.study.rbac.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.study.rbac.pojo.AjaxResult;
import com.study.rbac.pojo.Role;
import com.study.rbac.pojo.User;
import com.study.rbac.service.RoleService;
import com.study.rbac.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 用户维护Controller
 * @Author zx
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    /**
     * 只加载用户信息页面，异步加载用户信息数据
     * @return
     */
    @RequestMapping("/users")
    public String index(){
        return "../user/index";
    }

    /**
     * Ajax异步查询用户信息
     * @param pageNum
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping("/users/pageQuery")
    public Object pageQuery(String queryText,Integer pageNum,Integer pageSize){
        AjaxResult result = new AjaxResult();
        try{
            PageHelper.startPage(pageNum,pageSize);
            List<User> users = userService.queryAll(queryText);
            PageInfo<User> pageInfo = new PageInfo<User>(users);
            result.setSuccess(true);
            result.setData(pageInfo);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 去添加用户信息界面
     * @return
     */
    @RequestMapping("/add")
    public String addUser(){
        return "../user/add";
    }

    /**
     * 添加用户信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user",method = RequestMethod.POST)
    public Object add(User user){
        AjaxResult result = new AjaxResult();
        //后端校验信息
        if (user.getUsername() == null || user.getUsername().equals("")
                || user.getName() == null || user.getName().equals("")
                || user.getEmail() == null || user.getEmail().equals("")) {
            result.setSuccess(false);
        }else{
            user.setId(null);
            //设置默认密码
            user.setPassword("123456");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            user.setCreatetime(sdf.format(new Date()));
            user.setUpdatetime(sdf.format(new Date()));
            userService.addUser(user);
            result.setSuccess(true);
        }
        return result;
    }

    /**
     * 去编辑页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/edit")
    public String toeditpage(@RequestParam("id")Integer id,Model model){
        //根据用户id查询用户信息回显到页面上
        User user = userService.getUserById(id);
        model.addAttribute("user",user);
        return "../user/edit";
    }

    /**
     * 修改user信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user",method = RequestMethod.PUT)
    public Object updateUser(User user){
        AjaxResult result = new AjaxResult();
        try{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            user.setUpdatetime(sdf.format(new Date()));
            userService.updateUser(user);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 根据id删除用户信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user",method = RequestMethod.DELETE)
    public Object deleteUser(Integer id){
        AjaxResult result = new AjaxResult();
        try{
            userService.deleteUser(id);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 批量删除用户信息
     * @param userid
     * @return
     */
    @ResponseBody
    @RequestMapping("user/deletes")
    public Object deleteUsers(@RequestParam("userid") Integer[] userid) {
        AjaxResult result = new AjaxResult();
        try {
            userService.deleteUsers(userid);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 去分配角色页面
     * @return
     */
    @RequestMapping("/assign")
    public String toAssignPage(@RequestParam("id") Integer id,Model model){
        User user = userService.getUserById(id);
        List<Role> roles = roleService.queryAll(null);
        model.addAttribute("user",user);
        //细节处理
        List<Role> assignRoles = new ArrayList<Role>();
        List<Role> unassignRoles = new ArrayList<Role>();

        //获取关系表的数据
        List<Integer> roleids = userService.queryRoleidsByUserid(id);
        for (Role role : roles){
            if(roleids.contains(role.getId())){
                //说明已经分配过
                assignRoles.add(role);
            }else{
                unassignRoles.add(role);
            }
        }
        model.addAttribute("assignRoles",assignRoles);
        model.addAttribute("unassignRoles",unassignRoles);
        return "../role/assignRole";
    }

    /**
     * 分配角色
     * @return
     */
    @ResponseBody
    @RequestMapping("doassign")
    public Object doAssign(Integer userid,Integer[] unassignroleids) {
        AjaxResult result = new AjaxResult();
        try {
            //增加关系表数据
            userService.insertUserRole(userid,unassignroleids);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 取消分配角色
     * @return
     */
    @ResponseBody
    @RequestMapping("donotassign")
    public Object doNotAssign(Integer userid,Integer[] assignroleids){
        System.out.println(Arrays.asList(assignroleids).toString());
        AjaxResult result = new AjaxResult();
        try {
            //删除关系表数据
            userService.deleteUserRoles(userid,assignroleids);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
}