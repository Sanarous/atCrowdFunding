package com.study.rbac.service;

import com.study.rbac.pojo.Permission;

import java.util.List;

public interface PermissionService {

    Permission queryRootPermission();

    List<Permission> queryChildPermissions(Integer pid);

    List<Permission> queryAll();

    void insertPermission(Permission permission);
}
