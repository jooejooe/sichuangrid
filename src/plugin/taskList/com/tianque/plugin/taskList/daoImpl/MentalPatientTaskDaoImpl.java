package com.tianque.plugin.taskList.daoImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.tianque.core.base.AbstractBaseDao;
import com.tianque.core.util.CalendarUtil;
import com.tianque.core.vo.PageInfo;
import com.tianque.exception.base.ServiceValidationException;
import com.tianque.plugin.taskList.constants.Constants;
import com.tianque.plugin.taskList.dao.MentalPatientTaskDao;
import com.tianque.plugin.taskList.domain.MentalPatientTask;

@Repository("mentalPatientTaskDao")
public class MentalPatientTaskDaoImpl extends AbstractBaseDao implements MentalPatientTaskDao {

	@Override
	public MentalPatientTask updateMentalPatientTask(MentalPatientTask mentalPatientTask) {
		try {
			getSqlMapClientTemplate().update("mentalPatientTask.updateMentalPatientTask",
					mentalPatientTask);
			return getMentalPatientTaskById(mentalPatientTask.getId());
		} catch (DataAccessException e) {
			throw new ServiceValidationException("修改吸毒人员走访信息出错", e);
		}
	}

	@Override
	public MentalPatientTask addMentalPatientTask(MentalPatientTask mentalPatientTask) {
		Long id = (Long) getSqlMapClientTemplate().insert("mentalPatientTask.addMentalPatientTask",
				mentalPatientTask);
		return getMentalPatientTaskById(id);
	}

	@Override
	public void deleteMentalPatientTaskByIds(List ids) {
		getSqlMapClientTemplate().delete("mentalPatientTask.deleteMentalPatientTaskById", ids);
	}

	@Override
	public PageInfo<MentalPatientTask> getMentalPatientTaskList(
			MentalPatientTask mentalPatientTask, Integer pageNum, Integer pageSize, String sidx,
			String sord) {
		Map map = new HashMap();
		map.put("orgCode", mentalPatientTask.getOrganization().getOrgInternalCode());
		map.put("order", sord);
		map.put("sortField", sidx);
		map.put("mode", mentalPatientTask.getMode());
		map.put("funOrgId", mentalPatientTask.getFunOrgId());
		map.put("mentalPatientId", mentalPatientTask.getMentalPatientId());
		map.put("hasReplay", mentalPatientTask.getHasReplay());
		map.put("hasException", mentalPatientTask.getHasException());
		map.put("modulekey", Constants.REPLY_MENTALPATIENTTASK_KEY);
		if (mentalPatientTask.getStatusJustice() != null) {
			map.put("statusJustice", mentalPatientTask.getStatusJustice());
		}
		if (mentalPatientTask.getStatusPolice() != null) {
			map.put("statusPolice", mentalPatientTask.getStatusPolice());
		}
		Integer countNum = (Integer) getSqlMapClientTemplate().queryForObject(
				"mentalPatientTask.countMentalPatientTask", map);
		List<MentalPatientTask> list = new ArrayList<MentalPatientTask>();
		if (pageNum == null || pageSize == null) {
			list = getSqlMapClientTemplate().queryForList(
					"mentalPatientTask.findMentalPatientTask", map);
			return new PageInfo<MentalPatientTask>(1, countNum, countNum, list);
		} else {
			list = getSqlMapClientTemplate().queryForList(
					"mentalPatientTask.findMentalPatientTask", map, (pageNum - 1) * pageSize,
					pageSize);
			return new PageInfo<MentalPatientTask>(pageNum, pageSize, countNum, list);
		}
	}

	@Override
	public PageInfo<MentalPatientTask> searchMentalPatientTaskAndGridTask(
			MentalPatientTask mentalPatientTask, Integer pageNum, Integer pageSize, String sidx,
			String sord) {
		Map map = new HashMap();
		if (mentalPatientTask.getConditionEndDate() != null) {
			map.put("conditionEndDate",
					CalendarUtil.getLastDaySecoend(mentalPatientTask.getConditionEndDate()));
		}
		map.put("orgCode", mentalPatientTask.getOrganization().getOrgInternalCode());
		map.put("fastSearchKeyWords", mentalPatientTask.getFastSearchKeyWords());
		map.put("conditionStartDate", mentalPatientTask.getConditionStartDate());
		map.put("guardianName", mentalPatientTask.getGuardianName());
		map.put("name", mentalPatientTask.getName());
		map.put("place", mentalPatientTask.getPlace());
		map.put("isout", mentalPatientTask.getIsout());
		map.put("isDriinked", mentalPatientTask.getIsDriinked());
		map.put("statusPolice", mentalPatientTask.getStatusPolice());
		map.put("statusJustice", mentalPatientTask.getStatusJustice());
		map.put("hasReplay", mentalPatientTask.getHasReplay());
		map.put("hasException", mentalPatientTask.getHasException());
		map.put("order", sord);
		map.put("sortField", sidx);
		Integer countNum = (Integer) getSqlMapClientTemplate().queryForObject(
				"mentalPatientTask.countMentalPatientTaskAndGridTask", map);
		List<MentalPatientTask> list = new ArrayList<MentalPatientTask>();
		if (pageNum == null || pageSize == null) {
			list = getSqlMapClientTemplate().queryForList(
					"mentalPatientTask.findMentalPatientTaskAndGridTask", map);
			return new PageInfo<MentalPatientTask>(1, countNum, countNum, list);
		} else {
			list = getSqlMapClientTemplate().queryForList(
					"mentalPatientTask.findMentalPatientTaskAndGridTask", map,
					(pageNum - 1) * pageSize, pageSize);
			return new PageInfo<MentalPatientTask>(pageNum, pageSize, countNum, list);
		}
	}

	@Override
	public PageInfo<MentalPatientTask> searchMentalPatientTaskAndGridTaskOther(
			MentalPatientTask mentalPatientTask, Integer pageNum, Integer pageSize, String sidx,
			String sord) {
		Map map = new HashMap();
		if (mentalPatientTask.getConditionEndDate() != null) {
			map.put("conditionEndDate",
					CalendarUtil.getLastDaySecoend(mentalPatientTask.getConditionEndDate()));
		}
		map.put("orgCode", mentalPatientTask.getOrganization().getOrgInternalCode());
		map.put("fastSearchKeyWords", mentalPatientTask.getFastSearchKeyWords());
		map.put("conditionStartDate", mentalPatientTask.getConditionStartDate());
		map.put("guardianName", mentalPatientTask.getGuardianName());
		map.put("name", mentalPatientTask.getName());
		map.put("place", mentalPatientTask.getPlace());
		map.put("isout", mentalPatientTask.getIsout());
		map.put("isDriinked", mentalPatientTask.getIsDriinked());
		map.put("statusPolice", mentalPatientTask.getStatusPolice());
		map.put("statusJustice", mentalPatientTask.getStatusJustice());
		map.put("hasReplay", mentalPatientTask.getHasReplay());
		map.put("hasException", mentalPatientTask.getHasException());
		map.put("order", sord);
		map.put("sortField", sidx);
		Integer countNum = (Integer) getSqlMapClientTemplate().queryForObject(
				"mentalPatientTask.countMentalPatientTaskAndGridTaskOther", map);
		List<MentalPatientTask> list = new ArrayList<MentalPatientTask>();
		if (pageNum == null || pageSize == null) {
			list = getSqlMapClientTemplate().queryForList(
					"mentalPatientTask.findMentalPatientTaskAndGridTaskOther", map);
			return new PageInfo<MentalPatientTask>(1, countNum, countNum, list);
		} else {
			list = getSqlMapClientTemplate().queryForList(
					"mentalPatientTask.findMentalPatientTaskAndGridTaskOther", map,
					(pageNum - 1) * pageSize, pageSize);
			return new PageInfo<MentalPatientTask>(pageNum, pageSize, countNum, list);
		}
	}

	@Override
	public MentalPatientTask getMentalPatientTaskById(Long id) {
		try {
			return (MentalPatientTask) getSqlMapClientTemplate().queryForObject(
					"mentalPatientTask.getById", id);
		} catch (DataAccessException e) {
			throw new ServiceValidationException("获取吸毒人员走访信息出错", e);
		}
	}

	@Override
	public PageInfo searchMentalPatient(MentalPatientTask mentalPatientTask, Integer pageNum,
			Integer pageSize, String sidx, String sord) {
		Map map = new HashMap();
		if (mentalPatientTask.getConditionEndDate() != null) {
			map.put("conditionEndDate",
					CalendarUtil.getLastDaySecoend(mentalPatientTask.getConditionEndDate()));
		}
		map.put("orgCode", mentalPatientTask.getOrganization().getOrgInternalCode());
		map.put("fastSearchKeyWords", mentalPatientTask.getFastSearchKeyWords());
		map.put("conditionStartDate", mentalPatientTask.getConditionStartDate());
		map.put("guardianName", mentalPatientTask.getGuardianName());
		map.put("name", mentalPatientTask.getName());
		map.put("place", mentalPatientTask.getPlace());
		map.put("isout", mentalPatientTask.getIsout());
		map.put("isDriinked", mentalPatientTask.getIsDriinked());
		map.put("statusPolice", mentalPatientTask.getStatusPolice());
		map.put("statusJustice", mentalPatientTask.getStatusJustice());
		map.put("hasReplay", mentalPatientTask.getHasReplay());
		map.put("hasException", mentalPatientTask.getHasException());
		map.put("order", sord);
		map.put("sortField", sidx);
		map.put("mode", mentalPatientTask.getMode());
		map.put("funOrgId", mentalPatientTask.getFunOrgId());
		map.put("helpPeople", mentalPatientTask.getHelpPeople());
		map.put("idCard", mentalPatientTask.getIdCard());
		map.put("phone", mentalPatientTask.getPhone());
		map.put("mentalPatientId", mentalPatientTask.getMentalPatientId());
		Integer countNum = (Integer) getSqlMapClientTemplate().queryForObject(
				"mentalPatientTask.countSearchMentalPatientTask", map);
		List<MentalPatientTask> list = new ArrayList<MentalPatientTask>();
		if (pageNum == null || pageSize == null) {
			list = getSqlMapClientTemplate().queryForList(
					"mentalPatientTask.searchMentalPatientTask", map);
			return new PageInfo<MentalPatientTask>(1, countNum, countNum, list);
		} else {
			list = getSqlMapClientTemplate().queryForList(
					"mentalPatientTask.searchMentalPatientTask", map, (pageNum - 1) * pageSize,
					pageSize);
			return new PageInfo<MentalPatientTask>(pageNum, pageSize, countNum, list);
		}
	}
}
