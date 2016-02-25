package com.jdk2010.index.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jdk2010.base.security.securitynews.service.ISecurityNewsService;
import com.jdk2010.framework.controller.BaseController;
import com.jdk2010.framework.dal.client.DalClient;
import com.jdk2010.framework.util.JsonUtil;
import com.jdk2010.framework.util.MD5Utils;
import com.jdk2010.system.systemadv.service.ISystemAdvService;
import com.jdk2010.util.ZjjMsgUtil;

@Controller
@RequestMapping(value = "/")
public class RegisterController extends BaseController {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Resource
	ISecurityNewsService securityNewsService;

	@Resource
	DalClient dalClient;

	@Resource
	ISystemAdvService systemAdvService;

	@RequestMapping("/toRegister")
	public String quanjingDetail(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return "/register";
	}

	@RequestMapping("/toLogin")
	public String toLogin(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return "/login";
	}
	
	@RequestMapping("/sendCode")
	public void sendCode(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String mobile=getPara("mobile");
		String returnMsg=ZjjMsgUtil.sendCode(mobile, "1");
		renderJson(response, returnMsg);
	}
	
	@RequestMapping("/isExists")
	public void isExists(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String mobile=getPara("mobile");
		String returnMsg=ZjjMsgUtil.isExists(mobile);
		renderJson(response, returnMsg);
	}
	
	@RequestMapping("/register")
	public void register(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String mobile=getPara("mobile");
		String verifyCode=getPara("verifyCode");
		String cpassword=getPara("cpassword");
		cpassword=MD5Utils.md5(cpassword);
		String returnMsg=ZjjMsgUtil.registerMember(mobile,verifyCode,cpassword);
		renderJson(response, returnMsg);
	}
	
	@RequestMapping("/login")
	public void login(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String mobile=getPara("mobile");
		String cpassword=getPara("cpassword");
		cpassword=MD5Utils.md5(cpassword);
		String returnMsg=ZjjMsgUtil.login(mobile,cpassword);
		setSessionAttr("member",JsonUtil.jsonToMap(returnMsg));
		renderJson(response, returnMsg);
	}
	
	@RequestMapping("/loginout")
	public void loginout(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		removeSessionAttr("member");
		renderJson(response,"");
	}
	
	
	@RequestMapping("/toGetPwd")
	public String toGetPwd(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return "/toGetPwd";
	}
	
	@RequestMapping("/sendCodeGetPwd")
	public void sendCodeGetPwd(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String mobile=getPara("mobile");
		String returnMsg=ZjjMsgUtil.sendCode(mobile, "3");
		renderJson(response, returnMsg);
	}
	
	@RequestMapping("/changePass")
	public void changePass(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String mobile=getPara("mobile");
		String verifyCode=getPara("verifyCode");
		String cpassword=getPara("cpassword");
//		cpassword=MD5Utils.md5(cpassword);
		String returnMsg=ZjjMsgUtil.changePass(mobile,verifyCode,cpassword);
		renderJson(response, returnMsg);
	}
	

}
