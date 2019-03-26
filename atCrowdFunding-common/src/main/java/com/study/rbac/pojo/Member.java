package com.study.rbac.pojo;

import lombok.Data;

@Data
public class Member {
    private Integer id;
    private String username;
    private String password;
    private String email;
    private String type;
    private String createtime;
    private String updatetime;
}
