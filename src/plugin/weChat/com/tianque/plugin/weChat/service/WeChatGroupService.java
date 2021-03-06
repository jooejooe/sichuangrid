package com.tianque.plugin.weChat.service;

import java.util.List;

import com.tianque.core.vo.PageInfo;
import com.tianque.plugin.weChat.domain.user.TencentUser;
import com.tianque.plugin.weChat.domain.user.WeChatGroup;

/**群组服务类*/
public interface WeChatGroupService {
	/**
	 * 微信分组列表
	 * @param weChatGroup
	 * @param pageNum
	 * @param pageSize
	 * @param sidx
	 * @param sord
	 * @return
	 */
	public PageInfo<WeChatGroup> findWeChatGroup(WeChatGroup weChatGroup, Integer pageNum,
			Integer pageSize, String sidx, String sord);
	/**根据微信公众号获取初始化该号的群组信息*/
	public boolean saveWeChatGroup(TencentUser tencentUser);

	/**根据服务号id（微信端）和groupId（微信端）获取群租对象*/
	public WeChatGroup getGroupByGroupIdAndWeChatUserId(WeChatGroup weChatGroup);

	/**根据服务号id（微信端）删除群组信息*/
	public void deleteWeChatGroupByWeChatUserId(String weChatUserId);

	/**根据服务号id（微信端）群列表*/
	public List<WeChatGroup> getGroupListWeChatUserId(String weChatUserId);

	/**
	 * 创建分组
	 * @param tencentUser
	 * @param groupName
	 * @return
	 */
	public WeChatGroup createGroup(TencentUser tencentUser, String groupName);
	/**
	 * 创建分组（系统）
	 * @param weChatGroup
	 * @return
	 */
	public Long addWeChatGroup(WeChatGroup weChatGroup);
	/**
	 * 修改分组（系统）
	 * @param weChatGroup
	 * @return
	 */
	public Integer updateWeChatGroup(WeChatGroup weChatGroup);

	/**
	 * 修改分组
	 * @param tencentUser
	 * @param groupId
	 * @param groupName
	 * @return
	 */
	public boolean updateGroup(TencentUser tencentUser, int groupId, String groupName);

	/**
	 * 移动用户分组
	 * @param tencentUser
	 * @param openId
	 * @param groupId
	 * @return
	 */
	public boolean removeUserForGroup(TencentUser tencentUser, String openId, int groupId);
	
	/**
	 * 根据id加载对象	
	 * @param weChatGroup
	 * @return
	 */
	public WeChatGroup getWeChatGroupById(WeChatGroup weChatGroup);
	
	/**
	 * 根据orgId得到群组信息
	 * @param orgId
	 * @return
	 */
	public List<WeChatGroup> getGroupListByOrgId(Long orgId);
	/**
	 * 根据name和weChatUserId得到groupId
	 * @param name
	 * @return
	 */
	public WeChatGroup getGroupListByNameAndWeChatUserId(String weChatUserId,String name);
	/**
	 * 修改消息管理分组及粉丝分组(系统)
	 * @param tencentUser
	 * @param groupId
	 * @return
	 */
	public void updateAllRelatedGroups(TencentUser tencentUser,Long groupId,String openId);
}
