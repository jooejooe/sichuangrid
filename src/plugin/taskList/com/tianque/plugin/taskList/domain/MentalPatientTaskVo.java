package com.tianque.plugin.taskList.domain;

import com.tianque.core.base.BaseDomain;
import com.tianque.domain.Organization;

public class MentalPatientTaskVo extends BaseDomain {
	/** 组织层级 **/
	private Organization organization;
	/** 姓名 **/
	private String name;
	/** 地点 **/
	private String place;
	/** 快速查询关键字  **/
	private String fastSearchCondition;
	/** 用户所在层级id  **/
	private Long userOrgId;
	/**是否有回复*/
	private Integer hasReplay;
	/**有无异常*/
	private Integer hasException;
	/**
	 * 帮扶人员
	 */
	private String helpPeople;
	/**
	 * 身份证号码
	 */
	private String idCard;
	/**
	 * 电话号码
	 */
	private String phone;
	
	public Integer getHasException() {
		return hasException;
	}

	public void setHasException(Integer hasException) {
		this.hasException = hasException;
	}

	public Integer getHasReplay() {
		return hasReplay;
	}

	public void setHasReplay(Integer hasReplay) {
		this.hasReplay = hasReplay;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getFastSearchCondition() {
		return fastSearchCondition;
	}

	public void setFastSearchCondition(String fastSearchCondition) {
		this.fastSearchCondition = fastSearchCondition;
	}

	public Long getUserOrgId() {
		return userOrgId;
	}

	public void setUserOrgId(Long userOrgId) {
		this.userOrgId = userOrgId;
	}

	public String getHelpPeople() {
		return helpPeople;
	}

	public void setHelpPeople(String helpPeople) {
		this.helpPeople = helpPeople;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

}
