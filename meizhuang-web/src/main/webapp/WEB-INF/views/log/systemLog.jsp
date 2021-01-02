<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>管理员日志管理</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="/static/layuiadmin/layui/css/layui.css" media="all">
		<link rel="stylesheet" href="/static/layuiadmin/style/admin.css" media="all">
		<link rel="stylesheet" href="/static/css/user.css" media="all">
	</head>

	<body>

		<div class="layui-fluid">
			<div class="layui-row layui-col-space15">
				<div class="layui-col-md12">
					<div class="layui-card">
						<div class="layui-card-body">
							<div class="test-table-reload-btn">
								<form class="layui-form" action="" lay-filter="search">
									<div class="layui-form-item">
										<div class="layui-inline" id="type">
											<label class="layui-form-label">操作类型</label>
											<div class="layui-input-block">
												<select name="operationType" lay-filter="operationType"></select>
											</div>
										</div>
							            <div class="layui-inline">
							              	<label class="layui-form-label">操作内容</label>
							              	<div class="layui-input-inline">
							                	<input class="layui-input" name="content"  autocomplete="off">
							                </div>
							            </div>
							            <div class="layui-inline">
							              	<label class="layui-form-label">操作IP</label>
							              	<div class="layui-input-inline">
							                	<input class="layui-input" name="ip"  autocomplete="off">
							                </div>
							            </div>
										<div class="layui-inline">
							              	<label class="layui-form-label">操作人</label>
							              	<div class="layui-input-inline">
							                	<input class="layui-input" name="cman"  autocomplete="off">
							                </div>
							            </div>
						            </div>
						            <div class="layui-form-item">
										<div class="layui-inline">
											<label class="layui-form-label">操作时间</label>
											<div class="layui-input-inline">
												<input type="text" name="ctime" class="layui-input" id="ctime-datetime" placeholder="" lay-key="17">
											</div>
										</div>
										<button class="layui-btn" lay-submit="" lay-filter="search">搜索</button>
									</div>
                                </form>
                            </div>
							<table class="layui-hide" id="table" lay-filter="table"></table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script src="/static/layuiadmin/layui/layui.js"></script>
		<script>
			layui.config({
				base: '/static/layuiadmin/' //静态资源所在路径
			}).extend({
				index: 'lib/index' //主入口模块
			}).use(['index', 'table', 'laydate', 'form'], function() {
				var $ = layui.jquery;
				var admin = layui.admin;
				var table = layui.table;
				//表单重新渲染
				function renderForm() {
					layui.use('form', function() {
						var form = layui.form;
						form.render();
					});
				}
				//获取操作类型
				$.post("/flow/getSystemOperationTypes", function(data) {
					if(data.success) {
						var data = data.data;
						var opt = "";
						var optAll = "";
						optAll = '<option value="">全部</option>';
						for(var i = 0; i < data.length; i++) {
							opt += '<option value="' + data[i].type + '">' + data[i].desc + '</option>';
						}
						$("select[name='operationType']").html(optAll + opt);
						renderForm();
					} else {
						layer.msg(data.msg, {
							icon: 5
						});
					}
				});
				
				table.render({
					elem: '#table',
					url: '/flow/systemLog/getSystemLogs',
					method: 'post',
					title: '用户数据表',
					totalRow: false,
					autoSort: false,
					initSort: {field:'id', type:'desc'},
					where: {sortField:'id', sortType:'desc'},
					cols: [[
				          {field:'id', title:'日志编号', width:120,align:'center',sort: true,fixed:'left'},
				          {field:'operationTypeDesc', title:'操作类型', width:150,align:'center', sort: false,fixed:'left'},
				          {field:'content', title:'操作描述', width:400,align:'center', sort: false},
				          {field:'runTime', title:'业务处理时间', width:150,align:'center', sort: true, templet: function(d){
				          		return d.runTime + ' ms';
					      }},
				          {field:'ip', title:'操作IP', width:150,align:'center', sort: false},
				          {field:'cman', title:'操作人', width:150,align:'center', sort: true},
				          {field:'ctime', title:'操作时间', width:180,align:'center', sort: true},
				          {field:'url', title:'请求URL', width:150,align:'center', sort: false},
				          {field:'method', title:'方法名', width:250,align:'center', sort: false},
				          {field:'params', title:'参数', width:150,align:'center', sort: false},
				          {field:'returnValue', title:'方法返回值', width:150,align:'center', sort: false}
					]],
					page: true
				});

				table.on('sort(table)', function(obj) {
					table.reload('table', {
						initSort: obj,
						where: {
							sortField: obj.field,
							sortType: obj.type
						}
					});
				});

				//监听提交
				var form = layui.form;
				form.on('submit(search)', function(data) {
					//执行重载
			        table.reload('table', {
						page: { curr: 1 },  //重新从第 1 页开始
						where:data.field
			        });
					return false;
				});

				//日期时间选择器
				layui.laydate.render({elem: '#ctime-datetime', range: '~' });
			});
		</script>

	</body>

</html>