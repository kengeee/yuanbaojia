<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>跳转管理</title>
<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="/static/layuiadmin/layui/css/layui.css" media="all">
		<link rel="stylesheet" href="/static/layuiadmin/style/admin.css" media="all">
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
						<div class="test-table-reload-btn" style="margin-bottom: 10px;">
							
						</div>
						<table class="layui-hide" id="test-table-totalRow"
							lay-filter="test-table-totalRow"></table>
							<script type="text/html" id="test-table-totalRow-toolbarDemo">
								<div class="layui-btn-container">
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="addSectionUI">添加</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateSectionUI">修改</button>
								</div>
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
				[ 'index', 'table','form','upload' ],
				function() {
					var $ = layui.jquery;
					var table = layui.table;
					var form = layui.form;
					//表单重新渲染
					function renderForm() {
						layui.use('form', function() {
							var form = layui.form;
							form.render();
						});
					}
					
					
					table.render({
						elem : '#test-table-totalRow',
						toolbar : '#test-table-totalRow-toolbarDemo',
						defaultToolbar:'',
						autoSort : false,
						url : '/flow/sectionUI/getSectionUiList',
						method : 'post',
						title : '用户数据表',
						totalRow : false,
						cols : [ [
							{type:'checkbox',fixed:'left'},
							{field:'name', title:'UI名称', width:180,align:'center'},
					        {field:'url', title:'跳转链接', width:200,align:'center'},
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
					
					//监听提交
					var form = layui.form;
					form.on('submit(search)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'})
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
				        case 'addSectionUI':
				        	layer.open({
								type: 1,
								title: "添加UI跳转", 
								area : [ '420px', '300px' ], //宽高
								content:$("#addSectionUI")
							});
				        break;
				        case 'updateSectionUI':
				        	if(data.length<1){
				        		layer.msg('至少选择一项');
				        		return;
				        	}else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		return;
				        	}else{
				        		var id = data[0].id;
				        		var name = data[0].name;
				        		var url = data[0].url;
				        		
				        		$("#updateSectionUI input[name='id']").val(id);
				        		$("#updateSectionUI input[name='name']").val(name);
				        		$("#updateSectionUI input[name='url']").val(url);			        		 
				        		renderForm()
				        	}
				        	layer.open({
								type: 1,
								title: "修改模板", 
								area : [ '420px', '300px' ], //宽高
								content:$("#updateSectionUI")
							});
				        break;
				      };
				    });
					
				
					
					//添加提交
					form.on('submit(addSectionUI)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						
							$.post('/flow/sectionUI/addSectionUi',
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
					
					//修改提交
					form.on('submit(updateSectionUI)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						$.post('/flow/sectionUI/updateSectionUi',
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
					
					
					
					
					//关闭弹窗
					$('.closeBtn').click(function() {
						layer.closeAll();
					});
					
					
					
					
					
				});
	</script>
	
</body>
<!-- 添加模板弹窗 -->
<div id="addSectionUI" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>跳转UI名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="name" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>

		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>跳转UI地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="url" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
			
		</div>
		
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="addSectionUI">添加</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
		<input type="hidden" name="uid" class="uid" />
	</form>
</div>
<!-- 修改弹窗 -->
<div id="updateSectionUI" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>跳转UI名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="name" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>

		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>跳转UI地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="url" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
			
		</div>
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="updateSectionUI">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
		<input type="hidden" name="uid" class="uid" />
	</form>
</div>
</html>