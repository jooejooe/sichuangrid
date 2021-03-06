package com.tianque.plugin.weChat.domain.sms;

import com.tianque.core.base.BaseDomain;
import com.tianque.domain.Organization;

/**
 * 短信账号
 * @ClassName: SmsAccount 
 * @author: he.simin
 * @date: 2015年11月5日 下午2:37:45
 */
public class SmsAccount extends BaseDomain {
	private Organization org;
	private String name;
	private String pwd;
	private String type;
	private String callbackPwd;
	/**
	 * 类容后缀
	 */
	private String contentSuffix;

	public Organization getOrg() {
		return org;
	}

	public void setOrg(Organization org) {
		this.org = org;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCallbackPwd() {
		return callbackPwd;
	}

	public void setCallbackPwd(String callbackPwd) {
		this.callbackPwd = callbackPwd;
	}

	public String getContentSuffix() {
		return contentSuffix;
	}

	public void setContentSuffix(String contentSuffix) {
		this.contentSuffix = contentSuffix;
	}
}
