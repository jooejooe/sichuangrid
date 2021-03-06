package com.tianque.plugin.statistics.vo;

import java.io.Serializable;

public class TaskListStatisticsVo implements Serializable{

	private String orgIds;
	private Long orgId;//饼状图使用
	private String orgName;
	private String selectTypes;//所选择的类别字段
	private Integer searchDateType;//时间查询类别(0：月 1：季度 2：年度)
	private Integer isSegin;//查询数据类别(0:上报 1：签收 2：上报与签收)
	private Integer year;
	private Integer month;
	private Integer quarter;
	private Integer yearType;//选择年度查询类别(0:上半年 1:下半年 2:全年)
	private Integer situationType;//0：总况 1：流口总况
	private String propertyDomainName;//类别
	
	private String basesicType;
	private String detailType;
	private String subType;
	private Integer mapTypeByOrg;//判断任务类别条件事件  0为查询区域下的值  1为查询本级区域值
	
	
	public String getBasesicType() {
		return basesicType;
	}
	public void setBasesicType(String basesicType) {
		this.basesicType = basesicType;
	}
	public String getDetailType() {
		return detailType;
	}
	public void setDetailType(String detailType) {
		this.detailType = detailType;
	}
	public String getSubType() {
		return subType;
	}
	public void setSubType(String subType) {
		this.subType = subType;
	}
	public String getPropertyDomainName() {
		return propertyDomainName;
	}
	public void setPropertyDomainName(String propertyDomainName) {
		this.propertyDomainName = propertyDomainName;
	}
	public Integer getSituationType() {
		return situationType;
	}
	public void setSituationType(Integer situationType) {
		this.situationType = situationType;
	}
	public Long getOrgId() {
		return orgId;
	}
	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}
	public String getOrgIds() {
		return orgIds;
	}
	public void setOrgIds(String orgIds) {
		this.orgIds = orgIds;
	}
	public String getSelectTypes() {
		return selectTypes;
	}
	public void setSelectTypes(String selectTypes) {
		this.selectTypes = selectTypes;
	}
	public Integer getSearchDateType() {
		return searchDateType;
	}
	public void setSearchDateType(Integer searchDateType) {
		this.searchDateType = searchDateType;
	}
	public Integer getIsSegin() {
		return isSegin;
	}
	public void setIsSegin(Integer isSegin) {
		this.isSegin = isSegin;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	public Integer getQuarter() {
		return quarter;
	}
	public void setQuarter(Integer quarter) {
		this.quarter = quarter;
	}
	public Integer getYearType() {
		return yearType;
	}
	public void setYearType(Integer yearType) {
		this.yearType = yearType;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public Integer getMapTypeByOrg() {
		return mapTypeByOrg;
	}
	public void setMapTypeByOrg(Integer mapTypeByOrg) {
		this.mapTypeByOrg = mapTypeByOrg;
	}
	
	
}
