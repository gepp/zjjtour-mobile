package com.jdk2010.util;

import com.jdk2010.framework.util.HttpUtil;
import com.jdk2010.framework.util.MD5Utils;

public class Test {
	// String
	// sign=MD5(“v7line001{\"ctel\":\"18616240385\",\"type\":\"3\"}#ESDfsdfff”)
	// c9ffe4b0ec0a04591b7e9edc1f14fe00
	public static void main(String[] args) {
		String url = "http://ststest.travelzjj.com:15404/sts-app/Api/member/";
		String paramsJson = "{\"ctel\":\"18952028230\",\"type\":\"1\"}";
		String sign = MD5Utils.md5("v7line001"+paramsJson+"YD#$kweri8889");
		// System.out.println("sign:"+username+paramsJson+key);
		// System.out.println(StringEscapeUtils.escapeHtml(username+paramsJson+key));

		// System.out.println(sign);
		// sendurl=sendurl+"&sign=c9ffe4b0ec0a04591b7e9edc1f14fe00";
		// System.out.println(HttpUtil.post(url+"getMember?format=json&user=v7line001&paramsJson="+paramsJson+"&sign=a98d4566326dbb7df834bfb40c5ad117",""));
		String posturl=url+ "sendCode?format=json&user=v7line001&paramsJson="+ paramsJson + "&sign="+sign;
		System.out.println(posturl);
		System.out.println(HttpUtil.post(posturl,""));

	}
}
