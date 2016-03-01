package com.tianque.plugin.taskList.domain;

import java.io.Serializable;

public class FloatingPopulationTask implements Serializable{
	/** 部们 、辖区中文名 */
	private String orgname;
	private Long id;
	//宣传核查
	private Long policeSum;
	private Long policeVisit;
	//民警带领开展工作
	private Long publicSum;
	private Long publicVisit;
	//大量聚集
	private Long gatherSum;
	private Long gatherVisit;
	private Long gatherReply;//大量聚集已回复
	//异常气味
	private Long smellSum;
	private Long smellVisit;
	private Long smellReply;
	//异常声音
	private Long noiseSum;
	private Long noiseVisit;
	private Long noiseReply;
	//无身份证
	private Long noIdcardSum;
	private Long noIdcardVisit;
	private Long noIdCardReply;
	//群租房人员来往复杂
	private Long groupLiveSum;
	private Long groupLiveVisit;
	private Long groupLiveReply;
	//已搬走
	private Long liveSum;
	private Long liveVisit;
	private Long liveReply;
	//总数
	private Long floatingPopulationSum;
	private Long floatingPopulationVisit;
	private Long floatingPolulationReply;
	
	

	public Long getGatherReply() {
		return gatherReply;
	}

	public void setGatherReply(Long gatherReply) {
		this.gatherReply = gatherReply;
	}

	public Long getSmellReply() {
		return smellReply;
	}

	public void setSmellReply(Long smellReply) {
		this.smellReply = smellReply;
	}

	public Long getNoiseReply() {
		return noiseReply;
	}

	public void setNoiseReply(Long noiseReply) {
		this.noiseReply = noiseReply;
	}

	public Long getNoIdCardReply() {
		return noIdCardReply;
	}

	public void setNoIdCardReply(Long noIdCardReply) {
		this.noIdCardReply = noIdCardReply;
	}

	public Long getGroupLiveReply() {
		return groupLiveReply;
	}

	public void setGroupLiveReply(Long groupLiveReply) {
		this.groupLiveReply = groupLiveReply;
	}

	public Long getLiveReply() {
		return liveReply;
	}

	public void setLiveReply(Long liveReply) {
		this.liveReply = liveReply;
	}

	public Long getFloatingPolulationReply() {
		return gatherReply+smellReply+noiseReply+noIdCardReply+groupLiveReply+liveReply;
	}

	public void setFloatingPolulationReply(Long floatingPolulationReply) {
		this.floatingPolulationReply = floatingPolulationReply;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getPoliceSum() {
		return policeSum;
	}

	public void setPoliceSum(Long policeSum) {
		this.policeSum = policeSum;
	}

	public Long getPoliceVisit() {
		return policeVisit;
	}

	public void setPoliceVisit(Long policeVisit) {
		this.policeVisit = policeVisit;
	}

	public Long getPublicSum() {
		return publicSum;
	}

	public void setPublicSum(Long publicSum) {
		this.publicSum = publicSum;
	}

	public Long getPublicVisit() {
		return publicVisit;
	}

	public void setPublicVisit(Long publicVisit) {
		this.publicVisit = publicVisit;
	}

	public Long getGatherSum() {
		return gatherSum;
	}

	public void setGatherSum(Long gatherSum) {
		this.gatherSum = gatherSum;
	}

	public Long getGatherVisit() {
		return gatherVisit;
	}

	public void setGatherVisit(Long gatherVisit) {
		this.gatherVisit = gatherVisit;
	}

	public Long getSmellSum() {
		return smellSum;
	}

	public void setSmellSum(Long smellSum) {
		this.smellSum = smellSum;
	}

	public Long getSmellVisit() {
		return smellVisit;
	}

	public void setSmellVisit(Long smellVisit) {
		this.smellVisit = smellVisit;
	}

	public Long getNoiseSum() {
		return noiseSum;
	}

	public void setNoiseSum(Long noiseSum) {
		this.noiseSum = noiseSum;
	}

	public Long getNoiseVisit() {
		return noiseVisit;
	}

	public void setNoiseVisit(Long noiseVisit) {
		this.noiseVisit = noiseVisit;
	}

	public Long getNoIdcardSum() {
		return noIdcardSum;
	}

	public void setNoIdcardSum(Long noIdcardSum) {
		this.noIdcardSum = noIdcardSum;
	}

	public Long getNoIdcardVisit() {
		return noIdcardVisit;
	}

	public void setNoIdcardVisit(Long noIdcardVisit) {
		this.noIdcardVisit = noIdcardVisit;
	}

	public Long getGroupLiveSum() {
		return groupLiveSum;
	}

	public void setGroupLiveSum(Long groupLiveSum) {
		this.groupLiveSum = groupLiveSum;
	}

	public Long getGroupLiveVisit() {
		return groupLiveVisit;
	}

	public void setGroupLiveVisit(Long groupLiveVisit) {
		this.groupLiveVisit = groupLiveVisit;
	}

	public Long getLiveSum() {
		return liveSum;
	}

	public void setLiveSum(Long liveSum) {
		this.liveSum = liveSum;
	}

	public Long getLiveVisit() {
		return liveVisit;
	}

	public void setLiveVisit(Long liveVisit) {
		this.liveVisit = liveVisit;
	}

	public Long getFloatingPopulationSum() {
		return policeSum + publicSum + gatherSum + smellSum + noiseSum + noIdcardSum + groupLiveSum
				+ liveSum;
	}

	public void setFloatingPopulationSum(Long floatingPopulationSum) {
		this.floatingPopulationSum = floatingPopulationSum;
	}

	public Long getFloatingPopulationVisit() {
		return policeVisit + publicVisit + gatherVisit + smellVisit + noiseVisit + noIdcardVisit
				+ groupLiveVisit + liveVisit;
	}

	public void setFloatingPopulationVisit(Long floatingPopulationVisit) {
		this.floatingPopulationVisit = floatingPopulationVisit;
	}

}