package com.study.rbac.controller;

import com.study.rbac.pojo.AjaxResult;
import com.study.rbac.pojo.Permission;
import com.study.rbac.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    @RequestMapping("/index")
    public String index(){
        return "../perm/permission";
    }

    /**
     * 异步加载数据
     * @return
     */
    @ResponseBody
    @RequestMapping("/loadData")
    public Object loadData() {
        List<Permission> permissions = new ArrayList<Permission>();
//        Permission parent = new Permission();
//        parent.setId(0);
//        queryChildPermissions(parent);
//        return parent.getChildren();
        //递归效率不高，需要一次查询所有数据

        //效率同样不高
        //查询所有的许可数据
         List<Permission> ps = permissionService.queryAll();
         //复杂度为O(n2)
//        for(Permission p : ps){
//            //子节点
//            Permission child = p;
//            if(p.getPid() == 0){
//                permissions.add(p);
//            }else{
//                //一定会有父节点
//                for(Permission innerPermission : ps){
//                    if(child.getPid().equals(innerPermission.getId())){
//                        //父节点
//                        Permission parent = innerPermission;
//                        //组合父子节点关系
//                        parent.getChildren().add(child);
//                        break;
//                    }
//                }
//            }
//        }
//        return permissions;

        //用Map,复杂度为O(n)
        Map<Integer,Permission> permissionMap = new HashMap<Integer,Permission>();
        for (Permission p : ps){
            permissionMap.put(p.getId(),p);
        }
        for(Permission p : ps){
            Permission child = p;
            if(child.getPid() == 0){
                permissions.add(p);
            }else {
                Permission parent = permissionMap.get(child.getPid());
                parent.getChildren().add(child);
            }
        }
        return permissions;
    }

    /**
     * 递归查询许可信息
     */
//    private void queryChildPermissions(Permission parent){
//        List<Permission> childPermissions = permissionService.queryChildPermissions(parent.getId());
//        for (Permission permission : childPermissions){
//            queryChildPermissions(permission);
//        }
//        parent.setChildren(childPermissions);
//    }

    @RequestMapping("/add")
    public String add(){
        return "../perm/add";
    }

    @ResponseBody
    @RequestMapping("/insert")
    public Object insert(Permission permission){
        AjaxResult result = new AjaxResult();
        try {
            permissionService.insertPermission(permission);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
}
