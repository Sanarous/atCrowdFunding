<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

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
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form id="addUserForm" action="/user" method="post" role="form">
                        <div class="form-group">
                            <label for="permissionName">许可名称</label>
                            <input type="text" class="form-control" id="permissionName" name="permissionName" placeholder="请输入许可名称">
                        </div>
                        <div class="form-group">
                            <label for="url">链接地址</label>
                            <input type="email" class="form-control" id="url" name="url" placeholder="请输入连接地址">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <button type="button" id="addBtn" onclick="doadduser()" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                        <button type="button" onclick="clearForm()" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${APP_PATH}/layer/layer.js"></script>
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
    });

    //添加user
    function doadduser() {
        var name = $("#permissionName").val();
        var url = $("#url").val();
        if(name === ""){
            layer.msg("添加许可名称不能为空",{time:2000,icon:5,shift:6},function () {});
            return;
        }else if(url === ""){
            layer.msg("添加链接地址不能为空",{time:2000,icon:5,shift:6},function () {});
            return;
        }
        //提交表单
        var loadingIndex = null;
        $.ajax({
            type:"POST",
            url:"/permission/insert",
            data:{
                "permissionName":name,
                "url":url,
                "pid":"${param.id}"
            },
            //实现等待时间的加载
            beforeSend:function () {
                loadingIndex = layer.msg('许可信息保存中',{icon:16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    //说明添加成功
                    layer.msg("许可信息保存成功",{time:1000,icon:6,shift:3},function () {
                        window.location.href="${APP_PATH}/permission/index";
                    });
                }else{
                    layer.msg("许可信息保存失败，请重新操作",{time:1500,icon:5,shift:6},function () {});
                }
            }
        });
    }

    //重置表单数据
    function clearForm() {
        $("#addUserForm")[0].reset();
    }
</script>
</body>
</html>

