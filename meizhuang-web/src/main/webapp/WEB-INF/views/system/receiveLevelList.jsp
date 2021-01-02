<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>收款账户级别管理</title>
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
	.limit {height:38px;line-height:38px;text-align:right;}
</style>
<body>

	<div class="layui-fluid">
		<div class="layui-row layui-col-space15">
			<div class="layui-col-md12">
				<div class="layui-card">
					<div class="layui-card-body">
						<table class="layui-hide" id="test-table-totalRow"
							lay-filter="test-table-totalRow"></table>
							<script type="text/html" id="test-table-totalRow-toolbarDemo">
								<div class="layui-btn-container">
									<button class="layui-btn layui-btn-sm layui-btn-normal"lay-event="addReceiveAccountLevel">添加</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateReceiveAccountLevel">修改</button>
								</div>
							</script>
							<script type="text/html" id="level">
								{{# if( d.level==1 ){	}}
										白银
								{{# }else if( d.level==2 ){	}}
										黄金
								{{# }else if( d.level==3 ){	}}
										铂金
								{{# }else if( d.level==4 ){	}}
										钻石
								{{# }else if( d.level=5 ){	}}
										王者
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
						url : '/lazy/receiveLevel/getReceiveLevel',
						method : 'post',
						title : '用户收款账号级别表',
						totalRow : false,
						cols : [ [
							{type:'checkbox',fixed:'left'},
					        {field:'level', title:'账户等级', toolbar:"#level", width:220,align:'center'},
					        {field:'grabNum', title:'当日允许最大匹配笔数', width:220,align:'center'},
					        {field:'receiveNum', title:'当日允许最大收款笔数', width:220,align:'center'},
					        {field:'receiveQuota', title:'当日允许总共收款金额', width:220,align:'center'},
					        {field:'receiveIntervalTime', title:'每笔收款间隔时间(分)', width:220,align:'center'},
					        {field:'receiveQrcodeNum', title:'收款二维码数量限制', width:220,align:'center'},
					        {field:'ctime', title:'创建时间', width:180,align:'center'},
					        {field:'mtime', title:'修改时间', width:220,align:'center'},
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
				        case 'addReceiveAccountLevel':
				        	layer.open({
								type: 1,
								title: "添加收款账户级别", 
								area : [ '450px', '480px' ], //宽高
								content:$("#addReceiveAccountLevel")
							});
				        break;
				        case 'updateReceiveAccountLevel':
				        	if(data.length<1){
				        		layer.msg('至少选择一项');
				        		return;
				        	}else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		return;
				        	}else{
				        		var id = data[0].id;
				        		var level = data[0].level;
				        		var receiveNum = data[0].receiveNum;
				        		var receiveQuota = data[0].receiveQuota;
				        		var receiveIntervalTime = data[0].receiveIntervalTime;
				        		var receiveQrcodeNum = data[0].receiveQrcodeNum;
				        		$(".id").val(id);
				        		$(".level").val(level);
				        		$(".receiveNum").val(receiveNum);
				        		$(".receiveQuota").val(receiveQuota);
				        		$(".receiveIntervalTime").val(receiveIntervalTime);
				        		$(".receiveQrcodeNum").val(receiveQrcodeNum);
				        		$(".grabNum").val(data[0].grabNum);
				        	}
				        	layer.open({
								type: 1,
								title: "修改", 
								area : [ '450px', '480px' ], //宽高
								content:$("#updateReceiveAccountLevel")
							});
				        break;
				      };
				    });
					
					//添加提交
					form.on('submit(addReceiveAccountLevel)', function(data) {
						if(!$("button[lay-filter='addReceiveAccountLevel']").hasClass("layui-btn-disabled")){
							$("button[lay-filter='addReceiveAccountLevel']").addClass("layui-btn-disabled").attr("disabled","disabled");
							$.post('/lazy/receiveLevel/add',
									data.field, function(res) {
										setTimeout(function(){
											$("button[lay-filter='addReceiveAccountLevel']").removeClass("layui-btn-disabled").removeAttr("disabled");
										},3000)
										var data = res;
										if (data.success) {
											layer.closeAll();
											layer.msg("审核操作成功", {
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
					form.on('submit(updateReceiveAccountLevel)', function(data) {
						$.post('/lazy/receiveLevel/update',
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
<!-- 添加代理商弹窗 -->
<div id="addReceiveAccountLevel" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label  layui-w160"><font style="color: #D82828">*</font>账户级别：</label>
			<div class="layui-input-block layui-w190" style="margin-left:190px">
				<select name="level" lay-filter="level">
					<option value="1">白银</option>
					<option value="2">黄金</option>
					<option value="3">铂金</option>
					<option value="4">钻石</option>
					<option value="5">王者</option>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label  layui-w160"><font
				style="color: #D82828">*</font>当日允许最大匹配笔数：</label>
			<div class="layui-input-inline">
				<input  type="text" name="grabNum" lay-verify="required"
					autocomplete="off" class="layui-input" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label  layui-w160"><font
				style="color: #D82828">*</font>当日允许最大收款笔数：</label>
			<div class="layui-input-inline">
				<input  type="text" name="receiveNum" lay-verify="required"
					autocomplete="off" class="layui-input" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label  layui-w160"><font
				style="color: #D82828">*</font>当日允许总共收款金额：</label>
			<div class="layui-input-inline">
				<input  type="text" name="receiveQuota" lay-verify="required"
					autocomplete="off" class="layui-input" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label  layui-w160"><font
				style="color: #D82828">*</font>每笔收款间隔时间：</label>
			<div class="layui-input-inline">
				<input  type="text" name="receiveIntervalTime" lay-verify="required"
					autocomplete="off" class="layui-input" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label  layui-w160"><font
				style="color: #D82828">*</font>收款二维码数量限制：</label>
			<div class="layui-input-inline">
				<input  type="text" name="receiveQrcodeNum" lay-verify="required"
					autocomplete="off" class="layui-input" />
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 40px">
			<div class="layui-input-block" style="margin-left: 130px;">
				<button class="layui-btn" lay-submit lay-filter="addReceiveAccountLevel">添加</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
	</form>
</div>
<!-- 修改弹窗 -->
<div id="updateReceiveAccountLevel" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
<!-- 		<div class="layui-inline layui-form-item">
			<span class="layui-input-inline limit"><font
				style="color: #D82828">*</font>账户级别：</span>
			<div class="layui-input-inline">
				<input type="text" name="level" lay-verify="required"
					autocomplete="off" class="layui-input level">
			</div>
		</div> -->
		<div class="layui-inline layui-form-item">
			<span class="layui-input-inline limit"><font
				style="color: #D82828">*</font>当日允许最大匹配笔数：</span>
			<div class="layui-input-inline">
				<input type="text" name="grabNum" lay-verify="required"
					autocomplete="off" class="layui-input grabNum">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<span class="layui-input-inline limit"><font
				style="color: #D82828">*</font>当日允许最大收款笔数：</span>
			<div class="layui-input-inline">
				<input type="text" name="receiveNum" lay-verify="required"
					autocomplete="off" class="layui-input receiveNum">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<span class="layui-input-inline limit"><font
				style="color: #D82828">*</font>当日允许总共收款金额：</span>
			<div class="layui-input-inline">
				<input type="text" name="receiveQuota" lay-verify="required"
					autocomplete="off" class="layui-input receiveQuota">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<span class="layui-input-inline limit"><font
				style="color: #D82828">*</font>每笔收款间隔时间：</span>
			<div class="layui-input-inline">
				<input type="text" name="receiveIntervalTime" lay-verify="required"
					autocomplete="off" class="layui-input receiveIntervalTime">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<span class="layui-input-inline limit"><font
				style="color: #D82828">*</font>收款二维码数量限制：</span>
			<div class="layui-input-inline">
				<input type="text" name="receiveQrcodeNum" lay-verify="required"
					autocomplete="off" class="layui-input receiveQrcodeNum">
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block" style="margin-left: 130px;">
				<button class="layui-btn" lay-submit lay-filter="updateReceiveAccountLevel">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
	</form>
</div>
</html>