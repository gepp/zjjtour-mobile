<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>${thirdShowName }</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
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

.mui-grid-view.mui-grid-9 .mui-table-view-cell {
	border: none;
}

.mui-media .iconfont {
	color: #00BB9E;
	font-size: 2em;
}
</style>
</head>

<body>
	<header class="mui-bar mui-bar-nav">
		<button onclick="window.location.href='${contextpath}/'"
			class=" mui-btn mui-btn-blue mui-btn-link mui-btn-nav mui-pull-left">
			<span class="mui-icon mui-icon-left-nav"></span>返回
		</button>
		<h1 class="mui-title">${thirdShowName }</h1>
		<a id="menu"
			class="mui-action-menu mui-icon mui-icon-bars mui-pull-right"
			style="margin: 0 -10px 0 0;" href="#middlePopover"></a>
			<input type="hidden" value="${secondMenuId}" id="secondMenuId" />
	</header>
	<div class="mui-content">
		<div class="mui-content-padded">
			 
			<c:forEach var="menu" items="${secondMenuList }">
				<div
					class="mui-btn <c:if test="${secondMenuId==menu.id}"> mui-btn-primary</c:if>"
					onclick="jumpChangyou('${menu.id}')">${menu.name }</div>
			</c:forEach>
		</div>
		<ul class="mui-table-view">
			<c:forEach var="item" items="${newsList }">
				<li class="mui-table-view-cell mui-media"
					onclick="jumpDetail('${item.id}','${item.jumpType}','${item.url}')">
					<a href="javascript:;"> <img
						class="mui-media-object mui-pull-left" src="${item.smallimg } ">
						<div class="mui-media-body"
							style="white-space: nowrap; text-overflow: ellipsis">
							${item.title }
							<fmt:formatDate value="${item.ctime }" pattern="yyyy-MM-dd"
								var="ctime" />
							<p class="mui-ellipsis">${item.abstract_content }</p>
							<p class="mui-ellipsis">${ctime }
								&nbsp;&nbsp;<span class="number"><i class="iconfont">&#xe616;</i>${item.readtotal }</span>
							</p>
						</div>
				</a>
				</li>
			</c:forEach>
			<div id="moreLi"></div>
			<button id="moreBtn" type="button"
				class="mui-btn mui-btn-block mui-btn-radius" style="margin: 0;"
				onclick="getMore()">加载更多</button>
		</ul>
		<button id="noBtn" style="display: none; margin-left: 0px"
			type="button" class="mui-btn mui-btn-block mui-btn-radius">没有数据了...</button>
	</div>
	<div id="footer"></div>
	<!--右上角弹出菜单-->
	<div id="header"></div>
</body>
<script src="${contextpath}/js/mui.min.js"></script>
<script src="${contextpath}/js/jquery.min.js"></script>
<script src="${contextpath}/js/common.js"></script>
<script>
	String.prototype.endWith = function(s) {
		if (s == null || s == "" || this.length == 0 || s.length > this.length)
			return false;
		if (this.substring(this.length - s.length) == s)
			return true;
		else
			return false;
		return true;
	}
	String.prototype.startWith = function(s) {
		if (s == null || s == "" || this.length == 0 || s.length > this.length)
			return false;
		if (this.substr(0, s.length) == s)
			return true;
		else
			return false;
		return true;
	}
	jQuery(document).ready(function() {
		$("#header").load("${contextpath}/header.htm?type=index");
		/* $("#footer").load("${contextpath}/footer.htm"); */
	});
	mui.init({
		swipeBack : true
	//启用右滑关闭功能
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
		interval : 5000
	});
	function jumpDetail(id, jumpType, url) {
		if (url == '') {
			if (jumpType == '0') {
				window.open('${contextpath}/changyouDetail.htm?id=' + id);
			} else {
				window.location.href = '${contextpath}/changyouDetail.htm?id='
						+ id;
			}
		} else {
			if (jumpType == '0') {
				if (url.startWith('http')) {
					window.open(url);
				} else {
					window.open("${contextpath}/" + url);
				}

			} else {
				if (url.startWith('http')) {
					window.location.href = url;
				} else {
					window.location.href = "${contextpath}/" + url;
				}

			}
		}
	}
	
	var pageIndex=1;
	function getMore(){
		pageIndex++;
		$.ajax({
			type: "post", 
			url: "${contextpath}/changyouGetMore.htm?secondMenuId="+$("#secondMenuId").val()+"&pageIndex="+pageIndex, 
			dataType: "json",
			success: function (data) { 
				 var jsonArray=str2json(data);
				 console.log(jsonArray.list.length);
				 if(jsonArray.list.length==0){
					 $("#moreBtn").hide();
					 $("#noBtn").show();
				 }else{
					 var strLis="";
					 for(var i=0;i<jsonArray.list.length;i++){
						 var item=jsonArray.list[i];
					 var strLi='<li class="mui-table-view-cell mui-media"'+
							   'onclick="jumpDetail(\''+item.id+'\',\''+item.jump_type+'\',\''+item.url+'\')">'
							   +'<a href="javascript:;"> <img'+
								'class="mui-media-object mui-pull-left" src="'+item.smallimg+'">'+
							'<div class="mui-media-body" style="white-space: nowrap; text-overflow: ellipsis">'+
							''+item.title+''+'<p class="mui-ellipsis">'+item.abstract_content+'</p>'+
							'<p class="mui-ellipsis">'+item.ctime+
							'&nbsp;&nbsp;<span class="number"><i class="iconfont">&#xe616;</i>'+item.readtotal+'</span>'+
							'</p></div></a></li>';
					 strLis=strLis+strLi;
					 }
					 $("#moreLi").append(strLis);
				 
			 }
			} 
	});
	}
</script>

</html>