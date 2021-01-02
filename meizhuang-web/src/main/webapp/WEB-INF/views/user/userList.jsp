<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>商户列表</title>
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
									<label class="layui-form-label">创建时间</label>
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
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateMerchant">状态修改</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="updateUserInfo">修改用户信息</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="resetPwd">重置密码</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="delUserInfo">删除用户</button>
									<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="marketClass">市场分类</button>
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
		
		<script type="text/html" id="loginStatus">
	     	{{# if( d.loginStatus==0 ){	}}
			<font style="color: red">禁止</font>
	     	{{# }else if( d.loginStatus==1 ){	}}
			<font style="color: green">正常</font>
	    	{{# }	}}
	    </script>
	    
	    <script type="text/html" id="auditStatus">
	     	{{# if( d.auditStatus==0 ){	}}
			<font style="color: red">未审核</font>
	     	{{# }else if( d.auditStatus==1 ){	}}
			<font style="color: green">已审核</font>
	    	{{# }	}}
	    </script>
	    
	    
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
					url: '/flow/userInfo/geUserInfos',
					method: 'post',
					title: '用户数据表',
					totalRow: true,
					initSort: {field:'ctime', type:'desc'},
					where: {sortField:'ctime', sortType:'desc',merchantType:'1001'},
					cols: [[
						  {type:'checkbox',fixed:'left'},
						  {field:'uid', title:'商户UID', width:'80',align:'center'},
						  {field:'mobile', title:'手机号', width:'120',align:'center'},
				          {field:'weixin', title:'微信账号', width:'120',align:'center'},
				          {field:'weixinImg', title:'微信二维码', width:'100',align:'center', templet: function(d){
				            	if(d.weixinImg!='' && d.weixinImg!= null){
				            		return '<img src="/getFile/'+d.weixinImg+'/" width=35 height=35 lay-event="details">';
					        	 }
					        	 return "";
							}},
							{field:'logoImg', title:'logo', width:'100',align:'center', templet: function(d){
				            	if(d.logoImg!='' && d.logoImg!= null){
				            		return '<img src="/getFile/logo/'+d.logoImg+'/" width=35 height=35 lay-event="logoDetails">';
					        	 }
					        	 return "";
							}},
				          {field:'storeName', title:'店名', width:'120',align:'center'},
						  {field:'storeRemark', title:'店备注', width:'120',align:'center'},
						  {field:'tradeStall', title:'市场档口位置', width:'120',align:'center'},
						  {field:'marketLid', title:'市场分类', width:'250', align:'center', templet:function(d){
						    if(d.marketSid !=0){
						    	return d.marketCname +"/" +d.marketMname + "/"+ d.marketLname+ "/"+ d.marketSname;
						    }else if(d.marketLid != 0){
						  		return d.marketCname +"/" +d.marketMname + "/"+ d.marketLname;
						  	}
						  	return "";
						  }},
						  {title:'登录状态', toolbar:"#loginStatus", width:'100',align:'center'},
						  {title:'审核状态', toolbar:"#auditStatus", width:'100',align:'center'},						  
						  {field:'auditRemark', title:'审核备注', width:'120',align:'center'},
						  {field:'ctime', title:'创建时间', width:'170',align:'center',sort:true},
						  {field:'mtime', title:'更新时间', width:'170',align:'center',sort:true},
						  {field:'lastLoginTime', title:'最近登录时间', width:'170',align:'center',sort:true},
						  
				          
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

				//监听行工具事件
				table.on('tool(test-table-totalRow)', function(obj) {
					if (obj.event === 'details') {
						var data = obj.data;
						var img = '/file/getImage/'+data.weixinImg+'/';
						layer.open({
							type : 1,
							title : "微信二维码",
							area : [ '500px', '480px' ], //宽高
							content : "<img src='"+img+"' width=500>"
						});
					}else if(obj.event === 'logoDetails') {
						var data = obj.data;
						var img = '/file/getImage/logo/'+data.logoImg+'/';
						layer.open({
							type : 1,
							title : "LOGO",
							area : [ '500px', '480px' ], //宽高
							content : "<img src='"+img+"' width=500>"
						});
					}
					
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
			        	}else if(data.length>1){
			        		layer.msg('最多选择一项');
			        		break;
			        	}else{
			        		var uid = data[0].uid;
			        		var loginStatus = data[0].loginStatus;
			        		var auditStatus = data[0].auditStatus;
			        		var auditRemark = data[0].auditRemark;
			        		
			 			    $("#updateMerchant select[name='loginStatus']").val(loginStatus);
			        		$("#updateMerchant select[name='auditStatus']").val(auditStatus);
			        		$("#updateMerchant input[name='auditRemark']").val(auditRemark);
			        		
			        		$("#updateMerchant .uid").val(uid);
			        		renderForm();
			        	}
			        	layer.open({
							type: 1,
							title: "修改商户状态", 
							area : [ '450px', '350px' ], //宽高
							content:$("#updateMerchant")
						});
			        break;
			        
			        case 'updateUserInfo':
				        if(data.length<1){
				        		layer.msg('至少选择一项');
				        		break;
				        	}else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		break;
				        	}else{
				        		var uid = data[0].uid;
				        		var mobile = data[0].mobile;
				        		var weixin = data[0].weixin;
				        		var storeName = data[0].storeName;
				        		var storeRemark = data[0].storeRemark;
				        		var tradeStall = data[0].tradeStall;
				        		
				        		
				        		$("#updateUserInfo input[name='mobile']").val(mobile);
				        		$("#updateUserInfo input[name='weixin']").val(weixin);
				        		$("#updateUserInfo input[name='storeName']").val(storeName);
				        		$("#updateUserInfo input[name='storeRemark']").val(storeRemark);
				        		$("#updateUserInfo input[name='tradeStall']").val(tradeStall);
				        		$("#updateUserInfo .uid").val(uid);
				        		renderForm();
				        	}
				        	layer.open({
								type: 1,
								title: "修改用户信息", 
								area : [ '450px', '450px' ], //宽高
								content:$("#updateUserInfo")
							});
			        break;
			        case 'resetPwd':
			           if(data.length<1){
				        		layer.msg('至少选择一项');
				        		break;
				       }else if(data.length>1){
				        		layer.msg('最多选择一项');
				        		break;
				      }else{
				      	var uid = data[0].uid;
				      	$("#resetPwd .uid").val(uid);
				        renderForm();
			        	layer.open({
								type: 1,
								title: "重置新密码", 
								area : [ '450px', '250px' ], //宽高
								content:$("#resetPwd")
						});
					  }
			        break;
			        
			        case 'delUserInfo':
			        
				       if(data.length<1){
					       layer.msg('至少选择一项');
					       break;
					   }
			        	var ids = "-1";
						for(var i = 0; i < data.length; i++) {
								//uids.push(data[i].uid);
							ids += ","+data[i].uid;
						}
							
						layer.confirm('请确认选择的用户要删除?', function(index){
							var jsonD = {
									ids:ids
							}
							$.post('/flow/userInfo/batchDel', jsonD,
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
			        case 'marketClass':
			        	if(data.length<1){
				        	layer.msg('至少选择一项');
				        	break;
				       	}else if(data.length>1){
				        	layer.msg('最多选择一项');
				        	break;
				     	}
				     	var uid = data[0].uid;
				     	var marketLid  = data[0].marketLid;
				     	$("#marketClass .uid").val(uid);
				        renderForm();
			        	layer.open({
								type: 1,
								title: "市场分类", 
								area : [ '450px', '350px' ], //宽高
								content:$("#marketClass")
						});
						
						$.post("/flow/marketClass/getParentMarketClass",{type:1}, function(data) {
							if(data.success) {
								var data = data.data;
								var merchantIdOpt = "<option>请选择</option>";
								for(var i = 0; i < data.length; i++) {
									merchantIdOpt += '<option value="' + data[i].id + '">' + data[i].className  + '</option>';
								}
								$("select[name='marketCid']").html(merchantIdOpt);
								renderForm();
							} else {
								layer.msg(data.msg, {
									icon: 5
								});
							}
						});
				     	
			        break;
			      };
			    });
				
			  	
			  	form.on('select(marketCid)',function(data){
						var v = data.value;
						if(v == null || v == ''){
							return;
						}
		
						//
						$.post("/flow/marketClass/getParentIdMarketClass",{pid:v}, function(data) {
							if(data.success) {
								var data = data.data;
								var merchantIdOpt = "<option>请选择</option>";
								for(var i = 0; i < data.length; i++) {
									merchantIdOpt += '<option value="' + data[i].id + '">' + data[i].className + '</option>';
								}
								$("select[name='marketMid']").html(merchantIdOpt);
								renderForm();
							} else {
								layer.msg(data.msg, {
									icon: 5
								});
							}
						});
					
				});
				
				form.on('select(marketMid)',function(data){
						var v = data.value;
						if(v == null || v == ''){
							return;
						}
		
						//
						$.post("/flow/marketClass/getParentIdMarketClass",{pid:v}, function(data) {
							if(data.success) {
								var data = data.data;
								var merchantIdOpt = "<option>请选择</option>";
								for(var i = 0; i < data.length; i++) {
									merchantIdOpt += '<option value="' + data[i].id + '">'  + data[i].className +  '</option>';
								}
								$("select[name='marketLid']").html(merchantIdOpt);
								renderForm();
							} else {
								layer.msg(data.msg, {
									icon: 5
								});
							}
						});
					
				});
				
				form.on('select(marketLid)',function(data){
						var v = data.value;
						if(v == null || v == ''){
							return;
						}
		
						//
						$.post("/flow/marketClass/getParentIdMarketClass",{pid:v}, function(data) {
							if(data.success) {
								var data = data.data;
								var merchantIdOpt = "";
								for(var i = 0; i < data.length; i++) {
									merchantIdOpt += '<option value="' + data[i].id + '">'  + data[i].className +  '</option>';
								}
								$("select[name='marketSid']").html(merchantIdOpt);
								renderForm();
							} else {
								layer.msg(data.msg, {
									icon: 5
								});
							}
						});
					
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
				
				
				
				//修改用户信息提交
				form.on('submit(updateUserInfo)', function(data) {
					//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
					$.post('/flow/userInfo/updateUserInfo',
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
				
				//
				form.on('submit(marketClass)', function(data) {
					//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
					$.post('/flow/userInfo/marketClass',
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
				
				
				form.on('submit(resetPwd)', function(data) {
					//layer.alert(JSON.stringify(data.field), {title: '最终的提交信息'});
					$.post('/flow/userInfo/resetPwd',
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
				style="color: #D82828"></font>审核备注：</label>
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


<!-- 修改弹窗 -->
<div id="updateUserInfo" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width: 120px"><font
				style="color: #D82828"></font>手机号：</label>
			<div class="layui-input-inline">
				<input type="text" name="mobile"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width: 120px"><font
				style="color: #D82828"></font>微信账号：</label>
			<div class="layui-input-inline">
				<input type="text" name="weixin"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width: 120px"><font
				style="color: #D82828"></font>店名：</label>
			<div class="layui-input-inline">
				<input type="text" name="storeName"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width: 120px"><font
				style="color: #D82828"></font>店备注：</label>
			<div class="layui-input-inline">
				<input type="text" name="storeRemark"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width: 120px"><font
				style="color: #D82828"></font>市场档口位置：</label>
			<div class="layui-input-inline">
				<input type="text" name="tradeStall"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="updateUserInfo">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="uid" class="uid" />
	</form>
</div>

<!-- 重置新密码 -->
<div id="resetPwd" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">

		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width: 120px"><font
				style="color: #D82828">*</font>新密码：</label>
			<div class="layui-input-inline">
				<input type="text" name="pwd"  autocomplete="off"
					class="layui-input">
			</div>
		</div>
		
		
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="resetPwd">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="uid" class="uid" />
	</form>
</div>

<!-- 市场分类-->
<div id="marketClass" class="layui-mask-label"
	style="display: none; padding: 20px;">
	<form class="layui-form" action="">
		
		<div class="layui-inline layui-form-item" >
			<label class="layui-form-label" style="width: 120px">城市：</label>
			<div class="layui-input-inline layui-short-select" >
				<select  name="marketCid" lay-filter="marketCid">
					
				</select>
			</div>
		</div>
		
		<div class="layui-inline layui-form-item" >
			<label class="layui-form-label" style="width: 120px">市场：</label>
			<div class="layui-input-inline layui-short-select" >
				<select  name="marketMid" lay-filter="marketMid">
					
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width: 120px"><font
				style="color: #D82828"></font>楼层：</label>
			<div class="layui-input-inline">
				<select  name="marketLid" lay-filter="marketLid">
					
				</select>
			</div>
		</div>
		<div class="layui-inline layui-form-item">
			<label class="layui-form-label"  style="width: 120px"><font
				style="color: #D82828"></font>位置：</label>
			<div class="layui-input-inline">
				<select  name="marketSid" lay-filter="marketSid">
					
				</select>
			</div>
		</div>
		
		<div class="layui-form-item" style="margin-top: 20px">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="marketClass">修改</button>
				<button type="reset" class="layui-btn layui-btn-primary closeBtn">取消</button>
			</div>
		</div>
		<input type="hidden" name="uid" class="uid" />
	</form>
</div>



</html>