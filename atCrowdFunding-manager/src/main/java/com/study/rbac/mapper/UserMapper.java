package com.study.rbac.mapper;

import com.study.rbac.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户信息
 */
public interface UserMapper {
    /**
     * 查询所有的user信息
     * @return
     */
    List<User> queryAllUsers(@Param("queryText") String queryText);

    /**
     * 添加user信息
     * @param user
     */
    void addUser(User user);

    /**
     * 编辑用户信息
     * @param user
     */
    void updateUser(User user);

    /**
     * 根据用户Id查询用户信息
     * @param id
     * @return
     */
    User getUserById(Integer id);

    /**
     * 根据主键删除用户信息
     * @param id
     */
    void deleteUserById(Integer id);

    /**
     * 批量删除用户信息
     * @param userid
     */
    void deleteUsers(@Param("userid") Integer[] userid);

    /**
     * 分配角色
     * @param userid
     * @param unassignroleids
     */
    void insertUserRole(@Param("userid") Integer userid, @Param("unassignroleids") Integer[] unassignroleids);

    /**
     * 取消分配角色
     * @param userid
     * @param assignroleids
     */
    void deleteUserRoles(@Param("userid") Integer userid,@Param("assignroleids") Integer[] assignroleids);

    /**
     * 查询roleid
     * @param id
     */
    List<Integer> queryRoleidsByUserid(Integer id);
}
