package com.study.rbac.pojo;

import lombok.Data;

@Data
public class User {
    private Integer id;
    private String username;
    private String password;
    private String name;
    private String email;
    private String createtime;
    private String updatetime;
}
