package com.tianque.plugin.account.controller;

import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Actions;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.tianque.account.api.PeopleAspirationDubboService;
import com.tianque.account.api.ThreeRecordsIssueDubboService;
import com.tianque.account.api.ThreeRecordsSearchIssueStepDubboService;
import com.tianque.controller.ControllerHelper;
import com.tianque.core.base.BaseAction;
import com.tianque.core.util.GlobalValue;
import com.tianque.core.util.ThreadVariable;
import com.tianque.core.vo.GridPage;
import com.tianque.core.vo.PageInfo;
import com.tianque.domain.Organization;
import com.tianque.domain.User;
import com.tianque.plugin.account.constants.LedgerConstants;
import com.tianque.plugin.account.constants.ThreeRecordsIssueConstants;
import com.tianque.plugin.account.constants.ThreeRecordsIssueViewType;
import com.tianque.plugin.account.domain.LedgerPeopleAspirations;
import com.tianque.plugin.account.domain.Medical;
import com.tianque.plugin.account.toexcel.AccountExportHelper;
import com.tianque.plugin.account.util.DialogMode;
import com.tianque.plugin.account.util.ThreeRecordOrgJudge;
import com.tianque.plugin.account.util.ThreeRecordsIssueOperationUtil;
import com.tianque.plugin.account.vo.ThreeRecordsIssueViewObject;
import com.tianque.sysadmin.service.OrganizationDubboService;

@Scope("request")
@Namespace("/threeRecords/medical")
@Controller("medicalController")
public class MedicalController extends BaseAction {

	private Long issuesKeyId;
	private String seachValue;
	private LedgerPeopleAspirations peopleAspirations;
	private Organization organization;
	private String type;
	/** 根据操作不同 可能是台账id、orgid、台账处理步骤id(issueStepId) */
	private Long keyId;
	private String viewType;// 视图类型
	private Long orgLevel;
	private Long sourceType; // 台账来源
	private Long issueType;
	private Integer viewProcess;// 是否是查询大屏滚动的数据
	private Medical medical;

	@Autowired
	private ThreeRecordsSearchIssueStepDubboService searchIssueStepDubboService;
	@Autowired
	private ThreeRecordsIssueDubboService threeRecordsIssueDubboService;
	@Autowired
	private PeopleAspirationDubboService peopleAspirationDubboService;
	@Autowired
	private OrganizationDubboService organizationDubboService;
	private Map<String, Integer> countMap;
	private Integer year;
	private Integer month;

	/**
	 * 页面跳转
	 * 
	 * @return
	 */
	@Actions({ @Action(value = "dispatch", results = {
			@Result(name = "success", location = "/account/peopleAspiration/medicalMainDlg.jsp"),
			@Result(name = "viewNew", location = "/account/peopleAspiration/viewMedicalNewDlg.jsp"),
			@Result(name = "print", location = "/account/peopleAspiration/printMedicalDlg.jsp"),
			@Result(name = "search", location = "/account/peopleAspiration/searchMedicalDlg.jsp"),
			@Result(name = "error", type = "json", params = { "root",
					"errorMessage" }) }) })
	public String dispatchOperate() throws Exception {
		if (DialogMode.ADD_MODE.equals(mode)) {
			peopleAspirations = peopleAspirationDubboService
					.createTemporaryPeopleAspiration(
							LedgerConstants.PEOPLEASPIRATION_MEDICAL,
							ThreadVariable.getOrganization().getId());

		} else if (DialogMode.EDIT_MODE.equals(mode)) {
			if (keyId == null) {
				errorMessage = "参数无效!";
				return ERROR;
			}
			peopleAspirations = peopleAspirationDubboService
					.findPeopleAspirationAndFileOrLogAndLogFile(
							LedgerConstants.PEOPLEASPIRATION_MEDICAL, keyId,
							false, false);
			medical = peopleAspirationDubboService
					.getMedicalByAspirationId(keyId);
		} else if (DialogMode.VIEW_NEW_MODE.equals(mode)
				|| DialogMode.PRINT_MODE.equals(mode)) {
			return forwardToViewNew();
		} else if (DialogMode.SEARCH_MODE.equalsIgnoreCase(mode)) {
			return DialogMode.SEARCH_MODE;
		}

		return SUCCESS;
	}

	/**
	 * Medical
	 * 
	 * @return
	 */
	@Action(value = "addMedical", results = {
			@Result(name = "success", type = "json", params = { "root",
					"medical", "ignoreHierarchy", "false" }),
			@Result(name = "error", type = "json", params = { "root",
					"errorMessage" }) })
	public String addMedical() throws Exception {
		if (medical == null || medical.getPeopleAspiration() == null) {
			this.errorMessage = "参数无效!";
			return ERROR;
		}
		medical = peopleAspirationDubboService.addMedical(medical);
		return SUCCESS;
	}

	@Action(value = "updateMedical", results = {
			@Result(name = "success", type = "json", params = { "root",
					"medical", "ignoreHierarchy", "false" }),
			@Result(name = "error", type = "json", params = { "root",
					"errorMessage" }) })
	public String updateMedical() throws Exception {
		if (medical == null || medical.getId() == null) {
			this.errorMessage = "参数无效!";
			return ERROR;
		}
		medical = peopleAspirationDubboService.updateMedical(medical);
		return SUCCESS;
	}

	@Action(value = "getMedical", results = { @Result(name = "success", location = "/account/peopleAspiration/medicalDlg.jsp") })
	public String viewMedical() throws Exception {
		if (keyId != null) {
			medical = peopleAspirationDubboService
					.getMedicalByAspirationId(keyId);
		}
		return SUCCESS;
	}

	@Action(value = "deleteMedical", results = {
			@Result(name = "success", type = "json", params = { "root", "true" }),
			@Result(name = "error", type = "json", params = { "root",
					"errorMessage", "ignoreHierarchy", "false" }) })
	public String deleteMedical() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		User user = ThreadVariable.getUser();
		if (user == null
				|| user.getOrganization() == null
				|| !(user.getOrganization().getDepartmentNo()
						.endsWith(ThreeRecordsIssueConstants.COUNTY_LEDGER))) {
			return GlobalValue.NOT_HAVE_PERMISSION_RESULT;
		}
		if (!hasPermission(keyId, null)
				&& !ThreeRecordOrgJudge.isJg(ThreadVariable.getOrganization())) {
			return GlobalValue.NOT_HAVE_PERMISSION_RESULT;
		}
		AttachFileUtil.removeIssueAllAttachFiles(keyId,
				LedgerConstants.PEOPLEASPIRATION_MEDICAL,
				threeRecordsIssueDubboService);
		peopleAspirationDubboService.deleteMedicalLedgerAndStepById(keyId);
		return SUCCESS;
	}

	@Action(value = "getIssueCount", results = {
			@Result(name = "success", type = "json", params = { "root",
					"countMap", "ignoreHierarchy", "false" }),
			@Result(name = "error", type = "json", params = { "root",
					"errorMessage" }) })
	public String getIssueCount() {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		countMap = threeRecordsIssueDubboService.getIssueCount(keyId,
				Long.valueOf(LedgerConstants.PEOPLEASPIRATION_MEDICAL), year, month);
		return SUCCESS;
	}

	@Action(value = "findIssueForView", results = {
			@Result(name = "success", type = "json", params = { "root",
					"gridPage", "ignoreHierarchy", "false" }),
			@Result(name = "error", type = "json", params = { "root",
					"errorMessage", "ignoreHierarchy", "false" }) })
	public String findIssueForView() throws Exception {
		// 根据不同类型调用不同的service
		if (ThreeRecordsIssueViewType.NEED.equalsIgnoreCase(viewType)) {
			return findJurisdictionsNeedDo();
		} else if (ThreeRecordsIssueViewType.DONE.equalsIgnoreCase(viewType)) {
			return findJurisdictionsDone();
		} else if (ThreeRecordsIssueViewType.PERIOD.equalsIgnoreCase(viewType)) {
			return findPeriodCompletedList();
		} else if (ThreeRecordsIssueViewType.COMPLETED
				.equalsIgnoreCase(viewType)) {
			return findCompletedIssueList();
		} else if (ThreeRecordsIssueViewType.FEEDBACK
				.equalsIgnoreCase(viewType)) {
			return findJurisdictionsFeedBack();
		} else if (ThreeRecordsIssueViewType.ASSIGN.equalsIgnoreCase(viewType)) {
			return findJurisdictionsAssgin();
		} else if (ThreeRecordsIssueViewType.SUBMIT.equalsIgnoreCase(viewType)) {
			return findJurisdictionsSubmit();
		} else if (ThreeRecordsIssueViewType.FOLLOW.equalsIgnoreCase(viewType)) {
			return findJurisdictionsFollow();
		} else if (ThreeRecordsIssueViewType.SUPPORT.equalsIgnoreCase(viewType)) {
			return findJurisdictionsSupportDo();
		} else if (ThreeRecordsIssueViewType.NOTICE.equalsIgnoreCase(viewType)) {
			return findJurisdictionsNoticeDo();
		} else if (ThreeRecordsIssueViewType.CREATE_DONE
				.equalsIgnoreCase(viewType)) {
			return findJurisdictionsCreateAndDone();
		} else {
			errorMessage = "未知的操作类型";
			return ERROR;
		}
	}

	@Action(value = "existMedical", results = {
			@Result(name = "success", type = "json", params = { "root",
					"medical", "ignoreHierarchy", "false" }),
			@Result(name = "error", type = "json", params = { "root",
					"errorMessage" }) })
	public String existMedical() throws Exception {
		if (keyId != null) {
			medical = peopleAspirationDubboService
					.getMedicalByAspirationId(keyId);
		}
		return SUCCESS;
	}

	/**
	 * 导出
	 */
	@Action(value = "exportExcel", results = {
			@Result(name = "success", type = "stream", params = { "contentType", "application/vnd.ms-excel;charset=ISO8859-1",
					"inputName","inputStream","contentDisposition","attachment;filename=${downloadFileName}","bufferSize","4096"}),
			@Result(name = "error", type = "json", params = { "root",
					"errorMessage", "ignoreHierarchy", "false" }) })
	public String exportExcel() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		if (issuesKeyId != null) {
			keyId = issuesKeyId;
		}
		if (!hasPermission(keyId, null) && !ThreeRecordOrgJudge.isJgOrLxOrxW(ThreadVariable.getOrganization())) {
			return GlobalValue.NOT_HAVE_PERMISSION_RESULT;
		}
		peopleAspirations = peopleAspirationDubboService
				.findPeopleAspirationAndFileOrLogAndLogFile(
						LedgerConstants.PEOPLEASPIRATION_MEDICAL, keyId, true,
						true, true);
		medical = peopleAspirationDubboService.getMedicalByAspirationId(keyId);
		inputStream = AccountExportHelper.exportDateToExcel(peopleAspirations,medical==null?new Medical():medical);
		downloadFileName = new String(("民生信息登记卡（医疗卫生类）"+peopleAspirations.getSerialNumber()).getBytes("gbk"),
				"ISO8859-1") + ".xls";
		return SUCCESS;
	}
	
	/***************************************************************************
	 * 下辖事项-待办事项列表
	 * 
	 * @return
	 */
	private String findJurisdictionsNeedDo() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsNeedDo(seachValue, keyId, page, rows, sidx,
						sord, issueType, year, month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);
		return SUCCESS;
	}

	/***************************************************************************
	 * 下辖事项-已办结案事项列表
	 * 
	 * @return
	 */
	private String findJurisdictionsDone() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsDone(seachValue, keyId, page, rows, sidx,
						sord, issueType,year,month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);
		return SUCCESS;
	}

	/***************************************************************************
	 * 
	 * 下辖事项-已办事项列表
	 * 
	 * @return
	 */
	private String findCompletedIssueList() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsSubstanceDone(seachValue, keyId, page, rows,
						sidx, sord, issueType,year,month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);
		return SUCCESS;
	}

	/***************************************************************************
	 * 
	 * 下辖事项-阶段办结事项列表
	 * 
	 * @return
	 */
	private String findPeriodCompletedList() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsPeriodDone(seachValue, keyId, page, rows,
						sidx, sord, issueType,year,month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);

		return SUCCESS;
	}

	/***************************************************************************
	 * 下辖事项-协办事项列表
	 * 
	 * @return
	 */
	private String findJurisdictionsSupportDo() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsSupportDo(seachValue, keyId, page, rows,
						sidx, sord, issueType,year,month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);
		return SUCCESS;
	}

	/***************************************************************************
	 * 下辖事项-抄告事项列表
	 * 
	 * @return
	 */
	private String findJurisdictionsNoticeDo() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsNoticeDo(seachValue, keyId, page, rows, sidx,
						sord, issueType,year,month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);
		return SUCCESS;
	}

	/***************************************************************************
	 * 下辖事项-已办和新建事项列表
	 * 
	 * @return
	 */
	private String findJurisdictionsCreateAndDone() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsCreateAndDone(seachValue, keyId, page, rows,
						sidx, sord, issueType,year,month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);
		return SUCCESS;
	}

	/***************************************************************************
	 * 下辖事项-待跟进事项列表
	 * 
	 * @return
	 */
	private String findJurisdictionsFollow() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsFollow(seachValue, keyId, page, rows, sidx,
						sord, issueType,year,month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);
		return SUCCESS;
	}

	/***************************************************************************
	 * 下辖事项-待反馈事项列表
	 * 
	 * @return
	 */
	private String findJurisdictionsFeedBack() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsFeedBack(seachValue, keyId, page, rows, sidx,
						sord, issueType,year,month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);
		return SUCCESS;
	}

	/***************************************************************************
	 * 下辖事项-上报案事项列表
	 * 
	 * @return
	 */
	private String findJurisdictionsSubmit() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsSubmit(seachValue, keyId, page, rows, sidx,
						sord, issueType,year,month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);
		return SUCCESS;
	}

	/***************************************************************************
	 * 下辖事项-上级交办事项列表
	 * 
	 * @return
	 */
	private String findJurisdictionsAssgin() throws Exception {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		resolveIssueType();
		PageInfo<ThreeRecordsIssueViewObject> issues = threeRecordsIssueDubboService
				.findJurisdictionsAssgin(seachValue, keyId, page, rows, sidx,
						sord, issueType,year,month);
		String[] params = ThreeRecordsIssueOperationUtil
				.getViewprocessParams(viewProcess);
		issues = ControllerHelper.processAllOrgRelativeName(issues,
				organizationDubboService, params, null);
		gridPage = new GridPage(issues);
		return SUCCESS;
	}

	private boolean hasPermission(Long ledgerId, Long stepId) {
		boolean hasPermission = false;
		String userOrgCode = ThreadVariable.getOrganization()
				.getOrgInternalCode();

		hasPermission = searchIssueStepDubboService.hasPermission(ledgerId,
				LedgerConstants.PEOPLEASPIRATION_MEDICAL, stepId, userOrgCode);
		return hasPermission;

	}

	private String forwardToViewNew() {
		if (!legalKeyIdParam()) {
			errorMessage = "参数无效!";
			return ERROR;
		}
		Long num = 0L;
		if (issuesKeyId != null) {
			num = keyId;
			keyId = issuesKeyId;
		}
		if (!hasPermission(keyId, null)
				&& !ThreeRecordOrgJudge.isJgOrLxOrxW(ThreadVariable
						.getOrganization())) {
			return GlobalValue.NOT_HAVE_PERMISSION_RESULT;
		}
		peopleAspirations = peopleAspirationDubboService
				.findPeopleAspirationAndFileOrLogAndLogFile(
						LedgerConstants.PEOPLEASPIRATION_MEDICAL, keyId, true,
						true, true);
		medical = peopleAspirationDubboService.getMedicalByAspirationId(keyId);

		if (DialogMode.PRINT_MODE.equalsIgnoreCase(mode)) {
			return DialogMode.PRINT_MODE;
		}
		if (num != 0L) {
			keyId = num;
		}
		return DialogMode.VIEW_NEW_MODE;
	}

	public Long getIssuesKeyId() {
		return issuesKeyId;
	}

	public void setIssuesKeyId(Long issuesKeyId) {
		this.issuesKeyId = issuesKeyId;
	}

	public String getSeachValue() {
		return seachValue;
	}

	public void setSeachValue(String seachValue) {
		this.seachValue = seachValue;
	}

	private boolean legalKeyIdParam() {
		return null != keyId;
	}

	public Long getKeyId() {
		return keyId;
	}

	public void setKeyId(Long keyId) {
		this.keyId = keyId;
	}

	private void resolveIssueType() {
		issueType = Long.valueOf(LedgerConstants.PEOPLEASPIRATION_MEDICAL);
	}

	public LedgerPeopleAspirations getPeopleAspirations() {
		return peopleAspirations;
	}

	public void setPeopleAspirations(LedgerPeopleAspirations peopleAspirations) {
		this.peopleAspirations = peopleAspirations;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Medical getMedical() {
		return medical;
	}

	public void setMedical(Medical Medical) {
		this.medical = Medical;
	}

	public String getViewType() {
		return viewType;
	}

	public void setViewType(String viewType) {
		this.viewType = viewType;
	}

	public Long getOrgLevel() {
		return orgLevel;
	}

	public void setOrgLevel(Long orgLevel) {
		this.orgLevel = orgLevel;
	}

	public Long getSourceType() {
		return sourceType;
	}

	public void setSourceType(Long sourceType) {
		this.sourceType = sourceType;
	}

	public Long getIssueType() {
		return issueType;
	}

	public void setIssueType(Long issueType) {
		this.issueType = issueType;
	}

	public Integer getViewProcess() {
		return viewProcess;
	}

	public void setViewProcess(Integer viewProcess) {
		this.viewProcess = viewProcess;
	}

	public Map<String, Integer> getCountMap() {
		return countMap;
	}

	public void setCountMap(Map<String, Integer> countMap) {
		this.countMap = countMap;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Integer getMonth() {
		return month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}

}
