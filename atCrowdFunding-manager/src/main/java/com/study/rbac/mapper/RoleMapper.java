package com.study.rbac.mapper;

import com.study.rbac.pojo.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleMapper {
    /**
     * 查询所有Role信息
     * @return
     */
    List<Role> queryAll(@Param("queryText") String queryText);

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
     * 根据Id删除role信息
     * @param id
     */
    void deleteRoleById(@Param("id") Integer id);

    /**
     * 批量删除role信息
     * @param ids
     */
    void deleteRoles(@Param("roleid") Integer[] ids);
}
