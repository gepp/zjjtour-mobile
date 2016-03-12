<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>${indexMap.title }</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">

		<!--标准mui.css-->
		<link rel="stylesheet" href="${contextpath}/css/mui.min.css">
		<!--App自定义的css-->
		<!--<link rel="stylesheet" type="text/css" href="${contextpath}/css/app.css" />-->
		<style>
			/*跨webview需要手动指定位置*/
			
			.mui-plus header.mui-bar {
				display: none!important;
			}
			
			.mui-plus .mui-bar-nav~.mui-content {
				padding: 0!important;
			}
			
			.mui-plus .plus {
				display: inline;
			}
			
			.plus {
				display: none;
			}
			
			#topPopover {
				position: fixed;
				top: 16px;
				right: 6px;
			}
			
			#topPopover .mui-popover-arrow {
				left: auto;
				right: 6px;
			}
			
			.mui-table-view-cell.mui-collapse .mui-table-view.mui-table-view-chevron {
				margin-right: -15px;
			}
			
			h5 {
				padding-top: 8px;
				padding-bottom: 8px;
				text-indent: 12px;
				color:#000;
				font-weight:bolder;
			}
			
			.mui-table-view-cell h5 {
				text-indent: 0;
			}
			
			.mui-table-view-cell h4 {
				line-height: 24px;
			}
			.mui-grid-view.mui-grid-9 .mui-table-view-cell{border: none;}
			.mui-media .iconfont{color: #00BB9E; font-size: 2em;}
			.mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-body {
				font-size: 15px;
				margin-top: 8px;
				color: #333;
			}
			
		</style>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
			
			
			<a id="menu" class="mui-action-menu mui-icon mui-icon-bars mui-pull-right" style="margin: 0;" href="#middlePopover"></a>
			<a class="mui-icon mui-icon-contact mui-pull-right" style="margin: 0;" href="
			<c:if test="${member!=null }"> ${contextpath }/memberCenter.htm </c:if>
			<c:if test="${member==null }"> #picture </c:if>
			"></a>
			<img src="${contextpath}/images/zjj-logo.png" height="36px" style="margin-top: 4px;">
		</header>
		<div class="mui-content">
			<div id="slider" class="mui-slider">
				<div class="mui-slider-group mui-slider-loop">
					
					 <c:forEach items="${advList }" var="adv">
					<div class="mui-slider-item">
						<a href="${adv.jumpUrl }">
							<img src="${adv.imgUrl }">
							<p class="mui-slider-title">${adv.title }</p>
						</a>
					</div>
					 </c:forEach>
				</div>
				<div class="mui-slider-indicator mui-text-right">
					<div class="mui-indicator mui-active"></div>
					<div class="mui-indicator"></div>
					<div class="mui-indicator"></div>
					<div class="mui-indicator"></div>
				</div>
			</div>
			<!--畅游张家界-->
			<h5>全景<span style="float:right;margin-right: 12px;font-weight: normal;" onclick="window.location.href='${contextpath}/quanjing.htm'">更多</span></h5>
			<ul class="mui-table-view mui-grid-view">
				<c:forEach items="${quanjingList }" var="quanjing">
				<li class="mui-table-view-cell mui-media mui-col-xs-6">
					<a href="javascript:void(0)"  onclick="jumpQuanjingDetail('${quanjing.id}')">
						<img class="mui-media-object" src="${quanjing.indeximg }">
						<div class="mui-media-body">${quanjing.title }</div>
					</a>
				</li>
				 </c:forEach>
			</ul>
			<h5>畅游张家界<span style="float:right;margin-right: 12px;font-weight: normal;" onclick="window.location.href='${contextpath}/changyou.htm'">更多</span></h5>
			<ul class="mui-table-view mui-grid-view">
				<c:forEach items="${changyouList }" var="changyou">
				<li class="mui-table-view-cell mui-media mui-col-xs-6">
					<a href="javascript:void(0)"  onclick="jumpChangyouDetail('${changyou.id}')">
						<img class="mui-media-object" src="${changyou.indeximg }">
						<div class="mui-media-body">${changyou.title }</div>
					</a>
				</li>
				 </c:forEach>
			</ul>
			
			
			
			<!--畅游张家界 end-->
			<!--休闲张家界-->
			<h5>休闲张家界<span style="float:right;margin-right: 12px;font-weight: normal;" onclick="window.location.href='${contextpath}/xiuxian.htm'">更多</span></h5>
			<ul class="mui-table-view mui-table-view-chevron">
				<li class="mui-table-view-cell mui-media" onclick="jumpXiuxiansecond('${meishiMenu.id}');">
					<a class="mui-navigate-right">
						<img class="mui-media-object mui-pull-left" src="${meishiMenu.img }-wxxindex">
						<div class="mui-media-body">
							${meishiMenu.name }
							<p class="mui-ellipsis">${meishiMenu.description }</p>
						</div>
					</a>
				</li>
				<li class="mui-table-view-cell mui-media" onclick="jumpXiuxiansecond('${jiudianMenu.id}');">
					<a class="mui-navigate-right" href="javascript:;">
						<img class="mui-media-object mui-pull-left" src="${jiudianMenu.img }-wxxindex">
						<div class="mui-media-body">
							${jiudianMenu.name }
							<p class="mui-ellipsis">${jiudianMenu.description }</p>
						</div>
					</a>
				</li>
				<li class="mui-table-view-cell mui-media" onclick="jumpXiuxiansecond('${jingdianMenu.id}');">
					<a class="mui-navigate-right">
						<img class="mui-media-object mui-pull-left" src="${jingdianMenu.img }-wxxindex">
						<div class="mui-media-body">
							${jingdianMenu.name }
							<p class="mui-ellipsis">${jingdianMenu.description }</p>
						</div>
					</a>
				</li>
				<li class="mui-table-view-cell mui-media" onclick="jumpXiuxiansecond('${menpiaoMenu.id}');">
					<a class="mui-navigate-right">
						<img class="mui-media-object mui-pull-left" src="${menpiaoMenu.img }-wxxindex">
						<div class="mui-media-body">
							${menpiaoMenu.name }
							<p class="mui-ellipsis">${menpiaoMenu.description}</p>
						</div>
					</a>
				</li>
			</ul>
			<!--休闲张家界 end-->

			<!--娱乐张家界-->
			<h5>娱乐张家界 <span style="float:right;margin-right: 12px;font-weight: normal;" onclick="window.location.href='${contextpath}/activity.htm'">更多</span></h5>
			<ul class="mui-table-view mui-grid-view">
				<c:forEach var="yule" items="${activityList }">
				<li class="mui-table-view-cell mui-media mui-col-xs-12" onclick="jumpActivityDetail('${yule.id}')">
					<a href="#">
						<img class="mui-media-object" src="${yule.indeximg }">
						<div class="mui-media-body">${yule.abstractContent }</div>
					</a>
				</li>
				 </c:forEach>
			</ul>
			<!--娱乐张家界 end-->
			<!--听闻张家界-->
			<h5>听闻张家界<span style="float:right;margin-right: 12px;font-weight: normal;" onclick="window.location.href='${contextpath}/tingwen.htm'">更多</span></h5>
			<ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
				<c:forEach var="tingwen" items="${tingwenList }">
				<li class="mui-table-view-cell" onclick="jumpTingwenDetail('${tingwen.id}')">
					<div class="mui-table">
						<div class="mui-table-cell mui-col-xs-10">
							<h4 class="mui-ellipsis-2">${tingwen.title }</h4>
							<fmt:formatDate value="${tingwen.ctime }" pattern="yyyy-MM-dd" var="ctime"/>
							<h5 class="mui-h6">发布时间：${ctime }</h5>
							<p class="mui-h5 mui-ellipsis">${tingwen.abstractContent }</p>
						</div>
					</div>
				</li>
				 </c:forEach>
			</ul>
			<!--听闻张家界 end-->

		</div>
		<div id="footer"></div>
		<!--右上角弹出菜单-->
		<div id="header"></div>


		<script src="${contextpath}/js/mui.min.js"></script>
		<script src="${contextpath}/js/jquery.min.js"></script>
		<script>
		jQuery(document).ready(function() {
			$("#header").load("${contextpath}/header.htm?type=index");
			$("#footer").load("${contextpath}/footer.htm");
		});
			
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
			function jumpChangyouDetail(id){
				window.location.href='${contextpath}/changyouDetail.htm?id='+id;
			}
			function jumpQuanjingDetail(id){
				window.location.href='${contextpath}/quanjingDetail.htm?id='+id;
			}
			function jumpTingwenDetail(id){
				window.location.href='${contextpath}/tingwenDetail.htm?id='+id;
			}
			function jumpXiuxiansecond(secondMenuId){
				window.location.href="${contextpath}/xiuxian.htm?secondMenuId="+secondMenuId;
			}	
			
			function jumpActivityDetail(id){
				window.location.href="${contextpath}/activityDetail.htm?id="+id;
			}
		</script>
	</body>

</html>