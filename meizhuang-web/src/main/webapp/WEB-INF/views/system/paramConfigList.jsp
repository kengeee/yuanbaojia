<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>通用参数管理</title>
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
										<label class="layui-form-label">参数id</label>
										<div class="layui-input-inline">
											<input class="layui-input" name="id" autocomplete="off">
										</div>
									</div>
									<div class="layui-inline">
										<label class="layui-form-label">参数名</label>
										<div class="layui-input-inline">
											<input class="layui-input" name="name" autocomplete="off">
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
									<button class="layui-btn layui-btn-sm layui-btn-normal"lay-event="addParam">添加</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateParam">修改</button>
								</div>
							</script>
							<!-- 提现状态 -->
						<script type="text/html" id="status">
								{{# if( d.status==0 ){	}}
										启用
								{{# }else if( d.status==1 ){	}}
										禁用
								{{# }	}}
						</script>

						<!-- 抢单状态 -->
						<script type="text/html" id="type">
								{{# if( d.type==0 ){	}}
										微信
								{{# }else if( d.type==1 ){	}}
										支付宝
								{{# }else if( d.type==2 ){	}}
										银行卡
								{{# }	}}
						</script>
						
						<!-- 系统参数类型 -->
						<script type="text/html" id="status">
								{{# if( d.paramType==0 ){	}}
										用户参数
								{{# }else if( d.paramType==1 ){	}}
										代理参数
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
						url : '/flow/paramConfig/getParamConfig',
						method : 'post',
						title : '用户数据表',
						totalRow : false,
						cols : [ [
							{type:'checkbox',fixed:'left'},
							{field:'id', title:'参数id', width:80,align:'center'},
							{field:'name', title:'参数名', width:220,align:'center'},
							{field:'value', title:'参数值', width:300,align:'center'},
					        {field:'fieldName', title:'参数描述', width:450,align:'center'},
					        {field:'remake', title:'详细说明', width:450,align:'center'},
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
				        case 'addParam':
				        	layer.open({
								type: 1,
								title: "添加参数", 
								area : [ '420px', '350px' ], //宽高
								content:$("#addParam")
							});
				        break;
				        case 'updateParam':
				        	if(data.length<1){
				        		layer.msg('至少选择一项');
				        		return;
				        	}else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		return;
				        	}else{
				        		var id = data[0].id;
				        		var name = data[0].name;
				        		var value = data[0].value;
				        		var fieldName = data[0].fieldName;
				        		var remake = data[0].remake;
				        		$(".id").val(id);
				        		$(".name").val(name);
				        		$(".value").val(value);
				        		$(".fieldName").val(fieldName);
				        		$(".remake").val(remake);
				        	}
				        	layer.open({
								type: 1,
								title: "修改", 
								area : [ '420px', '350px' ], //宽高
								content:$("#updateParam")
							});
				        break;
				      };
				    });
					
					//添加提交
					form.on('submit(addParam)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						if(!$("button[lay-filter='addParam']").hasClass("layui-btn-disabled")){
							$("button[lay-filter='addParam']").addClass("layui-btn-disabled").attr("disabled","disabled");
							$.post('/flow/paramConfig/add',
									data.field, function(res) {
										setTimeout(function(){
											$("button[lay-filter='addParam']").removeClass("layui-btn-disabled").removeAttr("disabled");
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
					form.on('submit(updateParam)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						$.post('/flow/paramConfig/update',
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
<!-- 添加参数弹窗 -->
<div id="addParam" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label" ><font
				style="color: #D82828">*</font>参数名：</label>
			<div class="layui-input-inline">
				<input type="tel" name="name" lay-verify="required"
					autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>参数值：</label>
			<div class="layui-input-inline">
				<input type="text" name="value" lay-verify="required"
					autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>参数描述：</label>
			<div class="layui-input-inline">
				<input type="text" name="fieldName" lay-verify="required"
					autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>详细说明：</label>
			<div class="layui-input-inline">
				<input type="text" name="remake" lay-verify="required"
					autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 15px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="addParam">添加</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
	</form>
</div>
<!-- 修改参数弹窗 -->
<div id="updateParam" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label" ><font
				style="color: #D82828">*</font>参数名：</label>
			<div class="layui-input-inline">
				<input type="text" name="name" lay-verify="require" autocomplete="off"
					class="layui-input name">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>参数值：</label>
			<div class="layui-input-inline">
				<input type="text" name="value" lay-verify="required"
					autocomplete="off" class="layui-input value">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>参数描述：</label>
			<div class="layui-input-inline">
				<input type="text" name="fieldName" lay-verify="required"
					autocomplete="off" class="layui-input fieldName">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"><font
				style="color: #D82828">*</font>详细说明：</label>
			<div class="layui-input-inline">
				<input type="text" name="remake" lay-verify="required"
					autocomplete="off" class="layui-input remake">
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="updateParam">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
	</form>
</div>
</html>