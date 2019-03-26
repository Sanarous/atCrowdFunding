package com.study.rbac.service;

import com.study.rbac.pojo.Role;

import java.util.List;

public interface RoleService {

    /**
     * 查询所有的role信息
     * @return
     */
    List<Role> queryAll(String queryText);

    /**
     * 根据role名查询role信息
     * @param rolename
     * @return
     */
    Role queryRoleByName(String rolename);

    /**
     * 新增role信息
     * @param role
     */
    void insertRole(Role role);

    /**
     * 根据id查询role信息
     * @param id
     * @return
     */
    Role queryRoleById(Integer id);

    /**
     * 更新role信息
     * @param role
     */
    void updateRole(Role role);

    /**
     * 根据id删除role信息
     * @param id
     */
    void deleteRoleById(Integer id);

    /**
     * 批量删除role信息
     * @param ids
     */
    void deleteRoles(Integer[] ids);
}
