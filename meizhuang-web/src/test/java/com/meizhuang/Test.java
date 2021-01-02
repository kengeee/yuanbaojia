package com.meizhuang;

import com.meizhuang.utils.encrypt.MD5;
import com.meizhuang.web.Constants;

/**   
* @Title: Test.java 
* @Package com.meizhuang 
* @Description: TODO(用一句话描述该文件做什么) 
* @author：Owen   
* @date 2020年8月16日 下午5:30:39
*/
public class Test {

	 public static void main(String[] args) {
		System.out.println(MD5.MD5EncodeUTF8(Constants.PWD_MD5_KEY + "admin@123"));
	}
}
