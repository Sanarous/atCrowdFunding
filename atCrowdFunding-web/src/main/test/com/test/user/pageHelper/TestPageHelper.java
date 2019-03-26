package com.test.user.pageHelper;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.study.rbac.pojo.User;
import com.study.rbac.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath*:spring/applicationContext.xml")
public class TestPageHelper {

    @Autowired
    private UserService userService;

    /**
     * 测试pageHelper分页插件
     */
    @Test
    public void test01(){
        PageHelper.startPage(1,10);
        List<User> allUsers = userService.queryAll("a");
        PageInfo<User> pageInfo = new PageInfo<>(allUsers);
        List<User> list = pageInfo.getList();
        for(User user : list){
            System.out.println(user);
        }
        System.out.println(pageInfo.getNavigatepageNums());
        System.out.println(pageInfo.getNavigatePages());
    }
}
