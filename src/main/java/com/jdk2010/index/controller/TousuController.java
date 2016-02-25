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
import com.jdk2010.member.memberactivity.model.MemberActivity;
import com.jdk2010.member.membercomplain.model.MemberComplain;
import com.jdk2010.system.systemadv.service.ISystemAdvService;


@Controller
@RequestMapping(value = "/")
public class TousuController extends BaseController {
    Logger logger = LoggerFactory.getLogger(this.getClass());


    @Resource
    ISecurityNewsService securityNewsService;

    @Resource
    DalClient dalClient;
    
    @Resource
    ISystemAdvService systemAdvService;

    
    @RequestMapping("/tousu")
    public String tousu(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	DbKit dbKit = new DbKit("select * from member_complain where replay_status=1 and review_status=1  order by complain_time desc");
    	Page pagePage=getPage();
    	pagePage.setPageSize(3);
    	Page pageList = dalClient.queryForPageList(dbKit, pagePage, MemberComplain.class);
    	setAttr("pageList", pageList);
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        return "/tousu" ;
    }
    
    @RequestMapping("/wantTousu")
    public String wantTousu(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        return "/wantTousu" ;
    }
    
    
    @RequestMapping("/tousuDetail")
    public String tousuDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
         
        String id=getPara("id");
        MemberComplain complain=dalClient.findById(id, MemberComplain.class);
        setAttr("complain", complain);
        return "/tousuDetail" ;
    }
     
    @RequestMapping("/saveTousu")
    public void saveTousu(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	Map<String,Object> member=getSessionAttr("member");
    	Map<String,Object> data=(Map<String,Object>)member.get("data");
    	String memberid=data.get("id").toString();
       String complain_title=getPara("complain_title");
       String complain_message=getPara("complain_message");
       MemberComplain complain=new MemberComplain();
       complain.setComplainMessage(complain_message);
       complain.setComplainTitle(complain_title);
       complain.setComplainTime(new Date());
       complain.setMemberId(Integer.parseInt(memberid));
       complain.setMemberMobile(data.get("ctel")+"");
       complain.setReplayStatus(0);
       complain.setReviewStatus(0);
       if(data.get("cname")!=null){
    	   complain.setMemberName(data.get("cname")+"");
       }else{
    	   complain.setMemberName("游客");
       }
       
       dalClient.save(complain);
       ReturnData returnData=new ReturnData(Constants.SUCCESS,"保存成功");
       renderJson(response, returnData);
        
    }
    
    @RequestMapping("/myTousuList")
    public String myTousuList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String,Object>  indexMap=dalClient.queryForObject("select * from system_indexsetting");
        setAttr("indexMap", indexMap);
        
        Map<String, Object> member = getSessionAttr("member");
		if (member == null) {
			return "/login";
		} else {
			// 活动
			Map<String, Object> data = (Map<String, Object>) member.get("data");
			String memberid = data.get("id") + "";
			String searchSQL = "";

			String complain_title = getPara("complain_title");
			if (complain_title != null && !"".equals(complain_title)) {
				searchSQL = searchSQL + " and  complain_title LIKE '%" + complain_title + "%'";
				setAttr("complain_title", complain_title);
			}
			String replay_status = getPara("replay_status");
			if (replay_status != null && !"".equals(replay_status)) {
				searchSQL = searchSQL + " and  replay_status ="
						+ replay_status;
				setAttr("replay_status", replay_status);
			}

			String start_time_start = getPara("complain_time_start");
			if (start_time_start != null && !"".equals(start_time_start)) {
				searchSQL = searchSQL + " and  complain_time >='"
						+ start_time_start + "'";
				setAttr("complain_time_start", start_time_start);
			}

			String start_time_end = getPara("complain_time_end");
			if (start_time_end != null && !"".equals(start_time_end)) {
				searchSQL = searchSQL + " and  complain_time <='" + start_time_end
						+ "'";
				setAttr("complain_time_end", start_time_end);
			}

			List<MemberComplain> complainList = dalClient
					.queryForObjectList(
							"select * from member_complain where member_id ="+memberid + searchSQL+" order by complain_time desc",
							MemberComplain.class);
			setAttr("complainList", complainList);
			return "/myTousuList";
		}
    }
    
    

}
    