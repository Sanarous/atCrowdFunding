package com.study.rbac.Interceptor;

import com.study.rbac.pojo.Permission;
import com.study.rbac.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 认证权限
 */
public class AuthInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private PermissionService permissionService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取用户的请求地址
        String uri = request.getRequestURI();
        //判断当前的路径是否需要进行权限验证
        List<Permission> permissions = permissionService.queryAll();
        Set<String> uriSet = new HashSet<>();
        for(Permission permission : permissions){
            if(permission.getUrl() == null || permission.getUrl().equals("")){
                uriSet.add(permission.getUrl());
            }
        }

        if(uriSet.contains(uri)){
            //权限验证
            //判断当前的用户是否拥有对应的权限
            return true;
        }else{
            response.sendRedirect("/error");
            return false;
        }
    }
}
