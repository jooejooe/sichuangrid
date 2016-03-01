package com.tianque.plugin.account.constants;

import java.util.ArrayList;
import java.util.List;

import com.tianque.domain.PropertyDict;

public class LedgerReportType {

	/*** 工作月报表 */
	public static final int MONTH_REPORT = 1;
	/*** 首页报表 */
	public static final int HOME_PAGE_REPORT = 2;
	/*** 年收集 */
	public static final int YEAR_COLLECT_REPORT = 3;
	/*** 月收集 */
	public static final int MONTH_COLLECT_REPORT = 4;
	/*** 月办结 */
	public static final int MONTH_DONE_REPORT = 5;
	/** 年月收集汇总 */
	public static final int YEAR_COLLECT_MONTH_SUM = 6;
	/** 年月收集详细 */
	public static final int YEAR_COLLECT_MONTH_DETAIL = 7;
	/** 年月收集办结汇总 */
	public static final int YEAR_COLLECT_DONE_SUM = 8;
	/** 年月收集办结详细 */
	public static final int YEAR_COLLECT_DONE_DETAIL = 9;
	/*** 村级工作月报表 */
	public static final String MONTH_REPORT_VILLAGE = "villageReport";
	/*** 镇级工作月报表 */
	public static final String MONTH_REPORT_TOWN = "townReport";
	/*** 县级工作月报表 */
	public static final String MONTH_REPORT_COUNTY = "countyReport";
	/*** 县级部门工作月报表 */
	public static final String MONTH_REPORT_COUNTY_DEPARTMENT = "countyDepartmentReport";
	/*** 村级工作报表 */
	public static final Integer REPORT_VILLAGE = 1;
	/*** 镇级工作报表 */
	public static final Integer REPORT_TOWN = 2;
	/*** 县级部门工作报表 */
	public static final Integer REPORT_COUNTY_DEPARTMENT = 3;
	/*** 县级工作报表 */
	public static final Integer REPORT_COUNTY = 4;
	/*** 用于民生报表分类信息对比 */
	public static List<PropertyDict> peopleAsPirationPropertyDicts = null;

	public static List<PropertyDict> initPeopleAsPirationPropertyDicts() {
		if (peopleAsPirationPropertyDicts == null) {
			peopleAsPirationPropertyDicts = new ArrayList<PropertyDict>();
			peopleAsPirationPropertyDicts.add(createPropertyDict(11L, "水利"));
			peopleAsPirationPropertyDicts.add(createPropertyDict(12L, "交通"));
			peopleAsPirationPropertyDicts.add(createPropertyDict(13L, "民生教育"));
			peopleAsPirationPropertyDicts.add(createPropertyDict(14L, "医疗卫生"));
			peopleAsPirationPropertyDicts.add(createPropertyDict(15L, "农业资源"));
			peopleAsPirationPropertyDicts.add(createPropertyDict(16L, "能源"));
			peopleAsPirationPropertyDicts
					.add(createPropertyDict(17L, "劳动和社会保障"));
			peopleAsPirationPropertyDicts
					.add(createPropertyDict(18L, "民生环境保护"));
			peopleAsPirationPropertyDicts.add(createPropertyDict(19L,
					"城乡规划建议管理"));
			peopleAsPirationPropertyDicts.add(createPropertyDict(110L, "科技文体"));
			peopleAsPirationPropertyDicts.add(createPropertyDict(111L, "其他资源"));
			// peopleAsPirationPropertyDicts.add(createPropertyDict(0L,
			// "民生工作小计"));
		}
		return peopleAsPirationPropertyDicts;
	}

	public static PropertyDict getPeopleAsPirationPropertyDict(Long id) {
		if (null != id) {
			List<PropertyDict> peopleAsPirationPropertyDicts = initPeopleAsPirationPropertyDicts();
			for (PropertyDict dict : peopleAsPirationPropertyDicts) {
				if (dict.getId().equals(id)) {
					return dict;
				}
			}
		}
		return new PropertyDict();
	}

	private static PropertyDict createPropertyDict(Long id, String name) {
		PropertyDict pro = new PropertyDict();
		pro.setId(id);
		pro.setDisplayName(name);
		return pro;
	}

}