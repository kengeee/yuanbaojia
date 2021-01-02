<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>框架管理</title>
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
							<form class="layui-form" action="" lay-filter="search">
									<div class="layui-inline" style="margin-top:10px;">
										<label class="layui-form-label">产品名称</label>
										<div class="layui-input-block">
									      	<select name="appId" lay-filter="appId">
				
											</select>
									    </div>
									</div>
									
									
									<div class="layui-inline">
										<label class="layui-form-label layui-w120">风格</label>
										<div class="layui-input-block" style="margin-left: 160px;">
									      	<select name="style" lay-filter="style">
									      		<option value="">全部</option>
									      		<option value="1">通用</option>
									        	<option value="2">定制</option>
									      	</select>
									    </div>
									</div>
									<div class="layui-inline">
										<label class="layui-form-label layui-w120">app模块</label>
										<div class="layui-input-block" style="margin-left: 160px;">
									      	<select name="appMode" lay-filter="appMode">
									      		<option value="">全部</option>
									      		<option value="1">首页</option>
									        	<option value="2">我的</option>
									        	<option value="3">消息</option>
									        	<option value="4">订单</option>
									        	<option value="5">活动</option>
									      	</select>
									    </div>
									</div>
									<div class="layui-inline" >
										<label class="layui-form-label">状态</label>
										<div class="layui-input-block">
									      	<select name="state" lay-filter="state">
									      		<option value="">全部</option>
									      		<option value="1">打开</option>
									        	<option value="2">关闭</option>
									      	</select>
									    </div>
									</div>
									
									<div class="layui-inline">
										<label class="layui-form-label">框架名称</label>
										<div class="layui-input-block">
									      	<input class="layui-input" name="name" autocomplete="off" style="width: 212px;">
									    </div>
									</div>
									
									<button class="layui-btn margin-l-10" lay-submit="" lay-filter="search" style="margin-top:10px;margin-left:100px;">搜索</button>
								</form>
						</div>
						<table class="layui-hide" id="test-table-totalRow"
							lay-filter="test-table-totalRow"></table>
							<script type="text/html" id="test-table-totalRow-toolbarDemo">
								<div class="layui-btn-container">
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="addFrame">添加</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateFrame">修改</button>
								</div>
							</script>
							<script type="text/html" id="exampleImg">
								{{# if( d.exampleImg==null || d.exampleImg==undefined || d.exampleImg=="" ){	}}

								{{# }else{	}}
									<div class="layui-list-icon"><img src="{{ d.exampleImg }}"  lay-event="photoDetails"/></div>
								{{# }	}}
							</script>
							<script type="text/html" id="operate">
								<a class="layui-btn layui-btn-mini layui-btn-xs" lay-event="updateFrameTemplate">编辑</a>
							</script>
							
							<script type="text/html" id="test-table-totalRow-toolbarDemo1">
								<div class="layui-btn-container">
									<input type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-event="addTemplate" value="添加">
									<input type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateTemplate" value="修改">
								</div>
							</script>
							
							
							<script type="text/html" id="operate1">
								<a class="layui-btn layui-btn-mini layui-btn-xs" lay-event="getTemplateImg">查看</a>
							</script>
							
							<script type="text/html" id="test-table-totalRow-toolbarDemo2">
								<div class="layui-btn-container">
									<input type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-event="addTemplateImg" value="添加">
									<input type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateTemplateImg" value="修改">
									<input type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-event="deleteTemplateImg" value="删除">
								</div>
							</script>
							
							<script type="text/html" id="imgUrl">
								{{# if( d.imgUrl==null || d.imgUrl==undefined || d.imgUrl=="" ){	}}

								{{# }else{	}}
									<div class="layui-list-icon"><img src="{{ d.imgUrl }}"  lay-event="photoDetails1"/></div>
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
					
					
					
					
					//获取模板
					$.post("/flow/frame/getTemplate", function(data) {
						if(data.success) {
							var data = data.data;
							var opt = "";
							
							optAll = '<option value="">全部</option>';
							for(var i = 0; i < data.length; i++) {
								opt += '<option value="' + data[i].id + '" exampleImg="'+data[i].exampleImg+'">' + data[i].name + '</option>';
							}
							$("select[name='templateId']").html(opt);
							$("#openExampleImg").val(data[0].exampleImg);
							$("#updateTemplate select[name='templateId']").html(opt);
							renderForm();
						} else {
							layer.msg(data.msg, {
								icon: 5
							});
						}
					});
					
					
					
					//获取UI跳转
					$.post("/flow/frame/getAllSectionUI", function(data) {
						if(data.success) {
							var data = data.data;
							var opt = "";
							
							optAll = '';
							for(var i = 0; i < data.length; i++) {
								opt += '<option value="' + data[i].id + '" url="'+data[i].url+'">' + data[i].name + '</option>';
							}
							$("select[name='sectionUi']").html(opt);
							$("#sectionUrl").val(data[0].url);
							renderForm();
						} else {
							layer.msg(data.msg, {
								icon: 5
							});
						}
					});
					
					
					form.on('select(templateId)', function(data){
						var example = $("select[name='templateId']").find('option:selected').attr('exampleImg');   
						$("#openExampleImg").val(example);
						renderForm();
                     });
					
					form.on('select(sectionType)', function(data){
						var example = $("select[name='sectionType']").find('option:selected').val();   
						if(example==1004){
							$("#sectionDiv").attr("style","display:block;");
							$("#popupDiv").attr("style","display:none;");
							var url = $("select[name='sectionUi']").find('option:selected').attr('url');
							$("input[name='sectionUrl']").val(url);
						}else if(example==1002 || example==1005){
							$("#popupDiv").attr("style","display:block;");
							$("#sectionDiv").attr("style","display:none;");
							$("input[name='sectionUrl']").val("");
						}else{
							$("#popupDiv").attr("style","display:none;");
							$("#sectionDiv").attr("style","display:none;");
							$("input[name='sectionUrl']").val("");
						}
						
						renderForm();
                     });
					
					form.on('select(sectionUi)', function(data){
						var url = $("select[name='sectionUi']").find('option:selected').attr('url'); 
						$("input[name='sectionUrl']").val(url);
						renderForm();
                     });
                     
                     form.on('select(sectionType1)', function(data){
						var example = $("#updateTemplateImg select[name='sectionType']").find('option:selected').val();   
						if(example==1004){
							$("#sectionDiv1").attr("style","display:block;");
							$("#popupDiv1").attr("style","display:none;");
							var url = $("#updateTemplateImg select[name='sectionUi']").find('option:selected').attr('url');
							$("#updateTemplateImg input[name='sectionUrl']").val(url);
						}else if(example==1002 || example==1005){
							$("#popupDiv1").attr("style","display:block;");
							$("#sectionDiv1").attr("style","display:none;");
							$("#updateTemplateImg input[name='sectionUrl']").val("");
						}else{
							$("#popupDiv1").attr("style","display:none;");
							$("#sectionDiv1").attr("style","display:none;");
							$("#updateTemplateImg input[name='sectionUrl']").val("");
						}
						
						
						renderForm();
                     });
					
					form.on('select(sectionUi1)', function(data){
						var url = $("#updateTemplateImg select[name='sectionUi']").find('option:selected').attr('url'); 
						$("#updateTemplateImg input[name='sectionUrl']").val(url);
						renderForm();
                     });
					
					
					
					
					table.render({
						elem : '#test-table-totalRow',
						toolbar : '#test-table-totalRow-toolbarDemo',
						defaultToolbar:'',
						autoSort : false,
						url : '/flow/frame/getFrameList',
						method : 'post',
						title : '用户数据表',
						totalRow : false,
						cols : [ [
							{type:'checkbox',fixed:'left'},
							{field:'id', title:'框架id', width:90,align:'center'},
							{field:'appName', title:'产品名称', width:90,align:'center'},
							{field:'name', title:'框架名称', width:180,align:'center'},
					        {field:'style', title:'风格', width:180,align:'center', templet: function(d){
				            	if(d.style==1){
				            		return '通用';
					        	  }else if(d.style==2){
				            		return '定制';
					        	  }else{
					        	  	return '--';
					        	  }
							}},
							{field:'appMode', title:'app模板', width:180,align:'center', templet: function(d){
				            	if(d.appMode==1){
				            		return '首页';
					        	  }else if(d.appMode==2){
				            		return '我的';
					        	  }else if(d.appMode==3){
				            		return '消息';
					        	  }else if(d.appMode==4){
				            		return '订单';
					        	  }else if(d.appMode==5){
				            		return '活动';
					        	  }else{
					        	  	return '--';
					        	  }
							}},
					        {field:'state', title:'状态', width:180,align:'center', templet: function(d){
				            	if(d.state==1){
				            		return '打开';
					        	  }else if(d.state==2){
				            		return '关闭';
					        	  }else{
					        	  	return '--';
					        	  }
							}},
					        
					        {field:'ctime', title:'创建时间', width:180,align:'center'},
					        {field:'mtime', title:'修改时间', width:180,align:'center'},
					        {title:'操作',toolbar:'#operate',width:100,align:'center',fixed:'right'}
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
				        case 'addFrame':
				        	layer.open({
								type: 1,
								title: "添加框架", 
								area : [ '420px', '400px' ], //宽高
								content:$("#addFrame")
							});
				        break;
				        case 'updateFrame':
				        	if(data.length<1){
				        		layer.msg('至少选择一项');
				        		return;
				        	}else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		return;
				        	}else{
				        		var id = data[0].id;
				        		var name = data[0].name;
				        		var style = data[0].style;
				        		var state = data[0].state;
				        		var appMode = data[0].appMode;
				        		var appId = data[0].appId;
				        		
				        		$("#updateFrame input[name='id']").val(id);
				        		$("#updateFrame input[name='name']").val(name);
				        		$("#updateFrame select[name='style']").val(style);
				        		$("#updateFrame select[name='state']").val(state);
				        		$("#updateFrame select[name='appMode']").val(appMode);
				        		
				        		
				        		$.post("/flow/frame/getAllAppProduct",{}, function(data1) {
									if(data1.success) {
										console.log(data1);
										var data1 = data1.data;
										var passTypeOpt = "";
										for(var i = 0; i < data1.length; i++) {
											if(data1[i].appId==appId){
												passTypeOpt += '<option selected="selected" value="' + data1[i].appId + '">' + data1[i].appName + '</option>';
											}else{
												passTypeOpt += '<option value="' + data1[i].appId + '">' + data1[i].appName + '</option>';		
											}
										}
										$("#updateFrame select[name='appId']").html(passTypeOpt);
										renderForm();
									} else {
										layer.msg(data1.msg, {
											icon: 5
										});
									}
								});
				        		
				        						        		 
				        		renderForm()
				        	}
				        	layer.open({
								type: 1,
								title: "修改框架", 
								area : [ '420px', '400px' ], //宽高
								content:$("#updateFrame")
							});
				        break;
				      };
				    });
					
				
					
					//添加提交
					form.on('submit(addFrame)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						
							$.post('/flow/frame/addFrame',
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
						
					});
					
					//修改提交
					form.on('submit(updateFrame)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						$.post('/flow/frame/updateFrame',
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
					
					
					
					//添加提交
					form.on('submit(addTemplate)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						
							$.post('/flow/frame/addTemplate',
									data.field, function(res) {
										setTimeout(function(){
											$("button[lay-filter='addTemplate']").removeClass("layui-btn-disabled").removeAttr("disabled");
										},3000)
										var data = res;
										var index = $("#addTemplate input[name='index']").val();
										if (data.success) {
											layer.close(index);
											layer.msg(data.msg, {
												icon : 6
											});
											table.reload('test-table-totalRow1');
										} else {
											layer.msg(data.msg, {
												icon : 5
											});
										}
									});
							return false;
						
					});
					
					
					//修改提交
					form.on('submit(updateTemplate)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						$.post('/flow/frame/updateTemplate',
								data.field, function(res) {
									var data = res;
									var index = $("#updateTemplate input[name='index']").val();
									if (data.success) {
										layer.close(index);
										layer.msg("操作成功", {
											icon : 6
										});
										table.reload('test-table-totalRow1');
									} else {
										layer.msg(data.msg, {
											icon : 5
										});
									}
								});
						return false;
					});
					
					
					//添加提交
					form.on('submit(addTemplateImg)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						
							$.post('/flow/frame/addTemplateImg',
									data.field, function(res) {
										setTimeout(function(){
											$("button[lay-filter='addTemplateImg']").removeClass("layui-btn-disabled").removeAttr("disabled");
										},3000)
										var data = res;
										var index = $("#addTemplateImg input[name='index']").val();
										if (data.success) {
											layer.close(index);
											layer.msg(data.msg, {
												icon : 6
											});
											table.reload('test-table-totalRow2');
										} else {
											layer.msg(data.msg, {
												icon : 5
											});
										}
									});
							return false;
						
					});
					
					
					//修改提交
					form.on('submit(updateTemplateImg)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						$.post('/flow/frame/updateTemplateImg',
								data.field, function(res) {
									var data = res;
									var index = $("#updateTemplateImg input[name='index']").val();
									if (data.success) {
										layer.close(index);
										layer.msg("操作成功", {
											icon : 6
										});
										table.reload('test-table-totalRow2');
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
					
					
					
					form.on('submit(openExampleImg)', function(data) {
							var img = $("#openExampleImg").val();
							layer.open({
								type: 1,
								title: "效果图",
								area: ['360px'], //宽高
								content: "<img src='" + img + "' style='width: 360px;'>"
							});
					});
					
					
					
					
					table.on('tool(test-table-totalRow)', function(data) {
						var id = data.data.id;
						$("#addTemplate input[name='frameId']").val(id);		
						if (data.event === 'updateFrameTemplate') {
							layui.use(['table', 'form'], function() {
								var table2 = layui.table;
								var form = layui.form;
								
								
								
								layer.open({
									type: 1,
									title: '模板',
									area: ['100%', '100%'], //宽高
									content: $('#updateFrameTemplate'),
									success: function() {

									table2.render({
										elem : '#test-table-totalRow1',
										toolbar : '#test-table-totalRow-toolbarDemo1',
										defaultToolbar:'',
										autoSort : false,
										url : '/flow/frame/getTemplateList?id='+id,
										method : 'post',
										title : '用户数据表',
										totalRow : false,
										cols : [ [
											{type:'checkbox',fixed:'left'},
											{field:'name', title:'模板名称', width:180,align:'center'},
						        			{field:'exampleImg', title:'示例图', width:200,align:'center', toolbar:'#exampleImg'},
						        			{field:'order', title:'顺序', width:150, align:'center'},
									        {field:'state', title:'状态', width:180,align:'center', templet: function(d){
								            	if(d.state==1){
								            		return '打开';
									        	  }else if(d.state==2){
								            		return '关闭';
									        	  }else{
									        	  	return '--';
									        	  }
											}},
											{title:'操作',toolbar:'#operate1',width:100,align:'center',fixed:'right'}
										] ],
										where: {
											sortField: '`order`',
											sortType: 'asc'
										},
										page : true
									});
				
									table2.on('sort(test-table-totalRow1)', function(obj) {
										table2.reload('test-table-totalRow1', {
											initSort : obj,
											where : {
												sortField : obj.field,
												sortType : obj.type
											}
										});
									});
									
									
									//头工具栏事件
								    table2.on('toolbar(test-table-totalRow1)', function(obj){
								      var checkStatus = table2.checkStatus(obj.config.id);
								      var data = checkStatus.data;
								      switch(obj.event){
								        case 'addTemplate':
								        	
								        	
								        	var addT = layer.open({
												type: 1,
												title: "添加模板", 
												area : [ '500px', '300px' ], //宽高
												content:$("#addTemplate"),
												success: function(layero, index){
											       $("#addTemplate input[name='index']").val(index);
											    }
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
								        		$("#updateTemplate input[name='id']").val(data[0].id);
								        		$("#updateTemplate input[name='frameId']").val(data[0].frameId);
								        		$("#updateTemplate select[name='templateId']").val(data[0].templateId);
								        		$("#updateTemplate input[name='order']").val(data[0].order);
								        		$("#updateTemplate select[name='state']").val(data[0].state);				        		 
								        		renderForm()
					        				}
								        	var updateT = layer.open({
												type: 1,
												title: "修改模板", 
												area : [ '500px', '360px' ], //宽高
												content:$("#updateTemplate"),
												success: function(layero, index){
											       $("#updateTemplate input[name='index']").val(index);
											    }
											});
								        break;
								      };
								    });
									
									
									
									
									
									$('.closeBtn1').click(function() {
										var index = $("#addTemplate input[name='index']").val();
										layer.close(index);
									});
									
									$('.closeBtn2').click(function() {
										var index = $("#updateTemplate input[name='index']").val();
										layer.close(index);
									});
									
									
									
									
									table.on('tool(test-table-totalRow1)', function(data) {
										var id = data.data.id;
										$("#addTemplateImg input[name='frameTemplateId']").val(id);		
										if (data.event === 'getTemplateImg') {
											layui.use(['table', 'form'], function() {
												var table3 = layui.table;
												var form = layui.form;
												
												
												
												layer.open({
													type: 1,
													title: '图片管理',
													area: ['75%', '75%'], //宽高
													content: $('#getTemplateImg'),
													success: function() {
				
													table3.render({
														elem : '#test-table-totalRow2',
														toolbar : '#test-table-totalRow-toolbarDemo2',
														defaultToolbar:'',
														autoSort : false,
														url : '/flow/frame/getTemplateImgList?id='+id,
														method : 'post',
														title : '用户数据表',
														totalRow : false,
														cols : [ [
															{type:'checkbox',fixed:'left'},
										        			{field:'imgUrl', title:'图片', width:200,align:'center', toolbar:'#imgUrl'},
										        			{field:'theLocation', title:'所在位置', width:150, align:'center', templet: function(d){
												            	if(d.theLocation==1){
												            		return '标题';
													        	  }else if(d.theLocation==2){
												            		return '内容';
													        	  }else if(d.theLocation==3){
												            		return '底部';
													        	  }else{
													        	  	return '--';
													        	  }
															}},
													        {field:'isSection', title:'是否跳转', width:180,align:'center', templet: function(d){
												            	if(d.isSection==0){
												            		return '是';
													        	  }else if(d.isSection==1){
												            		return '否';
													        	  }else{
													        	  	return '--';
													        	  }
															}},
															{field:'sectionType', title:'跳转类型', width:180,align:'center', templet: function(d){
												            	  if(d.sectionType==1000){
												            		return '无跳转';
													        	  }else if(d.sectionType==1001){
												            		return '网页内部跳转';
													        	  }else if(d.sectionType==1002){
												            		return '网页弹窗跳转';
													        	  }else if(d.sectionType==1003){
												            		return '网页外部跳转';
													        	  }else if(d.sectionType==1004){
												            		return 'UI内部跳转';
													        	  }else if(d.sectionType==1005){
												            		return 'UI弹窗跳转';
													        	  }else if(d.sectionType==1006){
												            		return 'SDK跳转';
													        	  }else{
													        	  	return '--';
													        	  }
															}},
															{field:'sectionUiName', title:'跳转UI', width:180, align:'center'},
															{field:'popupContent', title:'弹窗内容', width:180, align:'center'},
															{field:'sectionUrl', title:'跳转地址', width:180, align:'center'},
															{field:'ctime', title:'创建时间', width:180,align:'center'},
					        								{field:'mtime', title:'修改时间', width:180,align:'center'},
														] ],
														where: {
															sortField: 'the_location',
															sortType: 'asc'
														},
														page : true
													});
								
													table3.on('sort(test-table-totalRow2)', function(obj) {
														table3.reload('test-table-totalRow2', {
															initSort : obj,
															where : {
																sortField : obj.field,
																sortType : obj.type
															}
														});
													});
													
													
													//头工具栏事件
												    table3.on('toolbar(test-table-totalRow2)', function(obj){
												      var checkStatus = table3.checkStatus(obj.config.id);
												      var data = checkStatus.data;
												      switch(obj.event){
												        case 'addTemplateImg':
												        	
												        	$("#sectionDiv").attr("style","display:none;");
												        	
												        	layer.open({
																type: 1,
																title: "添加图片", 
																area : [ '400px', '550px' ], //宽高
																content:$("#addTemplateImg"),
																success: function(layero, index){
															       $("#addTemplateImg input[name='index']").val(index);
															    }
															});
												        break;
												        case 'updateTemplateImg':
													        if(data.length<1){
												        		layer.msg('至少选择一项');
												        		return;
												        	}else if(data.length>1){
												        		layer.msg('最多选择一项');
												        		return;
												        	}else{							        		
												        		$("#updateTemplateImg input[name='id']").val(data[0].id);
												        		$("#updateTemplateImg input[name='frameTemplateId']").val(data[0].frameTemplateId);
												        		$("#updateTemplateImg select[name='theLocation']").val(data[0].theLocation);
												        		$("#updateTemplateImg input[name='sectionUrl']").val(data[0].sectionUrl);
												        		$("#updateTemplateImg select[name='isSection']").val(data[0].isSection);
												        		$("#updateTemplateImg select[name='sectionType']").val(data[0].sectionType);
												        		$("#updateTemplateImg select[name='sectionUi']").val(data[0].sectionUi);												        		
												        		$("#updateTemplateImg #demo2").attr("src",data[0].imgUrl);
				        										$("#updateTemplateImg input[name='imgUrl']").val(data[0].imgUrl);
												        		$("#updateTemplateImg input[name='popupContent']").val(data[0].popupContent);
												        		
												        					
												        		if(data[0].sectionType==1004){
																	$("#sectionDiv1").attr("style","display:block;");
																	$("#popupDiv1").attr("style","display:none;");
																}else if(data[0].sectionType==1002 || data[0].sectionType==1005){
																	$("#popupDiv1").attr("style","display:block;");
																	$("#sectionDiv1").attr("style","display:none;");
																}else{
																	$("#popupDiv1").attr("style","display:none;");
																	$("#sectionDiv1").attr("style","display:none;");
																}			
												        					
												        						        		 
												        		renderForm()
									        				}
												        	layer.open({
																type: 1,
																title: "修改图片", 
																area : [ '400px', '550px' ], //宽高
																content:$("#updateTemplateImg"),
																success: function(layero, index){
															       $("#updateTemplateImg input[name='index']").val(index);
															    }
															});
												        break;
												        case 'deleteTemplateImg':
												        	if(data.length<1){
												        		layer.msg('至少选择一项');
												        		return;
												        	}else if(data.length>1){
												        		layer.msg('最多选择一项');
												        		return;
												        	}else{
												        		var id = data[0].id;
												        		layer.confirm('您确定要删除该图片吗？', function(index){
																	$.post("/flow/frame/deleteTemplateImg",{id:id},function(res){
																		if(res.success){
																			layer.msg(res.msg, {time: 2000, icon:6});
																			table.reload('test-table-totalRow2');
																			layer.close(index);
																		}else{
																			layer.msg(res.msg, {time: 2000, icon:5});
																		}
																	});
															      });
												        	}
												         break;
												      };
												    });
													
													
													//监听行工具事件
													table3.on('tool(test-table-totalRow2)', function(obj) {
															var data = obj.data;
															var img = data.imgUrl;
															layer.open({
																type: 1,
																title: "效果图",
																area: ['360px'], //宽高
																content: "<img src='" + img + "' style='width: 360px;'>"
															});
												       		
													});
													
													
													$('.closeBtn3').click(function() {
														var index = $("#addTemplateImg input[name='index']").val();
														layer.close(index);
													});
													
													$('.closeBtn4').click(function() {
														var index = $("#updateTemplateImg input[name='index']").val();
														layer.close(index);
													});
													
													
													}
												});
											});
										
										}
										
										if(data.event === 'photoDetails'){
											var data = data.data;
											var img = data.exampleImg;
											layer.open({
												type: 1,
												title: "效果图",
												area: ['360px'], //宽高
												content: "<img src='" + img + "' style='width: 360px;'>"
											});
										}
										
									});
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									}
								});
							});
						
						}
					});
					
					
					
					//图片上传
			  	var upload = layui.upload;
			    var uploadInst = upload.render({
			      elem: '#test1'
			      ,url: '/file/uploadImageToYun'
			      ,before: function(obj){
			        //预读本地文件示例，不支持ie8
			        obj.preview(function(index, file, result){
			          $('#demo1').attr('src', result); //图片链接（base64）
			          $("button[lay-filter='testButton1']").addClass("layui-btn-disabled").attr("disabled","disabled");
			          $("button[lay-filter='addTemplateImg']").addClass("layui-btn-disabled").attr("disabled","disabled");
			        });
			      }
			      ,done: function(res){
			        //如果上传失败
			        if(res.code > 0){
			          $("button[lay-filter='testButton1']").removeClass("layui-btn-disabled").removeAttr("disabled");
			          $("button[lay-filter='addTemplateImg']").removeClass("layui-btn-disabled").removeAttr("disabled");
			          return layer.msg('上传失败');
			        }
			        //上传成功
			        $(".imgUrl").val(res.data);
			        $("button[lay-filter='testButton1']").removeClass("layui-btn-disabled").removeAttr("disabled");
			        $("button[lay-filter='addTemplateImg']").removeClass("layui-btn-disabled").removeAttr("disabled");
			      }
			      ,error: function(){
			    	  $("button[lay-filter='testButton1']").removeClass("layui-btn-disabled").removeAttr("disabled");
			    	  $("button[lay-filter='addTemplateImg']").removeClass("layui-btn-disabled").removeAttr("disabled");
			        //演示失败状态，并实现重传
			        var demoText = $('#demoText');
			        demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
			        demoText.find('.demo-reload').on('click', function(){
			          uploadInst.upload();
			        });
			      }
			    });
			    
			    
			    //图片上传
			  	var upload = layui.upload;
			    var uploadInst = upload.render({
			      elem: '#test2'
			      ,url: '/file/uploadImageToYun'
			      ,before: function(obj){
			        //预读本地文件示例，不支持ie8
			        obj.preview(function(index, file, result){
			          $('#demo2').attr('src', result); //图片链接（base64）
			          $("button[lay-filter='testButton2']").addClass("layui-btn-disabled").attr("disabled","disabled");
			          $("button[lay-filter='updateTemplateImg']").addClass("layui-btn-disabled").attr("disabled","disabled");
			        });
			      }
			      ,done: function(res){
			        //如果上传失败
			        if(res.code > 0){
			          $("button[lay-filter='testButton2']").removeClass("layui-btn-disabled").removeAttr("disabled");
			          $("button[lay-filter='updateTemplateImg']").removeClass("layui-btn-disabled").removeAttr("disabled");
			          return layer.msg('上传失败');
			        }
			        //上传成功
			        $(".imgUrl").val(res.data);
			        $("button[lay-filter='testButton2']").removeClass("layui-btn-disabled").removeAttr("disabled");
			        $("button[lay-filter='updateTemplateImg']").removeClass("layui-btn-disabled").removeAttr("disabled");
			      }
			      ,error: function(){
			    	  $("button[lay-filter='testButton2']").removeClass("layui-btn-disabled").removeAttr("disabled");
			    	  $("button[lay-filter='updateTemplateImg']").removeClass("layui-btn-disabled").removeAttr("disabled");
			        //演示失败状态，并实现重传
			        var demoText2 = $('#demoText2');
			        demoText2.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
			        demoText2.find('.demo-reload').on('click', function(){
			          uploadInst.upload();
			        });
			      }
			    });
					
					
					
					
					
					
					
					
					
				});
	</script>
	
</body>
<!-- 添加模板弹窗 -->
<div id="addFrame" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>产品id：</label>
			<div class="layui-input-inline">
				<select name="appId" lay-filter="appId" lay-verify="required">
				
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>框架名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="name" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>风格：</label>
			<div class="layui-input-inline">
				<select name="style" lay-filter="style">
					<option value="1">通用</option>
					<option value="2">定制</option>
				</select>
			</div>
			
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>app模板：</label>
			<div class="layui-input-inline">
				<select name="appMode" lay-filter="style">
					<option value="1">首页</option>
					<option value="2">我的</option>
					<option value="3">消息</option>
					<option value="4">订单</option>
					<option value="5">活动</option>
				</select>
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
				<button class="layui-btn" lay-submit lay-filter="addFrame">添加</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
		<input type="hidden" name="uid" class="uid" />
		<input type="hidden" name="agentId" value="0" />
	</form>
</div>
<!-- 修改弹窗 -->
<div id="updateFrame" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>产品id：</label>
			<div class="layui-input-inline">
				<select name="appId" lay-filter="appId" lay-verify="required">
				
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>模板名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="name" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>风格：</label>
			<div class="layui-input-inline">
				<select name="style" lay-filter="style">
					<option value="1">通用</option>
					<option value="2">定制</option>
				</select>
			</div>
			
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>app模板：</label>
			<div class="layui-input-inline">
				<select name="appMode" lay-filter="appMode">
					<option value="1">首页</option>
					<option value="2">我的</option>
					<option value="3">消息</option>
					<option value="4">订单</option>
					<option value="5">活动</option>
				</select>
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
				<button class="layui-btn" lay-submit lay-filter="updateFrame">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
		<input type="hidden" name="uid" class="uid" />
		<input type="hidden" name="agentId" value="0" />
	</form>
</div>


<div id="updateFrameTemplate" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<table class="layui-hide" id="test-table-totalRow1"
							lay-filter="test-table-totalRow1"></table>
	</form>
</div>

<!-- 添加模板弹窗 -->
<div id="addTemplate" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>选择模板：</label>
			<div class="layui-input-inline">
					<select name="templateId" lay-filter="templateId" lay-verify="required">
				
					</select>
			</div>
			<input type="button" class="layui-btn" lay-submit lay-filter="openExampleImg" value="示例图">
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>顺序：</label>
			<div class="layui-input-inline">
				<input type="text" name="order"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="addTemplate">确定</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn1">取消</button>
			</div>
		</div>
		<input type="hidden" name="frameId" class="frameId" />
		<input type="hidden" name="index" class="index" />
		<input type="hidden" id="openExampleImg" value="">
	</form>
</div>


<!-- 修改模板弹窗 -->
<div id="updateTemplate" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>选择模板：</label>
			<div class="layui-input-inline">
					<select name="templateId" lay-filter="templateId" lay-verify="required">
				
					</select>
			</div>
			<input type="button" class="layui-btn" lay-submit lay-filter="openExampleImg" value="示例图">
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>顺序：</label>
			<div class="layui-input-inline">
				<input type="text" name="order"  autocomplete="off"
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
				<button class="layui-btn" lay-submit lay-filter="updateTemplate">确定</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn2">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
		<input type="hidden" name="frameId" class="frameId" />
		<input type="hidden" id="openExampleImg" value="">
		<input type="hidden" name="index" class="index" />
	</form>
</div>

<div id="getTemplateImg" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<table class="layui-hide" id="test-table-totalRow2"
							lay-filter="test-table-totalRow2"></table>
	</form>
</div>


<!-- 添加模板弹窗 -->
<div id="addTemplateImg" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item" style="margin-bottom:0px;width:250px;">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>图片：</label>
			<div class="layui-upload">
			  <button type="button" class="layui-btn" id="test1" lay-filter="testButton1">上传图片</button>
			  <div class="layui-upload-list layui-little-ico" style="margin-left:130px;">
			    <img class="layui-upload-img" id="demo1" style="max-width:100px;_width:expression(this.width > 100 ? '100px' : this.width); max-height:100px;_height:expression(this.height > 100 ? '100px' : this.height);">·
			    <p id="demoText"></p>
			  </div>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>所在位置：</label>
			<div class="layui-input-inline">
				<select name="theLocation" lay-filter="theLocation">
					<option value="1">标题</option>
					<option value="2" selected="">内容</option>
					<option value="3">底部</option>
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>是否跳转：</label>
			<div class="layui-input-inline">
				<select name="isSection" lay-filter="isSection">
					<option value="0">是</option>
					<option value="1">否</option>
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>跳转类型：</label>
			<div class="layui-input-inline">
				<select name="sectionType" lay-filter="sectionType">
					<option value="1000">无跳转</option>
					<option value="1001">网页内部跳转</option>
					<option value="1002">网页弹窗跳转</option>
					<option value="1003">网页外部跳转</option>
					<option value="1004">UI内部跳转</option>
					<option value="1005">UI弹窗跳转</option>
					<option value="1006">SDK跳转</option>
				</select>
			</div>
		</div>
		
		<div class="layui-inline layui-form-item" style="display:none;" id="sectionDiv">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>跳转UI：</label>
			<div class="layui-input-inline">
				<select name="sectionUi" lay-filter="sectionUi">
					
				</select>
			</div>
		</div>
		
		<div class="layui-inline layui-form-item" style="display:none;" id="popupDiv">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>弹窗内容：</label>
			<div class="layui-input-inline">
				<input type="text" name="popupContent"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>跳转地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="sectionUrl"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="addTemplateImg">确定</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn3">取消</button>
			</div>
		</div>
		<input type="hidden" name="frameTemplateId" class="frameTemplateId" />
		<input type="hidden" name="index" class="index" />
		<input type="hidden" name="imgUrl" class="imgUrl" />
		<input type="hidden" name ="uploadOpType" class="uploadOpType" />
	</form>
</div>


<!-- 修改模板弹窗 -->
<div id="updateTemplateImg" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item" style="margin-bottom:0px;width:250px;">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>图片：</label>
			<div class="layui-upload">
			  <button type="button" class="layui-btn" id="test2" lay-filter="testButton2">上传图片</button>
			  <div class="layui-upload-list layui-little-ico" style="margin-left:130px;">
			    <img class="layui-upload-img" id="demo2" style="max-width:100px;_width:expression(this.width > 100 ? '100px' : this.width); max-height:100px;_height:expression(this.height > 100 ? '100px' : this.height);">·
			    <p id="demoText2"></p>
			  </div>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>所在位置：</label>
			<div class="layui-input-inline">
				<select name="theLocation" lay-filter="theLocation">
					<option value="1">标题</option>
					<option value="2">内容</option>
					<option value="3">底部</option>
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>是否跳转：</label>
			<div class="layui-input-inline">
				<select name="isSection" lay-filter="isSection">
					<option value="0">是</option>
					<option value="1">否</option>
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>跳转类型：</label>
			<div class="layui-input-inline">
				<select name="sectionType" lay-filter="sectionType1">
					<option value="1000">无跳转</option>
					<option value="1001">网页内部跳转</option>
					<option value="1002">网页弹窗跳转</option>
					<option value="1003">网页外部跳转</option>
					<option value="1004">UI内部跳转</option>
					<option value="1005">UI弹窗跳转</option>
					<option value="1006">SDK跳转</option>
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item" style="display:none;" id="sectionDiv1">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>跳转UI：</label>
			<div class="layui-input-inline">
				<select name="sectionUi" lay-filter="sectionUi1">
					
				</select>
			</div>
		</div>
		
		<div class="layui-inline layui-form-item" style="display:none;" id="popupDiv1">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>弹窗内容：</label>
			<div class="layui-input-inline">
				<input type="text" name="popupContent"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>跳转地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="sectionUrl"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="updateTemplateImg">确定</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn4">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
		<input type="hidden" name="frameTemplateId" class="frameTemplateId" />
		<input type="hidden" name="index" class="index" />
		<input type="hidden" name="imgUrl" class="imgUrl" />
		<input type="hidden" name ="uploadOpType" class="uploadOpType" />
	</form>
</div>

</html>