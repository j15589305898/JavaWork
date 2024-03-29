<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>主页</title>
	<%@ include file="header.jsp"%>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">监考管理查询系统</div>
			<ul class="layui-nav layui-layout-left">   </ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item">
				    <a href="javascript:;"> 
<%-- 				        <img src="<%=path%>/img/fei.png" --%>
<!-- 				        class="layui-nav-img"/> -->
				        	用户: ${user.name}
<%-- 				        	[${user.name}] --%>
				    </a>
					<dl class="layui-nav-child">
<%--						<dd>--%>
<%--							<a href="javascript:openUser()">基本资料</a>--%>
<%--						</dd>--%>
<%--						<dd>--%>
<%--							<a href="javascript:openPass()">修改密码</a>--%>
<%--						</dd>--%>
						<dd>
                            <a href="/user/user_update1.jsp">修改个人信息</a>
                        </dd>
					</dl>
				</li>
				<li class="layui-nav-item">
				    <a href="javascript:logout()">注销</a>
				</li>
			</ul>
		</div>
		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" >
					<li class="layui-nav-item layui-nav-itemed">
					    <a href="javascript:;">信息维护</a>
						<dl class="layui-nav-child">
							<c:if test="${user.type == 1}">
							<dd>
								<a href="javascript:;" 
								data-url="${pageContext.request.contextPath}/user/user_list.jsp"
								class="site-demo-active">管理员管理</a>
							</dd>
							</c:if>
							<dd>
								<a href="javascript:;" 
								data-url="${pageContext.request.contextPath}/emp/emp_list.jsp"
								class="site-demo-active">监考老师安排</a>
							</dd>
							<dd>
								<a href="javascript:;" 
								data-url="${pageContext.request.contextPath}/dept/dept_list.jsp"
								class="site-demo-active">学院监考安排</a>
							</dd>
							<c:if test="${user.type == 1}">
								<dd>
									<a href="javascript:;"
									   data-url="${path}/echarts.jsp"
									   class="site-demo-active">统计图表</a>
								</dd>
							</c:if>
						</dl>
					</li>
<%--					<li class="layui-nav-item">--%>
<%--					    <a href="javascript:;">基础配置</a>--%>
<%--						<dl class="layui-nav-child">--%>
<%--							<dd>--%>
<%--								<a href="javascript:;"--%>
<%--								class="site-demo-active"--%>
<%--								data-url="/web/page/dict/dictlist.jsp">--%>
<%--								基础数据维护</a>--%>
<%--							</dd>--%>
<%--							<dd>--%>
<%--								<a href="javascript:;" class="site-demo-active"--%>
<%--								data-url="/web/404.jsp">404-1</a>--%>
<%--							</dd>--%>
<%--						</dl>--%>
<%--					</li>--%>
				</ul>
			</div>
		</div>
			<div class="layui-body"><!-- 内容主体区域 -->
				<iframe name="rightframe" width="99%" height="97%" src="${path}/page_origin.jsp"></iframe>
			</div>
		<div class="layui-footer">© 监考管理查询系统</div>
	</div>
	<script type="text/javascript">
		var $ = layui.jquery;
		var layer = layui.layer;
		var element = layui.element;
		$('.site-demo-active').click(function() {
			window.open($(this).data('url'), "rightframe");
		});
		element.render();// element.init();
		function openURL(url){
			window.open(url, "rightframe");
		}

		function logout() {
			layer.confirm(
					'您确认要退出么',
					{icon:3},
					function() {
						location.href = '${path}/login?method=logout'
					}
			);
		}


	</script>
</body>
</html>