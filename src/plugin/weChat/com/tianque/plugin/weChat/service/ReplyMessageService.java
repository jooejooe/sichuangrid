package com.tianque.plugin.weChat.service;

import java.util.List;

import com.tianque.plugin.weChat.domain.inbox.ReplyMessage;

public interface ReplyMessageService {
	/**列表显示（根据inboxId）*/
	/*public PageInfo<ReplyMessage> findReplyMessages(ReplyMessage replyMessage, Integer pageNum,
			Integer pageSize, String sidx, String sord);*/
	/**根据InboxId查找模糊消息回复信息*/
	public List<ReplyMessage> findReplyMessagesByInboxId(Long InboxId);
	
	/**根据preciseInboxId查找精确消息回复信息*/
	public List<ReplyMessage> findReplyMessagesByPreciseInboxId(Long preciseInboxId);

	/**新增回复信息记录*/
	public Long saveReplyMessage(ReplyMessage replyMessage);

	/**根据inboxId删除模糊消息回复记录*/
	public int deleteReplyMessageByInboxId(Long inboxId);
	
	/**根据preciseInboxId删除精确消息回复记录*/
	public int deleteReplyMessageByPreciseInboxId(Long preciseInboxId);

	/**根据inboxId查询查询模糊消息回复条数*/
	public Long countRMByInboxId(Long inboxId);
	
	/**根据preciseInbox查询精确消息回复条数*/
	public Long countRMByPreciseInboxId(Long preciseInboxId);
	/**根据openId查询出未受理的回复记录*/
	public List<ReplyMessage> findReplyMessagesByOpenIdAndDealState(String fromUserName,Long isIssue);
	/**修改回复记录*/
	public void update(ReplyMessage replyMessage);
}
