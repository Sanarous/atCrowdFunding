package com.study.rbac.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.study.rbac.pojo.AjaxResult;
import com.study.rbac.pojo.Role;
import com.study.rbac.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 角色维护Controller
 */
@Controller
public class RoleController {

    @Autowired
    private RoleService roleService;

    /**
     * 去role页面
     * @return
     */
    @RequestMapping("/roles")
    public String index(){
        return "../role/role";
    }

    /**
     * 异步查询所有role信息
     * @param pageNum
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping("/queryRole")
    public Object queryRole(String queryText,Integer pageNum,Integer pageSize){
        AjaxResult result = new AjaxResult();
        try{
            PageHelper.startPage(pageNum,pageSize);
            List<Role> roles = roleService.queryAll(queryText);
            PageInfo<Role> pageInfo = new PageInfo<Role>(roles);
            result.setData(pageInfo);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 去新增role页面
     * @return
     */
    @RequestMapping("/toaddpage")
    public String toaddpage(){
        return "../role/add";
    }

    /**
     * 新增role信息
     * @param role
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/role",method = RequestMethod.POST)
    public Object addRole(Role role){
        AjaxResult result = new AjaxResult();
        try{
            role.setId(null);
            Role dbRole = roleService.queryRoleByName(role.getRolename());
            if(dbRole != null){
                result.setSuccess(false);
            }else{
                roleService.insertRole(role);
                result.setSuccess(true);
            }
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 去编辑页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/toeditpage")
    public String toeditpage(@RequestParam("id") Integer id, Model model){
        Role role = roleService.queryRoleById(id);
        model.addAttribute("role",role);
        return "../role/edit";
    }

    /**
     * 修改role信息
     * @param role
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/role",method = RequestMethod.PUT)
    public Object updateRole(Role role){
        AjaxResult result = new AjaxResult();
        try{
            roleService.updateRole(role);
            result.setSuccess(true);
        }catch(Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 单个删除用户信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/role",method = RequestMethod.DELETE)
    public Object deleteRole(Integer id){
        AjaxResult result = new AjaxResult();
        try {
            roleService.deleteRoleById(id);
            result.setSuccess(true);
        }catch(Exception e){
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 批量删除role信息
     * @param roleid
     * @return
     */
    @ResponseBody
    @RequestMapping("role/deletes")
    public Object deleteUsers(@RequestParam("roleid") Integer[] roleid) {
        AjaxResult result = new AjaxResult();
        try {
            roleService.deleteRoles(roleid);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/role/assign")
    public String assign(){
        return "../role/assignPermission";
    }
}
