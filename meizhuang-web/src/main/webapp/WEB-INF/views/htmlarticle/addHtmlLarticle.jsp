<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>添加HTML文章管理</title>
<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="/static/layuiadmin/layui/css/layui.css" media="all">
		<link rel="stylesheet" href="/static/layuiadmin/style/admin.css" media="all">
		<link rel="stylesheet" href="/static/css/user.css" media="all">
		<link rel="stylesheet" href="/static/kindeditor/themes/default/default.css" />
		<link rel="stylesheet" href="/static/kindeditor/plugins/code/prettify.css" />
		<script charset="utf-8" src="/static/kindeditor/kindeditor-all-min.js"></script>
		<script charset="utf-8" src="/static/kindeditor/lang/zh-CN.js"></script>
		<script charset="utf-8" src="/static/kindeditor/plugins/code/prettify.js"></script>
		
	<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="content1"]', {
				cssPath : '/static/kindeditor/plugins/code/prettify.css',
				uploadJson : '/upload_json.jsp',
				fileManagerJson : '/file_manager_json.jsp',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['content'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['content'].submit();
					});
				}
			});
			prettyPrint();
		});
	</script>
	<script>
		function back()
		{
			var r=confirm("你正在编辑内容，是否返回到内容列表?")
  		    if (r==true){
  		    	window.location.href = '/flow/html/htmlLarticleList';
  		    }else{
  		    
  		    }
		}
	</script>
</head>
<style>
.layui-upload-list{ float:left;width:280px;}
.layui-upload-list img{width:100%;margin-bottom:15px}
.readonlyInput{border:0;border-bottom:1px solid #e6e6e6}
.layui-little-ico{width: 100px;height:100px;margin-left:150px;border:1px solid #C0C0C0}
.layui-list-icon{width:20px;}
.layui-list-icon img{width:100%};
</style>
<body>
<div style="padding: 50px">
<form name="content" method="post" action="${actionUrl}">
             <div style="margin-bottom: 10px">
					<label class="" style="height: 35px; line-height: 35px;">标题:</label>
					<input style="height: 35px; line-height: 35px; width: 520px;" name="title" autocomplete="off" value="${htmlArticle.title}">
			</div>
			<div style="margin-bottom: 10px">
					<label class="" style="height: 35px; line-height: 35px;">分类:</label>
					<select name="type" lay-filter="type" style="height: 35px; line-height: 35px; width: 520px;">
						<option value="1"<c:if test="${htmlArticle.type == 1}">selected="selected"</c:if> >跨境物流</option>
						<option value="2"<c:if test="${htmlArticle.type == 2}">selected="selected"</c:if> >跑腿代发</option>
						<option value="3"<c:if test="${htmlArticle.type == 3}">selected="selected"</c:if> >广告跳转</option>
						<option value="4"<c:if test="${htmlArticle.type == 4||htmlArticle==null}">selected="selected"</c:if> >其它</option>
						<option value="5"<c:if test="${htmlArticle.type == 5}">selected="selected"</c:if> >关于我们</option>
						<option value="6"<c:if test="${htmlArticle.type == 6}">selected="selected"</c:if> >商务合作</option>
						<option value="7"<c:if test="${htmlArticle.type == 7}">selected="selected"</c:if> >服务条款</option>
						<option value="8"<c:if test="${htmlArticle.type == 8}">selected="selected"</c:if> >法律声明</option>
						<option value="9"<c:if test="${htmlArticle.type == 9}">selected="selected"</c:if> >秒换侠</option>
						<option value="10"<c:if test="${htmlArticle.type == 10}">selected="selected"</c:if> >回收猿</option>
						<option value="11"<c:if test="${htmlArticle.type == 11}">selected="selected"</c:if> >商家群</option>
				    </select>
			</div>
        
		<textarea name="content1" cols="100" rows="8" style="width:90%;height:650px;visibility:hidden;">${htmlArticle.text}</textarea>
		<br />
		<input class="layui-btn" type="button" name="back_but" value="返回" onclick="back()"/>
		<input class="layui-btn" type="submit" name="submit" value="提交内容" /> (提交快捷键: Ctrl + Enter)
		<input type="hidden" name="id" value="${htmlArticle.id}"/>
		 
</form>
</div>
</body>
</html>


<%!
private String htmlspecialchars(String str) {
    if(str== null){
    return "";
    }
	str = str.replaceAll("&", "&amp;");
	str = str.replaceAll("<", "&lt;");
	str = str.replaceAll(">", "&gt;");
	str = str.replaceAll("\"", "&quot;");
	return str;
}
%>