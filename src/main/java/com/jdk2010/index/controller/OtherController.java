package com.jdk2010.index.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import com.jdk2010.framework.constant.Constants;
import com.jdk2010.framework.controller.BaseController;
import com.jdk2010.framework.dal.client.DalClient;
import com.jdk2010.framework.util.DbKit;
import com.jdk2010.framework.util.HttpUtil;
import com.jdk2010.framework.util.JsonUtil;
import com.jdk2010.framework.util.Page;
import com.jdk2010.framework.util.ReturnData;
import com.jdk2010.framework.util.StringUtil;
import com.jdk2010.member.memberactivity.model.MemberActivity;
import com.jdk2010.search.systemsearchword.model.SystemSearchword;
import com.jdk2010.system.systemadv.model.SystemAdv;
import com.jdk2010.system.systemadv.service.ISystemAdvService;
import com.jdk2010.util.ZjjMsgUtil;

@Controller
@RequestMapping(value = "/")
public class OtherController extends BaseController {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource
	ISecurityNewsService securityNewsService;

	@Resource
	DalClient dalClient;

	@Resource
	ISystemAdvService systemAdvService;

	@RequestMapping("/other")
	public String other(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String otherId = getPara("otherId");
		List<SecurityMenu> otherMenuList = dalClient.queryForObjectList(
				"select * from security_menu where parent_id=" + otherId+"  order by orderlist asc",
				SecurityMenu.class);
		setAttr("otherMenuList", otherMenuList);

		Map<String, Object> indexMap = dalClient
				.queryForObject("select * from system_indexsetting");
		setAttr("indexMap", indexMap);

		SecurityMenu menu = dalClient.queryForObject(
				"select * from security_menu where id=" + otherId,
				SecurityMenu.class);
		setAttr("other", menu);
		
		
		
		// 全景的二级目录

		List<SecurityMenu> secondMenuList = dalClient.queryForObjectList(
				"select * from security_menu where parent_id=" + otherId
						+ " and status=1  order by orderlist asc",
				SecurityMenu.class);
		setAttr("secondMenuList", secondMenuList);

		String secondMenuId = getPara("secondMenuId");
		if (secondMenuId == null) {
			if (secondMenuList != null)
				secondMenuId = secondMenuList.get(0).getId() + "";
		}
		setAttr("secondMenuId", secondMenuId);

		// 全景的标签list
		List<SecurityMenu> bqMenuList = dalClient.queryForObjectList(
				"select * from security_menu where banner_id=" + secondMenuId
						+ " order by orderlist asc", SecurityMenu.class);
		setAttr("bqMenuList", bqMenuList);

		String currentId = getPara("currentId");
		if (currentId == null || currentId == "") {
			if (bqMenuList != null && bqMenuList.size() != 0) {
				if (bqMenuList != null && bqMenuList.size() > 0) {
					currentId = bqMenuList.get(0).getId() + "";
				}
			} else {
				currentId = "";
			}

		}
		setAttr("currentId", currentId);
		if (currentId.equals("")) {
			currentId = "0";
		}
		DbKit dbKit=null;
		if(bqMenuList.size()!=0){
		dbKit= new DbKit(
				"select * from security_news where id in (select news_id from bq_news where bq_id="
						+ currentId + ") order by orderlist asc");
		}else{
			dbKit= new DbKit(
					"select * from security_news where menu_id="+secondMenuId);	
		}
		Page pagePage = getPage();
		pagePage.setPageSize(1000);
		Page pageList = dalClient.queryForPageList(dbKit, pagePage,
				SecurityNews.class);
		setAttr("pageList", pageList);
		
		SecurityMenu secondMenu=dalClient.findById(secondMenuId, SecurityMenu.class);
		
		if(secondMenu.getColumnType().equals("1")){
			return "/other";
		}
		else if(secondMenu.getColumnType().equals("2")){
			SecurityNews securityNew = dalClient.queryForObject("select * from security_news where menu_id="+secondMenuId+ " limit 0,1",SecurityNews.class);
			setAttr("securityNew", securityNew);
			return "/otherDetail";
		}
		return null;
		
		
	}

	@RequestMapping("/otherDetail")
	public String otherDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String otherId = getPara("otherId");

		List<SecurityMenu> quanjingMenuList = dalClient.queryForObjectList(
				"select * from security_menu where parent_id=" + otherId,
				SecurityMenu.class);
		setAttr("quanjingMenuList", quanjingMenuList);

		Map<String, Object> indexMap = dalClient
				.queryForObject("select * from system_indexsetting");
		setAttr("indexMap", indexMap);

		SecurityMenu menu = dalClient.queryForObject(
				"select * from security_menu where id=" + otherId,
				SecurityMenu.class);
		setAttr("other", menu);

		String id = getPara("id");
		SecurityNews securityNew = dalClient.findById(id, SecurityNews.class);
		securityNew.setReadtotal(securityNew.getReadtotal() + 1);
		dalClient.update(securityNew);
		setAttr("securityNew", securityNew);

		String bqId = getPara("bqId");
		SecurityMenu bq=new SecurityMenu();
		if(StringUtil.isNotBlank(bqId)){
		 bq = dalClient.queryForObject(
				"select * from security_menu where id=" + bqId,
				SecurityMenu.class);
		
		}
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

		return "/otherDetail";
	}

}
