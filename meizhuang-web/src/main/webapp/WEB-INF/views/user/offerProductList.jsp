<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>商户产品列表</title>
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
							<div class="test-table-reload-btn" style="margin-bottom: 10px;">
								<form class="layui-form" action="" lay-filter="search">
								
								<div class="layui-inline layui-form-item">
									<label class="layui-form-label">手机号</label>
									<div class="layui-input-inline">
										<input class="layui-input" name="mobile"
											autocomplete="off">
									</div>
								</div>
								<div class="layui-inline layui-form-item">
									<label class="layui-form-label">市场档口</label>
									<div class="layui-input-inline">
										<input class="layui-input" name=tradeStall
											autocomplete="off">
									</div>
								</div>
								
								<div class="layui-inline layui-form-item">
									<label class="layui-form-label">更新时间</label>
									<div class="layui-input-inline">
										<input type="text" class="layui-input" id="ctime" name="sctime"
											placeholder="yyyy-MM-dd" lay-key="1">
									</div>
								</div>
								<button class="layui-btn layui-form-item margin-l-10"
									lay-submit="" lay-filter="search">搜索</button>
							</form>
							</div>
							<table class="layui-hide" id="test-table-totalRow" lay-filter="test-table-totalRow"></table>
							<script type="text/html" id="test-table-totalRow-toolbarDemo">
								<div class="layui-btn-container">
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="batchDel">批量删除</button>
									
								</div>
							</script>
							<!-- 商户状态 -->
						<script type="text/html" id="status">
								{{# if( d.status==0 ){	}}
										开启
								{{# }else if( d.status==1 ){	}}
										关闭
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
				base: '/static/layuiadmin/' //静态资源所在路径
			}).extend({
				index: 'lib/index' //主入口模块
			}).use(['index', 'table', 'laydate', 'form'], function() {
				var $ = layui.jquery;
				var table = layui.table;
				
				//表单重新渲染
				function renderForm() {
					layui.use('form', function() {
						var form = layui.form;
						form.render();
					});
				}
				
				table.render({
					elem: '#test-table-totalRow',
					toolbar:'#test-table-totalRow-toolbarDemo',
					autoSort: false,
					url: '/flow/offerProduct/getOfferProducts',
					method: 'post',
					title: '商户产品数据表',
					totalRow: true,
					initSort: {field:'ctime', type:'desc'},
					where: {sortField:'ctime', sortType:'desc',merchantType:'1001'},
					cols: [[
						  {type:'checkbox',fixed:'left'},
						  {field:'uid', title:'商户ID', width:'80',align:'center'},
						  {field:'mobile', title:'手机号', width:'200',align:'center'},
						  {field:'tradeStall', title:'市场档口位置', width:'230',align:'center'},
						  {field:'offerProduct', title:'产品+报价', width:'380',align:'center'},  
						  {field:'gatherPrice', title:'采集价格', width:'180',align:'center'},  
						  {field:'ctime', title:'创建时间', width:'170',align:'center',sort:true},
						  {field:'mtime', title:'更新时间', width:'170',align:'center',sort:true},
						  
				          
				    ]],
					page: true
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

				//日期时间选择器
				var laydate = layui.laydate;
				laydate.render({
					elem : '#ctime',
					range: '~',
					type: 'datetime'
				});

				//头工具栏事件
			    table.on('toolbar(test-table-totalRow)', function(obj){
			      var checkStatus = table.checkStatus(obj.config.id);
			      var data = checkStatus.data;
			      switch(obj.event){
			       
			        case 'updateMerchant':
			        	if(data.length<1){
			        		layer.msg('至少选择一项');
			        		break;
			        	}else{
			        		
			        		renderForm();
			        	}
			        	
			        break;
			        
			        case 'batchDel':
							if(data.length < 1) {
								layer.msg('至少选择一项');
								return;
							}
							//var uids = "-1";
							var ids = "-1";
							for(var i = 0; i < data.length; i++) {
								//uids.push(data[i].uid);
								ids += ","+data[i].id;
							}
							
							layer.confirm('请确认选择的产品删除?', function(index){
								var jsonD = {
										ids:ids
								}
								$.post('/flow/offerProduct/batchDel', jsonD,
										function(res) {
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
								layer.close(index);
								return false;
							});
							
						break;
			      };
			    });
				
			  
				//修改提交
				form.on('submit(updateMerchant)', function(data) {
					//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
					$.post('/flow/userInfo/updateStatus',
							data.field, function(res) {
								var data = res;
								if (data.success) {
									layer.closeAll();
									layer.msg("修改成功", {
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

<!-- 修改弹窗 -->
<div id="updateMerchant" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		
		<div class="layui-inline layui-form-item" >
			<label class="layui-form-label" style="width: 120px">登录状态：</label>
			<div class="layui-input-inline layui-short-select" >
				<select  name="loginStatus" lay-filter="loginStatus">
					<option value="0">禁止</option>
					<option value="1">正常</option>
				</select>
			</div>
		</div>
		
		<div class="layui-inline layui-form-item" >
			<label class="layui-form-label" style="width: 120px">审核状态：</label>
			<div class="layui-input-inline layui-short-select" >
				<select  name="auditStatus" lay-filter="auditStatus">
					<option value="0">未审核</option>
					<option value="1">已审核</option>
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width: 120px"><font
				style="color: #D82828">*</font>审核备注：</label>
			<div class="layui-input-inline">
				<input type="text" name="auditRemark"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		
		
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="updateMerchant">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="uid" class="uid" />
	</form>
</div>



</html>