<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>
<!-- 导航栏 -->
<jsp:include page="../common/common-header.jsp"/>
<!-- 侧边栏 -->
<jsp:include page="../common/menu.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="main">首页</a></li>
                <li><a href="users">数据列表</a></li>
                <li class="active">修改</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form id="editUserForm" action="user" action="POST" role="form">
                        <div class="form-group">
                            <label for="username">登陆账号</label>
                            <input type="text" class="form-control" id="username" name="username" value="${user.username}">
                        </div>
                        <div class="form-group">
                            <label for="name">用户名称</label>
                            <input type="text" class="form-control" id="name" name="name" value="${user.name}">
                        </div>
                        <div class="form-group">
                            <label for="email">邮箱地址</label>
                            <input type="email" class="form-control" id="email" name="email" value="${user.email}">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <button type="button" id="updateBtn" class="btn btn-success"><i class="glyphicon glyphicon-edit"></i> 修改</button>
                        <button type="button" onclick="resetEditForm()" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="script/docs.min.js"></script>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });

        //页面加载完成就给修改按钮添加绑定事件
        $("#updateBtn").click(function () {
           var username = $("#username").val();
           var name = $("#name").val();
           var email = $("#email").val();
            if(username === ""){
                layer.msg("添加用户名不能为空",{time:2000,icon:5,shift:6},function () {})
                return;
            }else if(name === ""){
                layer.msg("添加用户姓名不能为空",{time:2000,icon:5,shift:6},function () {})
                return;
            }else if (email === ""){
                layer.msg("添加用户邮箱不能为空",{time:2000,icon:5,shift:6},function () {})
                return;
            }
            var loadingIndex = null;
            $.ajax({
                type:"post",
                url:"/user",
                data:{
                    "id": "${user.id}", //由页面传递过来的
                    "username":username,
                    "name":name,
                    "email":email,
                    "_method":"put" },
                //实现等待时间的加载
                beforeSend:function () {
                    loadingIndex = layer.msg('更新用户信息中',{icon:16});
                },
                success:function (result) {
                    layer.close(loadingIndex);
                    if(result.success){
                        //说明添加成功
                        layer.msg("修改用户信息成功",{time:1000,icon:6,shift:3},function () {
                            window.location.href="users";
                        });
                    }else{
                        layer.msg("用户信息修改失败，请重新操作",{time:1500,icon:5,shift:6},function () {});
                    }
                }
            });
        });
    });

    //重置表单数据
    function resetEditForm() {
        //JQuery对象 --> DOM对象，JQuery中是没有reset方法的
        //DOM --> $(DOM) --> JQuery对象
        $("#editUserForm")[0].reset();
    }
</script>
</body>
</html>

