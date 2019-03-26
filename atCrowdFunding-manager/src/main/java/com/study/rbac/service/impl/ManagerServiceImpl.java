package com.study.rbac.service.impl;

import com.study.rbac.mapper.ManagerMapper;
import com.study.rbac.pojo.Member;
import com.study.rbac.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    private ManagerMapper managerMapper;

    /**
     * 会员注册
     * @param member
     * @return
     */
    public void insert4Register(Member member) {
        managerMapper.insert4Register(member);
    }

    /**
     * 根据用户名和密码查询数据库中数据
     * @param username
     * @param email
     * @return
     */
    public List<Member> queryByUsernameAndEmail(String username, String email) {
        List<Member> members = managerMapper.queryManagerByUsernameAndEmail(username, email);
        return members;
    }

    /**
     * 登陆查询
     * @param member
     * @return
     */
    public Member query4Login(Member member) {
        Member mem = managerMapper.query4Login(member);
        return mem;
    }
}
