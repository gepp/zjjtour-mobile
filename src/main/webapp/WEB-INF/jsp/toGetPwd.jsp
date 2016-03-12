<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="ui-page-login">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>注册</title>
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
			.mui-input-row a{position: absolute; top: 0; line-height: 40px;  right: 20px;}
		</style>

	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
			<h1 class="mui-title">忘记密码</h1>
		</header>
		<div class="mui-content">
			<form id='login-form' class="mui-input-group">
				<div class="mui-input-row">
					<input id="mobile" name="mobile" type="text" class="mui-input-clear mui-input" placeholder="请输入手机号码">
				</div>
				<div class="mui-input-row">
					<input id="cpassword" name="cpassword" type="password" class="mui-input-clear mui-input" placeholder="请输入新密码">
				</div>
				<div class="mui-input-row">
					<input id="cpassword1" name="cpassword1" type="password" class="mui-input-clear mui-input" placeholder="请再次输入新密码">
				</div>
				<div class="mui-input-row">
					<input  id="verifyCode" name="verifyCode" type="text" class="mui-input-clear mui-input" placeholder="手机验证码">
					<a  onclick="sendCode();" id="getCode">获取验证码</a>
				</div>
			</form>
			
			<div class="mui-content-padded">
				<button id='login' class="mui-btn mui-btn-block mui-btn-primary" onclick="getPwd();">修改密码</button>
				<div class="link-area"><a href="${contextpath }/toLogin.htm">已有账号，立即登录</a></div>
			</div>
			<div class="mui-content-padded oauth-area">

			</div>
		</div>
		<script src="${contextpath}/js/mui.min.js"></script>
		 <script src="${contextpath}/js/jquery.min.js"></script>
		<script src="${contextpath}/js/layer/layer.js"></script>
		<script src="${contextpath}/js/common.js"></script>
	</body>
	</html>
<script type="text/javascript">
	function sendCode() {
		var mobile = $("#mobile").val();
		
		if (trim(mobile) == '') {
			layer.open({
			    content: '请输入手机号码！',
			    btn: ['确定']
			});
			return false;
		} else if (!(/^1[3|4|5|7|8]\d{9}$/.test(mobile))) {
			layer.open({
			    content: '手机号码有误，请 重新输入！',
			    btn: ['确定']
			});
			$("#mobile").focus();
			return false;
		} else {
			$
					.ajax({
						type : "post",
						url : "${contextpath}/isExists.htm?mobile=" + mobile,
						dataType : "json",
						success : function(data) {
							var jsonArray = str2json(data);
							if (jsonArray.data == true) {
								var codeBtn = $("#getCode");
								var ti = 120;
								var t = setInterval(
										function() {
											codeBtn
													.html("重新获取(<span style='color:red;font-size:16px;padding:0 3px;font-weight:bold;'>"
															+ ti + "</span>) ");
											ti--;
											if (ti < 0) {
												clearInterval(t);
												codeBtn.html("获取验证码")
														.removeAttr("disabled")
											}
										}, 1000);
								codeBtn.attr("disabled", "disabled");
								setTimeout('sendCodeTrue()', 100);
							} else {
								
								layer.open({
								    content: '手机号码不存在,请重新输入您的手机号码！',
								    btn: ['确定']
								});
								
								$("#mobile").focus();
								return false;
							}
						}
					});
		}

	}
	function sendCodeTrue() {
		var mobile = $("#mobile").val();
		$.ajax({
			type : "post",
			async : false,
			url : "${contextpath}/sendCodeGetPwd.htm?mobile=" + mobile,
			dataType : "json",
			success : function(data) {
				var jsonArray = str2json(data);
				if (jsonArray.status == 'success') {
					layer.open({
					    content: '验证码已发送！',
					    btn: ['确定']
					});
				} else {
					layer.open({
					    content: jsonArray.error.msg,
					    btn: ['确定']
					});
					$("#mobile").focus();
					return false;
				}
			}
		});
	}

	function getPwd() {
		var mobile = $("#mobile").val();
		var verifyCode = $("#verifyCode").val();
		var cpassword = $("#cpassword").val();
		var cpassword1=$("#cpassword1").val();
		if(cpassword!=cpassword1){
			layer.open({
			    content: '两次密码不一致,请重新输入！',
			    btn: ['确定']
			});
			return false;
		}
		if (trim(mobile) == '') {
			layer.open({
			    content: '请输入手机号码！',
			    btn: ['确定']
			});
			return false;
		} else if (trim(verifyCode) == '') {
			layer.open({
			    content: '请输入验证码！',
			    btn: ['确定']
			});
			return false;
		} else if (trim(cpassword) == '') {
			layer.open({
			    content: '请输入新的密码！',
			    btn: ['确定']
			});
			return false;
		}

		$.ajax({
			type : "post",
			async : false,
			url : "${contextpath}/changePass.htm?mobile=" + mobile
					+ "&verifyCode=" + verifyCode + "&cpassword=" + cpassword,
			dataType : "json",
			success : function(data) {

				var jsonArray = str2json(data);
				if (jsonArray.status == 'success') {
					 layer.open({
						    content: '恭喜您,修改密码成功！',
						    btn: ['确认'],
						    shadeClose: false,
						    yes: function(){
						    	window.location.href="${contextpath}/toLogin.htm";
						    }, no: function(){
						         
						    }
						});
					
				 

				} else {
					layer.open({
					    content:jsonArray.error.msg,
					    btn: ['确定']
					});
					$("#mobile").focus();
					return false;
				}
			}
		});

	}
</script>
