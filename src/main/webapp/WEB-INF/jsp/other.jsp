<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>${other.name }</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">

		<!--标准mui.css-->
		<link rel="stylesheet" href="${contextpath}/css/mui.min.css">
		<!--App自定义的css-->
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
			<h1 class="mui-title">${other.name }</h1>
			<a id="menu" class="mui-action-menu mui-icon mui-icon-bars mui-pull-right" style="margin: 0 -10px 0 0;" href="#middlePopover"></a>
		</header>
		<div class="mui-content">
			<div class="mui-content-padded">
				 
			<c:forEach var="secondMenu" items="${secondMenuList }">
				<div <c:if test="${secondMenu.id==secondMenuId}">class="mui-btn mui-btn-primary"</c:if>
					<c:if test="${secondMenu.id!=secondMenuId}">class="mui-btn "</c:if>
				onclick="jumpOther('${secondMenu.id}','${other.id }')" >
				${secondMenu.name }
				</div>
			</c:forEach>
			</div>
			<input type="hidden" name="secondMenuId" id="secondMenuId" value="${secondMenuId }"/>
		<input type="hidden" name="currentId" id="currentId" value="${currentId }"/>
			<ul class="mui-table-view">
				<c:forEach var="item" items="${pageList.list }">
				<li class="mui-table-view-cell mui-media" onclick="jumpDetail('${item.id}')">
					<a href="javascript:;">
						<img class="mui-media-object mui-pull-left" src="${item.smallimg } ">
						<div class="mui-media-body">
							${item.title }
							<p class="mui-ellipsis">${item.abstractContent }</p>
						</div>
					</a>
				</li>
				</c:forEach>
			</ul>
		</div>
		<input type="hidden" name="secondMenuId" id="secondMenuId" value="${secondMenuId }"/>
		<input type="hidden" name="currentId" id="currentId" value="${currentId }"/>
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
				var secondMenuId=$("#secondMenuId").val();
				var bqId=$("#currentId").val();
				window.location.href='${contextpath}/otherDetail.htm?id='+id+"&bqId="+bqId+"&secondMenuId="+secondMenuId+'&otherId=${other.id}';
			}
		</script>

</html>