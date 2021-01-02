<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>版本管理</title>
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

<body>

	<div class="layui-fluid">
		<div class="layui-row layui-col-space15">
			<div class="layui-col-md12">
				<div class="layui-card">
					<div class="layui-card-body">
						<div class="test-table-reload-btn" style="margin-bottom: 10px;">
							<form class="layui-form" action="" lay-filter="search">
									<div class="layui-inline">
										<label class="layui-form-label">版本号</label>
										<div class="layui-input-inline">
											<input class="layui-input" name="version" autocomplete="off">
										</div>
									</div>
									<div class="layui-inline">
										<label class="layui-form-label layui-w100">是否强制升级</label>
										<div class="layui-input-block" style="margin-left:130px">
									      	<select name="forceUpdate" lay-filter="forceUpdate">
									        	<option value="">全部</option>
									        	<option value="0">否</option>
									        	<option value="1">是</option>
									      	</select>
									    </div>
									</div>
									<div class="layui-inline">
										<label class="layui-form-label">系统类型</label>
										<div class="layui-input-block">
									      	<select name="osName" lay-filter="osName">
									        	<option value="">全部</option>
									        	<option value="android">android</option>
									        	<option value="ios">ios</option>
									      	</select>
									    </div>
									</div>
									<div class="layui-inline">
										<label class="layui-form-label">创建时间</label>
										<div class="layui-input-inline">
											<input type="text" class="layui-input" id="ctime" name="ctime"
												placeholder="yyyy-MM-dd" lay-key="1">
										</div>
									</div>
									<button class="layui-btn margin-l-10" lay-submit="" lay-filter="search">搜索</button>
								</form>
						</div>
						<table class="layui-hide" id="test-table-totalRow"
							lay-filter="test-table-totalRow"></table>
							<script type="text/html" id="test-table-totalRow-toolbarDemo">
								<div class="layui-btn-container">
									<button class="layui-btn layui-btn-sm layui-btn-normal"lay-event="addVersion">添加</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateVersion">修改</button>
								</div>
							</script>
							<script type="text/html" id="status">
								{{# if( d.forceUpdate==0 ){	}}
										否
								{{# }else if( d.forceUpdate==1 ){	}}
										是
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
				[ 'index', 'table', 'laydate','form' ],
				function() {
					var $ = layui.jquery;
					var table = layui.table;
					var form = layui.form;
					table.render({
						elem : '#test-table-totalRow',
						toolbar : '#test-table-totalRow-toolbarDemo',
						autoSort : false,
						url : '/flow/version/getVersionList',
						method : 'post',
						title : '版本管理表',
						totalRow : false,
						cols : [ [
							{type:'checkbox',fixed:'left'},
							{field:'id', title:'id', width:80,align:'center'},
							{field:'appName', title:'产品', width:120,align:'center'},
							{field:'version', title:'版本号', width:80,align:'center'},
							{field:'contentEn', title:'更新内容', width:250,align:'center'},
							{field:'downloadUrl', title:'下载地址', width:150,align:'center'},
					        {field:'forceUpdate', title:'是否强制升级', width:80,align:'center',templet: function(d){
					        	if(d.forceUpdate==0){
					        		return "否";
					        	}else if( d.forceUpdate==1){
					        		return "是";
					        	}else {
					        		return "------";
					        	}
					        }},
					        {field:'osName', title:'系统类型', width:80,align:'center'},
					        {field:'ctime', title:'创建时间', width:180,align:'center'},
					        {field:'mtime', title:'修改时间', width:180,align:'center'},
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
					
					//表单重新渲染
					function renderForm() {
						layui.use('form', function() {
							var form = layui.form;
							form.render();
						});
					}
					
					
					//获取APP名称
					$.post("/flow/frame/getAllAppProduct",{}, function(data1) {
									if(data1.success) {
										console.log(data1);
										var data1 = data1.data;
										var passTypeOpt = "<option value=''>请选择</option>";
										for(var i = 0; i < data1.length; i++) {
											passTypeOpt += '<option value="' + data1[i].appId + '">' + data1[i].appName + '</option>';		
										}
										$("select[name='appId']").html(passTypeOpt);
										renderForm();
									} else {
										layer.msg(data1.msg, {
											icon: 5
										});
									}
								});
					
					
					//监听提交
					var form = layui.form;
					form.on('submit(search)', function(data) {
						//执行重载
						table.reload('test-table-totalRow', {
							page : {
								curr : 1
							//重新从第 1 页开始
							},
							where : data.field
						});
						return false;
					});

					//头工具栏事件
				    table.on('toolbar(test-table-totalRow)', function(obj){
				      var checkStatus = table.checkStatus(obj.config.id);
				      var data = checkStatus.data;
				      switch(obj.event){
				        case 'addVersion':
				        	layer.open({
								type: 1,
								title: "添加版本", 
								area : [ '420px', '520px' ], //宽高
								content:$("#addVersion")
							});
				        break;
				        case 'updateVersion':
				        	if(data.length<1){
				        		layer.msg('至少选择一项');
				        		return;
				        	}else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		return;
				        	}else{
				        		var id = data[0].id;
				        		var version = data[0].version;
				        		var contentEn = data[0].contentEn;
				        		var downloadUrl = data[0].downloadUrl;
				        		var forceUpdate = data[0].forceUpdate;
				        		var appId = data[0].appId;
				        		var osName = data[0].osName;
				        		$(".id").val(id);
				        		$(".contentEn").val(contentEn);
				        		$(".downloadUrl").val(downloadUrl);
				        		$(".forceUpdate").val(forceUpdate);
				        		$("#updateVersion select[name='osName']").val(osName);
				        		$("#updateVersion select[name='appId']").val(appId);
				        		renderForm()
				        	}
				        	layer.open({
								type: 1,
								title: "修改版本", 
								area : [ '420px', '480px' ], //宽高
								content:$("#updateVersion")
							});
				        break;
				      };
				    });
					
					//添加提交
					form.on('submit(addVersion)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						if(!$("button[lay-filter='addVersion']").hasClass("layui-btn-disabled")){
							$("button[lay-filter='addVersion']").addClass("layui-btn-disabled").attr("disabled","disabled");
							$.post('/flow/version/add',
									data.field, function(res) {
										setTimeout(function(){
											$("button[lay-filter='addVersion']").removeClass("layui-btn-disabled").removeAttr("disabled");
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
					form.on('submit(updateVersion)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						$.post('/flow/version/update',
								data.field, function(res) {
									var data = res;
									if (data.success) {
										layer.closeAll();
										layer.msg("操作成功", {
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
					
					//日期时间选择器
					var laydate = layui.laydate;
					laydate.render({
						elem : '#ctime',
						range: '~',
						type: 'datetime'
					});
					//关闭弹窗
					$('.closeBtn').click(function() {
						layer.closeAll();
					});
				});
	</script>

</body>
<!-- 添加版本弹窗 -->
<div id="addVersion" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>产品id：</label>
			<div class="layui-input-inline">
				<select name="appId" lay-filter="appId" lay-verify="required">
				
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label" ><font
				style="color: #D82828">*</font>版本号：</label>
			<div class="layui-input-inline">
				<input type="tel" name="version" lay-verify="required"
					autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>更新内容：</label>
			<div class="layui-input-inline">
				<textarea  type="text" name="contentEn" lay-verify="required"
					autocomplete="off" class="layui-textarea"></textarea>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>下载地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="downloadUrl" lay-verify="required"
					autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font style="color: #D82828">*</font>强制更新：</label>
			<div class="layui-input-block">
				<select name="forceUpdate" lay-filter="forceUpdate">
					<option value="1">是</option>
					<option value="0" selected="selected">否</option>
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font style="color: #D82828">*</font>系统类型：</label>
			<div class="layui-input-block">
				<select name="osName" lay-filter="osName">
					<option value="android">android</option>
					<option value="ios">ios</option>
				</select>
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 15px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="addVersion">添加</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
	</form>
</div>
<!-- 修改版本弹窗 -->
<div id="updateVersion" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>产品id：</label>
			<div class="layui-input-inline">
				<select name="appId" lay-filter="appId" lay-verify="required">
				
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>更新内容：</label>
			<div class="layui-input-inline">
				<textarea  type="text" name="contentEn" lay-verify="required"
					autocomplete="off" class="layui-textarea contentEn"></textarea>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>下载地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="downloadUrl" lay-verify="required"
					autocomplete="off" class="layui-input downloadUrl">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font style="color: #D82828">*</font>强制更新：</label>
			<div class="layui-input-block">
				<select name="forceUpdate" lay-filter="forceUpdate">
					<option value="1">是</option>
					<option value="0" selected="selected">否</option>
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font style="color: #D82828">*</font>系统类型：</label>
			<div class="layui-input-block">
				<select name="osName" lay-filter="osName">
					<option value="android">android</option>
					<option value="ios">ios</option>
				</select>
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="updateVersion">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
	</form>
</div>
</html>