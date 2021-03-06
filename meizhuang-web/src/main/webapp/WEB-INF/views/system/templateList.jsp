<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>模板名称管理</title>
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
									<div class="layui-inline">
										<label class="layui-form-label">模板名称</label>
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
						url : '/flow/template/getTemplateList',
						method : 'post',
						title : '用户数据表',
						totalRow : false,
						cols : [ [
							{type:'checkbox',fixed:'left'},
							{field:'name', title:'模板名称', width:180,align:'center'},
					        {field:'exampleImg', title:'示例图', width:200,align:'center', toolbar:'#exampleImg'},
					        {field:'minNum', title:'最小张数', width:150, align:'center'},
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
								title: "添加模板", 
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
				        		var exampleImg = data[0].exampleImg;
				        		var state = data[0].state;
				        		var minNum = data[0].minNum;
				        		
				        		$("#updateTemplate input[name='id']").val(id);
				        		$("#updateTemplate input[name='name']").val(name);
				        		$("#updateTemplate #demo2").attr("src",exampleImg);
				        		$("#updateTemplate input[name='exampleImg']").val(exampleImg);
				        		$("#updateTemplate input[name='state']").val(state);
				        		$("#updateTemplate input[name='minNum']").val(minNum);				        		 
				        		renderForm()
				        	}
				        	layer.open({
								type: 1,
								title: "修改模板", 
								area : [ '420px', '450px' ], //宽高
								content:$("#updateTemplate")
							});
				        break;
				      };
				    });
					
				
					
					//添加提交
					form.on('submit(addTemplate)', function(data) {
						//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
						if(!$("button[lay-filter='addBankCard']").hasClass("layui-btn-disabled")){
							$("button[lay-filter='addBankCard']").addClass("layui-btn-disabled").attr("disabled","disabled");
							$.post('/flow/template/addTemplate',
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
						$.post('/flow/template/updateTemplate',
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
					
					
					//关闭弹窗
					$('.closeBtn').click(function() {
						layer.closeAll();
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
			          $("button[lay-filter='addTemplate']").addClass("layui-btn-disabled").attr("disabled","disabled");
			        });
			      }
			      ,done: function(res){
			        //如果上传失败
			        if(res.code > 0){
			          $("button[lay-filter='testButton1']").removeClass("layui-btn-disabled").removeAttr("disabled");
			          $("button[lay-filter='addTemplate']").removeClass("layui-btn-disabled").removeAttr("disabled");
			          return layer.msg('上传失败');
			        }
			        //上传成功
			        $(".exampleImg").val(res.data);
			        $("button[lay-filter='testButton1']").removeClass("layui-btn-disabled").removeAttr("disabled");
			        $("button[lay-filter='addTemplate']").removeClass("layui-btn-disabled").removeAttr("disabled");
			      }
			      ,error: function(){
			    	  $("button[lay-filter='testButton1']").removeClass("layui-btn-disabled").removeAttr("disabled");
			    	  $("button[lay-filter='addTemplate']").removeClass("layui-btn-disabled").removeAttr("disabled");
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
			          $("button[lay-filter='updateTemplate']").addClass("layui-btn-disabled").attr("disabled","disabled");
			        });
			      }
			      ,done: function(res){
			        //如果上传失败
			        if(res.code > 0){
			          $("button[lay-filter='testButton2']").removeClass("layui-btn-disabled").removeAttr("disabled");
			          $("button[lay-filter='updateTemplate']").removeClass("layui-btn-disabled").removeAttr("disabled");
			          return layer.msg('上传失败');
			        }
			        //上传成功
			        $(".exampleImg").val(res.data);
			        $("button[lay-filter='testButton2']").removeClass("layui-btn-disabled").removeAttr("disabled");
			        $("button[lay-filter='updateTemplate']").removeClass("layui-btn-disabled").removeAttr("disabled");
			      }
			      ,error: function(){
			    	  $("button[lay-filter='testButton2']").removeClass("layui-btn-disabled").removeAttr("disabled");
			    	  $("button[lay-filter='updateTemplate']").removeClass("layui-btn-disabled").removeAttr("disabled");
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
<div id="addTemplate" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>模板名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="name" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item" style="margin-bottom:0px;width:250px;">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>示例图：</label>
			<div class="layui-upload">
			  <button type="button" class="layui-btn" id="test1" lay-filter="testButton1">上传示例图</button>
			  <div class="layui-upload-list layui-little-ico" style="margin-left:130px;">
			    <img class="layui-upload-img" id="demo1" style="max-width:100px;_width:expression(this.width > 100 ? '100px' : this.width); max-height:100px;_height:expression(this.height > 100 ? '100px' : this.height);">·
			    <p id="demoText"></p>
			  </div>
			</div>
		</div>
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>最小张数：</label>
			<div class="layui-input-inline">
				<input type="text" name="minNum" lay-verify="amountDayLimit" autocomplete="off"
					class="layui-input">
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
		<input type="hidden" name="agentId" value="0" />
		<input type="hidden" name="exampleImg" class="exampleImg" />
		<input type="hidden" name ="uploadOpType" class="uploadOpType" />
	</form>
</div>
<!-- 修改弹窗 -->
<div id="updateTemplate" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>模板名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="name" lay-verify="required" autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item" style="margin-bottom:0px;width:250px;">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>示例图：</label>
			<div class="layui-upload">
			  <button type="button" class="layui-btn" id="test2" lay-filter="testButton2">上传示例图</button>
			  <div class="layui-upload-list layui-little-ico" style="margin-left:130px;">
			    <img class="layui-upload-img" id="demo2" style="max-width:100px;_width:expression(this.width > 100 ? '100px' : this.width); max-height:100px;_height:expression(this.height > 100 ? '100px' : this.height);">
			    <p id="demoText1"></p>
			  </div>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label layui-w100"><font
				style="color: #D82828">*</font>最小张数：</label>
			<div class="layui-input-inline">
				<input type="text" name="minNum" lay-verify="amountDayLimit" autocomplete="off"
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
				<button class="layui-btn" lay-submit lay-filter="updateTemplate">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="id" class="id" />
		<input type="hidden" name="uid" class="uid" />
		<input type="hidden" name="agentId" value="0" />
		<input type="hidden" name="exampleImg" class="exampleImg" />
		<input type="hidden" name ="uploadOpType" class="uploadOpType" />
	</form>
</div>
</html>