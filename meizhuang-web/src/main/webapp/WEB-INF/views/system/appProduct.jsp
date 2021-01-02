<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>产品管理</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="stylesheet" href="/static/layuiadmin/layui/css/layui.css"
	media="all">
<link rel="stylesheet" href="/static/layuiadmin/style/admin.css"
	media="all">
<link rel="stylesheet" href="/static/css/user.css" media="all">
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

	<div class="layui-fluid">
		<div class="layui-row layui-col-space15">
			<div class="layui-col-md12">
				<div class="layui-card">
					<div class="layui-card-body">
						<div class="test-table-reload-btn" style="margin-bottom: 10px;"></div>
						<table class="layui-hide" id="test-table-totalRow"
							lay-filter="test-table-totalRow"></table>
							<script type="text/html" id="test-table-totalRow-toolbarDemo">
								<div class="layui-btn-container">
									<button class="layui-btn layui-btn-sm layui-btn-normal"lay-event="addApp">添加</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateApp">修改</button>
								</div>
							</script>
							<!-- 图标 -->
						<script type="text/html" id="appIcon">
								{{# if( d.appIcon==null || d.appIcon==undefined || d.appIcon=="" ){	}}

								{{# }else{	}}
									<div class="layui-list-icon"><img src="{{ d.appIcon }}"  lay-event="photoDetails"/></div>
								{{# }	}}
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="/static/layuiadmin/layui/layui.js"></script>
	<script>
		layui.config({
			base : '/static/layuiadmin/' //静态资源所在路径
		}).extend({
			index : 'lib/index' //主入口模块
		}).use(
				[ 'index', 'table', 'form','upload' ],
				function() {
					var $ = layui.jquery;
					var table = layui.table;
					var form = layui.form;
					table.render({
						elem : '#test-table-totalRow',
						toolbar : '#test-table-totalRow-toolbarDemo',
						autoSort : false,
						url : '/flow/appProduct/getAppProducts',
						method : 'post',
						title : '用户数据表',
						totalRow : false,
						cols : [ [
							{type:'checkbox',fixed:'left'},
							{field:'appName', title:'产品名称', width:150,align:'center'},
					        {title:'产品图标',toolbar:"#appIcon", width:120,align:'center'},
					        {field:'appDownloadUrl', title:'产品下载地址', width:250,align:'center'},
					        {field:'appDomainUrl', title:'产品域名地址', width:250,align:'center'},
					        {field:'agentServerIp', title:'代理服务ip', width:250,align:'center'},
					        {field:'serverUrl', title:'API服务器ip', width:250,align:'center'},
					        {field:'appDesc', title:'产品描述', width:180,align:'center'},
					        {field:'status', title:'状态', width:180,align:'center',templet: function(d){
					        	if(d.status==1){
					        		return "开启";
					        	}else if( d.status==2){
					        		return "禁用";
					        	}else {
					        		return "------";
					        	}
					        }},
					        {field:'ctime', title:'添加时间', width:220,align:'center'},
					        {field:'appVersion', title:'最新版本号', width:125,align:'center'}
						] ],
						page : true
					});

					table.on('sort(test-table-totalRow)', function(obj) {
						table.reload('test-table-totalRow', {
							initSort : obj,
							where : {
								sortField : obj.field,
								sortType : obj.type
							}
						});
					});

					//头工具栏事件
				    table.on('toolbar(test-table-totalRow)', function(obj){
				      var checkStatus = table.checkStatus(obj.config.id);
				      var data = checkStatus.data;
				      switch(obj.event){
				        case 'addApp':
				        	layer.open({
								type: 1,
								title: "添加", 
								area : [ '450px', '640px' ], //宽高
								content:$("#addApp")
							});
				        break;
				        case 'updateApp':
				        	if(data.length<1){
				        		layer.msg('至少选择一项');
				        		break;
				        	}else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		break;
				        	}else{
				        		var uid = data[0].uid;
				        		var appId = data[0].appId;
				        		var appName = data[0].appName;
				        		var appDesc = data[0].appDesc;
				        		var icon = data[0].appIcon;
				        		var appDownloadUrl = data[0].appDownloadUrl;
				        		var appDomainUrl = data[0].appDomainUrl;
				        		var agentServerIp = data[0].agentServerIp;
				        		var serverUrl = data[0].serverUrl;
				        		var status = data[0].status;
				        		$("#demo2").attr("src",icon);
				        		$("#updateApp input[name='appName']").val(appName);
				        		$("#updateApp input[name='appDesc']").val(appDesc);
				        		$("#updateApp input[name='appDownloadUrl']").val(appDownloadUrl);
				        		$("#updateApp input[name='appDomainUrl']").val(appDomainUrl);
				        		$("#updateApp input[name='agentServerIp']").val(agentServerIp);
				        		$("#updateApp input[name='serverUrl']").val(serverUrl);
				        		$("#updateApp select[name='status']").val(status);
				        		$(".uid").val(uid);
				        		$(".appId").val(appId);
				        		$(".appIcon").val(icon);
				        	}
				        	layer.open({
								type: 1,
								title: "修改", 
								area : [ '450px', '700px' ], //宽高
								content:$("#updateApp")
							});
				        break;
				      };
				    });
					
				  //图片上传
				  	var upload = layui.upload;
				    var uploadInst = upload.render({
				      elem: '#test1,#test2'
				      ,url: '/file/uploadImageToYun'
				      ,before: function(obj){
				        //预读本地文件示例，不支持ie8
				        obj.preview(function(index, file, result){
				          $('#demo1,#demo2').attr('src', result); //图片链接（base64）
				        });
				      }
				      ,done: function(res){
				        //如果上传失败
				        if(res.code > 0){
				          return layer.msg('上传失败');
				        }
				        //上传成功
				        $(".appIcon").val(res.data);
				      }
				      ,error: function(){
				        //演示失败状态，并实现重传
				        var demoText = $('#demoText');
				        demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
				        demoText.find('.demo-reload').on('click', function(){
				          uploadInst.upload();
				        });
				      }
				    });

					//添加提交
					form.on('submit(addApp)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						if(!$("button[lay-filter='addApp']").hasClass("layui-btn-disabled")){
							$("button[lay-filter='addApp']").addClass("layui-btn-disabled").attr("disabled","disabled");
							$.post('/flow/appProduct/addAppProduct',
									data.field, function(res) {
										setTimeout(function(){
											$("button[lay-filter='addApp']").removeClass("layui-btn-disabled").removeAttr("disabled");
										},3000)
										var data = res;
										if (data.success) {
											layer.closeAll();
											layer.msg(data.msg, {
												icon : 6
											});
											table.reload('test-table-totalRow');
										} else {
											layer.msg(data.msg, {
												icon : 5
											});
										}
									});
							return false;
						}
					});
					
					//修改提交
					form.on('submit(updateApp)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						$.post('/flow/appProduct/updateAppProduct',
								data.field, function(res) {
									var data = res;
									if (data.success) {
										layer.closeAll();
										layer.msg(data.msg, {
											icon : 6
										});
										table.reload('test-table-totalRow');
									} else {
										layer.msg(data.msg, {
											icon : 5
										});
									}
								});
						return false;
					});
					//关闭弹窗
					$('.closeBtn').click(function() {
						layer.closeAll();
					});
				});
	</script>

</body>
<!-- 添加弹窗 -->
<div id="addApp" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px"><font
				style="color: #D82828">*</font>产品名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="appName" lay-verify="require" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item" style="margin-bottom: 30px;">
			<label class="layui-form-label" style="width:120px">产品图标：</label>
			<div class="layui-upload">
			  <button type="button" class="layui-btn" id="test1">上传图片</button>
			  <div class="layui-upload-list layui-little-ico">
			    <img class="layui-upload-img" id="demo1">
			    <p id="demoText"></p>
			  </div>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px">产品下载地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="appDownloadUrl" lay-verify="" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px">产品域名地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="appDomainUrl" lay-verify="" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px">代理服务ip：</label>
			<div class="layui-input-inline">
				<input type="text" name="agentServerIp" lay-verify="" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px">API服务器IP：</label>
			<div class="layui-input-inline">
				<input type="text" name="serverUrl" lay-verify="" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px">产品描述：</label>
			<div class="layui-input-inline">
				<input type="text" name="appDesc" lay-verify="" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="addApp">添加</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="uid" class="uid" />
		<input type="hidden" name="appIcon" class="appIcon" />
	</form>
</div>
<!-- 修改弹窗 -->
<div id="updateApp" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px"><font
				style="color: #D82828">*</font>产品名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="appName" lay-verify="require" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item" style="margin-bottom: 30px;">
			<label class="layui-form-label" style="width:120px">产品图标：</label>
			<div class="layui-upload">
			  <button type="button" class="layui-btn" id="test2">上传图片</button>
			  <div class="layui-upload-list layui-little-ico">
			    <img class="layui-upload-img" id="demo2">
			    <p id="demoText"></p>
			  </div>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px">产品下载地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="appDownloadUrl" lay-verify="" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px">产品域名地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="appDomainUrl" lay-verify="" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px">代理服务ip：</label>
			<div class="layui-input-inline">
				<input type="text" name="agentServerIp" lay-verify="" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px">API服务器IP：</label>
			<div class="layui-input-inline">
				<input type="text" name="serverUrl" lay-verify="" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width:120px">产品描述：</label>
			<div class="layui-input-inline">
				<input type="text" name="appDesc" lay-verify="" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label" style="width:120px"><font style="color: #D82828">*</font>状态：</label>
			<div class="layui-input-inline">
				<select name="status" lay-filter="status">
					<option value="1">开启</option>
					<option value="2">禁用</option>
				</select>
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="updateApp">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="uid" class="uid" />
		<input type="hidden" name="appId" class="appId" />
		<input type="hidden" name="appIcon" class="appIcon" />
	</form>
</div>
</html>