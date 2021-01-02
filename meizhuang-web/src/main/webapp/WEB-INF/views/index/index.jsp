<%@ page import="com.meizhuang.config.properties.PropertiesUtils"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String profile = PropertiesUtils.getProperty("spring.profiles.active");
	request.setAttribute("logo", "/static/images/" + profile + "/logo-title.png");
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>猿报价管理后台</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"> -->
		<link rel="stylesheet" href="/static/layuiadmin/layui/css/layui.css" media="all">
		<link rel="stylesheet" href="/static/layuiadmin/style/admin.css" media="all">
	</head>
	<body class="layui-layout-body">

		<div id="LAY_app">
			<div class="layui-layout layui-layout-admin">
				<div class="layui-header">
					<!-- 头部区域 -->
					<ul class="layui-nav layui-layout-left">
						<li class="layui-nav-item layadmin-flexible" lay-unselect>
							<a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
								<i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
							</a>
						</li>
						
						<li class="layui-nav-item layui-hide-xs" lay-unselect>
							<a href="/index" target="_blank" title="新窗口打开">
								<i class="layui-icon layui-icon-website"></i>
							</a>
						</li>
						
						<li class="layui-nav-item" lay-unselect>
							<a href="javascript:;" layadmin-event="refresh" title="刷新">
								<i class="layui-icon layui-icon-refresh-3"></i>
							</a>
						</li>
						<!-- 
						<li class="layui-nav-item layui-hide-xs" lay-unselect>
							<input type="text" placeholder="搜索..." autocomplete="off" class="layui-input layui-input-search" layadmin-event="serach" lay-action="template/search.html?keywords=">
						</li>
						 -->
					</ul>
					<ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">
						<!-- 
						<li class="layui-nav-item" lay-unselect>
							<a lay-href="app/message/index.html" layadmin-event="message" lay-text="消息中心">
								<i class="layui-icon layui-icon-notice"></i>

								如果有新消息，则显示小圆点
								<span class="layui-badge-dot"></span>
							</a>
						</li>
						<li class="layui-nav-item layui-hide-xs" lay-unselect>
							<a href="javascript:;" layadmin-event="theme">
								<i class="layui-icon layui-icon-theme"></i>
							</a>
						</li>
						 -->
						<li class="layui-nav-item layui-hide-xs" lay-unselect>
							<a href="javascript:;" layadmin-event="note">
								<i class="layui-icon layui-icon-note"></i>
							</a>
						</li>
						<li class="layui-nav-item layui-hide-xs" lay-unselect>
							<a href="javascript:;" layadmin-event="fullscreen">
								<i class="layui-icon layui-icon-screen-full"></i>
							</a>
						</li>
						<li class="layui-nav-item" lay-unselect>
							<a href="javascript:;">
								<cite>${agent_channel_sessionid.agentName}</cite>
							</a>
							<dl class="layui-nav-child">
								<!-- 
								<dd>
									<a lay-href="/user/info">基本资料</a>
								</dd>
								
								<dd layadmin-event="refreshResourceAuthority" style="text-align: center;">
									<a>刷新资源权限</a>
								</dd> -->
								<hr>
								<dd layadmin-event="logout" style="text-align: center;">
									<a>退出</a>
								</dd>
							</dl>
						</li>

						<li class="layui-nav-item layui-hide-xs" lay-unselect>
							<a href="javascript:;" layadmin-event="about1"><i class="layui-icon layui-icon-more-vertical"></i></a>
						</li>
						<li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect>
							<a href="javascript:;" layadmin-event="more"><i class="layui-icon layui-icon-more-vertical"></i></a>
						</li>
					</ul>
				</div>

				<!-- 侧边菜单 -->
				<div class="layui-side layui-side-menu">
					<div class="layui-side-scroll">
						<div class="layui-logo" lay-href="/doc.html">
							<span ><img src="${logo}"/></span>
						</div>
						<ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
							<li data-name="home" class="layui-nav-item layui-nav-itemed">
								<a href="javascript:;" lay-href="/doc.html"" lay-tips="主页" lay-direction="2">
									<i class="layui-icon layui-icon-home"></i>
									<cite>主页</cite>
								</a>
							</li>
							<c:forEach var="g" items="${menus}" varStatus="gr">
								<li data-name="user" class="layui-nav-item">
									<a href="javascript:;" lay-tips="${g.text}" lay-direction="2">
										<i class="layui-icon ${g.icon}"></i>
										<cite>${g.text}</cite>
									</a>
									<c:forEach var="chrild" items="${g.children }">
										<dl class="layui-nav-child">
											<dd>
												<a lay-href="${chrild.attributes.url}">${chrild.text}</a>
											</dd>
										</dl>
									</c:forEach> 
								</li>
							</c:forEach> 
						</ul>
					</div>
				</div>

				<!-- 页面标签 -->
				<div class="layadmin-pagetabs" id="LAY_app_tabs">
					<div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
					<div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
					<div class="layui-icon layadmin-tabs-control layui-icon-down">
						<ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
							<li class="layui-nav-item" lay-unselect>
								<a href="javascript:;"></a>
								<dl class="layui-nav-child layui-anim-fadein">
									<dd layadmin-event="closeThisTabs">
										<a href="javascript:;">关闭当前标签页</a>
									</dd>
									<dd layadmin-event="closeOtherTabs">
										<a href="javascript:;">关闭其它标签页</a>
									</dd>
									<dd layadmin-event="closeAllTabs">
										<a href="javascript:;">关闭全部标签页</a>
									</dd>
								</dl>
							</li>
						</ul>
					</div>
					<div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
						<ul class="layui-tab-title" id="LAY_app_tabsheader">
							<li lay-id="/doc.html" lay-attr="/doc.html" class="layui-this"><i class="layui-icon layui-icon-home"></i></li>
						</ul>
					</div>
				</div>

				<!-- 主体内容 -->
				<div class="layui-body" id="LAY_app_body">
					<div class="layadmin-tabsbody-item layui-show">
						<iframe src="/doc.html" frameborder="0" class="layadmin-iframe"></iframe>
					</div>
				</div>

				<!-- 辅助元素，一般用于移动设备下遮罩 -->
				<div class="layadmin-body-shade" layadmin-event="shade"></div>
			</div>
		</div>
	

		<script src="/static/layuiadmin/layui/layui.js"></script>
		<script>
			layui.config({
				base: '/static/layuiadmin/' //静态资源所在路径
			}).extend({
				index: 'lib/index' //主入口模块
			}).use('index', function(){ //
				  var $ = layui.jquery, layer = layui.layer; //
				  
				  var infoIndex = 0;
				  var closeWaitTime = 300;//300秒
				  
				  var manualClose = 0;//手动关闭标志
				  var loopTime = 0;
				  //触发事件
				  var active = {
				    offset: function(othis){
				      var type = othis.data('type')
				      ,text = othis.text();
				      
				    infoIndex =  layer.open({
				        type: 1
				        ,offset: type //
				        ,id: 'layerDemo'+type //防止重复弹出
				        ,content: '<div style="padding: 15px 60px;">'+ text +'</div>'
				        ,area: ['370px', '155px'] //宽高
				        ,btn: '关闭'
				        ,btnAlign: 'c' //按钮居中
				        ,shade: 0 //不显示遮罩
				        ,closeBtn :0//不显示关闭按钮
				        ,yes: function(){
				        	//alert('close')
				          manualClose = 1;
				          loopTime = 0;
				          //layer.close(infoIndex);
				          layer.closeAll();
				        }
				      });
				    }
				  };
				 
				  
				  
				  
			});
		</script>
	</body>

</html>