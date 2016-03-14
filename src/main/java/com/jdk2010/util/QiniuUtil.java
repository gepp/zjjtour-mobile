package com.jdk2010.util;

import java.io.IOException;
import java.util.Map;

import com.jdk2010.framework.util.ConfigUtil;
import com.jdk2010.framework.util.JsonUtil;
import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;

public class QiniuUtil {
	// 设置好账号的ACCESS_KEY和SECRET_KEY

	private static final ConfigUtil configUtil = new ConfigUtil("/conf/qiniu.properties");
	private static String ACCESS_KEY = "";
	private static String SECRET_KEY = "";
	private static String BEFORE_URL = "";
	// 要上传的空间
	private static String BUCKETNAME = "";
	static {
		ACCESS_KEY = configUtil.getString("ACCESS_KEY");
		SECRET_KEY = configUtil.getString("SECRET_KEY");
		BUCKETNAME = configUtil.getString("BUCKETNAME");
		BEFORE_URL = configUtil.getString("BEFORE_URL");
	}

	// 上传到七牛后保存的文件名
	String key = "my-java.png";
	// 上传文件的路径
	String FilePath = "c:\\image10.jpg";

	// 密钥配置
	static Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
	// 创建上传对象
	static UploadManager uploadManager = new UploadManager();

	// 简单上传，使用默认策略，只需要设置上传的空间名就可以了
	public static String getUpToken() {
		return auth.uploadToken(BUCKETNAME);
	}

	public static String upload(String FilePath) throws IOException {
		String name = "03.jpg";
		try {
			// 调用put方法上传
			Response res = uploadManager.put(FilePath, null, getUpToken());
			// 打印返回的信息
			String returnMsg = res.bodyString();
			Map<String, Object> returnMap = JsonUtil.jsonToMap(returnMsg);
			name = (String) returnMap.get("key");

		} catch (QiniuException e) {
			Response r = e.response;
			// 请求失败时打印的异常的信息
			System.out.println(r.toString());
			try {
				// 响应的文本信息
				System.out.println(r.bodyString());
			} catch (QiniuException e1) {
				// ignore
			}
		}
		return BEFORE_URL + name;
	}

	public static void main(String args[]) throws IOException {

	}

}
