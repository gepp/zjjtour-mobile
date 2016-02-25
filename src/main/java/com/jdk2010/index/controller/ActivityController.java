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
import com.jdk2010.framework.constant.Constants;
import com.jdk2010.framework.controller.BaseController;
import com.jdk2010.framework.dal.client.DalClient;
import com.jdk2010.framework.util.DateUtil;
import com.jdk2010.framework.util.ReturnData;
import com.jdk2010.framework.util.StringUtil;
import com.jdk2010.member.memberactivity.model.MemberActivity;
import com.jdk2010.system.systemadv.service.ISystemAdvService;


@Controller
@RequestMapping(value = "/")
public class ActivityController extends BaseController {
    Logger logger = LoggerFactory.getLogger(this.getClass());


    @Resource
    ISecurityNewsService securityNewsService;

    @Resource
    DalClient dalClient;
    
    @Resource
    ISystemAdvService systemAdvService;

    
    @RequestMapping("/activity")
    public String xiuxian(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SecurityMenu> quanjingMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1011",SecurityMenu.class);
        setAttr("quanjingMenuList",quanjingMenuList);
        
        List<SecurityMenu> changyouMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1010",SecurityMenu.class);
        setAttr("changyouMenuList",changyouMenuList);
        
        List<SecurityMenu> tingwenMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1037",SecurityMenu.class);
        setAttr("tingwenMenuList",tingwenMenuList);
        
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        SecurityMenu menu=dalClient.queryForObject("select * from security_menu where id=1058" ,SecurityMenu.class);
        setAttr("xiuxian", menu);
      
        String activityStatus=getPara("activityStatus");
        String conditionSql="";
        if(StringUtil.isNotBlank(activityStatus)){
        	conditionSql=" and activity_status="+activityStatus ;
        }else{
        	activityStatus="";
        }
        setAttr("activityStatus",activityStatus);
        String sql="select * from member_activity where 1=1 "+conditionSql+"  order by orderlist asc";
        List<MemberActivity> activityList=dalClient.queryForObjectList(sql,MemberActivity.class);
        setAttr("activityList", activityList);
        return "/activity" ;
    }
    
    @RequestMapping("/activityDetail")
    public String xiuxianDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<SecurityMenu> quanjingMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1011",SecurityMenu.class);
        setAttr("quanjingMenuList",quanjingMenuList);
        
        List<SecurityMenu> changyouMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1010",SecurityMenu.class);
        setAttr("changyouMenuList",changyouMenuList);
        
        List<SecurityMenu> tingwenMenuList=dalClient.queryForObjectList("select * from security_menu where parent_id=1037",SecurityMenu.class);
        setAttr("tingwenMenuList",tingwenMenuList);
        
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        String id=getPara("id");
        MemberActivity activity=dalClient.findById(id, MemberActivity.class);
        setAttr("activity", activity);
        return "/activityDetail" ;
    }
    
    @RequestMapping("/checkActivity")
    public void  checkActivity(HttpServletRequest request, HttpServletResponse response) throws Exception {
       String id=getPara("id");
       String status=Constants.SUCCESS;
       String msg="";
       Map<String,Object> member=getSessionAttr("member");
       System.out.println("member:"+member);
       if(member==null){
    	   status="001";
    	   msg="请您先登录！";
       }else{
    	   Map<String,Object> data=(Map<String,Object>)member.get("data");
    	   String userid=data.get("id").toString();
    	   Map<String,Object> map=dalClient.queryForObject("select * from member_activity_detail where activity_id="+id+ " and userid="+userid);
    	   if(map==null){
    		  dalClient.update("insert into member_activity_detail (activity_id,userid,ctime) values ("+id+","+userid+",'"+DateUtil.getNowTime()+"')");
    		  dalClient.update("update member_activity set usercount=usercount+1 where id="+id);
    	   }else{
    		   status="002";
        	   msg="您已经报名成功！";
    	   }
       }
       ReturnData returnData = new ReturnData(status, msg);
       renderJson(response,returnData);
    }
    
    
    
    
     
   
 

}
    