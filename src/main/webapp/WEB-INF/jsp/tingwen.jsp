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
			.mui-table-view .mui-media, .mui-table-view .mui-media-body{padding-top: 15px; text-align: center;}
			.mui-ellipsis{margin-top: 10px;}
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
				<div class="mui-btn <c:if test="${secondMenuId==''}"> mui-btn-primary</c:if> "  onclick="jumpTingwen('')">
					全部
				</div>
			<c:forEach var="menu" items="${secondMenuList }">
				<div class="mui-btn <c:if test="${secondMenuId==menu.id}"> mui-btn-primary</c:if>" onclick="jumpTingwen('${menu.id}')">
				${menu.name }
				</div>
			</c:forEach>
			</div>
			<ul class="mui-table-view" id="changeSpan">
				<c:forEach items="${pageList.list }" var="item">
				<li class="mui-table-view-cell mui-media" onclick="jumpDetail('${item.id}','${item.jumpType }','${item.url }')">
					<a href="javascript:;">
						<img class="mui-media-object mui-pull-left" src="${item.smallimg } ">
						<div class="mui-media-body" style="white-space:nowrap;text-overflow:ellipsis;text-align:left">
							${item.title }
							<p class="mui-ellipsis">${item.abstractContent }</p>
							<fmt:formatDate value="${item.ctime }" pattern="yyyy-MM-dd" var="ctime"/>
							<p class="mui-ellipsis">${ctime } &nbsp;&nbsp;<span class="number"><i class="iconfont">&#xe616;</i>${item.readtotal }</span></p>
						</div>
					</a>
				</li>
				</c:forEach>
			</ul>
			<ul class="mui-table-view leader"  id="lingdaozhichuang" style="display:none">
				<c:forEach var="lingdao" items="${lingdaoList }">
				<li class="mui-table-view-cell mui-media" onclick="gotoLingdao('${lingdao.id}')">
					<a href="javascript:;">
						<img src="${lingdao.img }">
						<div class="mui-media-body">
							${lingdao.name }
							<p class="mui-ellipsis">${lingdao.code }</p>
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
	String.prototype.endWith=function(s){ 
		if(s==null||s==""||this.length==0||s.length>this.length) 
		return false; 
		if(this.substring(this.length-s.length)==s) 
		return true; 
		else 
		return false; 
		return true; 
		} 
		String.prototype.startWith=function(s){ 
		if(s==null||s==""||this.length==0||s.length>this.length) 
		return false; 
		if(this.substr(0,s.length)==s) 
		return true; 
		else 
		return false; 
		return true; 
		} 
	jQuery(document).ready(function() {
		$("#header").load("${contextpath}/header.htm?type=index");
		/* $("#footer").load("${contextpath}/footer.htm"); */
		if('${secondMenuId}'=='1108'){
			 
			$("#changeSpan").hide();
			$("#lingdaozhichuang").show();
		}
	});
	function gotoLingdao(id){
		window.location.href='${contextpath}/lingdaoDetail.htm?id='+id;
	}
	function jumpDetail(id,jumpType,url){
		if(url==''){
			if(jumpType=='0'){
				window.open('${contextpath}/tingwenDetail.htm?id='+id);
			}else{
				window.location.href='${contextpath}/tingwenDetail.htm?id='+id;
			}
		}else{
			if(jumpType=='0'){
				if(url.startWith('http')){
					window.open(url);
				}else{
					window.open("${contextpath}/"+url);
				}
				 
			}else{
				if(url.startWith('http')){
					window.location.href=url;
				}else{
					window.location.href="${contextpath}/"+url;
				}
				
			}
		}
	}
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
			 
			function jumpTingwen(secondMenuId){
				window.location.href="${contextpath}/tingwen.htm?secondMenuId="+secondMenuId;
			}
		</script>

</html>