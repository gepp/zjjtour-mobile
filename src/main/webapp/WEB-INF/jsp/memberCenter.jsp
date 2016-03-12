<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>个人中心</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">

		<link rel="stylesheet" href="${contextpath}/css/mui.min.css">
		<!--<link rel="stylesheet" href="${contextpath}/css/feedback-page.css" />-->
		<style>
			html,
			body {
				background-color: #efeff4;
			}
			
			.mui-views,
			.mui-view,
			.mui-pages,
			.mui-page,
			.mui-page-content {
				position: absolute;
				left: 0;
				right: 0;
				top: 0;
				bottom: 0;
				width: 100%;
				height: 100%;
				background-color: #efeff4;
			}
			
			.mui-pages {
				top: 46px;
				height: auto;
			}
			
			.mui-table-view-cell h4 {
				line-height: 24px;
			}
			
			.mui-scroll-wrapper,
			.mui-scroll {
				background-color: #efeff4;
			}
			
			.mui-page.mui-transitioning {
				-webkit-transition: -webkit-transform 300ms ease;
				transition: transform 300ms ease;
			}
			
			.mui-page-left {
				-webkit-transform: translate3d(0, 0, 0);
				transform: translate3d(0, 0, 0);
			}
			
			.mui-ios .mui-page-left {
				-webkit-transform: translate3d(-20%, 0, 0);
				transform: translate3d(-20%, 0, 0);
			}
			
			.mui-navbar {
				position: fixed;
				right: 0;
				left: 0;
				z-index: 10;
				height: 44px;
				background-color: #f7f7f8;
			}
			
			.mui-navbar .mui-bar {
				position: absolute;
				background: transparent;
				text-align: center;
			}
			
			.mui-android .mui-navbar-inner.mui-navbar-left {
				opacity: 0;
			}
			
			.mui-ios .mui-navbar-left .mui-left,
			.mui-ios .mui-navbar-left .mui-center,
			.mui-ios .mui-navbar-left .mui-right {
				opacity: 0;
			}
			
			.mui-navbar .mui-btn-nav {
				-webkit-transition: none;
				transition: none;
				-webkit-transition-duration: .0s;
				transition-duration: .0s;
			}
			
			.mui-navbar .mui-bar .mui-title {
				display: inline-block;
				width: auto;
			}
			
			.mui-page-shadow {
				position: absolute;
				right: 100%;
				top: 0;
				width: 16px;
				height: 100%;
				z-index: -1;
				content: '';
			}
			
			.mui-page-shadow {
				background: -webkit-linear-gradient(left, rgba(0, 0, 0, 0) 0, rgba(0, 0, 0, 0) 10%, rgba(0, 0, 0, .01) 50%, rgba(0, 0, 0, .2) 100%);
				background: linear-gradient(to right, rgba(0, 0, 0, 0) 0, rgba(0, 0, 0, 0) 10%, rgba(0, 0, 0, .01) 50%, rgba(0, 0, 0, .2) 100%);
			}
			
			.mui-navbar-inner.mui-transitioning,
			.mui-navbar-inner .mui-transitioning {
				-webkit-transition: opacity 300ms ease, -webkit-transform 300ms ease;
				transition: opacity 300ms ease, transform 300ms ease;
			}
			
			.mui-page {
				display: none;
			}
			
			.mui-pages .mui-page {
				display: block;
			}
			
			.mui-page .mui-table-view:first-child {
				margin-top: 15px;
			}
			
			.mui-page .mui-table-view:last-child {
				margin-bottom: 30px;
			}
			
			.mui-table-view {
				margin-top: 20px;
			}
			
			.mui-table-view span.mui-pull-right {
				color: #999;
			}
			
			.mui-table-view-divider {
				background-color: #efeff4;
				font-size: 14px;
			}
			
			.mui-table-view-divider:before,
			.mui-table-view-divider:after {
				height: 0;
			}
			
			.head {
				height: 40px;
			}
			
			#head {
				line-height: 40px;
			}
			
			.head-img {
				width: 40px;
				height: 40px;
			}
			
			#head-img1 {
				position: absolute;
				bottom: 10px;
				right: 40px;
				width: 40px;
				height: 40px;
			}
			
			.update {
				font-style: normal;
				color: #999999;
				margin-right: -25px;
				font-size: 15px
			}
			
			.mui-fullscreen {
				position: fixed;
				z-index: 20;
				background-color: #000;
			}
			
			.mui-ios .mui-navbar .mui-bar .mui-title {
				position: static;
			}
			.mui-input-row label{width: 45%;}
			.mui-input-row label~input, .mui-input-row label~select, .mui-input-row label~textarea{width: 55%;}
			.mui-table-view-cell.mui-media.mui-col-xs-6>a>span.start{position: absolute;top: 10px;left: 14px;font-size: 12px;padding: 5px; background: rgba(0, 187, 158, 0.9);color: #fff;}
			.mui-table-view-cell.mui-media.mui-col-xs-6>a>span.end{position: absolute;top: 10px;left: 14px;font-size: 12px;padding: 5px; background: rgba(232, 232, 232, 0.9);color: #999;}
			.mui-table-view-cell.mui-media.mui-col-xs-6>a>span.prepare{position: absolute;top: 10px;left: 14px;font-size: 12px;padding: 5px; background: rgba(255, 73, 73, 0.9);color: #fff;}
		</style>
	</head>

	<body class="mui-fullscreen">
		<!--页面主结构开始-->
		<div id="app" class="mui-views">
			<div class="mui-view">
				<div class="mui-navbar">
				</div>
				<div class="mui-pages">
				</div>
			</div>
		</div>
		<!--页面主结构结束-->
		<!--单页面开始-->
		<div id="setting" class="mui-page">
			<!--页面标题栏开始-->
			<div class="mui-navbar-inner mui-bar mui-bar-nav">
				<button type="button" class="mui-left mui-action-back mui-btn  mui-btn-link mui-btn-nav mui-pull-left">
					<span class="mui-icon mui-icon-left-nav"></span>
				</button>
				<h1 class="mui-center mui-title">个人中心</h1>
			</div>
			<!--页面标题栏结束-->
			<!--页面主内容区开始-->
			<div class="mui-page-content">
				<div class="mui-scroll-wrapper">
					<div class="mui-scroll">
						<ul class="mui-table-view mui-table-view-chevron">
							<li class="mui-table-view-cell mui-media">
								<a class="mui-navigate-right" href="#account">
									<img class="mui-media-object mui-pull-left head-img" id="head-img" src="${contextpath}/images/11.jpg">
									<div class="mui-media-body">
										${member.data.cname }
										<p class='mui-ellipsis'>手机:${member.data.ctel }</p>
									</div>
								</a>
							</li>
						</ul>
						<ul class="mui-table-view mui-table-view-chevron">
							<li class="mui-table-view-cell">
								<a href="#notifications" class="mui-navigate-right">个人信息修改</a>
							</li>
							<li class="mui-table-view-cell">
								<a href="#privacy" class="mui-navigate-right">我的活动</a>
							</li>
							<li class="mui-table-view-cell">
								<a href="#general" class="mui-navigate-right">我的投诉</a>
							</li>
						</ul>
						<ul class="mui-table-view">
							<li class="mui-table-view-cell" style="text-align: center;">
								<a href="javascript:void(0)" onclick="logout();">退出登录</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!--页面主内容区结束-->
		</div>
		<!--单页面结束-->
		<div id="account" class="mui-page">
			<div class="mui-navbar-inner mui-bar mui-bar-nav">
				<button type="button" class="mui-left mui-action-back mui-btn   mui-btn-nav " onclick="window.location.href='${contextpath}/'">
					<span class="mui-icon mui-icon-left-nav"></span>个人中心
				</button>
				<h1 class="mui-center mui-title">个人信息</h1>
			</div>
			<div class="mui-page-content">
				<div class="mui-scroll-wrapper">
					<div class="mui-scroll">
						<ul class="mui-table-view">
							<li class="mui-table-view-cell">
								<a id="head" >头像
								<span class="mui-pull-right head">
									<img class="head-img mui-action-preview" id="head-img1" style="right: 15px;" src="${contextpath}/images/11.jpg"/>
								</span>
							</a>
							</li>
							<li class="mui-table-view-cell">
								<a>姓名<span class="mui-pull-right">${member.data.cname }</span></a>
							</li>
							<li class="mui-table-view-cell">
								<a>手机<span class="mui-pull-right">${member.data.ctel }</span></a>
							</li>
						</ul>
						<ul class="mui-table-view">
							<li class="mui-table-view-cell">
								<a>邮箱<span class="mui-pull-right">${member.data.cemail }</span></a>
							</li>
							<li class="mui-table-view-cell">
								<a>性别<span class="mui-pull-right"><c:if test="${member.data.csex==null }">未设置</c:if><c:if test="${member.data.csex!=null }">${member.data.csex }</c:if></span></a>
							</li>
						</ul>
						 
					</div>
				</div>
			</div>
		</div>
		<div id="notifications" class="mui-page">
			<div class="mui-navbar-inner mui-bar mui-bar-nav">
				<button type="button" class="mui-left mui-action-back mui-btn  mui-btn-link mui-btn-nav mui-pull-left">
					<span class="mui-icon mui-icon-left-nav"></span>个人中心
				</button>
				<h1 class="mui-center mui-title">信息修改</h1>
			</div>
			<div class="mui-page-content">
				
				<div class="mui-scroll-wrapper">
					<div class="mui-scroll">
						<ul class="mui-table-view">
							<li class="mui-table-view-cell">
								<a id="head" class="mui-navigate-right">头像
								<span class="mui-pull-right head">
									<img class="head-img mui-action-preview" id="head-img1" src="${contextpath}/images/11.jpg">
								</span>
							</a>
							</li>
						</ul>
						<form method="post" class="mui-input-group mui-table-view" action="${contextpath }/memberEditAction.htm" id="myform" name="myform">
							<div class="mui-input-row">
								<label>姓名</label>
								<input type="text" placeholder="" name="cname" id="cname" value="${member.data.cname }" >
							</div>
							<br/>
							 
							<div class="mui-button-row">
								<button type="button" class="mui-btn mui-btn-primary" onclick="submitform();">确认</button>&nbsp;&nbsp;
								<button type="button" class="mui-btn mui-btn-danger" onclick="window.location.href='${contextpath}/memberCenter.htm'">取消</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div id="privacy" class="mui-page">
			<div class="mui-navbar-inner mui-bar mui-bar-nav">
				<button type="button" class="mui-left mui-action-back mui-btn  mui-btn-link mui-btn-nav mui-pull-left">
					<span class="mui-icon mui-icon-left-nav"></span>个人中心
				</button>
				<h1 class="mui-center mui-title">我的活动</h1>
				<!-- <a id="menu" class="iconfont mui-pull-right" style="margin: 0;position: absolute;top: 0;right: 10px;line-height: 44px;font-size: 24px;" href="#middlePopover">&#xe61c;</a> -->
			</div>
			<div class="mui-page-content">
				<div class="mui-scroll-wrapper">
					<div class="mui-scroll">
						<ul class="mui-table-view mui-grid-view">
						<c:forEach items="${activityList }" var="activity">
							<li class="mui-table-view-cell mui-media mui-col-xs-6" onclick="jumpActivityDetail('${activity.id}')" >
								<a href="#">
									<img class="mui-media-object" src="${activity.indeximg }">
									<span class="start">进行中</span>
									<div class="mui-media-body">${activity.title }</div>
								</a>
							</li>
						</c:forEach>	 
						</ul>

					</div>
				</div>
			</div>
		</div>
		<div id="general" class="mui-page">
			<div class="mui-navbar-inner mui-bar mui-bar-nav">
				<button type="button" class="mui-left mui-action-back mui-btn  mui-btn-link mui-btn-nav mui-pull-left">
					<span class="mui-icon mui-icon-left-nav"></span>个人中心
				</button>
				<h1 class="mui-center mui-title">我的投诉</h1>
<!-- 				<a id="menu" class="iconfont mui-pull-right" style="margin: 0;position: absolute;top: 0;right: 10px;line-height: 44px;font-size: 24px;" href="#middlePopover">&#xe61c;</a>
 -->			</div>
			<div class="mui-page-content">
				<div class="mui-scroll-wrapper">
					<div class="mui-scroll">
						<div class="mui-content">
							<ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
								<c:forEach items="${complainList }" var="item">
								<li class="mui-table-view-cell" onclick="gotoTousuDetail('${item.id}');">
									<div class="mui-table">
										<div class="mui-table-cell mui-col-xs-10">
											<h4 class="mui-ellipsis">${item.complainTitle }</h4>
											<fmt:formatDate value="${item.complainTime }" pattern="yyyy-MM-dd" var="complainTime"/>
											<h5>时间：${complainTime}</h5>
											<p class="mui-h6 mui-ellipsis">${ item.replayStatus==0?'待回复':'已回复'}</p>
										</div>
										<div class="mui-table-cell mui-col-xs-2 mui-text-right">
											<span class="mui-h5">查看</span>
										</div>
									</div>
								</li>
								 </c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--右上角弹出菜单-->
		<div id="middlePopover" class="mui-popover" style="height: 220px;">
			<div class="mui-popover-arrow"></div>
			<div class="mui-scroll-wrapper">
				<div class="mui-scroll">
					<form class="mui-input-group">
						<div class="mui-input-row">
							<label>标题:</label>
							<input type="text" placeholder="输入标题">
						</div>
						<div class="mui-input-row">
							<label>状态:</label>
							<select>
								<option>已完成</option>
								<option>1111</option>
								<option>1111</option>
								<option>1111</option>
							</select>
						</div>
						<div class="mui-input-row">
							<label>起始时间:</label>
							<input type="date" placeholder="选择时间">
						</div>
						<div class="mui-input-row">
							<label>起始时间:</label>
							<input type="date" placeholder="选择时间">
						</div>
						<div class="mui-button-row">
							<button type="button" class="mui-btn mui-btn-primary" onclick="return false;">搜索</button>
						</div>
					</form>
				</div>
			</div>

		</div>
	</body>
	<script src="${contextpath}/js/mui.min.js "></script>
	<script src="${contextpath}/js/mui.view.js "></script>
	<script src="${contextpath}/js/jquery.min.js"></script>
		<script src="${contextpath}/js/layer/layer.js"></script>
		<script src="${contextpath}/js/common.js"></script>
		
	<!--<script src='${contextpath}/js/feedback.js'></script>
	<script src="${contextpath}/js/feedback-page.js"></script>-->
	<script>
		mui.init();
		//初始化单页view
		var viewApi = mui('#app').view({
			defaultPage: '#setting'
		});
		//初始化单页的区域滚动
		mui('.mui-scroll-wrapper').scroll();
		var view = viewApi.view;
		(function($) {
			//处理view的后退与webview后退
			var oldBack = $.back;
			$.back = function() {
				if (viewApi.canBack()) { //如果view可以后退，则执行view的后退
					viewApi.back();
				} else { //执行webview后退
					oldBack();
				}
			};
			//监听页面切换事件方案1,通过view元素监听所有页面切换事件，目前提供pageBeforeShow|pageShow|pageBeforeBack|pageBack四种事件(before事件为动画开始前触发)
			//第一个参数为事件名称，第二个参数为事件回调，其中e.detail.page为当前页面的html对象
			view.addEventListener('pageBeforeShow', function(e) {
				//				console.log(e.detail.page.id + ' beforeShow');
			});
			view.addEventListener('pageShow', function(e) {
				//				console.log(e.detail.page.id + ' show');
			});
			view.addEventListener('pageBeforeBack', function(e) {
				//				console.log(e.detail.page.id + ' beforeBack');
			});
			view.addEventListener('pageBack', function(e) {
				//				console.log(e.detail.page.id + ' back');
			});
		})(mui);
		//更换头像
		mui(".mui-table-view-cell").on("tap", "#head", function(e) {
			if (mui.os.plus) {
				var a = [{
					title: "拍照"
				}, {
					title: "从手机相册选择"
				}];
				plus.nativeUI.actionSheet({
					title: "修改头像",
					cancel: "取消",
					buttons: a
				}, function(b) {
					switch (b.index) {
						case 0:
							break;
						case 1:
							getImage();
							break;
						case 2:
							galleryImg();
							break;
						default:
							break
					}
				})
			}
		});

		function getImage() {
			var c = plus.camera.getCamera();
			c.captureImage(function(e) {
				plus.io.resolveLocalFileSystemURL(e, function(entry) {
					var s = entry.toLocalURL() + "?version=" + new Date().getTime();
					console.log(s);
					document.getElementById("head-img").src = s;
					document.getElementById("head-img1").src = s;
					//变更大图预览的src
					//目前仅有一张图片，暂时如此处理，后续需要通过标准组件实现
					document.querySelector("#__mui-imageview__group .mui-slider-item img").src = s + "?version=" + new Date().getTime();;;
				}, function(e) {
					console.log("读取拍照文件错误：" + e.message);
				});
			}, function(s) {
				console.log("error" + s);
			}, {
				filename: "_doc/head.jpg"
			})
		}

		
		function galleryImg() {
			plus.gallery.pick(function(a) {
				plus.io.resolveLocalFileSystemURL(a, function(entry) {
					plus.io.resolveLocalFileSystemURL("_doc/", function(root) {
						root.getFile("head.jpg", {}, function(file) {
							//文件已存在
							file.remove(function() {
								console.log("file remove success");
								entry.copyTo(root, 'head.jpg', function(e) {
										var e = e.fullPath + "?version=" + new Date().getTime();
										document.getElementById("head-img").src = e;
										document.getElementById("head-img1").src = e;
										//变更大图预览的src
										//目前仅有一张图片，暂时如此处理，后续需要通过标准组件实现
										document.querySelector("#__mui-imageview__group .mui-slider-item img").src = e + "?version=" + new Date().getTime();;
									},
									function(e) {
										console.log('copy image fail:' + e.message);
									});
							}, function() {
								console.log("delete image fail:" + e.message);
							});
						}, function() {
							//文件不存在
							entry.copyTo(root, 'head.jpg', function(e) {
									var path = e.fullPath + "?version=" + new Date().getTime();
									document.getElementById("head-img").src = path;
									document.getElementById("head-img1").src = path;
									//变更大图预览的src
									//目前仅有一张图片，暂时如此处理，后续需要通过标准组件实现
									document.querySelector("#__mui-imageview__group .mui-slider-item img").src = path;
								},
								function(e) {
									console.log('copy image fail:' + e.message);
								});
						});
					}, function(e) {
						console.log("get _www folder fail");
					})
				}, function(e) {
					console.log("读取拍照文件错误：" + e.message);
				});
			}, function(a) {}, {
				filter: "image"
			})
		};

		function defaultImg() {
			if (mui.os.plus) {
				plus.io.resolveLocalFileSystemURL("_doc/head.jpg", function(entry) {
					var s = entry.fullPath + "?version=" + new Date().getTime();;
					document.getElementById("head-img").src = s;
					document.getElementById("head-img1").src = s;
				}, function(e) {
					document.getElementById("head-img").src = '${contextpath}/images/logo.png';
					document.getElementById("head-img1").src = '${contextpath}/images/logo.png';
				})
			} else {
				document.getElementById("head-img").src = '${contextpath}/images/logo.png';
				document.getElementById("head-img1").src = '${contextpath}/images/logo.png';
			}
		}
		document.getElementById("head-img1").addEventListener('tap', function(e) {
			e.stopPropagation();
		});
		document.getElementById("welcome").addEventListener('tap', function(e) {
			//显示启动导航
			mui.openWindow({
				id: 'guide',
				url: 'guide.html',
				show: {
					aniShow: 'fade-in',
					duration: 300
				},
				waiting: {
					autoShow: false
				}
			});
		});

		function initImgPreview() {
			var imgs = document.querySelectorAll("img.mui-action-preview");
			imgs = mui.slice.call(imgs);
			if (imgs && imgs.length > 0) {
				var slider = document.createElement("div");
				slider.setAttribute("id", "__mui-imageview__");
				slider.classList.add("mui-slider");
				slider.classList.add("mui-fullscreen");
				slider.style.display = "none";
				slider.addEventListener("tap", function() {
					slider.style.display = "none";
				});
				slider.addEventListener("touchmove", function(event) {
					event.preventDefault();
				})
				var slider_group = document.createElement("div");
				slider_group.setAttribute("id", "__mui-imageview__group");
				slider_group.classList.add("mui-slider-group");
				imgs.forEach(function(value, index, array) {
					//给图片添加点击事件，触发预览显示；
					value.addEventListener('tap', function() {
						slider.style.display = "block";
						_slider.refresh();
						_slider.gotoItem(index, 0);
					})
					var item = document.createElement("div");
					item.classList.add("mui-slider-item");
					var a = document.createElement("a");
					var img = document.createElement("img");
					img.setAttribute("src", value.src);
					a.appendChild(img)
					item.appendChild(a);
					slider_group.appendChild(item);
				});
				slider.appendChild(slider_group);
				document.body.appendChild(slider);
				var _slider = mui(slider).slider();
			}
		}
		function logout(){
			 $.ajax({
					type: "post", 
					url: "${contextpath}/loginout.htm", 
					dataType: "json",
					success: function (data) { 
						layer.open({
						    content: '注销成功',
						    btn: ['确认'],
						    shadeClose: false,
						    yes: function(){
						    	window.location.href="${contextpath}/";
						    }, no: function(){
						         
						    }
						});
						
						 
					} 
			});
		}

		function gotoTousuDetail(id){
			window.location.href='${contextpath}/tousuDetail.htm?id='+id;
		}
		function jumpActivityDetail(id){
			window.location.href="${contextpath}/activityDetail.htm?id="+id;
		}
		function submitform(){
			$("#myform").submit();
		}
	</script>

</html>