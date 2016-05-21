<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>${thirdShowName }</title>
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
			.mui-table-view-cell h5 {
				text-indent: 0;
			}
			input, button, .mui-btn {
				margin-top: 10px;
				margin-left: 10px;
			}
			.mui-table-view-cell h4 {
				line-height: 24px;
			}
			.mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-body {
				font-size: 15px;
				margin-top: 8px;
				color: #333;
			}
			.mui-grid-view.mui-grid-9 .mui-table-view-cell{border: none;}
			.mui-media .iconfont{color: #00BB9E; font-size: 2em;}
			
			.leader>li>a>img{width: 60%; display: block; margin: 0 auto;}
			.mui-table-view-cell:after{left: 0;}
			.leader .mui-media-body{padding-top: 15px; text-align: center; overflow: auto;}
			.leader .mui-media-body>p{margin-top: 10px; text-align: left; text-indent: 2em; white-space: normal;}
			.mui-ellipsis {
				overflow: hidden;
				 white-space: normal; 
				text-overflow: ellipsis;
				overflow: hidden;
				text-overflow: ellipsis;
				display: -webkit-box;
				-webkit-line-clamp: 2;
				-webkit-box-orient: vertical;
			}
			.more{float: right; margin-right: 10px;}

		</style>
	</head>

	<body>
	<div id="header"></div>
		 <header class="mui-bar mui-bar-nav">
			<button class="mui-action-back mui-btn mui-btn-blue mui-btn-link mui-btn-nav mui-pull-left"><span class="mui-icon mui-icon-left-nav"></span>返回</button>
			<h1 class="mui-title">
				<c:if test="${news_type=='ZYHD' }">重要活动</c:if>
				<c:if test="${news_type=='ZYJH' }">重要讲话</c:if>
				<c:if test="${news_type=='MTBD' }">媒体报道</c:if>
			</h1>
			<a id="menu" class="mui-action-menu mui-icon mui-icon-bars mui-pull-right" style="margin: 0 -10px 0 0;" href="#middlePopover"></a>
		</header>
		<div class="mui-content">
			 
			
			<!--重要活动-->
			<h5>重要活动</h5>
			<ul class="mui-table-view mui-table-view-chevron">
				<c:forEach var="item" items="${pageList.list }">
				<li class="mui-table-view-cell mui-media"  onclick="jumpDetail('${item.id}')">
					<a class="mui-navigate-right">
						<img class="mui-media-object mui-pull-left" src="${item.smallimg }">
						<div class="mui-media-body">
							${item.title }
							<p class="mui-ellipsis">${item.abstractContent }</p>
						</div>
					</a>
				</li>
				</c:forEach>
				 <c:if test="${fn:length(pageList.list)<=0}">
				 <li class="mui-table-view-cell mui-media">
				 	暂无
				 </li>
				 </c:if>
			</ul>
			
			 
			 
		</div>
	</body>
	<script src="${contextpath}/js/mui.min.js"></script>
	<script src="${contextpath}/js/jquery.min.js"></script>
	<script>
	jQuery(document).ready(function() {
		$("#header").load("${contextpath}/header.htm?type=index");
		 
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
			slider.slider({
				interval: 5000
			});
			function jumpDetail(id){
				window.location.href='${contextpath}/tingwenDetail.htm?id='+id;
			}
			function jumpTingwen(secondMenuId){
				window.location.href="${contextpath}/tingwen.htm?secondMenuId="+secondMenuId;
			}
			function gotoMore(type){
				window.location.href='${contextpath}/lingdaoTingwen.htm?menu_id=${lingdao.id}&news_type='+type;
				
			}
		</script>

</html>