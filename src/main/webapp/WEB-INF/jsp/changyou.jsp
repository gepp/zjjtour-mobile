<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		</style>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
			<button onclick="window.location.href='${contextpath}/'" class=" mui-btn mui-btn-blue mui-btn-link mui-btn-nav mui-pull-left"><span class="mui-icon mui-icon-left-nav"></span>返回</button>
			<h1 class="mui-title">${thirdShowName }</h1>
			<a id="menu" class="mui-action-menu mui-icon mui-icon-bars mui-pull-right" style="margin: 0 -10px 0 0;" href="#middlePopover"></a>
		</header>
		<div class="mui-content">
			<div class="mui-content-padded">
				<div class="mui-btn <c:if test="${secondMenuId==''}"> mui-btn-primary</c:if> "  onclick="jumpChangyou('')">
					全部
				</div>
			<c:forEach var="menu" items="${secondMenuList }">
				<div class="mui-btn <c:if test="${secondMenuId==menu.id}"> mui-btn-primary</c:if>" onclick="jumpChangyou('${menu.id}')">
				${menu.name }
				</div>
			</c:forEach>
			</div>
			<ul class="mui-table-view">
				<c:forEach var="item" items="${newsList }">
				<li class="mui-table-view-cell mui-media" onclick="jumpDetail('${item.id}')">
					<a href="javascript:;">
						<img class="mui-media-object mui-pull-left" src="${item.smallimg } ">
						<div class="mui-media-body" style="white-space:nowrap;text-overflow:ellipsis">
							${item.title }
							<p class="mui-ellipsis">${item.abstract_content }</p>
						</div>
					</a>
				</li>
				</c:forEach>
			</ul>
		</div>
		<div id="footer"></div>
		<!--右上角弹出菜单-->
		<div id="header"></div>
	</body>
	<script src="${contextpath}/js/mui.min.js"></script>
	<script src="${contextpath}/js/jquery.min.js"></script>
	<script>
	jQuery(document).ready(function() {
		$("#header").load("${contextpath}/header.htm?type=index");
		/* $("#footer").load("${contextpath}/footer.htm"); */
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
				window.location.href='${contextpath}/changyouDetail.htm?id='+id;
			}
		</script>

</html>