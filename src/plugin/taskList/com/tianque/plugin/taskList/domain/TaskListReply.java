package com.tianque.plugin.taskList.domain;

import java.util.Date;
import java.util.List;

import org.apache.struts2.json.annotations.JSON;

import com.tianque.core.base.BaseDomain;

/**
 * 任务清单回复
 * @ClassName: TaskListReply 
 * @author: he.simin
 * @date: 2015年11月12日 下午3:24:47
 */
public class TaskListReply extends BaseDomain {
	private String moduleKey;
	private Long taskId;
	private String replyContent;
	private Long replyUserId;
	private String replyUser;
	private Date replyDate;
	/** 附件名 **/
	private String[] attachFileNames;

	/* 附件 */
	private List<TaskListAttachFile> annexFiles;
	/**回复部门类别，用于区分是派出所、卫生所*/
	private String replayOrgType;
	public String getModuleKey() {
		return moduleKey;
	}

	public void setModuleKey(String moduleKey) {
		this.moduleKey = moduleKey;
	}

	public Long getTaskId() {
		return taskId;
	}

	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public Long getReplyUserId() {
		return replyUserId;
	}

	public void setReplyUserId(Long replyUserId) {
		this.replyUserId = replyUserId;
	}

	public String getReplyUser() {
		return replyUser;
	}

	public void setReplyUser(String replyUser) {
		this.replyUser = replyUser;
	}

	@JSON(format = "yyyy-MM-dd HH:mm:ss")
	public Date getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}

	public String[] getAttachFileNames() {
		return attachFileNames;
	}

	public void setAttachFileNames(String[] attachFileNames) {
		this.attachFileNames = attachFileNames;
	}

	public List<TaskListAttachFile> getAnnexFiles() {
		return annexFiles;
	}

	public void setAnnexFiles(List<TaskListAttachFile> annexFiles) {
		this.annexFiles = annexFiles;
	}

	public String getReplayOrgType() {
		return replayOrgType;
	}

	public void setReplayOrgType(String replayOrgType) {
		this.replayOrgType = replayOrgType;
	}
}
