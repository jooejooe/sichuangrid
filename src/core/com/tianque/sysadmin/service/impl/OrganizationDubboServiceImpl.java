package com.tianque.sysadmin.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tianque.core.cache.constant.MemCacheConstant;
import com.tianque.core.cache.service.CacheService;
import com.tianque.core.cache.service.impl.CacheNameSpace;
import com.tianque.core.cache.util.CacheKeyGenerator;
import com.tianque.core.systemLog.service.SystemLogService;
import com.tianque.core.systemLog.util.ModelType;
import com.tianque.core.systemLog.util.OperatorType;
import com.tianque.core.util.Chinese2pinyin;
import com.tianque.core.util.ObjectToJSON;
import com.tianque.core.util.StringUtil;
import com.tianque.core.util.ThreadVariable;
import com.tianque.domain.GisInfo;
import com.tianque.domain.Organization;
import com.tianque.domain.PropertyDict;
import com.tianque.domain.Session;
import com.tianque.domain.User;
import com.tianque.domain.VillageProfile;
import com.tianque.domain.property.OrganizationLevel;
import com.tianque.domain.property.OrganizationType;
import com.tianque.domain.vo.OrganizationVo;
import com.tianque.exception.base.BusinessValidationException;
import com.tianque.exception.base.ServiceValidationException;
import com.tianque.platformMessage.constants.PlatformMessageType;
import com.tianque.service.VillageProfileService;
import com.tianque.service.impl.LogableService;
import com.tianque.service.impl.OrganizationServiceHelper;
import com.tianque.sysadmin.dao.OrganizationLocalDao;
import com.tianque.sysadmin.dao.UserHasMultizoneLocalDao;
import com.tianque.sysadmin.service.OrganizationDubboService;
import com.tianque.sysadmin.service.PermissionService;
import com.tianque.sysadmin.service.PropertyDictService;
import com.tianque.userAuth.api.OrganizationDubboRemoteService;

@Transactional(timeout = 12000)
@Service("organizationDubboService")
public class OrganizationDubboServiceImpl extends LogableService implements
		OrganizationDubboService {
	@Autowired
	private OrganizationLocalDao organizationDao;
	@Autowired
	private OrganizationDubboRemoteService organizationDubboRomoteService;
	@Autowired
	private PermissionService permissionService;
	@Autowired
	private PropertyDictService propertyDictService;
	@Autowired
	private SystemLogService systemLogService;

	@Autowired
	private UserHasMultizoneLocalDao userHasMultizoneLocalDao;
	@Autowired
	private VillageProfileService villageProfileService;
	@Autowired
	private CacheService cacheService;

	@Override
	public List<Organization> findOrganizationsByParentId(Long parentId) {
		return organizationDao.findOrganizationsByParentId(parentId);
	}

	public List<Long> findOrgIdByParentId(Long parentId) {
		return organizationDubboRomoteService.findOrgIdByParentId(parentId);
	}

	@Override
	public List<Organization> findProvinceOrganizationsByOrgIdAndCityLevel(
			Long orgId, Integer organizationLevel) {
		return organizationDao.findProvinceOrganizationsByOrgIdAndCityLevel(
				orgId, organizationLevel);
	}

	@Override
	public Organization addOrganization(Organization organization) {
		return organizationDubboRomoteService.addOrganization(organization);
	}

	@Override
	public String deleteOrgById(Long id) {
		Organization organization = organizationDao.getSimpleOrgById(id);

		userHasMultizoneLocalDao.deleteMultizoneByOrgId(id);

		deleteVillageprofiles(id);

		// orgLoginStanalsService.deleteOrgLoginStanalsByOrgId(id);
		// issueTypeStanalService.deleteAllStatIssueByOrgId(id);
		// operateLogService

		List<OrganizationVo> tables = organizationDao.getTableNameAndOrgId();
		List<String> tableInfo = new ArrayList<String>();
		for (int i = 0; i < tables.size(); i++) {
			if (organizationDao.countDatasByOrgIdAndTableName(tables.get(i)
					.getTableName(), tables.get(i).getOrgIdStr(), id) > 0) {
				tableInfo.add(tables.get(i).getTableName());
			}
		}

		String name = organization.getOrgName();
		try {
			organizationDao.deleteOrgById(id);
		} catch (Exception e) {
			throw new ServiceValidationException("不能删除此部门，此部门已被引用！", e);
		}
		if (ThreadVariable.getUser() != null
				&& ThreadVariable.getOrganization() != null
				&& ThreadVariable.getSession() != null) {
			systemLogService.log(WARN, ModelType.DEPT, OperatorType.DELETE,
					ThreadVariable.getSession().getUserName() + "删除部门" + name,
					ObjectToJSON.convertJSON(organization),
					organization.getId() + "", "", organization.getOrgName(),
					"");
		}
		if (organization.getParentOrg() != null
				&& organization.getParentOrg().getId() != null) {
			organizationDao.updateOrgsSeqAfterReferSeq(organization
					.getParentOrg().getId(), organization.getSeq(), -1L);
		}
		if (organization.getParentOrg() != null) {
			Organization parentOrg = getSimpleOrgById(organization
					.getParentOrg().getId());
			organizationDao.updateOrgSubCount(parentOrg.getId(), -1);
			if (organization.getOrgType().getInternalId() == OrganizationType.FUNCTIONAL_ORG
					&& organization.getParentFunOrg() != null
					&& organization.getParentFunOrg().getId() != null) {
				organizationDao.updateFunParentOrgSubCount(organization
						.getParentFunOrg().getId(), -1);
			}
		}
		return "success";

	}

	private void deleteVillageprofiles(Long orgId) {
		// 判断是否为空，为空删除部门
		VillageProfile villageProfile = villageProfileService
				.getVillageProfileByOrgId(orgId);
		if (villageProfile != null
				&& (villageProfile.getGridNum() == null || villageProfile
						.getGridNum().doubleValue() == 0)
				&& (villageProfile.getDoors() == null || villageProfile
						.getDoors().doubleValue() == 0)
				&& (villageProfile.getVillagers() == null || villageProfile
						.getVillagers().doubleValue() == 0)
				&& (villageProfile.getVillageRingsters() == null || villageProfile
						.getVillageRingsters() == 0)
				&& (villageProfile.getVillageDelegate() == null || villageProfile
						.getVillageDelegate().doubleValue() == 0)
				&& (villageProfile.getHamletEconomyinclude() == null || villageProfile
						.getHamletEconomyinclude().doubleValue() == 0)
				&& (villageProfile.getIndividualAverageInclude() == null || villageProfile
						.getIndividualAverageInclude().doubleValue() == 0)
				&& (villageProfile.getVillageCollectivityAsset() == null || villageProfile
						.getVillageCollectivityAsset().doubleValue() == 0)
				&& !StringUtil.isStringAvaliable(villageProfile
						.getInterzoneLeading())
				&& !StringUtil
						.isStringAvaliable(villageProfile.getDepartment())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getVillageBuildupSecretary())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getBuildupSecretaryPhone())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getVillageDirector())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getVillageDirectorPhone())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getInformationPersonA())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getInformationPersonAPhone())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getInformationPersonB())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getInformationPersonBPhone())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getNatureGeography())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getEconomyGeography())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getCommunityGeography())
				&& !StringUtil.isStringAvaliable(villageProfile
						.getItemEngineering())
				&& !StringUtil.isStringAvaliable(villageProfile.getImgUrl())) {

			villageProfileService.deleteVillageProfile(orgId);
		}

	}

	@Override
	public Organization getSimpleOrgById(Long id) {
		/*
		 * Organization organization = ThreadVariable.getOrganization(); if (id
		 * != null && organization != null && id.longValue() ==
		 * organization.getId().longValue()) { return organization; }
		 */
		Organization organization = (Organization) cacheService
				.get(MemCacheConstant.ORGANIZATION_NAMESPACE, MemCacheConstant
						.generateCacheKeyFromId(Organization.class, id));
		if (organization == null) {
			organization = organizationDubboRomoteService.getSimpleOrgById(id);
			cacheService.set(MemCacheConstant.ORGANIZATION_NAMESPACE,
					MemCacheConstant.generateCacheKeyFromId(Organization.class,
							id), organization);
		}
		return organization;
	}

	@Override
	public Organization updateOrgNameAndOrgTypeAndContactWay(
			Organization organization) {

		if (organization == null || organization.getId() == null) {
			throw new BusinessValidationException("参数错误");
		}
		Organization beforeOrganization = getFullOrgById(organization.getId());
		OrganizationServiceHelper organizationServiceHelper = new OrganizationServiceHelper();
		OrganizationServiceHelper.checkOrgWhenUpdate(organizationDao,
				propertyDictService, organization);
		organizationServiceHelper.checkOrgLevelAndDepartmentNo(organization,
				propertyDictService);
		organization.setUpdateDate(Calendar.getInstance().getTime());
		organization.setUpdateUser(ThreadVariable.getSession().getUserName());
		autoFillChinesePinyin(organization);
		Organization targetOrg = organizationDao
				.updateOrgNameAndOrgTypeAndContactWay(organization);
		if (ThreadVariable.getUser() != null
				&& ThreadVariable.getOrganization() != null
				&& ThreadVariable.getSession() != null) {
			systemLogService.log(
					INFO,
					ModelType.DEPT,
					OperatorType.UPDATE,
					ThreadVariable.getUser().getUserName()
							+ "在"
							+ getOrganizationRelativeNameByRootOrgIdAndOrgId(
									organization.getId(),
									OrganizationServiceHelper.getRootOrg(this)
											.getId()) + "修改部门"
							+ organization.getOrgName(), ObjectToJSON
							.convertJSON(targetOrg), beforeOrganization.getId()
							+ "", organization.getId() + "", beforeOrganization
							.getOrgName(), organization.getOrgName());
		}
		return targetOrg;
	}

	private void autoFillChinesePinyin(Organization org) {
		Map<String, String> pinyin = Chinese2pinyin.changeChinese2Pinyin(org
				.getOrgName());
		org.setSimplePinyin(pinyin.get("simplePinyin"));
		org.setFullPinyin(pinyin.get("fullPinyin"));
	}

	@Override
	public List<Organization> findOrganizationsByOrgNameForPage(String orgName,
			int pageNum, int pageSize) {
		Session session = ThreadVariable.getSession();
		User user = permissionService.getSimpleUserById(session.getUserId());

		Long parentId = null;
		if (user.isAdmin()) {
			parentId = findOrganizationsByParentId(null).get(0).getId();
		} else {
			parentId = user.getOrganization().getId();
		}

		Organization organization = organizationDubboRomoteService
				.getSimpleOrgById(parentId);
		return organizationDao.findOrganizationsByorgNameAndOrgType(
				organization.getOrgInternalCode(), orgName,
				organization.getOrgType(), pageNum, pageSize);
	}
	
	@Override
	public List<Organization> findOrganizationsByOrgNameAndOrgTypeForPage(String orgName,
			int pageNum, int pageSize) {
		Session session = ThreadVariable.getSession();
		User user = permissionService.getSimpleUserById(session.getUserId());
		Long parentId = null;
		Organization userOrg = organizationDao.getSimpleOrgById(user.getOrganization().getId());
		Long orgType = propertyDictService.findPropertyDictByDomainNameAndDictDisplayName(
						OrganizationType.ORG_TYPE_KEY,
						OrganizationType.FUNCTION_KEY).getId();
		if(orgType.equals(userOrg.getOrgType().getId())){
			userOrg = userOrg.getParentOrg();
		}
		if (user.isAdmin()) {
			parentId = findOrganizationsByParentId(null).get(0).getId();
		} else {
			parentId = userOrg.getId();
		}
		Organization organization = organizationDubboRomoteService
				.getSimpleOrgById(parentId);
		return organizationDao.findOrganizationsByorgNameAndOrgType(
				organization.getOrgInternalCode(), orgName,
				organization.getOrgType(), pageNum, pageSize);
	}
	

	@Override
	public List<Organization> findOrganizationsByorgNameAndOrgType(
			String orgName, int pageNum, int pageSize) {

		Session session = ThreadVariable.getSession();
		User user = permissionService.getSimpleUserById(session.getUserId());

		Long parentId = null;
		if (user.isAdmin()) {
			parentId = findOrganizationsByParentId(null).get(0).getId();
		} else {
			parentId = user.getOrganization().getId();
		}

		Organization organization = organizationDubboRomoteService
				.getSimpleOrgById(parentId);
		return organizationDao.findOrganizationsByorgNameAndOrgType(
				organization.getOrgInternalCode(), orgName,
				organization.getOrgType(), pageNum, pageSize);
	}

	@Override
	public void moveOrganization(Long id, Long parentId, ReferType position,
			Long referOrgId) {
		organizationDubboRomoteService.moveOrganization(id, parentId, position,
				referOrgId);
	}

	@Override
	public List<Long> searchParentOrgIds(Long orgId, Long rootId) {
		return organizationDubboRomoteService.searchParentOrgIds(orgId, rootId);
	}

	@Override
	public List<Long> searchParentOrgIdsWhenRootIsTown(Long id) {
		return organizationDubboRomoteService
				.searchParentOrgIdsWhenRootIsTown(id);
	}

	@Override
	public String getOrganizationRelativeNameByRootOrgIdAndOrgId(Long orgId,
			Long rootId) {
		return organizationDubboRomoteService
				.getOrganizationRelativeNameByRootOrgIdAndOrgId(orgId, rootId);
	}

	@Override
	public Map<Long, String> getOrganizationDisplayName(Long[] orgIds) {
		return organizationDubboRomoteService
				.getOrganizationDisplayName(orgIds);
	}

	@Override
	public List<Organization> findOrganizationsByOrgNameAndParentId(Long id,
			String orgName, Long parentId) {
		return organizationDao.findOrganizationsByOrgNameAndParentId(id,
				orgName, parentId);
	}

	@Override
	public List<Organization> findOrganizationsByDepartmentNoAndTypeAndLevel(
			Organization org) {
		return organizationDao
				.findOrganizationsByDepartmentNoAndTypeAndLevel(org);
	}

	@Override
	public List<Organization> findMultizonesByUserId(Long userId) {
		return organizationDao.findMultizonesByUserId(userId);
	}

	@Override
	public int countOrgsByOrgInternalCode(String orgInternalCode) {
		return organizationDubboRomoteService
				.countOrgsByOrgInternalCode(orgInternalCode);
	}

	@Override
	public List<Organization> findFunOrgsByParentId(Long parentId) {

		if (parentId == null) {
			Session session = ThreadVariable.getSession();
			parentId = permissionService.getSimpleUserById(session.getUserId())
					.getOrganization().getId();
		}

		List<PropertyDict> propertyDicts = propertyDictService
				.findPropertyDictByDomainNameAndInternalId(
						OrganizationType.ORG_TYPE_KEY,
						OrganizationType.FUNCTIONAL_ORG);
		Long[] propertyDictIds = new Long[propertyDicts.size()];
		for (int i = 0; i < propertyDicts.size(); i++) {
			propertyDictIds[i] = propertyDicts.get(i).getId();
		}
		return organizationDao.findFunOrgsByParentIdAndOrgTypes(parentId,
				propertyDictIds);
	}

	@Override
	public List<Organization> findOrgsByParentIdAndFunTypes(Long parentId) {
		return findOrgsByParentIdAndOrgTypeInternalIds(parentId,
				new Long[] { Long.valueOf(OrganizationType.FUNCTIONAL_ORG) });
	}

	@Override
	public List<Organization> findOrgsByParentIdAndOrgTypeInternalIds(
			Long parentId, Long[] orgTypeInternalIds) {
		return organizationDao.findOrgsByParentIdAndOrgTypeInternalIds(
				parentId, orgTypeInternalIds);
	}

	@Override
	public List<Organization> findMultizonesWithParentOrgNameByUserId(
			Long userId) {

		List<Organization> organizations = new ArrayList<Organization>();
		organizations.add(ThreadVariable.getUser().getOrganization());
		organizations.addAll(findMultizonesByUserId(userId));

		if (organizations == null || organizations.size() == 1) {
			User user = permissionService.getSimpleUserById(userId);
			organizations.addAll(this.findOrganizationsByParentId(user
					.getOrganization().getId()));
		}
		for (int i = 0; i < organizations.size(); i++) {
			organizations.set(i,
					this.getFullOrgById(organizations.get(i).getId()));
			Organization organization = organizations.get(i);
			if (organization.getParentOrg() != null
					&& organization.getParentOrg().getId() != null) {
				Organization parentOrg = organizationDubboRomoteService
						.getSimpleOrgById(organization.getParentOrg().getId());
				organization.setOrgName(parentOrg.getOrgName() + "->"
						+ organization.getOrgName());
			}
		}
		return organizations;
	}

	@Override
	public Organization getFullOrgById(Long id) {
		/*
		 * Organization organization = ThreadVariable.getOrganization(); if (id
		 * != null && organization != null && id.longValue() ==
		 * organization.getId().longValue()) { return organization; }
		 */
		Organization organization = (Organization) cacheService
				.get(MemCacheConstant.getOrganizationNameSpaceByIdAndType(id,
						"getFullOrgById"));
		if (organization == null) {
			organization = organizationDubboRomoteService.getFullOrgById(id);
			cacheService.set(MemCacheConstant
					.getOrganizationNameSpaceByIdAndType(id, "getFullOrgById"),
					organization);
		}
		return organization;
	}

	@Override
	public Organization getOrganizationsByParentAndOrgName(Long parentId,
			String orgName) {
		return organizationDubboRomoteService
				.getOrganizationsByParentAndOrgName(parentId, orgName);
	}

	@Override
	public boolean isGridOrganization(Long orgId) {
		return organizationDubboRomoteService.isGridOrganization(orgId);
	}
	
	@Override
	public boolean isVillageOrGridOrganization(Long orgId){
		return organizationDubboRomoteService.isVillageOrGridOrganization(orgId);
	}
	
	@Override
	public boolean isVillageOrganization(Long orgId){
		return organizationDubboRomoteService.isVillageOrganization(orgId);
	}
	
	@Override
	public boolean isTownOrganization(Long orgId) {
		return organizationDubboRomoteService.isTownOrganization(orgId);
	}

	@Override
	public Long getTownOrganizationId(Long orgId) {
		return organizationDubboRomoteService.getTownOrganizationId(orgId);
	}

	@Override
	public String getMaxDepartmentNoByParentId(Long parentId, Long orgLevel) {
		return organizationDubboRomoteService.getMaxDepartmentNoByParentId(
				parentId, orgLevel);
	}

	@Override
	public boolean ifGreaterThanDistrictOrgId(Long orgId) {
		return organizationDubboRomoteService.ifGreaterThanDistrictOrgId(orgId);
	}

	@Override
	public Organization getDistrictOrganizationId(Long orgId) {
		return organizationDubboRomoteService.getDistrictOrganizationId(orgId);
	}

	@Override
	public Organization getOrganizationByOrgInternalCode(String orgInternalCode) {
		return organizationDubboRomoteService
				.getOrganizationByOrgInternalCode(orgInternalCode);
	}

	@Override
	public List<Organization> findOrganizationsByOrgInternalCode(
			String orgInternalCode) {
		return organizationDao
				.findOrganizationsByOrgInternalCode(orgInternalCode);
	}

	@Override
	public Organization updateOrganizationByName(String orgName, Long orgId,
			Organization domain) {
		return organizationDubboRomoteService.updateOrganizationByName(orgName,
				orgId, domain);
	}

	@Override
	public List<Organization> findAdminOrgsByParentIdAndName(Long id, String tag) {
		return organizationDao.findAdminOrgsByParentIdAndName(id, tag);
	}

	@Override
	public List<Organization> findFunOrgsByParentFunOrgIdAndName(Long id,
			String tag) {
		return organizationDao.findFunOrgsByParentFunOrgIdAndName(id, tag);
	}

	@Override
	public List<Organization> findFunOrgsByParentIdAndName(Long id, String tag) {
		return organizationDao.findFunOrgsByParentIdAndName(id, tag);
	}

	@Override
	public Organization getSimplePinyinBySimpleCode(String simpleCode) {
		return organizationDubboRomoteService
				.getSimplePinyinBySimpleCode(simpleCode);
	}

	@Override
	public boolean isDistrictOfAdministrativeRegion(Organization organization) {
		return organizationDubboRomoteService
				.isDistrictOfAdministrativeRegion(organization);
	}

	@Override
	public List<Organization> findAdminOrgsByParentId(Long id) {
		return findOrgsByParentIdAndOrgTypeInternalIds(id,
				new Long[] { Long
						.valueOf(OrganizationType.ADMINISTRATIVE_REGION) });
	}

	@Override
	public List<Organization> getOrganizationByIdAndOrgInternalCode() {
		return organizationDao.getOrganizationByIdAndOrgInternalCode();
	}

	@Override
	public boolean validateRepeatDepartmentNo(Organization organization) {
		return organizationDubboRomoteService
				.validateRepeatDepartmentNo(organization);
	}

	@Override
	public Organization getOrgByDepartmentNo(String departmentNo) {
		return organizationDubboRomoteService
				.getOrgByDepartmentNo(departmentNo);
	}

	@Override
	public String[] findDepartmentNosByParentDeparmentNo(String departmentNo) {
		return organizationDubboRomoteService
				.findDepartmentNosByParentDeparmentNo(departmentNo);
	}

	@Override
	public Organization getOrgAndLevelInfo(Long orgId) {
		return organizationDubboRomoteService.getOrgAndLevelInfo(orgId);
	}

	@Override
	public List<Organization> fingOrganizationforLevel(Long orgLevelId) {
		return organizationDao.fingOrganizationforLevel(orgLevelId);
	}

	@Override
	public Organization updateOrganizationForGis(Long orgId, GisInfo gisInfo) {
		return organizationDubboRomoteService.updateOrganizationForGis(orgId,
				gisInfo);
	}

	@Override
	public Organization unBundOrgToGis(Long orgId) {
		return organizationDubboRomoteService.unBundOrgToGis(orgId);

	}

	@Override
	public List<Organization> findOrganizationByParentIdAndOrgType(
			Long parentId, Long orgType) {
		return organizationDao.findOrganizationByParentIdAndOrgType(parentId,
				orgType);
	}

	@Override
	public Organization getDistrictTownOrganizationId(Long orgId) {
		return organizationDubboRomoteService
				.getDistrictTownOrganizationId(orgId);
	}

	@Override
	public Organization findSomeLevelParentOrg(Long orgId, int levelInternalId) {
		return organizationDubboRomoteService.findSomeLevelParentOrg(orgId,
				levelInternalId);
	}

	@Override
	public boolean isHasThisOrganization(Long orgId) {
		return organizationDubboRomoteService.isHasThisOrganization(orgId);
	}

	@Override
	public List<Organization> findOrgsByOrgCodeAndOrgLevelInternalsAndOrgTypeInternals(
			String orgCode, List<Integer> orgLevelInternals,
			List<Integer> orgTypeInternals, List<Long> exceptOrgIds) {
		return organizationDao
				.findOrgsByOrgCodeAndOrgLevelInternalsAndOrgTypeInternals(
						orgCode, orgLevelInternals, orgTypeInternals,
						exceptOrgIds);
	}

	@Override
	public Organization getRootOrganization() {
		return organizationDubboRomoteService.getRootOrganization();
	}

	@Override
	public List<Organization> findChildOrgs(Long startOrgId, Long endOrgId) {
		List<Organization> organizations = new ArrayList<Organization>();
		recursionGetOrg(startOrgId, endOrgId, organizations);
		Collections.reverse(organizations);
		fillOrgTypeAndLevel(organizations);
		return organizations;
	}

	private void fillOrgTypeAndLevel(List<Organization> organizations) {
		for (Organization org : organizations) {
			org.setOrgLevel(propertyDictService.getPropertyDictById(org
					.getOrgLevel().getId()));
			org.setOrgType(propertyDictService.getPropertyDictById(org
					.getOrgType().getId()));
		}
	}

	private void recursionGetOrg(Long startOrgId, Long endOrgId,
			List<Organization> organizations) {
		Organization org = getSimpleOrgById(endOrgId);
		organizations.add(org);
		if (null == org.getParentOrg() || startOrgId.equals(endOrgId)) {
			return;
		} else if (startOrgId.equals(org.getParentOrg().getId())) {
			organizations.add(getSimpleOrgById(startOrgId));
			return;
		} else {
			recursionGetOrg(startOrgId, org.getParentOrg().getId(),
					organizations);
		}
	}

	@Override
	public List<Organization> findOrgsFetchParentOrgByKeyword(String keyword,
			int size) {
		if (null == keyword || "".equals(keyword)) {
			return null;
		}
		List<Organization> orgs = organizationDao
				.findOrgsFetchParentOrgByKeyword(keyword, size);
		for (Organization org : orgs) {
			org = getFullOrgById(org.getId());
		}
		return orgs;
	}

	@Override
	public List<Organization> findOrgsByOrgTypeAndOrgLevelAndParentId(
			Integer orgTypeInternalId, Integer orgLevelInternalId, Long parentId) {
		if (null == parentId || null == orgTypeInternalId
				|| null == orgLevelInternalId) {
			return null;
		}
		String parentOrgInternalCode = getOrgInternalCodeById(parentId);
		Long orgTypeId = getPropertyDictIdByDomainNameAndInternalId(
				OrganizationType.ORG_TYPE_KEY, orgTypeInternalId);
		Long orgLevelId = getPropertyDictIdByDomainNameAndInternalId(
				OrganizationLevel.ORG_LEVEL_KEY, orgLevelInternalId);

		return organizationDao
				.findOrgsByOrgTypeIdAndOrgLevelIdAndParentOrgInternalCode(
						orgTypeId, orgLevelId, parentOrgInternalCode);
	}

	@Override
	public List<Organization> findOrganizationByOrgTypeAndOrgLevelAndParentId(
			Integer orgTypeInternalId, Integer orgLevelInternalId, Long parentId) {
		List<Organization> list = new ArrayList<Organization>();
		if (null == parentId || null == orgTypeInternalId
				|| null == orgLevelInternalId) {
			return null;
		}
		User user = ThreadVariable.getUser();
		if (user == null || user.getOrganization() == null
				|| user.getOrganization().getId() == null
				|| user.getOrganization().getOrgLevel() == null
				|| user.getOrganization().getOrgLevel().getId() == null) {
			throw new BusinessValidationException("用户信息为空，请重新登录");
		}
		String userorgInternalCode = ThreadVariable.getUser()
				.getOrgInternalCode();
		Long orgTypeId = getPropertyDictIdByDomainNameAndInternalId(
				OrganizationType.ORG_TYPE_KEY, orgTypeInternalId);
		Long orgLevelId = getPropertyDictIdByDomainNameAndInternalId(
				OrganizationLevel.ORG_LEVEL_KEY, orgLevelInternalId);
		Long userLeavel = user.getOrganization().getOrgLevel().getId();
		Integer isUp = 0;
		if (orgLevelId < userLeavel) {// 查询当当前用户的直属上级
			isUp = 1;
		}
		if (orgTypeInternalId == OrganizationType.FUNCTIONAL_ORG
				&& (!PlatformMessageType.IS_SEARCH_ADMIN_MESSAGE
						.equals(ThreadVariable.getUser().getUserName()))) {
			Organization org = getCrruentOrg(orgLevelInternalId, user
					.getOrganization().getId());
			if (org != null) {
				// 根据查询得到的组织机构查询该组织机构下的职能部门信息 isUp=0：查询当前层级，1：下辖所有
				list = organizationDao.findFuncOrgInfoByCondition(orgLevelId,
						orgTypeId, org.getOrgInternalCode(), isUp);
			}
		} else {
			// 判断 如果用户是职能部门的用户，则通过parentId去查询信息，否则就通过当前用户的ID去查询。
			PropertyDict organizationType = propertyDictService
					.getPropertyDictById(user.getOrganization().getOrgType()
							.getId());
			if (organizationType.getInternalId() == OrganizationType.FUNCTIONAL_ORG) {
				userorgInternalCode = getOrgInternalCodeById(parentId);
			}
			list = organizationDao
					.findOrgsByOrgTypeIdAndOrgLevelIdAndOrgInternalCode(
							orgTypeId, orgLevelId, userorgInternalCode, isUp);
		}

		return list;
	}

	/***
	 * 判断当前需要发送的职能部门层级
	 * 
	 * @param organizations
	 */
	private Organization getCrruentOrg(Integer orgLevelInternalId, Long orgId) {
		List<Organization> list = new ArrayList<Organization>();
		if (orgLevelInternalId == OrganizationLevel.PROVINCE) {
			list = organizationDao.findOrganizationByOrgIdAndNum(orgId,
					OrganizationType.FUNCTIONAL_ORG_PROVINCE_LEVEL);// 查询省级的组织机构信息
		}
		if (orgLevelInternalId == OrganizationLevel.CITY) {
			list = organizationDao.findOrganizationByOrgIdAndNum(orgId,
					OrganizationType.FUNCTIONAL_ORG_CITY_LEVEL);// 查询市级的组织机构信息
		}
		if (orgLevelInternalId == OrganizationLevel.DISTRICT) {
			list = organizationDao.findOrganizationByOrgIdAndNum(orgId,
					OrganizationType.FUNCTIONAL_ORG_DISTRICT_LEVEL);// 查询县级的组织机构信息
		}
		if (orgLevelInternalId == OrganizationLevel.TOWN) {
			list = organizationDao.findOrganizationByOrgIdAndNum(orgId,
					OrganizationType.FUNCTIONAL_ORG_TOWN_LEVEL);// 查询乡镇级的组织机构信息
		}
		if (orgLevelInternalId == OrganizationLevel.VILLAGE) {
			list = organizationDao.findOrganizationByOrgIdAndNum(orgId,
					OrganizationType.FUNCTIONAL_ORG_VILLAGE_LEVEL);// 查询社区级的组织机构信息
		}
		if (list != null && list.size() != 0) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public List<Organization> findOrgsByOrgTypeAndOrgLevel(
			Integer orgTypeInternalId, Integer orgLevelInternalId,
			Long userOrgId) {
		if (null == orgTypeInternalId || null == orgLevelInternalId) {
			return new ArrayList<Organization>();
		}
		String userOrgInternalCode = getOrgInternalCodeById(userOrgId);
		Long orgTypeId = getPropertyDictIdByDomainNameAndInternalId(
				OrganizationType.ORG_TYPE_KEY, orgTypeInternalId);
		Long orgLevelId = getPropertyDictIdByDomainNameAndInternalId(
				OrganizationLevel.ORG_LEVEL_KEY, orgLevelInternalId);

		List<Organization> results = organizationDao
				.findOrgsByOrgTypeIdAndOrgLevelId(orgTypeId, orgLevelId,
						userOrgInternalCode);
		createPropertyDictNameById(results);
		return results;
	}

	private void createPropertyDictNameById(List<Organization> organizations) {
		if (organizations == null) {
			return;
		}
		for (int i = 0; i < organizations.size(); i++) {
			if (organizations.get(i).getFunctionalOrgType() != null) {
				Long functionalOrgTypeId = organizations.get(i)
						.getFunctionalOrgType().getId();
				if (functionalOrgTypeId != null) {
					organizations.get(i).setFunctionalOrgType(
							propertyDictService
									.getPropertyDictById(functionalOrgTypeId));
				}
			}
		}
	}

	private Long getPropertyDictIdByDomainNameAndInternalId(String domainName,
			Integer orgTypeInternalId) {
		if (null == domainName || "".equals(domainName)
				|| null == orgTypeInternalId) {
			return null;
		}
		List<PropertyDict> dicts = propertyDictService
				.findPropertyDictByDomainNameAndInternalId(domainName,
						orgTypeInternalId);
		if (null == dicts || dicts.size() == 0) {
			return null;
		}
		return dicts.get(0).getId();
	}

	@Override
	public String getOrgInternalCodeById(Long id) {
		return organizationDubboRomoteService.getOrgInternalCodeById(id);
	}

	@Override
	public List<Organization> findFunOrgsByFunParentId(Long funParentId) {
		return organizationDao.findFunOrgsByFunParentId(funParentId);
	}

	@Override
	public Organization getTownOrganizationById(Long orgId) {
		return organizationDubboRomoteService.getTownOrganizationById(orgId);
	}

	@Override
	public List<String> findOrganizationInternaCodeSpecifiedOrgName(
			String orgName) {
		return organizationDubboRomoteService
				.findOrganizationInternaCodeSpecifiedOrgName(orgName);
	}

	@Override
	public List<String> findOrganizationInternaCodeHaiNing() {
		return organizationDubboRomoteService
				.findOrganizationInternaCodeHaiNing();
	}

	@Override
	public List<Organization> getOrgZN(Long id) {
		return organizationDao.getOrgZN(id);
	}

	@Override
	public String getUserCityOrganizationName() {
		return organizationDubboRomoteService.getUserCityOrganizationName();
	}

	@Override
	public List<Organization> findOrgsByDepartmentNo(String departmentNo) {
		if (departmentNo == null) {
			throw new BusinessValidationException("部门编号不能为空");
		}
		return organizationDao.findOrgsByDepartmentNo(departmentNo);
	}

	@Override
	public List<Organization> findFunOrgsByParentOrgId(Long parentOrgId) {
		List<PropertyDict> propertyDicts = propertyDictService
				.findPropertyDictByDomainNameAndInternalId(
						OrganizationType.ORG_TYPE_KEY,
						OrganizationType.FUNCTIONAL_ORG);
		Long[] propertyDictIds = new Long[propertyDicts.size()];
		for (int i = 0; i < propertyDicts.size(); i++) {
			propertyDictIds[i] = propertyDicts.get(i).getId();
		}
		return organizationDao.findFunOrgsByParentOrgIdAndOrgTypes(parentOrgId,
				propertyDictIds);
	}

	@Override
	public List<Organization> findOrganizationsByOrgName(String orgName) {
		if (orgName == null) {
			throw new BusinessValidationException("部门名称不能为空");
		}
		return organizationDao.findOrganizationsByOrgName(orgName);
	}

	@Override
	public List<Organization> findOrgsByParentIdAndOrgTypeInternalIdsAndFunctionalType(
			Long parentId, Long[] orgTypeInternalIds, Long orgFunctionalType) {
		return organizationDao
				.findOrgsByParentIdAndOrgTypeInternalIdsAndFunctionalType(
						parentId, orgTypeInternalIds, orgFunctionalType);
	}

	@Override
	public Organization getParentOrgByOrgTypeAndChildOrgId(Long orgId,
			int orgLevel) {
		return organizationDubboRomoteService
				.getParentOrgByOrgTypeAndChildOrgId(orgId, orgLevel);
	}

	@Override
	public boolean hasFunOrganizationByParentOrgAndFunOrgType(
			String parentOrgCode, Long funOrgType) {
		return organizationDubboRomoteService
				.hasFunOrganizationByParentOrgAndFunOrgType(parentOrgCode,
						funOrgType);
	}

	@Override
	public List<Long> getOrganizationsByLevel(Long typeId, Long levelId) {
		return organizationDubboRomoteService.getOrganizationsByLevel(typeId,
				levelId);
	}

	@Override
	public List<Organization> getDepartmentNoByLevel(Long typeId, Long levelId) {
		return organizationDubboRomoteService.getDepartmentNoByLevel(typeId,
				levelId);
	}

	@Override
	public List<Organization> findDistrictAdminOrgsByOrgType(Long orgTypeId,
			String searchOrgCode, String orgCodeFindLevel) {
		return organizationDao.findDistrictAdminOrgsByOrgType(orgTypeId,
				searchOrgCode, orgCodeFindLevel);
	}

	@Override
	public List<Organization> findProvinceOrganizationsByOrgId(Long orgId) {
		return organizationDao.findProvinceOrganizationsByOrgId(orgId);
	}

	@Override
	public List<Organization> findOrganizationByOrgIdAndNum(Long orgId,
			Integer num) {
		List<Organization> list = organizationDao
				.findOrganizationByOrgIdAndNum(orgId, num);
		if (list != null && list.size() != 0) {
			Organization organization = list.get(0);
			organization.setOrgType(propertyDictService
					.getPropertyDictById(organization.getOrgType().getId()));
		}
		return list;
	}

	@Override
	public Organization getOrganizationByOrganizationCode(
			String organizationCode) {
		return organizationDubboRomoteService
				.getOrganizationByOrganizationCode(organizationCode);
	}

	/**
	 * 
	 * @Title: getOrganizationByIdAndDictName
	 * @Description: TODO根据组织机构id，字典项名称，查询组织机构
	 * @param @param id
	 * @param @param domainName
	 * @param @param dictName
	 * @param @return 设定文件
	 * @return Organization 返回类型
	 * @author wanggz
	 * @date 2014-8-29 上午10:46:16
	 */
	@Override
	public Organization getOrganizationByIdAndDictName(Long id,
			String domainName, String dictName) {
		return organizationDubboRomoteService.getOrganizationByIdAndDictName(
				id, domainName, dictName);
	}

	public List<Long> findAllRelatedOrgIdsByUserOrgId(int startLevelId) {
		return organizationDubboRomoteService
				.findAllRelatedOrgIdsByUserOrgId(startLevelId);
	}

	@Override
	public List<Organization> findOrgsByParentOrgAndOrgTypeInternalId(
			String OrgInternalCode, Integer orgTypeInternalId) {
		return organizationDao.findOrgsByParentOrgAndOrgTypeInternalId(
				OrgInternalCode, orgTypeInternalId);
	}

	@Override
	public Organization getCityOrgByAreaOrgId(Long id) {
		return organizationDubboRomoteService.getCityOrgByAreaOrgId(id);
	}

	@Override
	public Organization getCityOrganizationId(Long orgId) {
		return organizationDubboRomoteService.getCityOrganizationId(orgId);
	}

	@Override
	public List<Organization> findAllOrganization() {
		return organizationDao.findAllOrganization();
	}

	@Override
	public List<Organization> findOrgByOrgNameAndInternalCode(String orgName,
			String orgInternalCode, int pageNum, int pageSize) {
		return organizationDao
				.findOrganizationsByOrgNameAndInternalCodeForPage(
						orgInternalCode, orgName, pageNum, pageSize);
	}

	@Override
	public List<Long> findLeafOrgIdByCode(String orgCode) {
		return organizationDubboRomoteService.findLeafOrgIdByCode(orgCode);
	}

	@Override
	public List<Long> getOrganizationByOrgLevelAndOrgType(Long orgLevel,
			Long orgType) {
		return organizationDubboRomoteService
				.getOrganizationByOrgLevelAndOrgType(orgLevel, orgType);
	}

	@Override
	public List<Organization> findAllOrgByParentOrgCode(String orgCode,
			String orgType) {
		PropertyDict typeDict = propertyDictService
				.getPropertyDictByDomainName(orgType);
		return organizationDao.findAllOrgByParentOrgCode(orgCode,
				typeDict.getId());
	}

	public List<Long> findOrganizationsByParentIdAndType(Long orgId,
			int orgTypeId) {
		return organizationDubboRomoteService
				.findOrganizationsByParentIdAndType(orgId, orgTypeId);
	}

	@Override
	public List<Long> queryOrgIdsByModelForStatisticsAccountTimeouts(
			List<Long> idModList, String taskParameter, Integer paseSize,
			String tableName) {

		return organizationDubboRomoteService
				.queryOrgIdsByModelForStatisticsAccountTimeouts(idModList,
						taskParameter, paseSize, tableName);
	}

	// add by bing 2014年11月12日 下午6:06:18
	@Override
	public List<Long> findOrganIdForLevelExcludeGrid(Long orgLevelId,
			int taskItemNum, List<Long> idModList, int fetchNum, int year,
			int month, String targetIssueTable) {
		return organizationDubboRomoteService.findOrganIdForLevelExcludeGrid(
				orgLevelId, taskItemNum, idModList, fetchNum, year, month,
				targetIssueTable);
	}

	// add by bing 2014年11月12日 下午6:06:23

	@Override
	public Integer countOrgIdsByModelForStatisticsAccountTimeouts(
			List<Long> idModList, String taskParameter) {
		return organizationDubboRomoteService
				.countOrgIdsByModelForStatisticsAccountTimeouts(idModList,
						taskParameter);
	}

	@Override
	public List<Long> queryOrgIdsByModelForAccountReport(List<Long> idModList,
			String taskParameter, int orgLevelInternalId, int orgTypeInternalId) {
		return organizationDubboRomoteService
				.queryOrgIdsByModelForAccountReport(idModList, taskParameter,
						orgLevelInternalId, orgTypeInternalId);
	}

	/******************* 组织机构迁移合并方法 *******************/
	@Override
	public Organization updateOrgSubCount(Long id, int num) {
		return organizationDao.updateOrgSubCount(id, num);
	}

	@Override
	public int updateAllOrgSubCount(Long id) {
		return organizationDao.updateAllOrgSubCount(id);
	}

	@Override
	public void updateOrgSeqAndParentId(Long id, Long seq, Long parentId) {
		organizationDao.updateOrgSeqAndParentId(id, seq, parentId);
	}

	@Override
	public Integer getMaxCodeById(Long id) {
		organizationDao.updateMaxCodeById(id);
		Integer maxCode = organizationDao.getMaxCodeById(id);
		if (maxCode == null) {
			maxCode = 0;
		}
		return maxCode;
	}

	@Override
	public void updateOrgInternalCode(Long id, String newOrgCode) {
		organizationDao.updateOrgInternalCode(id, newOrgCode);
	}

	@Override
	public Integer findChildrenMaxSeqByParentId(Long parentId) {
		return organizationDubboRomoteService
				.findChildrenMaxSeqByParentId(parentId);
	}

	@Override
	public List<String> getDepartmentnosByParentOrgId(Long parentId) {
		return organizationDao.getDepartmentnosByParentOrgId(parentId);
	}

	@Override
	public void editChildOrganizationDeptNo(String oldDeptNo, String newDeptNo) {
		organizationDao.editChildOrganizationDeptNo(oldDeptNo, newDeptNo);
	}

	@Override
	public Organization getOrgForFirstCity(Long userOrgId) {
		return organizationDubboRomoteService.getOrgForFirstCity(userOrgId);
	}

	@Override
	public Organization findTownOrgInfoByOrgId(Long orgId) {
		return organizationDubboRomoteService.findTownOrgInfoByOrgId(orgId);
	}

	@Override
	public List<Long> findOrgIdsBySearchVo(OrganizationVo searchVo) {
		return organizationDubboRomoteService.findOrgIdsBySearchVo(searchVo);
	}

	@Override
	public List<Organization> findOrgsBySearchVo(OrganizationVo searchVo) {
		return organizationDao.findOrgsBySearchVo(searchVo);
	}

	@Override
	public List<Organization> findNameAndRemarkBySearchVo(
			OrganizationVo searchVo) {
		return organizationDao.findNameAndRemarkBySearchVo(searchVo);
	}

	@Override
	public Integer countOrgsBySearchVo(OrganizationVo searchVo) {
		return organizationDubboRomoteService.countOrgsBySearchVo(searchVo);
	}

	@Override
	public String getUserOrganztionCodeByOrgId(Long orgId) {
		return organizationDubboRomoteService
				.getUserOrganztionCodeByOrgId(orgId);
	}

	@Override
	public List<Integer> getViewObjectDefNum(List<Map<String, Object>> list) {
		return organizationDubboRomoteService.getViewObjectDefNum(list);
	}

	@Override
	public List<Long> getOrgIdsWhenSelectByLevel(
			List<Map<String, Object>> selectedLevelList) {
		return organizationDubboRomoteService
				.getOrgIdsWhenSelectByLevel(selectedLevelList);
	}

	@Override
	public List<String> getSelectedOrgNamesByOrgIdsAndTypeLevel(
			OrganizationVo organizationVo) {
		return organizationDubboRomoteService
				.getSelectedOrgNamesByOrgIdsAndTypeLevel(organizationVo);
	}

	@Override
	public Organization getOrgByOrgIdAndOrgLevelInternalId(Long orgId,
			Integer internalId) {
		return organizationDubboRomoteService
				.getOrgByOrgIdAndOrgLevelInternalId(orgId, internalId);
	}

	@Override
	public Integer countOrgByOrgIdsListAndResidentStatusDict(
			OrganizationVo searchVo) {
		return organizationDubboRomoteService
				.countOrgByOrgIdsListAndResidentStatusDict(searchVo);
	}

	@Override
	public Organization findOrganizationByOrgTypeAndOrgLevelAndOrgName(
			Long orgTypeId, Long orgLevelId, String orgName, String fullOrgName) {
		return organizationDubboRomoteService
				.findOrganizationByOrgTypeAndOrgLevelAndOrgName(orgTypeId,
						orgLevelId, orgName, fullOrgName);
	}

	@Override
	public Organization getSimpleOrgAllOrganizationById(Long id) {
		Organization organization = (Organization) cacheService.get(
				CacheNameSpace.Organization_nameSpace,
				CacheKeyGenerator.generateCacheKey(Organization.class, id));
		if (organization == null) {
			organization = organizationDubboRomoteService
					.getSimpleOrgAllOrganizationById(id);
		}
		return organization;
	}
	public Long countOrgsByLevelAndOrgCode(Long orgLevel,String orgCode){
		return organizationDubboRomoteService.countOrgsByLevelAndOrgCode(orgLevel, orgCode);
	}
}