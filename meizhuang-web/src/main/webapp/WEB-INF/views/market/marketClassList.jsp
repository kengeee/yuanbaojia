<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>市场分类</title>
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
						<div class="test-table-reload-btn" style="margin-bottom: 10px;" >
							<form class="layui-form" action="" lay-filter="search">
									<div class="layui-inline">
										<label class="layui-form-label">分类名称</label>
										<div class="layui-input-block">
									      	<input class="layui-input" name="className" autocomplete="off">
									    </div>
									</div>
									<div class="layui-inline">
										<label class="layui-form-label layui-w120">类型</label>
										<div class="layui-input-block" style="margin-left: 160px;">
									      	<select name="type" type-filter="state">
									      		<option value="">全部</option>
									      		<option value="1">城市</option>
									        	<option value="2">市场</option>
									      		<option value="3">楼层</option>
									      		<option value="4">位置</option>
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
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="addMarketClass">添加</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateMarketClass">修改</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="delMarketClass">批量删除</button>
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
		}).use([ 'index', 'table','form','upload' ],function() {
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
						url : '/flow/marketClass/getMarketClassList',
						method : 'post',
						title : '用户数据表',
						totalRow : false,
						initSort: {field:'', type:'asc'},
						where: {sortField:'', sortType:'asc'},
						cols : [ [
							{type:'checkbox',fixed:'left'},
							{field:'id', title:'id', width:150, align:'center',sort:true},
							{field:'type', title:'类型', width:180,align:'center', templet: function(d){
				            	if(d.type==1){
				            		return '城市';
					        	  }else if(d.type==2){
				            		return '市场';
					        	  }else if(d.type== 3){
					        	    return '楼层';
					        	  }else if(d.type = 4){
					        	    return '位置';
					        	  }else{
					        	  	return '--';
					        	}
							}},
							{field:'className', title:'分类名类', width:180,align:'center'},
					        {field:'pId', title:'pId', width:150, align:'center'},
					        {field:'pClassName', title:'父类名类', width:180,align:'center', templet: function(d){
								if(d.pClassName2 != null && d.pClassName2 != ''){
									return d.pClassName2 +" / "+d.pClassName;
								}else if(d.pClassName != null && d.pClassName != ''){
									return d.pClassName;
								}
								return '';
							}},
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
				        case 'addMarketClass':
				        	layer.open({
								type: 1,
								title: "添加市场分类", 
								area : [ '420px', '350px' ], //宽高
								content:$("#addMarketClass")
							});
				        break;
				        case 'updateMarketClass':
				        	if(data.length<1){
				        		layer.msg('至少选择一项');
				        		return;
				        	}else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		return;
				        	}else{
				        		var id = data[0].id;
				        		var className = data[0].className;
				        
				        		
				        		$("#updateMarketClass input[name='id']").val(id);
				        		$("#updateMarketClass input[name='className']").val(className);		 
				        		renderForm()
				        	}
				        	layer.open({
								type: 1,
								title: "修改市场分类", 
								area : [ '420px', '250px' ], //宽高
								content:$("#updateMarketClass")
							});
				        break;
				        
				       case 'delMarketClass':
							if(data.length < 1) {
								layer.msg('至少选择一项');
								return;
							}else{
				        		var ids = "-1";
								for(var i = 0; i < data.length; i++) {
									//uids.push(data[i].uid);
									ids += ","+data[i].id;
								}
				        		layer.confirm('你确认选择的分类删除?', function(index){
									var jsonD = {
											ids:ids
									}
									$.post('/flow/marketClass/delMarketClass', jsonD,
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
					form.on('submit(addMarketClass)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						if(!$("button[lay-filter='addBankCard']").hasClass("layui-btn-disabled")){
							$("button[lay-filter='addBankCard']").addClass("layui-btn-disabled").attr("disabled","disabled");
							$.post('/flow/marketClass/addMarketClass',
									data.field, function(res) {
										setTimeout(function(){
											$("button[lay-filter='addMarketClass']").removeClass("layui-btn-disabled").removeAttr("disabled");
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
					form.on('submit(updateMarketClass)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						$.post('/flow/marketClass/updateMarketClass',
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
					
					form.on('select(type)',function(data){
						var v = data.value;
						if(v == 1){
						    //alert(v);
						    
							$("#parentClass").hide();
							$("select[name='pId']").val(0);
							return;
						}
						$("#parentClass").show();
						v = parseInt(v)-1;
						//
						$.post("/flow/marketClass/getParentMarketClass",{type:v}, function(data) {
							if(data.success) {
								var data = data.data;
								var merchantIdOpt = "";
								for(var i = 0; i < data.length; i++) {
								    if(data[i].pClassName == null){
								    	merchantIdOpt += '<option value="' + data[i].id + '">'  + data[i].className +  '</option>';
								    }else{
								    	merchantIdOpt += '<option value="' + data[i].id + '">' + data[i].pClassName + '-（' + data[i].className + '）' + '</option>';
								    }
									
								}
								$("select[name='pId']").html(merchantIdOpt);
								renderForm();
								
							} else {
								layer.msg(data.msg, {
									icon: 5
								});
							}
						});
					
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
					
					
					//关闭弹窗
					$('.closeBtn').click(function() {
						layer.closeAll();
					});
					
					
					
			    
			    
			   
					
					
				});
	</script>
	
</body>
<!-- 添加分类弹窗 -->
<div id="addMarketClass" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
	    
	    <div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>类型：</label>
			<div class="layui-input-inline">
				<select name="type" lay-filter="type">
				    <option value="0" selected="selected">请选择</option>
					<option value="1">城市</option>
					<option value="2">名称</option>
					<option value="3">楼层</option>
					<option value="4">位置</option>
				</select>
			</div>
		</div>
		
		
		<div class="layui-inline layui-form-item" id="parentClass">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828"></font>父级：</label>
			<div class="layui-input-inline">
				<select name="pId" lay-filter="pId" lay-verify="" lay-search>
				</select>
			</div>
		</div>
		
		
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>分类名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="className" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="addMarketClass">添加</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
	</form>
</div>
<!-- 修改弹窗 -->
<div id="updateMarketClass" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>分类名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="className" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="updateMarketClass">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
	</form>
</div>
</html>