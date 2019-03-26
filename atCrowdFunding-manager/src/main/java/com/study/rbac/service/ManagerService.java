package com.study.rbac.service;

import com.study.rbac.pojo.Member;

import java.util.List;

/**
 * 登陆会员service
 */
public interface ManagerService {
    /**
     * 注册服务
     * @param member
     */
    void insert4Register(Member member);

    /**
     * 根据用户名或者邮箱查询用户信息
     * @param username
     * @param email
     * @return
     */
    List<Member> queryByUsernameAndEmail(String username,String email);

    /**
     * 登陆查询服务
     * @param member
     * @return
     */
    Member query4Login(Member member);
}
