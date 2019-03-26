package com.study.rbac.mapper;

import com.study.rbac.pojo.Member;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 会员信息
 */
@Repository
public interface ManagerMapper {
    /**
     * 会员注册
     * @param member
     */
    void insert4Register(Member member);

    /**
     * 根据用户名和邮箱查询用户信息
     * @param username
     * @param email
     * @return
     */
    List<Member> queryManagerByUsernameAndEmail(@Param("username") String username,@Param("email") String email);

    /**
     * 登陆查询数据库
     * @param member
     * @return
     */
    Member query4Login(Member member);
}
