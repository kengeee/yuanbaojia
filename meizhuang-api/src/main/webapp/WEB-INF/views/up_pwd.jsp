<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>修改密码_${SYSTEM_SITE_NAME}</title>
<meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width">
<meta http-equiv="Cache-Control" content="no-siteapp">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-title" content="修改密码_${SYSTEM_SITE_NAME}">
<meta name="apple-mobile-web-app-status-bar-style" content="default">
<meta name="mobile-web-app-capable" content="yes">
<meta name="msapplication-TileColor" content="#007AFF">
<link rel="shortcut icon" href="/static/favicon.ico" type="image/x-icon">

<c:if test="${WEB_CACHE_CONTROL eq '1'}">
	<meta http-equiv="expires" content="0">  
	<meta http-equiv="pragma" content="no-cache">  
	<meta http-equiv="cache-control" content="no-cache"> 
</c:if>

<link rel="stylesheet" type="text/css" href="/static/css/style.css">
<link rel="stylesheet" href="/static/css/layer.css">

<script type="text/javascript" src="/static/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="/static/js/layer.js"></script>

<style>
.contentBody {
    max-width: 800px;
    margin: 0 auto;
}
.public_box {
    padding: 10px;
    font-size: 13px;
    color: #4d4d4d;
}.public_inputtxt {
    width: 100%;
    border: 1px solid #ddd;
    border-radius: 5px;
    height: 40px;
    margin-bottom: 10px;
    box-sizing: border-box;
    text-indent: 10px;
    font-size: 14px;
    color: #666;
}.public_btn {
    background: #333;
    width: 100%;
    height: 45px;
    line-height: 45px;
    border: 0;
    font-size: 14px;
    color: #fff;
    text-align: center;
    display: block;
    border-radius: 4px;
}
.common_style_red {
    background: #ed4040 !important;
    color: #fff !important;
}.user_login_2017  {
    padding: 30px;
}.user_login_2017 .log_links {
    text-align: center;
    margin-top: 20px;
}.or {
    position: relative;
    height: 50px;
    line-height: 50px;
    text-align: center;
}.or span {
    position: relative;
    z-index: 8;
    display: inline-block;
    padding: 0 15px;
    background: #fff;
    color: #808080;
    font-size: 14px;
}.or .line {
    position: absolute;
    width: 100%;
    height: 1px;
    border-bottom: 1px solid #ddd;
    z-index: 7;
    top: 24px;
    left: 0;
}.order-btn-1 {
    background: #333;
    width: 100%;
    height: 45px;
    line-height: 45px;
    border: 0;
    font-size: 14px;
    color: #fff;
    text-align: center;
    display: block;
    border-radius: 4px;
}

.login-content .login-register__tit {
    text-align: center;
    margin-bottom: 20px;
    font-size: 0;
}.login-content .login-register__tit span.on {
    color: #333;
        font-weight: bold;
}
.login-content .login-register__tit span {
    display: inline-block;
    height: 40px;
    line-height: 40px;
    text-align: center;
    font-size: 18px;
    vertical-align: top;
    font-weight: normal;
    position: relative;
    padding: 0 30px;
    color: #999;
    cursor: pointer;
    transition: all 0.3s;
}.login-content .login-register__tit span:nth-child(1):before {
    content: '';
    position: absolute;
    right: 0;
    top: 8px;
    width: 1px;
    height: 24px;
    background: #969494;
}
</style>
<style id="tsbrowser_video_independent_player_style" type="text/css">
      [tsbrowser_force_max_size] {
        width: 100% !important;
        height: 100% !important;
        left: 0px !important;
        top: 0px !important;
        margin: 0px !important;
        padding: 0px !important;
        transform: none !important;
      }
      [tsbrowser_force_fixed] {
        position: fixed !important;
        z-index: 9999 !important;
        background: black !important;
      }
      [tsbrowser_force_hidden] {
        opacity: 0 !important;
        z-index: 0 !important;
      }
      [tsbrowser_hide_scrollbar] {
        overflow: hidden !important;
      }
      [tsbrowser_display_none] {
        display: none !important;
        visibility: hidden !important;
        opacity: 0 !important;
      }
      [tsbrowser_force_show] {
        display: black !important;
        visibility: visible !important;
        opacity: 0;
      }
      
      .user_info{
      	width: 100%;
      }
      .item_tip{
      width: 22%
      }
      .item_text{
      width: 78%
      }
      </style>
      
      </head>
<body style="">

<div class="contentBody">

<div id="head-bar">
<div class="head-bar">
<div class="head-bar-back">
<a href="javascript:history.go(-1);" onclick="javascript:history.go(-1);" data-direction="reverse">
<img src="/static/images/icon-back.png" width="24" height="24"></a>
</div>
<div class="head-bar-title">修改密码</div>

</div>
<div class="head-bar-fix"></div>
</div>




<div id="body_box" class="login-content">



<div class="box notranslate">
  <form action="${HOME_DOMAIN_NAME}/upPwdDo" method="post"  >
    <div class="public_box">
   
     <table class="user_info">
     	<tr>
     	<td class="item_tip">原密码:</td>
     	<td class="item_text"><input class="public_inputtxt" placeholder="旧密码" id="oldPwd" name="oldPwd" type="password">
     	</td>
     	</tr>
     	<tr>
     	<td class="item_tip">新密码:</td>
     	<td class="item_text"><input class="public_inputtxt" placeholder="新密码" id="newPwd"  name="newPwd" type="password">
        </td>
     	</tr>
     	
     	<tr>
     	<td class="item_tip">确认新密码:</td>
     	<td class="item_text"><input class="public_inputtxt" placeholder="确认新密码" id="newPwd2"  name="newPwd2" type="password">
        </td>
     	</tr>
     	
     	
     </table>
        <button class="public_btn register common_style_red">修改密码</button>
       
            
    </div>
  </form>
</div>

<c:if test="${ msg != null }">
  <script type="text/javascript">
		      //提示
			  layer.open({
			    content: "${msg}"
			    ,skin: 'msg'
			    ,time: 3
			  });
		</script>
</c:if>

<script type="text/javascript">
 	


    $('.login_btn').click(function(){
        
		
        if($('#user_pwd').val()=='' || $('#user_pwd').val()=='Password')
        {
            alert("请输入密码");
            return;
        }
		
		if(!/^.{6,20}$/.test($('#user_pwd').val()))
			{
				alert("密码长度必须是 6-20 位数");
				return false;
			}
    });
</script>
</div>
     <div style="height: 100px"></div>

   <div class="home_footer">
              
        <ul class="navbar">
                        
            <li class="navbar-item">
                <a href="/index">
                    <img src="/static/images/home.png" alt="">
                    <p>小猿找货</p>
                </a>
            </li>
            <li class="navbar-item">
                <a href="/uploadProduct">
                    <img src="/static/images/publish.png" alt="">
                    <p>上传报价</p>
                </a>
            </li>
         
         	<li class="navbar-item">
                <a href="/realTimeProduct">
                    <img src="/static/images/realtime.png" alt="">
                    <p>实时报价</p>
                </a>
            </li>
         
            <li class="navbar-item active">
                <a href="/userInfo">
                    <img src="/static/images/me_active.png" alt="">
                    <p>我</p>
                </a>
            </li>
        </ul>

    </div>

</div>
</body></html>