<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>投诉中心</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">

		<!--标准mui.css-->
		<link rel="stylesheet" href="${contextpath}/css/mui.min.css">
		<!--App自定义的css-->
		<style>
			h5 {
				color: #333;
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
			.mui-media .iconfont{color: #00BB9E;}
			.mui-table-view.mui-grid-view{padding: 0px 10px 10px 10px;}
			.mui-table-view.mui-grid-view .mui-table-view-cell{text-align: left; padding: 10px 0 0 0;}
			.mui-table-view.mui-grid-view .mui-table-view-cell>span{ display: -webkit-box; width: 100%; font-size: 1rem; margin: 10px 0;}
			.mui-table-view.mui-grid-view .mui-table-view-cell>span>b{font-weight: 100; display: block; -webkit-box-flex: 1; margin-left: 10px;}
			.mui-table-view.mui-grid-view .mui-table-view-cell>span>time{display: block; color: #999; font-size: 0.8rem;}
			.mui-table-view.mui-grid-view .mui-table-view-cell>p{margin-bottom: 20px;}
			.mui-table-view-cell.mui-media.mui-col-xs-12{border-bottom:1px dashed #ccc ;}
			.mui-bar~.mui-content{padding-bottom: 50px;}
			.mui-bar.mui-bar-tab>button{padding: 0; margin: 0; display: block; width: 100%; border: 0; text-align: center; line-height: 50px; background: none; color: #00BB9E; font-size: 16px;}
		</style>
	</head>

	<body>
		<header class="mui-bar mui-bar-nav">
			<button class="mui-action-back mui-btn mui-btn-blue mui-btn-link mui-btn-nav mui-pull-left"><span class="mui-icon mui-icon-left-nav"></span>返回</button>
			<h1 class="mui-title">投诉中心</h1>
			<a id="menu" class="mui-action-menu mui-icon mui-icon-bars mui-pull-right" style="margin: 0 -10px 0 0;" href="#middlePopover"></a>
		</header>
		<div class="mui-content">
			<ul class="mui-table-view mui-grid-view">
				<c:forEach items="${pageList.list }" var="item">
				<fmt:formatDate value="${item.complainTime }" pattern="yyyy-MM-dd" var="complainTime"/>
				<li class="mui-table-view-cell mui-media mui-col-xs-12">
					<span><i class="iconfont">&#xe61a;</i><b>${item.memberName }</b><time>${complainTime }</time></span>
					<h5>${item.complainTitle }</h5>
					<p>${item.complainMessage }&nbsp;&nbsp;</p>
							<fmt:formatDate value="${item.replayTime }" pattern="yyyy-MM-dd" var="replayTime"/>
					<span><i class="iconfont">&#xe61b;</i><b>系统管理员</b><time>${replayTime}&nbsp;&nbsp;</time></span>
					<p><b><strong>回复:</strong></b>${item.replayMessage }</p>
				</li>
				</c:forEach> 
				<div id="moreLi">
				
				</div>
			</ul>
			
			<button id="moreBtn" type="button" class="mui-btn mui-btn-block mui-btn-radius" style="margin: 0;" onclick="getMore()">加载更多</button>
			<button id="noBtn" style="display:none" type="button" class="mui-btn mui-btn-block mui-btn-radius" style="margin: 0;" >没有数据了...</button>
		</div>
		<nav class="mui-bar mui-bar-tab">
			<button onclick="wantTousu();">我要投诉</button>
		</nav>
		<div id="header"> </div>	
	</body>
	<script src="${contextpath}/js/mui.min.js"></script>
		<script src="${contextpath}/js/jquery.min.js"></script>
			<script src="${contextpath}/js/layer/layer.js"></script>
		<script src="${contextpath}/js/common.js"></script>
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
			//			document.getElementById("switch").addEventListener('toggle', function(e) {
			//				if (e.detail.isActive) {
			slider.slider({
				interval: 5000
			});
			function wantTousu(){
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
					 
					
				}else{
					window.location.href='${contextpath}/wantTousu.htm';
				}
			}	
			var pageIndex=1;
			function getMore(){
				pageIndex++;
				$.ajax({
					type: "post", 
					url: "${contextpath}/tousuJson.htm?pageIndex="+pageIndex, 
					dataType: "json",
					success: function (data) { 
						 var jsonArray=str2json(data);
						 if(jsonArray==''){
							 $("#moreBtn").hide();
							 $("#noBtn").show();
						 }else{
							 var strLis="";
							 for(var i=0;i<jsonArray.length;i++){
								 var item=jsonArray[i];
							 var strLi='<li class="mui-table-view-cell mui-media mui-col-xs-12">'+
									'<span><i class="iconfont">&#xe61a;</i><b>'+item.memberName+'</b><time>'+item.complainTime+'</time></span>'+
									'<h5>'+item.complainTitle+'</h5>'+
									'<p>'+item.complainMessage+'&nbsp;&nbsp;</p>'+
									'<span><i class="iconfont">&#xe61b;</i><b>系统管理员</b><time>'+item.replayTime+'&nbsp;&nbsp;</time></span>'+
									'<p><b><strong>回复:</strong></b>'+item.replayMessage+'</p>'+
									'</li>';
							 strLis=strLis+strLi;
							 }
							 $("#moreLi").append(strLis);
						 
					 }
					} 
			});
			}
		</script>

</html>

 