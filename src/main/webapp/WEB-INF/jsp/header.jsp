<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
		<div id="middlePopover" class="mui-popover" style="height: 270px;">
			<div class="mui-popover-arrow"></div>
			<div class="mui-scroll-wrapper">
				<div class="mui-scroll">
					<ul class="mui-table-view">
						<li class="mui-table-view-cell"><a class="mui-navigate-right" href="${contextpath }/">首页</a></li>
						<li class="mui-table-view-cell mui-collapse"><a class="mui-navigate-right" href="#">畅游</a>
							<ul class="mui-table-view mui-table-view-chevron">
								<c:forEach var="menu"  items="${changyouMenuList }">
								<li class="mui-table-view-cell" onclick="jumpChangyou('${menu.id}')"><a class="mui-navigate-right" href="#">${menu.name }</a>
								</li>
								 </c:forEach>
							</ul>
						</li>
						<li class="mui-table-view-cell" onclick="window.location.href='${contextpath}/activity.htm'"><a class="mui-navigate-right" href="#">娱乐</a>
							
						</li>
						<li class="mui-table-view-cell mui-collapse"><a class="mui-navigate-right" href="#">听闻</a>
							<ul class="mui-table-view mui-table-view-chevron">
								<c:forEach var="menu"  items="${tingwenMenuList }">
								<li class="mui-table-view-cell" onclick="jumpTingwen('${menu.id}')"><a class="mui-navigate-right" href="#">${menu.name }</a>
								</li>
								</c:forEach>
								 
							</ul>
						</li>
						<li class="mui-table-view-cell mui-collapse"><a class="mui-navigate-right" href="#">休闲</a>
							<ul class="mui-table-view mui-table-view-chevron">
								<c:forEach var="menu"  items="${xiuxianMenuList }">
								<li class="mui-table-view-cell"  onclick="jumpXiuxian('${menu.id}')"><a class="mui-navigate-right" href="#">${menu.name }</a>
								</li>
								 </c:forEach>
							</ul>
						</li>
						<li class="mui-table-view-cell " onclick="window.location.href='${contextpath}/memberCenter.htm'"><a class="mui-navigate-right" href="#">游客中心</a>
							 
						</li>
					</ul>
				</div>
			</div>

		</div>
		
		<!--登录注册弹窗-->
		<div id="picture" class="mui-popover mui-popover-action mui-popover-bottom">
			<ul class="mui-table-view">
				<li class="mui-table-view-cell">
					<a href="${contextpath }/toLogin.htm">登录</a>
				</li>
				<li class="mui-table-view-cell">
					<a href="${contextpath }/toRegister.htm">注册</a>
				</li>
			</ul>
			<ul class="mui-table-view">
				<li class="mui-table-view-cell">
					<a href="#picture"><b>取消</b></a>
				</li>
			</ul>
		</div>
		<script type="text/javascript">
		mui.init({
			swipeBack: true //启用右滑关闭功能
		});
		mui('.mui-scroll-wrapper').scroll();
		function jumpChangyou(secondMenuId){
			window.location.href="${contextpath}/changyou.htm?secondMenuId="+secondMenuId;
		}
		function jumpTingwen(secondMenuId){
			window.location.href="${contextpath}/tingwen.htm?secondMenuId="+secondMenuId;
		}
		function jumpXiuxian(secondMenuId){
			window.location.href="${contextpath}/xiuxian.htm?secondMenuId="+secondMenuId;
		}
		</script>
</html>