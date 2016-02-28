<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <!DOCTYPE html>
<html class="ui-page-login">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>我要投诉</title>
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
			<button class="mui-action-back mui-btn mui-btn-blue mui-btn-link mui-btn-nav mui-pull-left"><span class="mui-icon mui-icon-left-nav"></span>返回</button>
			<h1 class="mui-title">我要投诉</h1>
		</header>
		<div class="mui-content">
			<form id='login-form' class="mui-input-group">
				<div class="mui-input-row">
					<input name="complain_title" id="complain_title" type="text" class="mui-input-clear mui-input" placeholder="请输入投诉标题">
				</div>
				<div>
					<textarea name="complain_message" id="complain_message" rows="5"  placeholder="请输入投诉内容"></textarea>
				</div>
			</form>
			
			<div class="mui-content-padded">
				<button onclick="tousu();" class="mui-btn mui-btn-block mui-btn-primary">投诉</button>
			</div>
			<div class="mui-content-padded oauth-area">

			</div>
		</div>
		<div id="header"></div>
	<script src="${contextpath}/js/mui.min.js"></script>
	<script type="text/javascript" src="${contextpath }/js/jquery.min.js"></script>
	<script src="${contextpath}/js/layer/layer.js"></script>
	<script src="${contextpath}/js/common.js"></script>

	<script>
		jQuery(document).ready(function() {
			$("#header").load("${contextpath}/header.htm?type=index");
		});
		function tousu(){
			if('${member}'==''){
				 layer.open({
					    content: '请您先登录！',
					    btn: ['确认'],
					    shadeClose: false,
					    yes: function(){
					    	window.location.href="${contextpath}/toLogin.htm";
					    }
					    , no: function(){
					         
					    }
					});
				 
				
			}
			
			var complain_title=$("#complain_title").val();
			var complain_message=$("#complain_message").val();
			if(complain_title==''){
				layer.open({
				    content: '请输入标题！',
				    btn: ['OK']
				});
				return false;
			}
			else if(complain_message==''){
				layer.open({
				    content: '请输入投诉内容！',
				    btn: ['OK']
				});
				return false;
			}
			else{
				$.ajax({
					type: "post", 
					  async: false,
					url: "${contextpath}/saveTousu.htm", 
					data:{"complain_title":complain_title,"complain_message":complain_message},
					dataType: "json",
					success: function (data) { 
						 if(data.status=='success'){
							 layer.open({
								    content: '投诉成功！',
								    btn: ['确认'],
								    shadeClose: false,
								    yes: function(){
								    	 window.location.href="${contextpath}/tousu.htm";
								    }
								    , no: function(){
								         
								    }
								});
							 
							 
							 
						 }else{
							 layer.open({
								    content: '请稍后再试！',
								    btn: ['OK']
								});
						 }
					} 
			});
			}
			
		}
		 
	</script>
</body>

</html>