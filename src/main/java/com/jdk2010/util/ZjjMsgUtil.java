package com.jdk2010.util;

import java.util.HashMap;
import java.util.Map;

import com.jdk2010.framework.util.HttpUtil;
import com.jdk2010.framework.util.JsonUtil;
import com.jdk2010.framework.util.MD5Utils;
import com.jdk2010.framework.util.StringUtil;

public class ZjjMsgUtil {
	public static final String URL="http://ststest.travelzjj.com:15404/sts-app/Api/member/";
	public static final String KEY="YD#$kweri8889";
	public static final String USERNAME="v7line001";
	
	public static String getSign(String param){
		return MD5Utils.md5(USERNAME+param+KEY);
	}
	
	//发送验证码
	public static String sendCode(String mobile,String type){
 		String methodName="sendCode";
		String paramsJson = "{\"ctel\":\""+mobile+"\",\"type\":\""+type+"\"}";
		String sign = MD5Utils.md5(USERNAME+paramsJson+KEY);
		String posturl=URL+ methodName+"?format=json&user="+USERNAME+"&paramsJson="+ paramsJson + "&sign="+sign;
		System.out.println("sendCode-url:"+posturl);
		String returnStr=HttpUtil.post(posturl,"");
		System.out.println("returnstr:"+returnStr);
		return returnStr;
	}
	
	//是否注册
	public static String isExists(String mobile){
		String methodName="isExists";
		String paramsJson = "{\"cloginname\":\""+mobile+"\"}";
		String sign = MD5Utils.md5(USERNAME+paramsJson+KEY);
		String posturl=URL+ methodName+"?format=json&user="+USERNAME+"&paramsJson="+ paramsJson + "&sign="+sign;
		System.out.println("isExists-url:"+posturl);
		String returnStr=HttpUtil.post(posturl,"");
		System.out.println("returnstr:"+returnStr);
		return returnStr;
	}
	
	//注册
	public static String registerMember(String mobile,String verifyCode,String cpassword){
		String methodName="registerMember";
		String paramsJson ="{\"verifyCode\":\""+verifyCode+"\",data:{\"ctel\":\""+mobile+"\",\"cpassword\":\""+cpassword+"\",\"cnickname\":\""+mobile+"\"}}";
		String sign = MD5Utils.md5(USERNAME+paramsJson+KEY);
		String posturl=URL+ methodName+"?format=json&user="+USERNAME+"&paramsJson="+ paramsJson + "&sign="+sign;
		System.out.println("registerMember-url:"+posturl);
		String returnStr=HttpUtil.post(posturl,"");
		System.out.println("returnstr:"+returnStr);
		return returnStr;
	}
	
	//登录
	public static String login(String mobile,String cpassword){
		String methodName="memberLogin";
		String paramsJson ="{\"cloginname\":\""+mobile+"\",\"cpassword\":\""+cpassword+"\"}";
		String sign = MD5Utils.md5(USERNAME+paramsJson+KEY);
		String posturl=URL+ methodName+"?format=json&user="+USERNAME+"&paramsJson="+ paramsJson + "&sign="+sign;
		System.out.println("memberLogin-url:"+posturl);
		String returnStr=HttpUtil.post(posturl,"");
		System.out.println("returnstr:"+returnStr);
		return returnStr;
	}
	
	public static String updateMember(int id,String cnickname,String cname,String csex,String dbirthday,String cemail,String cheadimgurl){
		String methodName="updateMember";
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("id", id);
		if(StringUtil.isNotBlank(cnickname)){
			map.put("cnickname", cnickname);
		}
		if(StringUtil.isNotBlank(cname)){
			map.put("cname", cname);
		}
		if(StringUtil.isNotBlank(csex)){
			map.put("csex", csex);
		}
		if(StringUtil.isNotBlank(dbirthday)){
			map.put("dbirthday", dbirthday);
		}
		if(StringUtil.isNotBlank(cemail)){
			map.put("cemail", cemail);
		}
		if(StringUtil.isNotBlank(cheadimgurl)){
			map.put("cheadimgurl", cheadimgurl);
		}
		
		String paramsJson =JsonUtil.toJson(map);
		String sign = MD5Utils.md5(USERNAME+paramsJson+KEY);
		String posturl=URL+ methodName+"?format=json&user="+USERNAME+"&paramsJson="+ paramsJson + "&sign="+sign;
		System.out.println("updateMember-url:"+posturl);
		String returnStr=HttpUtil.post(posturl,"");
		System.out.println("returnstr:"+returnStr);
		return returnStr;
	}
	
	
	//注册
		public static String changePass(String mobile,String verifyCode,String cpassword){
			String methodName="changePass";
			String paramsJson ="{\"verifyCode\":\""+verifyCode+"\",\"ctel\":\""+mobile+"\",\"cpassword\":\""+cpassword+"\"}";
			String sign = MD5Utils.md5(USERNAME+paramsJson+KEY);
			System.out.println("sign:"+sign);
			String posturl=URL+ methodName+"?format=json&user="+USERNAME+"&paramsJson="+ paramsJson + "&sign="+sign;
			System.out.println("changePass-url:"+posturl);
			String returnStr=HttpUtil.post(posturl,"");
			System.out.println("returnstr:"+returnStr);
			return returnStr;
		}
	
	
	
	public static void main(String[] args) {
		int id=252;
		String cnickname="";
		String cname="123";
		String csex="";
		String dbirthday="";
		String cemail="";
		String cheadimgurl="";
		System.out.println(changePass("18952028230","255291","123433"));
	}
	
}
