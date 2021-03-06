package com.tianque.plugin.weChat.dao;

import java.util.List;
import java.util.Map;

import com.tianque.plugin.weChat.domain.inbox.ReplyMessage;

public interface ReplyMessageDao {
	/**列表查询*/
	/*public PageInfo<ReplyMessage> findReplyMessages(Map<String, Object> parameterMap,
			Integer pageNum, Integer pageSize);*/
	/**根据InboxId查找（模糊消息）回复信息*/
	public List<ReplyMessage> findReplyMessagesByInboxId(Long InboxId);
	
	/**根据preciseInboxId查找（精确消息）回复信息*/
	public List<ReplyMessage> findReplyMessagesByPreciseInboxId(Long preciseInboxId);

	/**新增回复记录*/
	public Long saveReplyMessage(ReplyMessage replyMessage);

	/**根据inboxId删除模糊消息回复记录*/
	public int deleteReplyMessageByInboxId(Long inboxId);
	
	/**根据preciseInboxId删除精确消息回复记录*/
	public int deleteReplyMessageByPreciseInboxId(Long preciseInboxId);

	/**根据inboxId查询模糊消息回复条数*/
	public Long countRMByInboxId(Long inboxId);
	
	/**根据preciseInboxId查询精确消息回复条数*/
	public Long countRMByPreciseInboxId(Long preciseInboxId);
	
	/**根据openId查询出未受理的回复记录*/
	public List<ReplyMessage> findReplyMessagesByOpenIdAndDealState(Map<String,Object> map);
	/**修改回复记录*/
	public void update(ReplyMessage replyMessage);
}
