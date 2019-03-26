<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/font-awesome.min.css"/>
    <link rel="stylesheet" href="css/login.css"/>
    <link rel="script" href="layer/layer.js"/>
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">
    <form id="loginForm" action="doAjaxLogin" method="post" class="form-signin" role="form">
        <h2 class="glyphicon glyphicon-user"> 用户登录</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="loginaccount" name="username" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="userpassword" name="password" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <select class="form-control" >
                <option value="member">会员</option>
                <option value="user">管理</option>
            </select>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="/register">我要注册</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
    </form>
</div>
<script type="application/javascript" src="jquery/jquery-2.1.1.min.js"></script>
<script type="application/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="application/javascript" src="layer/layer.js"></script>
<script>
    function dologin() {
        // var type = $(":selected").val(); 选中下拉框的选择项
        // if ( type == "user" ) {
        //     window.location.href = "main.html";
        // } else {
        //     window.location.href = "index.html";
        // }
        //非空校验
        var username =  $("#loginaccount").val();
        //注意：表单元素的value值不会为null
        if(username === ""){
            //alert("用户登陆账号或密码不能为空");
            layer.msg("用户登陆账号或密码不能为空",{time:2000,icon:5,shift:6},function () {})
            return;
        }

        var password = $("#userpassword").val();
        if(password === ""){
            //alert("用户登陆账号或密码不能为空");
            layer.msg("用户登陆账号或密码不能为空",{time:2000,icon:5,shift:6},function () {})
            return;
        }
        //提交表单
        //alert("提交表单");
        //$("#loginForm").submit();  原始的提交表单会使屏幕闪烁
        var loadingIndex = null;
        $.ajax({
            type:"POST",
            url:"/doAjaxLogin",
            data:{
                "username":username,
                "password":password
            },
            //实现等待时间的加载
            beforeSend:function () {
                loadingIndex = layer.msg('处理中',{icon:16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                //alert(result);
                if(result.success){
                    //说明登陆成功
                    window.location.href="main";
                }else{
                    layer.msg("用户登陆账号或密码不正确",{time:2000,icon:5,shift:6},function () {});
                }
            }
        });
    }
</script>
</body>
</html>
