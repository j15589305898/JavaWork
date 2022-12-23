<%--
  Created by IntelliJ IDEA.
  emp: jiruichang
  Date: 2022/12/20
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@ include file="../header.jsp"%>
</head>
<body>
<%--    右侧工具条--%>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
<%--    顶部工具条--%>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm"  lay-event="add">添加</button>
            <button class="layui-btn layui-btn-sm" lay-event="deleteAll">批量删除</button>
        </div>
    </script>
    <div class="demoTable">
        搜索名字：
        <div class="layui-inline">
            <input class="layui-input" name="name" id="nameId" autocomplete="off">
        </div>
        搜索邮箱：
        <div class="layui-inline">
            <input class="layui-input" name="email" id="emailId" autocomplete="off">
        </div>
        搜索手机：
        <div class="layui-inline">
            <input class="layui-input" name="phone" id="phoneId" autocomplete="off">
        </div>
        <button class="layui-btn" data-type="reload">搜索</button>
    </div>

    <table class="layui-hide" id="test" lay-filter="test"></table>
    <script src="//res/layui/dist/layui.js" charset="utf-8"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述 JS 路径需要改成你本地的 -->
    <script>
        layui.use('table', function(){
            var table = layui.table;

            //方法级渲染
            table.render({
                elem: '#test'
                ,url: '${path}/emp?method=selectByPage'
                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                ,cols: [[
                    {checkbox: true, fixed: true}
                    ,{field:'id', title: 'ID', sort: true, fixed: true}
                    ,{field:'name', title: '用户名'}
                    ,{field:'email', title: '邮箱'}
                    ,{field:'phone', title: '电话'}
                    ,{field:'deptId', title: '部门ID'}
                    ,{field:'', title: '操作', toolbar :'#barDemo'}
                ]]
                ,id: 'tableId'
                ,page: true
            });

            //头工具栏事件
            table.on('toolbar(test)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'add':
                        //location.href = "${path}/emp/emp_add.jsp"
                        layer.open({
                            type: 2,
                            area: ['700px','400px'],
                            content: '${path}/emp/emp_add.jsp'

                        })
                        break;
                    case 'deleteAll':

                        var data = checkStatus.data;
                        // {avatar: '', deleted: 0, email: '123', gmtCreate: null, gmtModified: null, …}, {…}, {…}, {…}, {…}, {…}]
                        layer.msg('选中了：'+ data.length + ' 个');
                        var idArray = new Array();
                        for (var i = 0; i < data.length; i++) {
                            idArray.push(data[i].id);
                        }
                        //[14,15] ->'14,15'
                        var ids = idArray.join(',');
                        layer.confirm('真的删除行么', function(index){
                            //异步请求，局部刷新
                            $.post(
                                '${path}/emp?method=deleteAll',
                                {'ids':ids},
                                function (jsonResult){
                                    console.log(jsonResult);
                                    if(jsonResult.ok){
                                        // mylayer.okMsg(jsonResult.msg)
                                        mylayer.okMsg('批量删除成功')
                                        //删除之后，刷新表格展示最新的数据
                                        table.reload('tableId');
                                    }else{
                                        mylayer.errorMsg(jsonResult.msg)
                                        mylayer.okMsg('批量删除失败')
                                    }
                                },
                                'json'
                            );
                            layer.close(index);
                        });
                        break;
                    case 'isAll':
                        layer.msg(checkStatus.isAll ? '全选': '未全选');
                        break;

                    //自定义头工具栏右侧图标 - 提示
                    case 'LAYTABLE_TIPS':
                        layer.alert('这是工具栏右侧自定义的一个图标按钮');
                        break;
                };
            });

            //监听右侧工具条
            table.on('tool(test)', function(obj){
                var data = obj.data;
                if(obj.event === 'del'){
                    layer.confirm('真的删除行么', function(index){
                        //异步请求，局部刷新
                        $.post(
                          '${path}/emp?method=deleteById',
                            {'id':data.id},
                            function (jsonResult){
                              console.log(jsonResult);
                              if(jsonResult.ok){
                                  mylayer.okMsg('删除成功')
                                  //删除之后，刷新表格展示最新的数据
                                  table.reload('tableId');
                              }else{
                                  mylayer.errorMsg('删除失败')
                              }
                            },
                            'json',
                        );
                        layer.close(index);
                    });
                } else if(obj.event === 'edit'){
                    layer.open({
                        type: 2,
                        area: ['700px','400px'],
                        //content: '${path}/emp/emp_add.jsp'
                        content: '${path}/emp?method=getEmpUpdatePage&id='+ data.id

                    })
                }
            });

            var $ = layui.$, active = {
                reload: function(){
                    var demoReload = $('#demoReload');

                    //执行重载
                    table.reload('tableId', {
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        ,where: {
                           name : $('#nameId').val(),
                           email : $('#emailId').val(),
                           phone : $('#phoneId').val(),
                        }
                    });
                }
            };

            $('.demoTable .layui-btn').on('click', function(){
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
        });
    </script>




<%--    <table class="table table-striped table-bordered table-hover table-condensed">--%>
<%--        <tr>--%>
<%--            <td>Id</td>--%>
<%--            <td>名字</td>--%>
<%--            <td>密码</td>--%>
<%--            <td>邮箱</td>--%>
<%--            <td>电话</td>--%>
<%--            <td>删除</td>--%>
<%--        </tr>--%>
<%--        <c:forEach items="${list}" var="emp">--%>
<%--            <tr>--%>
<%--                <td>${emp.id}</td>--%>
<%--                <td>${emp.name}</td>--%>
<%--                <td>${emp.password}</td>--%>
<%--                <td>${emp.email}</td>--%>
<%--                <td>${emp.phone}</td>--%>
<%--&lt;%&ndash;                <td><a href="${path}/emp?method=deleteById&id=${emp.id}">删除</a> </td>&ndash;%&gt;--%>
<%--                <td><a href="javascript:deleteById(${emp.id})">删除</a> </td>--%>
<%--            </tr>--%>
<%--        </c:forEach>--%>

<%--    </table>--%>

<%--    <script>--%>
<%--        function deleteById(id){--%>
<%--            var isDeleted = confirm('您确定要删除吗');--%>
<%--            if (isDeleted){--%>
<%--                location.href = "${path}/emp?method=deleteById&id=" + id;--%>
<%--            }--%>
<%--        }--%>
<%--    </script>--%>
</body>
</html>