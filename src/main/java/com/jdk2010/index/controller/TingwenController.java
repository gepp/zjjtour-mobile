package com.jdk2010.index.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ch.qos.logback.core.util.SystemInfo;

import com.jdk2010.base.security.menu.model.SecurityMenu;
import com.jdk2010.base.security.securitynews.model.SecurityNews;
import com.jdk2010.base.security.securitynews.service.ISecurityNewsService;
import com.jdk2010.framework.controller.BaseController;
import com.jdk2010.framework.dal.client.DalClient;
import com.jdk2010.framework.util.DbKit;
import com.jdk2010.framework.util.Page;
import com.jdk2010.framework.util.StringUtil;
import com.jdk2010.member.memberactivity.model.MemberActivity;
import com.jdk2010.system.systemadv.model.SystemAdv;
import com.jdk2010.system.systemadv.service.ISystemAdvService;


@Controller
@RequestMapping(value = "/")
public class TingwenController extends BaseController {
    Logger logger = LoggerFactory.getLogger(this.getClass());


    @Resource
    ISecurityNewsService securityNewsService;

    @Resource
    DalClient dalClient;
    
    @Resource
    ISystemAdvService systemAdvService;

    
    @RequestMapping("/tingwen")
    public String tingwen(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SecurityMenu> quanjingMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1011",SecurityMenu.class);
        setAttr("quanjingMenuList",quanjingMenuList);
        
        List<SecurityMenu> changyouMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1010",SecurityMenu.class);
        setAttr("changyouMenuList",changyouMenuList);
        
        List<SecurityMenu> tingwenMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1037",SecurityMenu.class);
        setAttr("tingwenMenuList",tingwenMenuList);
        
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        SecurityMenu menu=dalClient.queryForObject("select * from security_menu where id=1037" ,SecurityMenu.class);
        setAttr("quanjing", menu);
        //听闻
        String sql="select * from security_menu where  parent_id=1037 order by orderlist asc";
        List<SecurityMenu> secondMenuList=dalClient.queryForObjectList(sql,SecurityMenu.class);
        setAttr("secondMenuList", secondMenuList);
        
        String secondMenuId=getPara("secondMenuId");
        if(StringUtil.isBlank(secondMenuId)){
        	secondMenuId="";
        }
        setAttr("secondMenuId", secondMenuId);
        String thirdShowName="";
        //全景的新闻
        DbKit dbKit=null;        
        if(secondMenuId!=""){
        	dbKit = new DbKit("select * from security_news where menu_id="+secondMenuId+" and review_status=1 order by orderlist asc");
            SecurityMenu thirdShowMenu=   dalClient.findById(secondMenuId,SecurityMenu.class);
            thirdShowName=thirdShowMenu.getName();
        }else{
        	thirdShowName="全部";
        	dbKit = new DbKit("select * from security_news where  review_status=1 and menu_id in (select id from security_menu where  parent_id=1037) order by orderlist asc");
         }
        setAttr("thirdShowName", thirdShowName);
        
        Page pagePage = getPage();
		pagePage.setPageSize(6);
		Page pageList = dalClient.queryForPageList(dbKit, pagePage,
				SecurityNews.class);
		setAttr("pageList", pageList);
		
		
		if(secondMenuId.equals("1108")){
			List<SecurityMenu> lingdaoList=dalClient.queryForObjectList("select * from security_menu where type=3 and column_type=3 order by orderlist asc",SecurityMenu.class);
			setAttr("lingdaoList", lingdaoList);
		}
		
        return "/tingwen" ;
    }
    
    @RequestMapping("/tingwenDetail")
    public String quanjingDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SecurityMenu> quanjingMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1011",SecurityMenu.class);
        setAttr("quanjingMenuList",quanjingMenuList);
        
        List<SecurityMenu> changyouMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1010",SecurityMenu.class);
        setAttr("changyouMenuList",changyouMenuList);
        
        List<SecurityMenu> tingwenMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1037",SecurityMenu.class);
        setAttr("tingwenMenuList",tingwenMenuList);
        
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        SecurityMenu menu=dalClient.queryForObject("select * from security_menu where id=1011" ,SecurityMenu.class);
        setAttr("quanjing", menu);
         
        String id=getPara("id");
        dalClient.update("update security_news set readtotal=readtotal+1 where id="+id);
        SecurityNews securityNew=dalClient.findById(id, SecurityNews.class);
      
        setAttr("securityNew", securityNew);
        
        SecurityMenu securityMenu=dalClient.queryForObject("select * from security_menu where id="+securityNew.getMenuId() ,SecurityMenu.class);
        setAttr("securityMenu", securityMenu);
        
        
        return "/tingwenDetail" ;
    }
     
    
    @RequestMapping("/lingdaoDetail")
    public String lingdaoDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	 SecurityMenu menu=dalClient.queryForObject("select * from security_menu where id=1037" ,SecurityMenu.class);
         setAttr("xinwen", menu);
    	
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        String id=getPara("id");
        SecurityMenu lingdao=dalClient.findById(id, SecurityMenu.class);
        setAttr("lingdao", lingdao);
        
        
        List<SecurityNews> ZYHDList=dalClient.queryForObjectList("select * from security_news where menu_id="+id +" and review_status=1 and news_type='ZYHD' limit 0,3",SecurityNews.class);
        setAttr("ZYHDList", ZYHDList) ;
        
        List<SecurityNews> ZYJHList=dalClient.queryForObjectList("select * from security_news where menu_id="+id +" and review_status=1 and news_type='ZYJH' limit 0,3",SecurityNews.class);
        setAttr("ZYJHList", ZYJHList);
        
        List<SecurityNews> MTBDList=dalClient.queryForObjectList("select * from security_news where menu_id="+id +" and review_status=1 and news_type='MTBD' limit 0,3",SecurityNews.class);
        setAttr("MTBDList", MTBDList);
        
        return "/lingdaoDetail" ;
    }
    
    
    @RequestMapping("/lingdaoTingwen")
    public String lingdaoTingwen(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        SecurityMenu lingdao=dalClient.queryForObject("select * from security_menu where id="+getPara("menu_id") ,SecurityMenu.class);
        setAttr("lingdao", lingdao);
        
        SecurityMenu menu=dalClient.queryForObject("select * from security_menu where id=1037" ,SecurityMenu.class);
        setAttr("tingwen", menu);
        
        Page pagePage = getPage();
		pagePage.setPageSize(6);
		String news_type=getPara("news_type");
		String menu_id=getPara("menu_id");
		setAttr("news_type",news_type);
		setAttr("menu_id", menu_id);
		Page pageList = dalClient.queryForPageList("select * from security_news where news_type='"+news_type+"' and menu_id="+menu_id+" and review_status=1 order by ctime desc", pagePage,
				SecurityNews.class);
		setAttr("pageList", pageList);
        return "/lingdaoTingwen" ;
    }
   
 

}
    