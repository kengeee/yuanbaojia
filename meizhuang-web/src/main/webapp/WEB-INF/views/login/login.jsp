<%@ page import="com.meizhuang.config.properties.PropertiesUtils"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String profile = PropertiesUtils.getProperty("spring.profiles.active");
	request.setAttribute("logo", "/static/images/" + profile + "/logo.png");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>猿报价管理后台</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" href="/static/layuiadmin/layui/css/layui.css" media="all">
		<link rel="stylesheet" href="/static/layuiadmin/style/admin.css" media="all">
		<link rel="stylesheet" href="/static/layuiadmin/style/login.css" media="all">
	</head>
	<body>
		<div class="login_text">
	    	<div class="left_logo" style="padding: 25px 0px;">
	        	<img src="${logo}"/>
	        </div>
	        <div class="right_text">
				<div class="layadmin-user-login-main">
					<div class="layadmin-user-login-box layadmin-user-login-body layui-form">
						<div class="layui-form-item">
							<label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-username"></label>
							<input type="text" name="username" id="LAY-user-login-username" lay-verify="required" placeholder="用户名" class="layui-input">
						</div>
						<div class="layui-form-item">
							<label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
							<input type="password" name="password" id="LAY-user-login-password" lay-verify="required" placeholder="密码" class="layui-input">
						</div>
						<div class="layui-form-item">
							<div class="layui-row">
								<div class="layui-col-xs7">
									<label class="layadmin-user-login-icon layui-icon layui-icon-vercode" for="LAY-user-login-vercode"></label>
									<input type="text" name="vercode" id="LAY-user-login-vercode" lay-verify="required" placeholder="图形验证码" class="layui-input">
								</div>
								<div class="layui-col-xs5">
									<div style="margin-left: 10px;">
										<img src="/captcha" class="layadmin-user-login-codeimg" id="LAY-user-get-vercode">
									</div>
								</div>
							</div>
						</div>
						<div class="layui-form-item" style="margin-bottom: 20px;">
							<!-- <input type="checkbox" name="remember" lay-skin="primary" title="记住密码"> -->
							<!-- <a href="forget.html" class="layadmin-user-jump-change layadmin-link" style="margin-top: 7px;">忘记密码？</a> -->
						</div>
						<div class="layui-form-item">
							<button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-login-submit">登 入</button>
						</div>
					</div>
				</div>
			</div>
	        <div class="footer">Copyright © 2015-2020 Kish Inc. All rights reserved.</div>
	    </div>
		<script src="/static/layuiadmin/layui/layui.js"></script>  
		<script>
			layui.config({
				base: '/static/layuiadmin/' //静态资源所在路径
			}).extend({
				index: 'lib/index' //主入口模块
			}).use(['index', 'user'], function() {
				var $ = layui.$,
					setter = layui.setter,
					admin = layui.admin,
					form = layui.form,
					router = layui.router(),
					search = router.search;
					form.render();
		
				//提交
				this.enterConfirm = function(event){
		            if(event.keyCode === 13){
		                $(".layui-btn-fluid").click();
		                return false; //阻止系统默认回车事件
		            }
		        };
				$(document).on('keydown', this.enterConfirm); //监听键盘事件
				form.on('submit(LAY-user-login-submit)', function(obj) {
					var index = layer.load(0); //添加laoding,0-2两种方式
					//请求登入接口
					$.post('/doLogin', obj.field,
						function(res) {
							layer.close(index);//返回数据关闭loading
							if(res.success) {
								//请求成功后，写入 access_token
								layui.data(setter.tableName, {
									key: setter.request.tokenName,
									value: res.data.access_token
								});
								//登入成功的提示与跳转
								layer.msg(res.msg, {
									/* offset: '15px', */
									icon: 1,
									time: 1000
								}, function() {
									location.href = '/index'; //后台主页
								});
							} else {
								layer.msg(res.msg, {icon: 5, time: 1000});
								document.getElementById("LAY-user-get-vercode").src="/captcha?t=" + (new Date).getTime();
							}
					});
				});
		
			});
			
			//验证码30秒自动刷新一次
			setTimeout(function() {
				document.getElementById("LAY-user-get-vercode").src="/captcha?t=" + (new Date).getTime();
			}, 30000);
		</script>
	</body>
</html>