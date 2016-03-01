
package com.tianque.mobile.baseInfo.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.tianque.domain.Permission;
import com.tianque.domain.User;
import com.tianque.mobile.base.BaseMobileAction;
import com.tianque.mobile.baseInfo.UserPermissionEnameMobileAdapter;
import com.tianque.sysadmin.controller.PermissionController;

/**
 * @author Administrator
 *2015年12月22日下午6:03:23
 */

@Scope("request")
@Namespace("/mobile/userPermissionEnameManage")
@Controller("userPermissionEnameMobileAdapter")
public class UserPermissionEnameMobileAdapterImpl extends BaseMobileAction implements
UserPermissionEnameMobileAdapter{
	private User user;
	@Autowired
	private PermissionController permissionController;
	private List<String> userPermissionEname;
	private List<Permission> permissions;
	@Override
	@Action(value = "findUserAllPermissionForMobile", results = {
			@Result(type = "json", name = "success", params = { "root", "permissions",
					"ignoreHierarchy", "false" }),
			@Result(name = "error", type = "json", params = { "root", "errorMessage" }) })
	public String findUserAllPermissionForMobile() throws Exception {
		permissionController.findAllPermissionMobile();
		permissions = permissionController.getPermissions();
       return SUCCESS;
	}

	@Override
	@Action(value = "findUserAllPermissionMobileByUserId", results = {
			@Result(type = "json", name = "success", params = { "root", "userPermissionEname",
					"ignoreHierarchy", "false" }),
			@Result(name = "error", type = "json", params = { "root", "errorMessage" }) })
	public String findUserAllPermissionMobileByUserId() throws Exception {
		if (user == null) {
			this.errorMessage = "参数错误";
			return MOBILE_ERROR;
		}
		permissionController.setUser(user);
		permissionController.findUserAllPermissionByUserId();
		userPermissionEname = permissionController.getUserPermissionEname();
//		if (list!=null && list.size()>0) {
//			userPermissionEname=new ArrayList<String>();
//			for (int i = 0; i < list.size(); i++) {
//				
//				if (list.get(i).equals("interviewPositiveInfoRecordManagement")) {
//					userPermissionEname.add("interviewPositiveInfoRecordManagement");
//				}
//				if (list.get(i).equals("interviewRectificativePersonRecordManagement")) {
//					userPermissionEname.add("interviewRectificativePersonRecordManagement");
//				}
//				if (list.get(i).equals("interviewMentalPatientRecordManagement")) {
//					userPermissionEname.add("interviewMentalPatientRecordManagement");
//				}
//				if (list.get(i).equals("interviewDruggyRecordManagement")) {
//					userPermissionEname.add("interviewDruggyRecordManagement");
//				}
//			}
//		}
		return SUCCESS;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<String> getUserPermissionEname() {
		return userPermissionEname;
	}

	public void setUserPermissionEname(List<String> userPermissionEname) {
		this.userPermissionEname = userPermissionEname;
	}

	public List<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}
	
	
}