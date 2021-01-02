<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>公告管理</title>
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
						<div class="test-table-reload-btn" style="margin-bottom: 10px; display: none" >
							<form class="layui-form" action="" lay-filter="search">
									<div class="layui-inline">
										<label class="layui-form-label">名称</label>
										<div class="layui-input-block">
									      	<input class="layui-input" name="name" autocomplete="off">
									    </div>
									</div>
									<div class="layui-inline">
										<label class="layui-form-label layui-w120">状态</label>
										<div class="layui-input-block" style="margin-left: 160px;">
									      	<select name="state" lay-filter="state">
									      		<option value="">全部</option>
									      		<option value="1">打开</option>
									        	<option value="2">关闭</option>
									      	</select>
									    </div>
									</div>
									<button class="layui-btn margin-l-10" lay-submit="" lay-filter="search">搜索</button>
								</form>
						</div>
						<table class="layui-hide" id="test-table-totalRow"
							lay-filter="test-table-totalRow"></table>
							<script type="text/html" id="test-table-totalRow-toolbarDemo">
								<div class="layui-btn-container">
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="addTemplate">添加</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateTemplate">修改</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="delTemplate">删除</button>

								</div>
							</script>
							<script type="text/html" id="exampleImg">
								{{# if( d.exampleImg==null || d.exampleImg==undefined || d.exampleImg=="" ){	}}

								{{# }else{	}}
									<div class="layui-list-icon"><img src="{{ d.exampleImg }}"  lay-event="photoDetails"/></div>
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
						url : '/flow/proclamation/getProclamationList',
						method : 'post',
						title : '用户数据表',
						totalRow : false,
						initSort: {field:'orderNum', type:'asc'},
						where: {sortField:'orderNum', sortType:'asc'},
						cols : [ [
							{type:'checkbox',fixed:'left'},
							{field:'name', title:'名称', width:180,align:'center'},
							{field:'text', title:'公告描述', width:580,align:'center'},
					        {field:'state', title:'状态', width:180,align:'center', templet: function(d){
				            	if(d.state==1){
				            		return '打开';
					        	  }else if(d.state==2){
				            		return '关闭';
					        	  }else{
					        	  	return '--';
					        	}
							}},
					        {field:'orderNum', title:'显示排序', width:120, align:'center',sort:true},
					        {field:'clickResult', title:'点击效果', width:150, align:'center',templet: function(d){
								if(d.clickResult==0){
									return '无效果';
								}else if(d.clickResult == 1){
									return '跳转到H5页面';
								}
							}},
							{field:'h5Id', title:'H5页面ID', width:100,align:'center'},
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
				        case 'addTemplate':
				        	layer.open({
								type: 1,
								title: "添加公告", 
								area : [ '420px', '450px' ], //宽高
								content:$("#addTemplate")
							});
				        break;
				        case 'updateTemplate':
				        	if(data.length<1){
				        		layer.msg('至少选择一项');
				        		return;
				        	}else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		return;
				        	}else{
				        		var id = data[0].id;
				        		var name = data[0].name;
				        		var text = data[0].text;
				        		var state = data[0].state;
				        		var orderNum = data[0].orderNum;
				        		var h5Id = data[0].h5Id;
				        		var clickResult = data[0].clickResult; 
				        		
				        		$("#updateTemplate input[name='id']").val(id);
				        		$("#updateTemplate input[name='name']").val(name);
				        		$("#updateTemplate textarea[name='text']").val(text);
				        		$("#updateTemplate input[name='state']").val(state);
				        		$("#updateTemplate input[name='orderNum']").val(orderNum);		
				        		$("#updateTemplate input[name='h5Id']").val(h5Id);
				        		$("#updateTemplate select[name='clickResult']").val(clickResult);
				        		if(clickResult==0){
								    
								    $(".h5page").hide();
								    $("input[name='h5Id']").val('');
									
								}else{
									$(".h5page").show();
								    
								}		        		 
				        		renderForm()
				        	}
				        	layer.open({
								type: 1,
								title: "修改公告", 
								area : [ '420px', '550px' ], //宽高
								content:$("#updateTemplate")
							});
				        break;
				        
				       case 'delTemplate':
							if(data.length < 1) {
								layer.msg('至少选择一项');
								return;
							}else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		return;
				        	}else{
				        		var id = data[0].id;
				        		layer.confirm('请确认选择的公告删除?', function(index){
									var jsonD = {
											id:id
									}
									$.post('/flow/proclamation/delProclamation', jsonD,
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
				        	}
						break;
				        
				      };
				    });
					
				
					
					//添加提交
					form.on('submit(addTemplate)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						if(!$("button[lay-filter='addBankCard']").hasClass("layui-btn-disabled")){
							$("button[lay-filter='addBankCard']").addClass("layui-btn-disabled").attr("disabled","disabled");
							$.post('/flow/proclamation/addProclamation',
									data.field, function(res) {
										setTimeout(function(){
											$("button[lay-filter='addTemplate']").removeClass("layui-btn-disabled").removeAttr("disabled");
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
					form.on('submit(updateTemplate)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						$.post('/flow/proclamation/updateProclamation',
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
					
					//监听行工具事件
					table.on('tool(test-table-totalRow)', function(obj) {
							var data = obj.data;
							var img = data.exampleImg;
							layer.open({
								type: 1,
								title: "示例图",
								area: ['360px'], //宽高
								content: "<img src='" + img + "' style='width: 360px;'>"
							});
				       		
					});
					
					form.on('select(clickResult)',function(data){
						var v = data.value;
						
						if(v==0){
						    //alert(v);
						    $(".h5page").hide();
						    //$("input[name='h5Id']").val('');
							return;
						}else{
							$(".h5page").show();
						    
						    return;
						}
					});
					
					//关闭弹窗
					$('.closeBtn').click(function() {
						layer.closeAll();
					});
					
					
					
			    
			    
			   
					
					
				});
	</script>
	
</body>
<!-- 添加模板弹窗 -->
<div id="addTemplate" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="name" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>公告描述：</label>
			<div class="layui-input-inline">
				<textarea name="text" placeholder="请输入内容" class="layui-textarea" style="min-height:142px"></textarea>
				
			</div>
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>显示排序：</label>
			<div class="layui-input-inline">
				<input type="text" name="orderNum" lay-verify="amountDayLimit" autocomplete="off"
					class="layui-input">
			</div>
			
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>状态：</label>
			<div class="layui-input-inline">
				<select name="state" lay-filter="state">
					<option value="1">打开</option>
					<option value="2">关闭</option>
				</select>
			</div>
			
		</div>
		
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="addTemplate">添加</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
		<input type="hidden" name="uid" class="uid" />
	</form>
</div>
<!-- 修改弹窗 -->
<div id="updateTemplate" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="name" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>公告描述：</label>
			<div class="layui-input-inline">
				<textarea name="text" placeholder="请输入内容" class="layui-textarea" style="min-height:142px"></textarea>
			</div>
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>显示排序：</label>
			<div class="layui-input-inline">
				<input type="text" name="orderNum" lay-verify="amountDayLimit" autocomplete="off"
					class="layui-input">
			</div>
			
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>状态：</label>
			<div class="layui-input-inline">
				<select name="state" lay-filter="state">
					<option value="1">打开</option>
					<option value="2">关闭</option>
				</select>
			</div>
			
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>点击效果：</label>
			<div class="layui-input-inline">
				<select name="clickResult" lay-filter="clickResult">
					<option value="0">无效果</option>
					<option value="1">跳转到H5页面</option>
				</select>
			</div>
		</div>
		
		<div class="layui-inline layui-form-item h5page" style="display: none">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>H5页面ID：</label>
			<div class="layui-input-inline">
				<input type="text" name="h5Id" lay-verify="h5Id" autocomplete="off"
					class="layui-input">
			</div>
			
		</div>
		
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="updateTemplate">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
		<input type="hidden" name="uid" class="uid" />
	</form>
</div>
</html>