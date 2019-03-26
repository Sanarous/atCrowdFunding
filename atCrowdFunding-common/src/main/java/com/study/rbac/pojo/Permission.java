package com.study.rbac.pojo;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class Permission {
    private Integer id;
    private String name;
    private String url;
    private Integer pid;
    private boolean open = true;
    private String icon;
    private List<Permission> children = new ArrayList<Permission>();

}
