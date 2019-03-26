<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
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
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form id="roleForm" role="form" class="form-inline">
                        <input type="hidden" name="userid" value="${user.id}">
                        <div class="form-group">
                            <label for="leftList">未分配角色列表</label><br>
                            <select id="leftList" name="unassignroleids" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                                <c:forEach items="${unassignRoles}" var="unassignrole">
                                    <option value="${unassignrole.id}">${unassignrole.rolename}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li id="left2RightBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <li id="right2LeftBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label for="rightList">已分配角色列表</label><br>
                            <select id="rightList" name="assignroleids" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                                <c:forEach items="${assignRoles}" var="assignrole">
                                    <option value="${assignrole.id}">${assignrole.rolename}</option>
                                </c:forEach>
                            </select>
                        </div>
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

        //分配角色
        $("#left2RightBtn").click(function () {
            var opts = $("#leftList :selected");
            if(opts.length === 0){
                layer.msg("请选择需要分配的角色数据", {time: 2000, icon: 5, shift: 6}, function () {})
            }else{
                //把数据传递给后端
                $.ajax({
                    type:"post",
                    url:"doassign",
                    data:$("#roleForm").serialize(),
                    success:function (result) {
                        if(result.success) {
                            $("#rightList").append(opts);
                            layer.msg("分配角色数据成功", {time: 2000, icon: 6}, function () {})
                        }else{
                            layer.msg("分配角色数据失败", {time: 2000, icon: 5, shift: 6}, function () {})
                        }
                    }
                });
            }
        });

        //取消分配角色
        $("#right2LeftBtn").click(function () {
            var opts = $("#rightList :selected");
            if(opts.length === 0){
                layer.msg("请选择需要分配的角色数据", {time: 2000, icon: 5, shift: 6}, function () {})
            }else{
                //把数据传递给后端
                $.ajax({
                    type:"post",
                    url:"donotassign",
                    data:$("#roleForm").serialize(),
                    success:function (result) {
                        if(result.success) {
                            $("#leftList").append(opts);
                            layer.msg("取消分配角色数据成功", {time: 2000, icon: 6}, function () {})
                        }else{
                            layer.msg("取消分配角色数据失败", {time: 2000, icon: 5, shift: 6}, function () {})
                        }
                    }
                });
            }
        });
    });
</script>
</body>
</html>
