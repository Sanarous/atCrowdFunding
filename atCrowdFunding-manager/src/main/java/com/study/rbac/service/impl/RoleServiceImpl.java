package com.study.rbac.service.impl;

import com.study.rbac.mapper.RoleMapper;
import com.study.rbac.pojo.Role;
import com.study.rbac.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    /**
     * 查询所有的role信息
     * @return
     */
    public List<Role> queryAll(String queryText) {
        return roleMapper.queryAll(queryText);
    }

    /**
     * 根据rolename查询role信息
     * @param rolename
     * @return
     */
    public Role queryRoleByName(String rolename) {
        Role role = roleMapper.queryRoleByName(rolename);
        return role;
    }

    /**
     * 新增role信息
     * @param role
     */
    public void insertRole(Role role) {
        roleMapper.insertRole(role);
    }

    /**
     * 根据id查询role信息
     * @param id
     * @return
     */
    public Role queryRoleById(Integer id) {
        Role role = roleMapper.queryRoleById(id);
        return role;
    }

    /**
     * 更新role信息
     * @param role
     */
    public void updateRole(Role role) {
        roleMapper.updateRole(role);
    }

    /**
     * 根据id删除role信息
     * @param id
     */
    public void deleteRoleById(Integer id) {
        roleMapper.deleteRoleById(id);
    }

    /**
     * 批量删除role信息
     * @param ids
     */
    public void deleteRoles(Integer[] ids) {
        roleMapper.deleteRoles(ids);
    }
}
