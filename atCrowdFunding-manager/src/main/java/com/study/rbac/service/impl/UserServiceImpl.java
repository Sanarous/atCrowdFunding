package com.study.rbac.service.impl;

import com.study.rbac.mapper.UserMapper;
import com.study.rbac.pojo.User;
import com.study.rbac.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 左想
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 分页查询user信息
     * @return
     */
    public List<User> queryAll(String queryText) {
        List<User> users = userMapper.queryAllUsers(queryText);
        return users;
    }

    /**
     * 新增用户
     * @param user
     */
    public void addUser(User user) {
        userMapper.addUser(user);
    }

    /**
     * 根据用户id查询user信息
     * @param id
     * @return
     */
    public User getUserById(Integer id) {
        User user = userMapper.getUserById(id);
        return user;
    }

    /**
     * 修改用户信息
     * @param user
     */
    public void updateUser(User user) {
        userMapper.updateUser(user);
    }

    /**
     * 删除用户信息
     * @param id
     */
    public void deleteUser(Integer id) {
        userMapper.deleteUserById(id);
    }

    /**
     * 批量删除用户信息
     * @param ids
     */
    public void deleteUsers(Integer[] ids) {
        userMapper.deleteUsers(ids);
    }

    /**
     * 分配角色
     * @param userid
     * @param unassignroleids
     */
    public void insertUserRole(Integer userid, Integer[] unassignroleids) {
        userMapper.insertUserRole(userid,unassignroleids);
    }

    /**
     * 取消分配角色
     * @param userid
     * @param unassignroleids
     */
    public void deleteUserRoles(Integer userid, Integer[] unassignroleids) {
        userMapper.deleteUserRoles(userid,unassignroleids);
    }

    public List<Integer> queryRoleidsByUserid(Integer id) {
        return userMapper.queryRoleidsByUserid(id);
    }
}
