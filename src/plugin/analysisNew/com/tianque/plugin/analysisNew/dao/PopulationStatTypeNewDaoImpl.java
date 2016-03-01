package com.tianque.plugin.analysisNew.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.stereotype.Repository;

import com.tianque.core.base.AbstractBaseDao;
import com.tianque.core.util.BaseInfoTables;
import com.tianque.core.util.CalendarUtil;
import com.tianque.plugin.analysisNew.domain.PopulationStatType;
import com.tianque.plugin.analysisNew.domain.StatisticSearchPopulationVo;

@Repository("populationStatTypeNewDao")
public class PopulationStatTypeNewDaoImpl extends AbstractBaseDao implements
		PopulationStatTypeNewDao {

	@Override
	public List<Map<String, Object>> findPopulationStatTypeForOrg(Long orgId,
			String populationType, int year, int month, String orgCode,
			Integer orgLevelDistance, Long orgType) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgId", orgId);
		map.put("populationtype", populationType);
		map.put("year", year);
		map.put("month", month);
		map.put("orgCode", orgCode);
		map.put("orgType", orgType);
		map.put("orgLevelDistance", orgLevelDistance);
		ArrayList<String> list = new ArrayList<String>();
		for (Entry<String, String> entry : BaseInfoTables.personnelTables
				.entrySet()) {
			list.add(entry.getKey());
		}
		map.put("tabletypes", list);
		/**现有的研判有这个，wc改的没有具体测试确认是否需要*/
		map.put("orgType", orgType);
		return (List<Map<String, Object>>) getSqlMapClientTemplate()
				.queryForList("populationStatTypeNew.findBaeInfo", map);
	}

	@Override
	public void addpopulationStatType(PopulationStatType populationType,
			String tableName, Date createDate, Date nextMonthStart,
			String orgCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tableName", tableName);
		map.put("beginDate", createDate);
		map.put("nextMonthStart", nextMonthStart);
		map.put("populationStatType", populationType);
		map.put("orginternalcode", orgCode);
		map.put("involveTibet", "西藏");
		map.put("involveSinkiang", "新疆维吾尔自治区");
		getSqlMapClientTemplate().insert(
				"populationStatTypeNew.addpopulationStat", map);

	}

	@Override
	public int getCountByTableName(String tableName, String orgCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tableName", tableName);
		map.put("orginternalcode", orgCode);
		return (Integer) getSqlMapClientTemplate().queryForObject(
				"populationStatTypeNew.getCountByTableName", map);
	}

	@Override
	public List<Map<String, Object>> getCountByOrgInternalCodeAndTableNameAndMap(
			String tableName, Long orgId, String orgCode,
			Integer orgLevelDistance, Long orgType) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tableName", tableName);
		map.put("orgId", orgId);
		map.put("orgCode", orgCode);
		map.put("orgLevelDistance", orgLevelDistance);
		map.put("orgType", orgType);
		return (List<Map<String, Object>>) getSqlMapClientTemplate()
				.queryForList(
						"populationStatTypeNew.getCountByOrgInternalCodeAndTableNameAndMap",
						map);
	}

	@Override
	public List<Map<String, Object>> getPopulationColumnByTime(Long orgId,
			String populationType, Integer year, Integer month, Long orgType) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("populationType", populationType);
		map.put("orgId", orgId);
		map.put("year", year);
		map.put("month", month);
		map.put("orgType", orgType);
		return (List<Map<String, Object>>) getSqlMapClientTemplate()
				.queryForList("populationStatTypeNew.getCountColumnByMonth", map);
	}

	@Override
	public int findTendencyChart(String populationType, Long orgId, String time) {
		String[] data = time.split("-");
		int year = Integer.valueOf(data[0]);
		int month = Integer.valueOf(data[1].startsWith("0") ? data[1]
				.substring(1) : data[1]);
		Integer sum = getStatisticsCount(populationType, orgId, time, year,
				month);
		return sum == null ? 0 : sum;
	}

	private Integer getStatisticsCount(String populationType, Long orgId,
			String time, Integer year, Integer month) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("populationType", populationType);
		map.put("orgId", orgId);
		map.put("time", time);
		map.put("year", year);
		map.put("month", month);
		Integer sum = (Integer) getSqlMapClientTemplate().queryForObject(
				"populationStatTypeNew.getCountByMonth", map);
		return sum;
	}

	public int findTendencyChart(String populationType, Long orgId,
			int year, int month) {
		Integer sum = getStatisticsCount(populationType, orgId, null, year,
				month);
		return sum == null ? 0 : sum;
	}

	@Override
	public void deletePopulationStatType(String orgCode, int year, int month,
			String populationType) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("populationType", populationType);
		map.put("orginternalCode", orgCode);
		map.put("year", year);
		map.put("month", month);
		getSqlMapClientTemplate().delete(
				"populationStatTypeNew.deleteInfoStatType", map);
	}

	@Override
	public int getHouseholdStaffCountByTypes(String orgInternalCode, Long id,
			String startDate, String endDate, String tableName, String type,
			Long logOut) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgCode", orgInternalCode);
		map.put("typeId", id);
		map.put("type", type);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("tableName", tableName);
		map.put("logOut", logOut);

		return (Integer) getSqlMapClientTemplate().queryForObject(
				"populationStatTypeNew.getHouseholdStaffCountByTypes", map);
	}

	/** 删除实有人员类型分布历史单表的记录 */
	@Override
	public void deleteHouseholdStaffHistoryStatistic(String orginternalcode,
			int year, int month, String type) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tableName", type);
		/**现有研判用这个*/
		map.put("orginternalCode", orginternalcode);
		map.put("year", year);
		map.put("month", month);
		getSqlMapClientTemplate().delete(
				"populationStatTypeNew.deleteHouseholdStaffInfoStatType", map);
	}

	/** 将数据插入到对应月份的实有人口的的类型分布表中 */
	@Override
	public void addHouseholdStaffHistoryStatistic(
			StatisticSearchPopulationVo statisticSearchPopulationVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tableName", statisticSearchPopulationVo.getType());
		map.put("domainTable", statisticSearchPopulationVo.getTable());
		map.put("month", statisticSearchPopulationVo.getMonth());
		map.put("year", statisticSearchPopulationVo.getYear());
		map.put("populationType", statisticSearchPopulationVo.getDomainName());
		map.put("typeName", statisticSearchPopulationVo.getPropertyDict()
				.getId());
		map.put("orgInternalCode",
				statisticSearchPopulationVo.getOrginternalcode());
		map.put("typeId", statisticSearchPopulationVo.getPropertyDict().getId());
		map.put("domainType", statisticSearchPopulationVo.getDisplayName());
		map.put("logOut", statisticSearchPopulationVo.getLogOut());
		map.put("startDate", statisticSearchPopulationVo.getStartDate());
		map.put("endDate", statisticSearchPopulationVo.getEndDate());
		map.put("nowDate", CalendarUtil.today());
		getSqlMapClientTemplate().insert(
				"populationStatTypeNew.addHouseholdStaffHistoryStatistic", map);
	}

	/** 实有人口类型分布图的大类的总数 */
	@Override
	public Long countByMapFromHistorySta(Map<String, Object> map) {

		return (Long) getSqlMapClientTemplate().queryForObject(
				"populationStatTypeNew.getHouseholdStaffTotalByDomainName", map);
	}

	@Override
	public void deleteYouthStatType(int year, int month) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		map.put("month", month);
		getSqlMapClientTemplate().delete("populationStatTypeNew.deleteYouthType",
				map);
	}

	@Override
	public void addYouthStatType(PopulationStatType populationStat) {
		getSqlMapClientTemplate().insert("populationStatTypeNew.addYouthType",
				populationStat);

	}

}