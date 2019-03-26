package com.study.rbac.service;

import com.study.rbac.pojo.User;

import java.util.List;

/**
 * 用户service
 * @author 左想
 */
public interface UserService {
    /**
     * 查询数据库中的user信息
     * @return
     */
    List<User> queryAll(String queryText);

    /**
     * 添加User信息
     * @param user
     */
    void addUser(User user);

    /**
     * 根据Id查询用户信息
     * @param id
     * @return
     */
    User getUserById(Integer id);

    /**
     * 修改用户信息
     * @param user
     */
    void updateUser(User user);

    /**
     * 根据id删除用户信息
     * @param id
     */
    void deleteUser(Integer id);

    /**
     * 批量删除用户信息
     * @param ids
     */
    void deleteUsers(Integer[] ids);

    /**
     * 分配角色
     * @param userid
     * @param unassignroleids
     */
    void insertUserRole(Integer userid, Integer[] unassignroleids);

    /**
     * 取消分配角色
     * @param userid
     * @param unassignroleids
     */
    void deleteUserRoles(Integer userid, Integer[] unassignroleids);


    List<Integer> queryRoleidsByUserid(Integer id);
}
