package com.tianque.plugin.statistics.vo;

import java.io.Serializable;

import com.tianque.domain.Organization;

public class TaskListMapVo implements Serializable{

	private int monthCreateSign;//月签收总数
	private Organization organization;
	private int onMonthCreateSign;//同比差值
	private String onProportion;//同比比例
	
	private int momMonthCreateSign;//环比差值
	private String momProportion;//环比比例 
	
	private int ranking;//排名
	
	
	public int getRanking() {
		return ranking;
	}
	public void setRanking(int ranking) {
		this.ranking = ranking;
	}
	public Organization getOrganization() {
		return organization;
	}
	public void setOrganization(Organization organization) {
		this.organization = organization;
	}
	public int getMonthCreateSign() {
		return monthCreateSign;
	}
	public void setMonthCreateSign(int monthCreateSign) {
		this.monthCreateSign = monthCreateSign;
	}
	public int getOnMonthCreateSign() {
		return onMonthCreateSign;
	}
	public void setOnMonthCreateSign(int onMonthCreateSign) {
		this.onMonthCreateSign = onMonthCreateSign;
	}
	public String getOnProportion() {
		return onProportion;
	}
	public void setOnProportion(String onProportion) {
		this.onProportion = onProportion;
	}
	public int getMomMonthCreateSign() {
		return momMonthCreateSign;
	}
	public void setMomMonthCreateSign(int momMonthCreateSign) {
		this.momMonthCreateSign = momMonthCreateSign;
	}
	public String getMomProportion() {
		return momProportion;
	}
	public void setMomProportion(String momProportion) {
		this.momProportion = momProportion;
	}
	
	
}