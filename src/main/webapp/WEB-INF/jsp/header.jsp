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
						<li class="mui-table-view-cell" onclick="window.location.href='${contextpath}/'"><a class="mui-navigate-right" href="#">首页</a></li>
						<li class="mui-table-view-cell mui-collapse"><a class="mui-navigate-right" href="#">${quanjing.name }</a>
							<ul class="mui-table-view mui-table-view-chevron">
								<c:forEach var="menu"  items="${quanjingMenuList }">
								<li class="mui-table-view-cell" onclick="jumpQuanjing('${menu.id}')"><a class="mui-navigate-right" href="#">${menu.name }</a>
								</li>
								 </c:forEach>
							</ul>
						</li>
						
						<li class="mui-table-view-cell mui-collapse"><a class="mui-navigate-right" href="#">${changyou.name }</a>
							<ul class="mui-table-view mui-table-view-chevron">
								<c:forEach var="menu"  items="${changyouMenuList }">
								<li class="mui-table-view-cell" onclick="jumpChangyou('${menu.id}')"><a class="mui-navigate-right" href="#">${menu.name }</a>
								</li>
								 </c:forEach>
							</ul>
						</li>
						<li class="mui-table-view-cell" onclick="window.location.href='${contextpath}/activity.htm'"><a class="mui-navigate-right" href="#">${activity.name }</a>
							
						</li>
						<li class="mui-table-view-cell mui-collapse"><a class="mui-navigate-right" href="#">${tingwen.name }</a>
							<ul class="mui-table-view mui-table-view-chevron">
								<c:forEach var="menu"  items="${tingwenMenuList }">
								<li class="mui-table-view-cell" onclick="jumpTingwen('${menu.id}')"><a class="mui-navigate-right" href="#">${menu.name }</a>
								</li>
								</c:forEach>
								 
							</ul>
						</li>
						<li class="mui-table-view-cell mui-collapse"><a class="mui-navigate-right" href="#">${xiuxian.name }</a>
							<ul class="mui-table-view mui-table-view-chevron">
								<c:forEach var="menu"  items="${xiuxianMenuList }">
								<li class="mui-table-view-cell"  onclick="jumpXiuxian('${menu.id}')"><a class="mui-navigate-right" href="#">${menu.name }</a>
								</li>
								 </c:forEach>
							</ul>
						</li>
						<li class="mui-table-view-cell " onclick="window.location.href='${contextpath }/about.htm?secondMenuId=1118'"><a class="mui-navigate-right" href="#">会员中心</a>
						<li class="mui-table-view-cell " onclick="window.location.href='${contextpath}/tousu.htm'"><a class="mui-navigate-right" href="#">投诉中心</a>
						<li class="mui-table-view-cell " onclick="window.location.href='${contextpath}/chengxin.htm'"><a class="mui-navigate-right" href="#">诚信中心</a>
						</li>
						<c:forEach var="newMap" items="${newsMap }">
						<li class="mui-table-view-cell mui-collapse"><a class="mui-navigate-right" href="#">${newMap.key.name }</a>
							<ul class="mui-table-view mui-table-view-chevron">
								<c:forEach var="menu"  items="${newMap.value }">
								<li class="mui-table-view-cell"  onclick="jumpOther('${menu.id}','${newMap.key.id }');"><a class="mui-navigate-right" href="#">${menu.name }</a>
								</li>
								 </c:forEach>
							</ul>
						</li>
						</c:forEach>
						
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
		function jumpQuanjing(secondMenuId){
			window.location.href="${contextpath}/quanjing.htm?secondMenuId="+secondMenuId;
		}
		function jumpOther(secondMenuId,otherId){
			var currentId="";
			window.location.href="${contextpath}/other.htm?currentId="+currentId+"&otherId="+otherId+'&secondMenuId='+secondMenuId;
		}
		
		</script>
</html>