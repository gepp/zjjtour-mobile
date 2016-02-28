<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>活动列表</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">

		<!--标准mui.css-->
		<link rel="stylesheet" href="${contextpath}/css/mui.min.css">
		<!--App自定义的css-->
		<link rel="stylesheet" type="text/css" href="${contextpath}/css/app.css" />
		<style>
			h5 {
				padding-top: 8px;
				padding-bottom: 8px;
				text-indent: 12px;
			}
			input, button, .mui-btn {
				margin-top: 10px;
				margin-left: 10px;
			}
			.mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-body {
				font-size: 15px;
				margin-top: 8px;
				color: #333;
			}
			.mui-grid-view.mui-grid-9 .mui-table-view-cell{border: none;}
			.mui-media .iconfont{color: #00BB9E; font-size: 2em;}
		</style>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
			<button onclick="window.location.href='${contextpath}/'" class=" mui-btn mui-btn-blue mui-btn-link mui-btn-nav mui-pull-left"><span class="mui-icon mui-icon-left-nav"></span>返回</button>
			<h1 class="mui-title">活动列表</h1>
			<a id="menu" class="mui-action-menu mui-icon mui-icon-bars mui-pull-right" style="margin: 0 -10px 0 0;" href="#middlePopover"></a>
		</header>
		<div class="mui-content">
			<div class="mui-content-padded">
				<div class="mui-btn  <c:if test="${activityStatus=='' }"> mui-btn-primary</c:if>" onclick="jumpActivity('')" >
					全部
				</div>
				<div class="mui-btn <c:if test="${activityStatus=='0' }"> mui-btn-primary</c:if>" onclick="jumpActivity('0')">
					未开始
				</div>
				<div class="mui-btn <c:if test="${activityStatus=='1' }"> mui-btn-primary</c:if>" onclick="jumpActivity('1')">
					进行中
				</div>
				<div class="mui-btn <c:if test="${activityStatus=='2' }"> mui-btn-primary</c:if>" onclick="jumpActivity('2')">
					已结束
				</div>
			</div>
			<ul class="mui-table-view mui-grid-view">
				<c:forEach var="item" items="${activityList }">
				<li class="mui-table-view-cell mui-media mui-col-xs-6" onclick="jumpActivityDetail('${item.id}')">
					<a href="#">
						<img class="mui-media-object" src="${item.smallimg }">
						<div class="mui-media-body">${item.title }</div>
					</a>
				</li>
				</c:forEach>
				 
			</ul>
			<!-- <button type="button" class="mui-btn mui-btn-block mui-btn-radius" style="margin: 0;">加载更多</button> -->
		</div>
		<div id="footer"></div>
		<div id="header"></div>
	</body>
	<script src="${contextpath}/js/mui.min.js"></script>
	<script src="${contextpath}/js/jquery.min.js"></script>
	<script>
	jQuery(document).ready(function() {
		$("#header").load("${contextpath}/header.htm?type=index");
		$("#footer").load("${contextpath}/footer.htm");
	});
		mui.init({
			swipeBack: true //启用右滑关闭功能
		});
			mui('.mui-scroll-wrapper').scroll();
			mui('body').on('shown', '.mui-popover', function(e) {
				console.log('shown', e.detail.id); //detail为当前popover元素
			});
			mui('body').on('hidden', '.mui-popover', function(e) {
				console.log('hidden', e.detail.id); //detail为当前popover元素
			});
			var slider = mui("#slider");
			//			document.getElementById("switch").addEventListener('toggle', function(e) {
			//				if (e.detail.isActive) {
			slider.slider({
				interval: 5000
			});
			function jumpActivity(activityStatus){
				window.location.href="${contextpath}/activity.htm?activityStatus="+activityStatus;
			}	
			
			function jumpActivityDetail(id){
				window.location.href="${contextpath}/activityDetail.htm?id="+id;
			}
		</script>

</html>