package com.tianque.plugin.orgchange.constant;

import com.tianque.plugin.dataManage.util.Constants;

/**
 * @Description:数据管理组织机构迁移合并常量类
 * @author zhangyouwei@hztian.com
 * @date: 2014-10-17 上午09:48:47
 */
public class DataManageDBOrgChangeStat {
	/** 【人口相关】处理重复数的sql 如果有重复数据 修改A网格的数据 【处理为状态为1（已处理）】、【是否可认领状态为0(不可认领)】 */
	public static final String CHANGE_DUPLICATE_FOR_POPULATION_SQL = "UPDATE #TABLENAME# T1 SET T1.DISPOSE="
			+ Constants.DisposeState.DISPOSED
			+ ",T1.CLAIMAVAILABLE="
			+ Constants.ClaimAvailable.CLAIMAVAILABLE_CANT
			+ ",T1.CLAIMSTATE="
			+ Constants.ClaimState.BEUNCLAIM
			+ " WHERE EXISTS "
			+ "(SELECT T2.IDCARDNO FROM #TABLENAME# T2 WHERE T1.IDCARDNO=T2.IDCARDNO AND T2.ORGID <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID#) AND T1.ORGID=#OLDORGID#";

	public static final String COUNT_DUPLICATE_FOR_POPULATION_SQL = "SELECT COUNT(*) FROM #TABLENAME# T1 "
			+ " WHERE EXISTS "
			+ "(SELECT T2.IDCARDNO FROM #TABLENAME# T2 WHERE T1.IDCARDNO=T2.IDCARDNO AND T2.ORGID <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID#) AND T1.ORGID=#OLDORGID#";

	/** 【境外人员】处理重复数的sql 如果有重复数据 修改A网格的数据 【处理为状态为1（已处理）】、【是否可认领状态为0(不可认领)】 */
	public static final String CHANGE_DUPLICATE_FOR_OVERSEAPERSONNEL_SQL = "UPDATE #TABLENAME# T1 SET T1.DISPOSE="
			+ Constants.DisposeState.DISPOSED
			+ ",T1.CLAIMAVAILABLE="
			+ Constants.ClaimAvailable.CLAIMAVAILABLE_CANT
			+ ",T1.CLAIMSTATE="
			+ Constants.ClaimState.BEUNCLAIM
			+ " WHERE EXISTS "
			+ "(SELECT T2.CERTIFICATENO FROM #TABLENAME# T2 WHERE T1.CERTIFICATENO=T2.CERTIFICATENO AND T1.CERTIFICATETYPE = T2.CERTIFICATETYPE AND T2.ORGID <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID# ) AND T1.ORGID=#OLDORGID#";

	public static final String COUNT_DUPLICATE_FOR_OVERSEAPERSONNEL_SQL = "SELECT COUNT(*) FROM #TABLENAME# T1 "
			+ " WHERE EXISTS "
			+ "(SELECT T2.CERTIFICATENO FROM #TABLENAME# T2 WHERE T1.CERTIFICATENO=T2.CERTIFICATENO AND T1.CERTIFICATETYPE = T2.CERTIFICATETYPE AND T2.ORGID <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID# ) AND T1.ORGID=#OLDORGID#";

	/** 【单位场所】相关处理重复数的sql 如果有重复数据 修改A网格的数据 【处理为状态为1（已处理）】、【是否可认领状态为0(不可认领)】 */
	public static final String CHANGE_DUPLICATE_FOR_COMPANYPLACE_SQL = "UPDATE #TABLENAME# T1 SET T1.DISPOSE="
			+ Constants.DisposeState.DISPOSED
			+ ",T1.CLAIMAVAILABLE="
			+ Constants.ClaimAvailable.CLAIMAVAILABLE_CANT
			+ ",T1.CLAIMSTATE="
			+ Constants.ClaimState.BEUNCLAIM
			+ " WHERE EXISTS "
			+ "(SELECT T2.NAME FROM #TABLENAME# T2 WHERE T1.NAME=T2.NAME AND T1.CLASSIFICATIONEN=T2.CLASSIFICATIONEN AND T2.ORG <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID#) AND T1.ORG=#OLDORGID#";

	public static final String COUNT_DUPLICATE_FOR_COMPANYPLACE_SQL = "SELECT COUNT(*) FROM #TABLENAME# T1 "
			+ " WHERE EXISTS "
			+ "(SELECT T2.NAME FROM #TABLENAME# T2 WHERE T1.NAME=T2.NAME AND T1.CLASSIFICATIONEN=T2.CLASSIFICATIONEN AND T2.ORG <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID#) AND T1.ORG=#OLDORGID#";

	/** 【社会组织】相关处理重复数的sql 如果有重复数据 修改A网格的数据 【处理为状态为1（已处理）】、【是否可认领状态为0(不可认领)】 */
	public static final String CHANGE_DUPLICATE_FOR_NEWSOCIETYORGANIZATION_SQL = "UPDATE #TABLENAME# T1 SET T1.DISPOSE="
			+ Constants.DisposeState.DISPOSED
			+ ",T1.CLAIMAVAILABLE="
			+ Constants.ClaimAvailable.CLAIMAVAILABLE_CANT
			+ ",T1.CLAIMSTATE="
			+ Constants.ClaimState.BEUNCLAIM
			+ " WHERE EXISTS "
			+ "(SELECT T2.NAME FROM #TABLENAME# T2 WHERE T1.NAME=T2.NAME AND T2.ORGID <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID#) AND T1.ORGID=#OLDORGID#";
	public static final String COUNT_DUPLICATE_FOR_NEWSOCIETYORGANIZATION_SQL = "SELECT COUNT(*) FROM #TABLENAME# T1 "
			+ " WHERE EXISTS "
			+ "(SELECT T2.NAME FROM #TABLENAME# T2 WHERE T1.NAME=T2.NAME AND T2.ORGID <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID#) AND T1.ORGID=#OLDORGID#";

	/** 【新经济组织】相关处理重复数的sql 如果有重复数据 修改A网格的数据 【处理为状态为1（已处理）】、【是否可认领状态为0(不可认领)】 */
	public static final String CHANGE_DUPLICATE_FOR_NEWECONOMICORGANIZATION_SQL = "UPDATE #TABLENAME# T1 SET T1.DISPOSE="
			+ Constants.DisposeState.DISPOSED
			+ ",T1.CLAIMAVAILABLE="
			+ Constants.ClaimAvailable.CLAIMAVAILABLE_CANT
			+ ",T1.CLAIMSTATE="
			+ Constants.ClaimState.BEUNCLAIM
			+ " WHERE EXISTS "
			+ "(SELECT T2.NAME FROM #TABLENAME# T2 WHERE T1.LICENSENUMBER=T2.LICENSENUMBER AND T2.ORGID <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID#) AND T1.ORGID=#OLDORGID#";
	public static final String COUNT_DUPLICATE_FOR_NEWECONOMICORGANIZATION_SQL = "SELECT COUNT(*) FROM #TABLENAME# T1 "
			+ " WHERE EXISTS "
			+ "(SELECT T2.NAME FROM #TABLENAME# T2 WHERE T1.LICENSENUMBER=T2.LICENSENUMBER AND T2.ORGID <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID#) AND T1.ORGID=#OLDORGID#";
	/** 【新经济组织】只有名称时，修改名称为来自A网格 */
	public static final String CHANGE_DUPLICATE_FOR_NEWECONOMICORGANIZATION_FOR_NAME_SQL = "UPDATE #TABLENAME# T1 SET T1.NAME= T1.NAME || #CHANGEORGNAME#"
			+ " WHERE EXISTS "
			+ "(SELECT T2.NAME FROM #TABLENAME# T2 WHERE T1.NAME=T2.NAME AND T1.LICENSENUMBER<>T2.LICENSENUMBER AND T2.ORGID <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID#) AND T1.ORGID=#OLDORGID#";

	public static final String COUNT_DUPLICATE_FOR_NEWECONOMICORGANIZATION_FOR_NAME_SQL = "SELECT COUNT(*) FROM #TABLENAME# T1 "
			+ " WHERE EXISTS "
			+ "(SELECT T2.NAME FROM #TABLENAME# T2 WHERE T1.NAME=T2.NAME AND T1.LICENSENUMBER<>T2.LICENSENUMBER AND T2.ORGID <> #OLDORGID# AND T2.CLAIMAVAILABLE = 1 AND T2.DISTRICTORGID = #NEWDISTRICTORGID#) AND T1.ORGID=#OLDORGID#";

	/** 处理数据所在的组织机构orgid */
	public static final String CHANGE_ORGID_SQL = "UPDATE #TABLENAME# D SET D.#ORGIDCOLUMN# = #NEWORGID#,D.ORGINTERNALCODE=#NEWORGCODE# WHERE D.#ORGIDCOLUMN# = #OLDORGID#";
	public static final String COUNT_ORGID_SQL = "SELECT COUNT(*) FROM #TABLENAME# D WHERE D.#ORGIDCOLUMN# = #OLDORGID#";

	/** 处理认领人网格id claimorgid */
	public static final String CHANGE_CLAIMORGID_SQL = "UPDATE #TABLENAME# D SET D.CLAIMORGID=#NEWORGID# WHERE D.CLAIMORGID=#OLDORGID#";
	public static final String COUNT_CLAIMORGID_SQL = "SELECT COUNT(*) FROM #TABLENAME# D WHERE D.CLAIMORGID=#OLDORGID#";

	/** 修改 importdepartmentid(导入部门Id) */
	public static final String CHANGE_IMPORTDEPARTMENTID_SQL = "UPDATE #TABLENAME# D SET D.IMPORTDEPARTMENTID=#NEWORGID# WHERE D.IMPORTDEPARTMENTID=#OLDORGID#";
	public static final String COUNT_IMPORTDEPARTMENTID_SQL = "SELECT COUNT(*) FROM #TABLENAME# D WHERE D.IMPORTDEPARTMENTID=#OLDORGID#";

	/** oldorgid(刚导入时的所属 网格Id) */
	public static final String CHANGE_OLDORGID_SQL = "UPDATE #TABLENAME# D SET D.OLDORGID=#NEWORGID# WHERE D.OLDORGID=#OLDORGID#";
	public static final String COUNT_OLDORGID_SQL = "SELECT COUNT(*) FROM #TABLENAME# D WHERE D.OLDORGID=#OLDORGID#";

	/** districtorgid(导入时的到县区的组织机构) */
	public static final String CHANGE_DISTRICTORGID_SQL = "UPDATE #TABLENAME# D SET D.DISTRICTORGID=#NEWDISTRICTORGID# WHERE D.DISTRICTORGID=#OLDDISTRICTORGID#";
	public static final String COUNT_DISTRICTORGID_SQL = "SELECT COUNT(*) FROM #TABLENAME# D WHERE D.DISTRICTORGID=#OLDDISTRICTORGID#";

}
