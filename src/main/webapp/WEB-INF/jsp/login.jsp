<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="ui-page-login">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>登录</title>
		<link href="${contextpath}/css/mui.min.css" rel="stylesheet" />
		<style>
			.area {
				margin: 20px auto 0px auto;
			}
			.mui-input-group {
				margin-top: 10px;
			}
			.mui-input-group:first-child {
				margin-top: 20px;
			}
			.mui-input-row label~input,
			.mui-input-row label~select,
			.mui-input-row label~textarea {
				width: 100%;
			}
			.mui-checkbox input[type=checkbox],
			.mui-radio input[type=radio] {
				top: 6px;
			}
			.mui-content-padded {
				margin-top: 25px;
			}
			.mui-btn {
				padding: 10px;
			}
			.link-area {
				display: block;
				margin-top: 25px;
				text-align: center;
			}
			.spliter {
				color: #bbb;
				padding: 0px 8px;
			}
			.oauth-area {
				position: absolute;
				bottom: 20px;
				left: 0px;
				text-align: center;
				width: 100%;
				padding: 0px;
				margin: 0px;
			}
			.oauth-area .oauth-btn {
				display: inline-block;
				width: 50px;
				height: 50px;
				background-size: 30px 30px;
				background-position: center center;
				background-repeat: no-repeat;
				margin: 0px 20px;
				/*-webkit-filter: grayscale(100%); */
				
				border: solid 1px #ddd;
				border-radius: 25px;
			}
			.oauth-area .oauth-btn:active {
				border: solid 1px #aaa;
			}
		</style>

	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
			<h1 class="mui-title">登录</h1>
		</header>
		<div class="mui-content">
			<form id='login-form' class="mui-input-group">
				<div class="mui-input-row">
					<input id="mobile" name="mobile" type="text" class="mui-input-clear mui-input" placeholder="请输入手机号码">
				</div>
				<div class="mui-input-row">
					<input id="cpassword" name="cpassword" type="password" class="mui-input-clear mui-input" placeholder="请输入密码">
				</div>
			</form>
		 
			<div class="mui-content-padded">
				<button onclick="login();" class="mui-btn mui-btn-block mui-btn-primary">登录</button>
				<div class="link-area"><a href="${contextpath }/toRegister.htm">注册账号</a> <span class="spliter">|</span> <a id='forgetPassword'>忘记密码</a>
				</div>
			</div>
			<div class="mui-content-padded oauth-area">

			</div>
		</div>
		<script src="${contextpath}/js/mui.min.js"></script>
		<script src="${contextpath}/js/jquery.min.js"></script>
		<script src="${contextpath}/js/layer/layer.js"></script>
		<script src="${contextpath}/js/common.js"></script>
		<script>
		function login(){
			var mobile = $("#mobile").val();
			var cpassword = $("#cpassword").val();
			if ((mobile) == '') {
				layer.open({
				    content: '请输入手机号码！',
				    btn: ['OK']
				});
				 
				return false;
			} else if ((cpassword) == '') {
				layer.open({
				    content: '请输入密码！',
				    btn: ['OK']
				});
				return false;
			}
			
			 $.ajax({
					type: "post", 
					  async: false,
					url: "${contextpath}/login.htm?mobile="+mobile+"&cpassword="+cpassword, 
					dataType: "json",
					success: function (data) { 
						 var jsonArray=str2json(data);
						 if(jsonArray.status=='success'){
							  
							 window.location.href="${contextpath}/";
						 }else{
							 layer.open({
								    content: jsonArray.error.msg,
								    btn: ['OK']
								});
							 $("#mobile").focus();
							 return false;
						 }
					} 
			});
		} 
		</script>
	</body>

</html>