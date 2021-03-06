package com.tianque.plugin.weChat.util;


public class MediaUtil {
	private static Long maxId;

	/***
	 * 判断inboxId最大的值是否变化
	 * 比原来最大的inboxId大则表示有新增的信息
	 * @return
	 */
	public static boolean opinionInboxList(Long maxInboxId) {
		if (maxId == null) {
			maxId = maxInboxId;
		} else if (maxInboxId != null && maxId.intValue() < maxInboxId.intValue()) {
			maxId = maxInboxId;
			return true;
		}
		return false;
	}
}
