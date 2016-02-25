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
import com.jdk2010.framework.constant.Constants;
import com.jdk2010.framework.controller.BaseController;
import com.jdk2010.framework.dal.client.DalClient;
import com.jdk2010.framework.util.DbKit;
import com.jdk2010.framework.util.Page;
import com.jdk2010.framework.util.ReturnData;
import com.jdk2010.framework.util.StringUtil;
import com.jdk2010.member.member.model.Member;
import com.jdk2010.member.membercomplain.model.MemberComplain;
import com.jdk2010.system.systemadv.service.ISystemAdvService;


@Controller
@RequestMapping(value = "/")
public class SearchController extends BaseController {
    Logger logger = LoggerFactory.getLogger(this.getClass());


    @Resource
    ISecurityNewsService securityNewsService;

    @Resource
    DalClient dalClient;
    
    @Resource
    ISystemAdvService systemAdvService;

    
    @RequestMapping("/search")
    public String search(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String keyword=getPara("keyword");
    	
    	System.out.println("keyword:"+keyword);
    	keyword=new String(keyword.getBytes("ISO8859-1"),"UTF-8");
    	setAttr("keyword", keyword);
    	DbKit dbKit = new DbKit("select * from security_news where  review_status=1 and title like '%"+keyword+"%' and menu_id in(select id from security_menu where can_search=1 ) order by ctime desc");
    	Page pagePage=getPage();
    	pagePage.setPageSize(5);
    	Page pageList = dalClient.queryForPageList(dbKit, pagePage, SecurityNews.class);
    	setAttr("pageList", pageList);
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        return "/search" ;
    }
    
    @RequestMapping("/searchDetail")
    public String wantTousu(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        return "/searchDetail" ;
    }
    
    
    
   
 

}
    