package com.study.rbac.service.impl;

import com.study.rbac.mapper.PermissionMapper;
import com.study.rbac.pojo.Permission;
import com.study.rbac.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionServiceImpl implements PermissionService{

    @Autowired
    private PermissionMapper permissionMapper;

    public Permission queryRootPermission() {
        return permissionMapper.queryRootPermission();
    }

    public List<Permission> queryChildPermissions(Integer pid) {
        return permissionMapper.queryChildPermissions(pid);
    }

    public List<Permission> queryAll() {
        return permissionMapper.queryAll();
    }

    public void insertPermission(Permission permission) {
        permissionMapper.insertPermission(permission);
    }
}
