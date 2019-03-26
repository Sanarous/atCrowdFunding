<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="GB18030">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/main.css">
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
<jsp:include page="../common/menu.jsp"/>
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
                        <button type="button" id="queryBtn" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" id="deleteRolesBtn" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='toaddpage'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <form id="roleForm">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">ID</th>
                                <th width="30"><input id="allSelectBox" type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                                <!-- 异步查询role数据信息 -->
                            <tbody id="roleData">
                            </tbody>
                            <tfoot>
                            <!-- 异步查询分页信息 -->
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
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

<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="script/docs.min.js"></script>
<script type="text/javascript">
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

        //当页面加载完成后，发送一个异步ajax请求去数据库获取role信息
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
            $("#roleData :checkbox").each(function () {
                this.checked = flag;
            });
        });

        //页面加载完成后给顶部删除按钮添加绑定事件
        $("#deleteRolesBtn").click(function () {
            var boxes = $("input[type='checkbox']:checked");
            if(boxes.length === 0){
                layer.msg("请选择需要删除的角色信息后操作",{time:2000,icon:5,shift:6},function () {});
            }else{
                layer.confirm("是否删除所选中的角色?",{icon:3,title:'提示'},
                    function (cindex) {
                        //删除选择的用户信息
                        $.ajax({
                            type:"POST",
                            url:"/role/deletes",
                            data:$("#roleForm").serialize(),
                            success:function (result) {
                                if (result.success){
                                    pageQuery(1);
                                } else{
                                    layer.msg("角色信息删除失败",{time:2000,icon:5,shift:6},function () {});
                                }
                            }
                        })
                        layer.close(cindex);
                    },function (cindex) {
                        //如果点击取消
                        layer.close(cindex);
                    }
                )
            }
        });
    });

    $("tbody .btn-success").click(function(){
        window.location.href = "assignPermission.html";
    });

    //异步分页查询role信息
    function pageQuery(pageNum) {
        var loadingIndex = null;
        var jsonData = {"pageNum": pageNum, "pageSize": 10 };
        if(likeflag === true){
            jsonData.queryText = $("#queryText").val();
        }
        $.ajax({
            type: "post",
            url: "/queryRole",
            data: jsonData,
            beforeSend: function () {
                loadingIndex = layer.msg('查询用户信息中', {icon: 16});
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    //局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";

                    var pageInfo = result.data;
                    var roles = pageInfo.list;

                    //遍历出表格中的数据
                    $.each(roles, function (i, role) {
                        tableContent += '<tr>';
                        tableContent += '    <td>'+ role.id +'</td>';
                        tableContent += '    <td><input name="roleid" type="checkbox"></td>';
                        tableContent += '        <td>'+ role.rolename +'</td>';
                        tableContent += '    <td>';
                        tableContent += '        <button type="button" onclick="goAssignPage('+ role.id +')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                        tableContent += '        <button type="button" onclick="toUpdatePage('+ role.id +')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tableContent += '        <button type="button" onclick="deleteRole('+ role.id + ',\'' + role.rolename+ '\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tableContent += '    </td>';
                        tableContent += '</tr>';
                    });

                    //获取分页信息
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
                    $("#roleData").html(tableContent);
                    $(".pagination").html(pageContent);
                } else {
                    layer.msg("角色信息查询失败，请刷新页面重新查询", {time: 2000, icon: 5, shift: 6}, function () {
                    });
                }
            }
        });
    }
    //去edit页面
    function toUpdatePage(id) {
        window.location.href = "/toeditpage?id=" + id;
    }

    //单个删除role信息
    function deleteRole(id,rolename) {
        layer.confirm("删除用户【" + rolename +"】，是否继续?",{icon:3,title:'提示'},
            function (cindex) {
                //删除用户信息
                $.ajax({
                    type:"post",
                    url:"/role",
                    data:{id:id,"_method":"delete"},
                    success:function (result) {
                        if (result.success){
                            pageQuery(1);
                        } else{
                            layer.msg("角色信息删除失败",{time:2000,icon:5,shift:6},function () {});
                        }
                    }
                });
                layer.close(cindex);
            },function (cindex) {
                layer.close(cindex)
            }
        )
    }

    function goAssignPage(id) {
        window.location.href="${APP_PATH}/role/assign?id=" + id;
    }
</script>
</body>
</html>
