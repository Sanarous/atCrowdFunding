<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/script/docs.min.js"></script>
    <script src="${APP_PATH}/layer/layer.js"></script>
    <script src="${APP_PATH}/ztree/jquery.ztree.all-3.5.min.js"></script>
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>
<!-- 导航栏 -->
<jsp:include page="../common/common-header.jsp"/>
<!-- 侧边栏 -->
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <%@include file="../common/menu.jsp"%>
            </div>
        </div>
    </div>
</div>
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
        </div>
        <div class="panel-body">
            <form class="form-inline" role="form" style="float:left;">
                <div class="form-group has-feedback">
                    <div class="input-group">
                        <div class="input-group-addon">查询条件</div>
                        <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                    </div>
                </div>
                <button type="button" id="queryBtn" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i>
                    查询
                </button>
            </form>
            <button type="button" id="deleteUsersBtn"  class="btn btn-danger" style="float:right;margin-left:10px;">
                <i class=" glyphicon glyphicon-remove"></i> 删除
            </button>
            <button type="button" class="btn btn-primary" style="float:right;" id="addUserBtn"><i
                    class="glyphicon glyphicon-plus"></i> 新增
            </button>
            <br>
            <hr style="clear:both;">
            <div class="table-responsive">
                <form id="userForm">
                    <table class="table  table-bordered">
                        <thead>
                        <tr>
                            <th width="30">ID</th>
                            <th width="30"><input id="allSelectBox" type="checkbox"></th>
                            <th>账号</th>
                            <th>名称</th>
                            <th>邮箱地址</th>
                            <th width="100">操作</th>
                        </tr>
                        </thead>
                        <tbody id="userData">
                        <%--ajax异步获取表格数据--%>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="5" align="center">
                                <ul class="pagination">
                                    <%--ajax异步获取分页信息--%>
                                </ul>
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
    </div>
</div>
<script type="text/javascript">
    //表示是否是模糊查询，默认不是模糊查询
    var likeflag = false;
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
        //页面加载完成后查询第一页用户信息
        pageQuery(1);

        //页面加载完成之后给查询按钮增加一个绑定事件
        $("#queryBtn").click(function () {
            var queryText = $("#queryText").val();
            if( queryText === ""){
                //如果查询条件为空，那么就不是模糊查询
                likeflag = false;
            }else{
                //如果不为空，那么就是模糊查询
                likeflag = true;
            }
            pageQuery(1);
        });

        //页面加载完成后给全选框添加点击事件
        $("#allSelectBox").click(function () {
            //获取当前复选框的选中状态
            var flag = this.checked;
            //alert(flag);
            $("#userData :checkbox").each(function () {
                this.checked = flag;
            });
        });

        //页面加载完成后给顶部删除按钮添加绑定事件
        $("#deleteUsersBtn").click(function () {
            var boxes = $("input[type='checkbox']:checked");
            //alert($("input[type='checkbox']:checked").length);
            if(boxes.length === 0){
                layer.msg("请选择需要删除的用户信息后操作",{time:2000,icon:5,shift:6},function () {});
            }else{
                layer.confirm("是否删除所选中的用户?",{icon:3,title:'提示'},
                    function (cindex) {
                        //删除选择的用户信息
                        $.ajax({
                            type:"POST",
                            url:"/user/deletes",
                            data:$("#userForm").serialize(),
                            success:function (result) {
                                if (result.success){
                                    pageQuery(1);
                                } else{
                                    layer.msg("用户信息删除失败",{time:2000,icon:5,shift:6},function () {});
                                }
                            }
                        })
                        layer.close(cindex);
                    },function (cindex) {
                        //如果点击取消
                        layer.close(cindex)
                    }
                )
            }
        });
    });
    $("tbody .btn-success").click(function(){
        window.location.href = "/assignRole";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "/edit";
    });

    //异步分页查询
    function pageQuery(pageNum){
        var loadingIndex = null;

        var jsonData = {"pageNum": pageNum, "pageSize": 16};
        if(likeflag === true){
            //动态增加jsonData的属性值
            jsonData.queryText = $("#queryText").val();
        }
        $.ajax({
            type:"POST",
            url:"users/pageQuery",
            data: jsonData,
            beforeSend:function () {
                loadingIndex = layer.msg('查询用户信息中',{icon:16});
            },
            success:function (result) {
                //alert(result);
                layer.close(loadingIndex);
                if(result.success){
                    //局部刷新页面数据
                    var tableContent = "";
                    var pageContent =  "";

                    //获取封装的数据
                    var pageInfo = result.data;
                    var users = pageInfo.list;

                    //遍历表格数据
                    $.each(users,function (i, user) {
                    tableContent += '<tr>';
                    tableContent += '    <td>' + user.id + '</td>';
                    tableContent += '    <td><input type="checkbox" name="userid" value="'+ user.id +'"></td>';
                    tableContent += '     <td>' + user.username +'</td>';
                    tableContent += '     <td>' + user.name +'</td>';
                    tableContent += '     <td>' + user.email +'</td>';
                    tableContent += '     <td>';
                    tableContent += '       <button type="button" onclick="goAssignPage('+ user.id +')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                    tableContent += '       <button type="button" onclick="goUpdatePage('+ user.id +')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                    tableContent += '       <button type="button" onclick="deleteUser('+ user.id + ',\'' + user.username + '\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                    tableContent += '    </td>';
                    tableContent += '</tr>';
                    });

                    //遍历分页数据
                    pageContent += '<li><a href="#" onclick="pageQuery(1)">首页</a></li>';
                    if (pageNum > 1) {
                        pageContent += '<li><a href="#" onclick="pageQuery(' + (pageNum - 1) + ')">上一页</a></li>';
                    } else {
                        pageContent += '<li class="disabled"><a href="#" onclick="pageQuery(1)">上一页</a></li>';
                    }

                    for (var i = 1; i <= pageInfo.navigatepageNums.length; i++) {
                        if (i === pageNum) {
                            pageContent += '<li class="active"><a href="#" onclick="pageQuery(' + i + ')">' + i + ' <span class="sr-only">(current)</span></a></li>';
                        } else {
                            pageContent += '<li><a href="#" onclick="pageQuery(' + i + ')">' + i + '</a></li>';
                        }
                    }

                    if (pageNum < pageInfo.lastPage) {
                        pageContent += '<li><a href="#" onclick="pageQuery(' + (pageNum + 1) + ')">下一页</a></li>';
                    } else {
                        pageContent += '<li class="disabled"><a href="#" onclick="pageQuery(' + pageInfo.lastPage + ')">下一页</a></li>';
                    }
                    pageContent += '<li><a href="#" onclick="pageQuery(' + pageInfo.lastPage + ')">尾页</a></li>';
                    //渲染页面
                    $("#userData").html(tableContent);
                    $(".pagination").html(pageContent);
                } else {
                    layer.msg("用户信息查询失败，请刷新页面重新查询", {time: 2000, icon: 5, shift: 6}, function () {
                    });
                }
            }
        })
    }

    //给添加用户信息按钮添加绑定事件
    $("#addUserBtn").click(function () {
        window.location.href = "/add";
    });

    //去编辑页面
   function goUpdatePage(id) {
        window.location.href = "/edit?id=" + id;
    }

    //去分配角色页面
    function goAssignPage(id) {
        window.location.href = "assign?id=" + id;
    }

    //删除用户信息
    function deleteUser(id,username) {
        layer.confirm("删除用户【" + username +"】，是否继续?",{icon:3,title:'提示'},
            function (cindex) {
            //删除用户信息
             $.ajax({
                 type:"POST",
                 url:"/user",
                 data:{id:id,"_method":"delete"},
                 success:function (result) {
                     if (result.success){
                         pageQuery(1);
                     } else{
                         layer.msg("用户信息删除失败",{time:2000,icon:5,shift:6},function () {});
                     }
                 }
             })
            layer.close(cindex);
        },function (cindex) {
            layer.close(cindex)
            }
        )
    }
</script>
</body>
</html>

