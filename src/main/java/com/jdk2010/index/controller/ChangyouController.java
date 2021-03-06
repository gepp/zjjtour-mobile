package com.jdk2010.index.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jdk2010.base.security.menu.model.SecurityMenu;
import com.jdk2010.base.security.securitynews.model.SecurityNews;
import com.jdk2010.base.security.securitynews.service.ISecurityNewsService;
import com.jdk2010.framework.controller.BaseController;
import com.jdk2010.framework.dal.client.DalClient;
import com.jdk2010.framework.util.DateUtil;
import com.jdk2010.framework.util.JsonUtil;
import com.jdk2010.framework.util.Page;
import com.jdk2010.framework.util.StringUtil;
import com.jdk2010.system.systemadv.service.ISystemAdvService;

@Controller
@RequestMapping(value = "/")
public class ChangyouController extends BaseController {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource
	ISecurityNewsService securityNewsService;

	@Resource
	DalClient dalClient;

	@Resource
	ISystemAdvService systemAdvService;

	@RequestMapping("/changyou")
	public String changyou(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<SecurityMenu> quanjingMenuList = dalClient.queryForObjectList(
				"select * from security_menu where parent_id=1011",
				SecurityMenu.class);
		setAttr("quanjingMenuList", quanjingMenuList);

		List<SecurityMenu> changyouMenuList = dalClient.queryForObjectList(
				"select * from security_menu where parent_id=1010",
				SecurityMenu.class);
		setAttr("changyouMenuList", changyouMenuList);

		List<SecurityMenu> tingwenMenuList = dalClient.queryForObjectList(
				"select * from security_menu where parent_id=1037",
				SecurityMenu.class);
		setAttr("tingwenMenuList", tingwenMenuList);

		Map<String, Object> indexMap = dalClient
				.queryForObject("select * from system_indexsetting");
		setAttr("indexMap", indexMap);

		SecurityMenu menu = dalClient
				.queryForObject("select * from security_menu where id=1010",
						SecurityMenu.class);
		setAttr("changyou", menu);
		// 畅游
		String sql = "select * from security_menu where  parent_id=1010 and status=1 order by orderlist asc";
		List<SecurityMenu> secondMenuList = dalClient.queryForObjectList(sql,
				SecurityMenu.class);
		setAttr("secondMenuList", secondMenuList);

		String secondMenuId = getPara("secondMenuId");
		if (StringUtil.isBlank(secondMenuId)) {
			secondMenuId = "";
		}
		setAttr("secondMenuId", secondMenuId);
		String thirdShowName = "";
		// 畅游的新闻
		List<Map<String, Object>> newsList;
		if (secondMenuId != "") {
			newsList = dalClient
					.queryForObjectList("select * from security_news where menu_id="
							+ secondMenuId
							+ " and review_status=1 order by orderlist asc limit 0,5");
			SecurityMenu thirdShowMenu = dalClient.findById(secondMenuId,
					SecurityMenu.class);
			thirdShowName = thirdShowMenu.getName();
		} else {
			thirdShowName = "全部";
			newsList = dalClient
					.queryForObjectList("select * from security_news where  review_status=1 and menu_id in (select id from security_menu where  parent_id=1010) order by orderlist asc limit 0,5");
		}
		setAttr("thirdShowName", thirdShowName);

		setAttr("newsList", newsList);
		return "/changyou";
	}

	@RequestMapping("/changyouGetMore")
	public void tousuJson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String secondMenuId = getPara("secondMenuId");
		if (StringUtil.isBlank(secondMenuId)) {
			secondMenuId = "";
		}
		Page pagePage = getPage();
		pagePage.setPageSize(5);
		Page pageList = null;
		if (secondMenuId != "") {
			pageList = dalClient.queryForPageList(
					"select * from security_news where menu_id=" + secondMenuId
							+ " and review_status=1 order by orderlist asc  ",
					pagePage);
		} else {
			pageList = dalClient
					.queryForPageList(
							"select * from security_news where  review_status=1 and menu_id in (select id from security_menu where  parent_id=1010) order by orderlist asc ",
							pagePage);
		}
		for(int i=0;i<pageList.getList().size();i++){
			Map<String,Object> map=(Map<String, Object>) pageList.getList().get(i);
			map.put("ctime", DateUtil.formatDateTime((Date)map.get("ctime"),"yyyy-MM-dd"));
			if(map.get("url")==null){
				map.put("url", "");
			}
			if(map.get("abstract_content")==null){
				map.put("abstract_content","");
			}
		}
		
		
		renderJson(response, JsonUtil.toJson(pageList));
	}

	@RequestMapping("/changyouDetail")
	public String changyouDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<SecurityMenu> quanjingMenuList = dalClient.queryForObjectList(
				"select * from security_menu where parent_id=1011",
				SecurityMenu.class);
		setAttr("quanjingMenuList", quanjingMenuList);

		List<SecurityMenu> changyouMenuList = dalClient.queryForObjectList(
				"select * from security_menu where parent_id=1010",
				SecurityMenu.class);
		setAttr("changyouMenuList", changyouMenuList);

		List<SecurityMenu> tingwenMenuList = dalClient.queryForObjectList(
				"select * from security_menu where parent_id=1037",
				SecurityMenu.class);
		setAttr("tingwenMenuList", tingwenMenuList);

		Map<String, Object> indexMap = dalClient
				.queryForObject("select * from system_indexsetting");
		setAttr("indexMap", indexMap);

		SecurityMenu menu = dalClient
				.queryForObject("select * from security_menu where id=1010",
						SecurityMenu.class);
		setAttr("changyou", menu);

		String id = getPara("id");
		SecurityNews securityNew = dalClient.findById(id, SecurityNews.class);
		setAttr("securityNew", securityNew);

		SecurityMenu securityMenu = dalClient.queryForObject(
				"select * from security_menu where id="
						+ securityNew.getMenuId(), SecurityMenu.class);
		setAttr("securityMenu", securityMenu);
		String bqId = getPara("bqId");
		SecurityMenu bq = dalClient.queryForObject(
				"select * from security_menu where id=" + bqId,
				SecurityMenu.class);
		setAttr("bqMenu", bq);

		String secondMenuId = getPara("secondMenuId");
		SecurityMenu secondMenu = dalClient.queryForObject(
				"select * from security_menu where id=" + secondMenuId,
				SecurityMenu.class);
		setAttr("secondMenu", secondMenu);

		// 标签
		List<Map<String, Object>> biaoqianList = dalClient
				.queryForObjectList("select * from news_maodian where news_id="
						+ id);
		setAttr("biaoqianList", biaoqianList);

		return "/changyouDetail";
	}

}
