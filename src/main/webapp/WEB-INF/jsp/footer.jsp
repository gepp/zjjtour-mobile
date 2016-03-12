<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<div class="footer-center">
			<ul class="mui-table-view mui-grid-view mui-grid-9">
				<li class="mui-table-view-cell mui-media mui-col-xs-6 mui-col-sm-6" onclick="window.location.href='${contextpath}/tousu.htm'">
					<a href="javascript:void(0)">
						<span class="iconfont">&#xe601;</span>
						<div class="mui-media-body" >投诉中心</div>
					</a>
				</li>
				<%-- <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3" onclick="window.location.href='${contextpath}/jingqu.htm'">
					<a href="javascript:void(0)">
						<span class="iconfont">&#xe60e;</span>
						<div class="mui-media-body" >景区数据</div>
					</a>
				</li> --%>
				<li class="mui-table-view-cell mui-media mui-col-xs-6 mui-col-sm-6" onclick="window.location.href='${contextpath}/chengxin.htm'">
					<a  href="javascript:void(0)" >
						<span class="iconfont" style="display: block;height: 24px;margin-top: 3px;">&#xe60c;</span>
						<div class="mui-media-body">诚信中心</div>
					</a>
				</li>
			</ul>
			<div class="copyright">版权所有：张家界市人民政府<br />湘ICP备15001419号-2<br /></div>
		</div>
</html>