package com.jdk2010.index.controller;

import java.util.Date;
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
import com.jdk2010.framework.util.DbKit;
import com.jdk2010.framework.util.JsonUtil;
import com.jdk2010.framework.util.Page;
import com.jdk2010.framework.util.StringUtil;
import com.jdk2010.member.memberactivity.model.MemberActivity;
import com.jdk2010.member.membercomplain.model.MemberComplain;
import com.jdk2010.system.systemadv.service.ISystemAdvService;

@Controller
@RequestMapping(value = "/")
public class ShipinController extends BaseController {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource
	ISecurityNewsService securityNewsService;

	@Resource
	DalClient dalClient;

	@Resource
	ISystemAdvService systemAdvService;

	@RequestMapping("/shipin")
	public String shipin(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		SecurityMenu menu = dalClient
				.queryForObject("select * from security_menu where id=1133",
						SecurityMenu.class);
		setAttr("shipin", menu);
		
		List<SecurityMenu> secondMenuList = dalClient.queryForObjectList(
				"select * from security_menu where parent_id=1133",
				SecurityMenu.class);
		setAttr("secondMenuList", secondMenuList);
		String secondMenuId = getPara("secondMenuId");
		if (secondMenuId == null) {
			if (secondMenuList != null)
				secondMenuId = secondMenuList.get(0).getId() + "";
		}
		setAttr("secondMenuId", secondMenuId);
//		// 全景的标签list
//		List<SecurityMenu> bqMenuList = dalClient.queryForObjectList(
//				"select * from security_menu where banner_id=" + secondMenuId
//						+ " order by orderlist asc", SecurityMenu.class);
//		setAttr("bqMenuList", bqMenuList);

		Map<String, Object> indexMap = dalClient
				.queryForObject("select * from system_indexsetting");
		setAttr("indexMap", indexMap);

		
		String currentId = getPara("currentId");
//		if (currentId == null || currentId == "") {
//			if (bqMenuList != null && bqMenuList.size() != 0)
//				if(bqMenuList!=null&&bqMenuList.size()>0)
//				currentId = bqMenuList.get(0).getId() + "";
//		}
//		setAttr("currentId", currentId);
//		if(currentId.equals("")){
//			currentId="0";
//		}
//		DbKit dbKit = new DbKit(
//				"select * from security_news where id in (select news_id from bq_news where bq_id="
//						+ currentId + ")");
		DbKit dbKit = new DbKit(
		"select * from security_news where menu_id="+secondMenuId+" and review_status=1 order by orderlist asc limit 0,6");
		 
		List<SecurityNews> shipinList = dalClient.queryForObjectList(dbKit,
				SecurityNews.class);
		setAttr("shipinList", shipinList);
		return "/shipin";
	}
	
	@RequestMapping("/shipinGetMore")
	public void tousuJson(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String secondMenuId = getPara("secondMenuId");
		if (StringUtil.isBlank(secondMenuId)) {
			secondMenuId = "";
		}
		Page pagePage = getPage();
		pagePage.setPageSize(6);
		Page pageList = null;
		if (secondMenuId != "") {
			pageList = dalClient.queryForPageList(
					"select * from security_news where menu_id=" + secondMenuId
							+ " and review_status=1 order by orderlist asc  ",
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
	
	@RequestMapping("/shipinDetail")
	public String shipinDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SecurityMenu menu = dalClient
				.queryForObject("select * from security_menu where id=1133",
						SecurityMenu.class);
		setAttr("shipin", menu);
		String id=getPara("id");
		SecurityNews newsShipin=securityNewsService.findById(id,SecurityNews.class);
		setAttr("newsShipin", newsShipin);
		return "/shipinDetail";
	}

		

}
