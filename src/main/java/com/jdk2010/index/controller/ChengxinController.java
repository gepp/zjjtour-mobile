package com.jdk2010.index.controller;

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
import com.jdk2010.framework.util.StringUtil;
import com.jdk2010.system.systemadv.service.ISystemAdvService;


@Controller
@RequestMapping(value = "/")
public class ChengxinController extends BaseController {
    Logger logger = LoggerFactory.getLogger(this.getClass());


    @Resource
    ISecurityNewsService securityNewsService;

    @Resource
    DalClient dalClient;
    
    @Resource
    ISystemAdvService systemAdvService;

    
    @RequestMapping("/chengxin")
    public String changyou(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        SecurityMenu menu=dalClient.queryForObject("select * from security_menu where id=1081" ,SecurityMenu.class);
        setAttr("chengxin", menu);
        
       
        List<Map<String,Object>> newsList;
        newsList=dalClient.queryForObjectList("select * from security_news where  review_status=1 and menu_id =1081 order by orderlist asc");
        setAttr("newsList", newsList);
        return "/chengxin" ;
    }
    
    @RequestMapping("/chengxinDetail")
    public String changyouDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        SecurityMenu menu=dalClient.queryForObject("select * from security_menu where id=1081" ,SecurityMenu.class);
        setAttr("chegnxin", menu);
         
        String id=getPara("id");
        SecurityNews securityNew=dalClient.findById(id, SecurityNews.class);
        setAttr("securityNew", securityNew);
        
        return "/chengxinDetail" ;
    }
     
   
 

}
    