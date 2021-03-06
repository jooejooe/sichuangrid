package com.tianque.state;

public class OrgLocationInitType {
	public static final Integer IMPORT = 1; // 组织场所信息类
	public static final Integer TRANSFOR_MOVE = 2; // 转移流动信息类
	public static final Integer TRANSFOR_DOOM = 3; // 迁户注销信息类

	public static String toString(int typeValue) {
		switch (typeValue) {
		case 1:
			return "组织场所信息类";
		case 2:
			return "转移流动信息类";
		case 3:
			return "迁户注销信息类";

		default:
			return "";
		}
	}
}
