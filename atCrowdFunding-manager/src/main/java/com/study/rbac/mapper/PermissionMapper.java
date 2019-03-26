package com.study.rbac.mapper;

import com.study.rbac.pojo.Permission;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PermissionMapper {

    Permission queryRootPermission();

    List<Permission> queryChildPermissions(Integer pid);

    List<Permission> queryAll();

    void insertPermission(Permission permission);
}
