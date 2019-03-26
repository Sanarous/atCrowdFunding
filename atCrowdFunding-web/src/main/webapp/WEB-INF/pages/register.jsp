<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/login.css">
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

    <form id="doRegister" method="post" action="member" class="form-signin" role="form">
        <h2 class="glyphicon glyphicon-user"> 用户注册</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="username" name="username" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="password" name="password" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="email" name="email" placeholder="请输入邮箱地址" style="margin-top:10px;">
            <span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <select class="form-control" id="type" name="type">
                <option>企业</option>
                <option>个人</option>
            </select>
        </div>
        <div class="checkbox">
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="/login">我有账号</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="doregister()" > 注册</a>
    </form>
</div>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="layer/layer.js"></script>
<script>
    function doregister() {
        var username =  $("#username").val();
        //注意：表单元素的value值不会为null
        if(username === ""){
            //alert("用户登陆账号或密码不能为空");
            layer.msg("用户登陆账号或密码不能为空",{time:2000,icon:5,shift:6},function () {})
            return;
        }

        var password = $("#password").val();
        if(password === ""){
            //alert("用户登陆账号或密码不能为空");
            layer.msg("用户登陆账号或密码不能为空",{time:2000,icon:5,shift:6},function () {})
            return;
        }

        var email = $("#email").val();
        if(email === ""){
            layer.msg("邮箱不能为空",{time:2000,icon:5,shift:6},function () {})
            return;
        }
        //提交表单
        var loadingIndex = null;
        var type = $(":selected").val();
        $.ajax({
            type:"POST",
            url:"/member",
            data:{
                "username":username,
                "password":password,
                "email":email,
                "type": type
            },
            //实现等待时间的加载
            beforeSend:function () {
                loadingIndex = layer.msg('正在注册中，请稍等',{icon:16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    //说明登陆成功
                    alert("恭喜您注册成功，快去登陆吧！");
                    window.location.href="login";
                }else{
                    layer.msg("用户名或邮箱已被注册",{time:2000,icon:5,shift:6},function () {});
                }
            }
        });
    }
</script>
</body>
</html>