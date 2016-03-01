/**
 * 
 */
package com.tianque.serviceList.service.impl;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.tinygroup.commons.tools.StringUtil;

import com.tianque.controller.ControllerHelper;
import com.tianque.core.systemLog.util.ModuleConstants;
import com.tianque.core.util.ThreadVariable;
import com.tianque.core.validate.DomainValidator;
import com.tianque.core.vo.PageInfo;
import com.tianque.domain.Organization;
import com.tianque.domain.PropertyDict;
import com.tianque.domain.User;
import com.tianque.domain.property.OrganizationType;
import com.tianque.domain.property.PropertyTypes;
import com.tianque.exception.base.BusinessValidationException;
import com.tianque.exception.base.ServiceValidationException;
import com.tianque.plugin.taskList.constants.Constants;
import com.tianque.plugin.taskList.domain.MentalPatientTask;
import com.tianque.plugin.taskList.domain.PropagandaAndVerificationVo;
import com.tianque.plugin.taskList.service.GridConfigTaskService;
import com.tianque.serviceList.dao.PolicyPropagandaDao;
import com.tianque.serviceList.domain.PolicyPropaganda;
import com.tianque.serviceList.domain.Reply;
import com.tianque.serviceList.domain.ServiceListEnum;
import com.tianque.serviceList.service.PolicyPropagandaService;
import com.tianque.serviceList.service.ReplyAttachService;
import com.tianque.serviceList.service.ReplyService;
import com.tianque.serviceList.service.ServiceListAttachService;
import com.tianque.serviceList.validater.PolicyPropagandaValidatorImpl;
import com.tianque.sysadmin.service.OrganizationDubboService;
import com.tianque.sysadmin.service.PropertyDictService;
import com.tianque.userAuth.api.PermissionDubboService;

@Service("policyPropagandaServiceImpl")
@Transactional
public class PolicyPropagandaServiceImpl implements PolicyPropagandaService{
	@Autowired 
	private PolicyPropagandaDao policyPropagandaDao;
	@Autowired
	private OrganizationDubboService organizationDubboService;
	@Autowired
	private ServiceListAttachService attachService;
	@Autowired
	private ReplyAttachService replyAttachService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private PropertyDictService propertyDictService;
	@Autowired
	private GridConfigTaskService configTaskService;
	@Autowired 
	private PolicyPropagandaValidatorImpl validatorImpl;
	@Autowired
	private PermissionDubboService permissionDubboService;
	private static final Integer TYPE=ServiceListEnum.getValue("policyPropaganda");
	@Override
	public PolicyPropaganda addPolicyPropaganda(PolicyPropaganda info) {
		if (info == null) {
			throw new BusinessValidationException("新增失败！");
		}
		try {
			fillPolicyPropagandaOrg(info);
			info.setTelephone(ThreadVariable.getUser().getMobile());
			String[] attachFileNames = info.getAttachFileNames();
			if(info.getIsSign()==null){
				info.setIsSign(0);
			}
			if(info.getIsSign()==null){
				info.setIsReply(0);
			}
			validatorImpl.validatorPolicyPropaganda(info);
			info= policyPropagandaDao.add(info);
			attachService.addServiceListAttch(attachFileNames, info.getId(),TYPE);
			return info;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceValidationException("PolicyPropagandaServiceImpl的addPolicyPropaganda方法出错，原因：",
					"新增信息不全", e);
		}
	}
	@Override
	public PolicyPropaganda addPolicyPropaganda(PolicyPropaganda info,String[] attachFileNames) {
		if (info == null) {
			throw new BusinessValidationException("新增失败！");
		}
		try {
			fillPolicyPropagandaOrg(info);
			info.setIsSign(0);
			info.setIsReply(0);
			info= policyPropagandaDao.add(info);
			validatorImpl.validatorPolicyPropaganda(info);
			attachService.addServiceListAttch(attachFileNames, info.getId(),TYPE);
			return info;
		} catch (Exception e) {
			throw new ServiceValidationException("PolicyPropagandaServiceImpl的addPolicyPropaganda方法出错，原因：",
					"新增信息不全", e);
		}
	}
	@Override
	public PageInfo<PolicyPropaganda> getPolicyPropagandaListByQuery(
			PolicyPropaganda policyPropaganda, Integer page, Integer rows,
			String sidx, String sord) {
		if(policyPropaganda==null){
			policyPropaganda=new PolicyPropaganda();
		}
		PropertyDict orgTypeDict = propertyDictService
				.findPropertyDictByDomainNameAndDictDisplayName(
						PropertyTypes.ORGANIZATION_TYPE,
						OrganizationType.FUNCTION_KEY);
		fillPolicyPropagandaOrg(policyPropaganda);
		if(isGridConfigTaskSearch(policyPropaganda)){
			if(!StringUtil.isEmpty(policyPropaganda.getMode())&&
					"true".equals(policyPropaganda.getMode())){
				policyPropaganda.setFunOrgId(policyPropaganda.getOrganization().getId());
				policyPropaganda.setMode("gridConfigService");
			}
			policyPropaganda.getOrganization().setOrgInternalCode(null);
		}else if(orgTypeDict.getId().equals(policyPropaganda.getOrganization().getOrgType().getId())){
			policyPropaganda.getOrganization().setOrgInternalCode(organizationDubboService
						.getOrgInternalCodeById(policyPropaganda.getOrganization().getParentOrg().getId()));
		}else{
			policyPropaganda.getOrganization().setOrgInternalCode(policyPropaganda.getOrganization().getOrgInternalCode());
		}
		PageInfo<PolicyPropaganda> infos=policyPropagandaDao.findPagerBySearchVo(policyPropaganda, page, rows, sidx, sord);
		//设置督办时间
//		infos=supervise(infos);
		return infos;
	}
	//设置督办时间
	private PageInfo<PolicyPropaganda> supervise(PageInfo<PolicyPropaganda> infos ){
		List<PolicyPropaganda> propagandas= infos.getResult();
		for (PolicyPropaganda propaganda:propagandas) {
//			propaganda.setSupervise(5);
		}
		return infos;
	}
	public void fillPolicyPropagandaOrg(PolicyPropaganda policyPropaganda) {
		if (policyPropaganda.getOrganization().getId() == null) {
			throw new BusinessValidationException("组织结构获取异常！");
		}
		Organization organization = organizationDubboService.getFullOrgById(policyPropaganda.getOrganization()
				.getId());
		String[] orgs = organization.getFullOrgName().split(ModuleConstants.SEPARATOR);
		if (orgs.length > 2) {
			String org = orgs[orgs.length - 2] + ModuleConstants.SEPARATOR + orgs[orgs.length - 1];
			organization.setFullOrgName(org);
		}
		policyPropaganda.setOrganization(organization);
	}
	
	@Override
	public PolicyPropaganda updatePolicyPropaganda(
			PolicyPropaganda policyPropaganda) {
		fillPolicyPropagandaOrg(policyPropaganda);
		validatorImpl.validatorPolicyPropaganda(policyPropaganda);
		String[] attachIds=policyPropaganda.getDeleteAttachIds().split(",");
		for (int i = 0; i < attachIds.length; i++) {
			if(!attachIds[i].equals("")){
				attachService.deleteServiceListAttch(Long.parseLong(attachIds[i]));
			}
		}
		attachService.addServiceListAttch(policyPropaganda.getAttachFileNames(), policyPropaganda.getId(),TYPE);
		return policyPropagandaDao.update(policyPropaganda);
	}

	@Override
	public void deletePolicyPropagandaByIds(String ids) {
		String[]id= ids.split(",");
		for (String objId:id){
			List<Reply>replies=replyService.getReplyByIdAndType(Long.parseLong(objId), TYPE);
			for (Reply reply:replies) {
				replyAttachService.deleteReplyAttchByIds(reply.getId(), TYPE);
			}
			replyService.deleteReplyByIds(Long.parseLong(objId), TYPE);
			policyPropagandaDao.delete(Long.parseLong(objId));
			attachService.deleteServiceListAttchByIds(Long.parseLong(objId),TYPE);
		}
	}

	@Override
	public PolicyPropaganda getPolicyPropagandaById(Long id) {
		PolicyPropaganda policyPropaganda=policyPropagandaDao.get(id);
		if(policyPropaganda!=null){
			policyPropaganda.setPhotos(attachService.getServiceListAttchByIdAndType(id, TYPE));
			User user = permissionDubboService.getFullUserByUerName(policyPropaganda.getCreateUser());
			if(user!=null){
				policyPropaganda.setCreateUser(user.getName());
			}
		}
		fillOrganization(policyPropaganda);
		return policyPropaganda;
	}
	
	public void fillOrganization(PolicyPropaganda policyPropaganda) {
		if (policyPropaganda.getOrganization().getId() == null) {
			throw new BusinessValidationException("组织结构获取异常！");
		}
		Organization organization = organizationDubboService.getFullOrgById(policyPropaganda
				.getOrganization().getId());
		organization = ControllerHelper.proccessRelativeOrgNameByOrg(organization, organizationDubboService);
		policyPropaganda.setOrganization(organization);
	}

	@Override
	public PolicyPropaganda signPolicyPropaganda(
			PolicyPropaganda policyPropaganda) {
		PolicyPropaganda propaganda=policyPropagandaDao.get(policyPropaganda.getId());
		propaganda.setUpdateDate(new Date());
		propaganda.setUpdateUser(policyPropaganda.getSignPeople());
		propaganda.setSignContent(policyPropaganda.getSignContent());
		propaganda.setSignDate(policyPropaganda.getSignDate());
		propaganda.setSignPeople(policyPropaganda.getSignPeople());
		propaganda.setIsSign(1);
		return policyPropagandaDao.update(propaganda);
	}

	@Override
	public PolicyPropaganda replyPolicyPropaganda(
			PolicyPropaganda policyPropaganda) {
		PolicyPropaganda propaganda=policyPropagandaDao.get(policyPropaganda.getId());
		propaganda.setIsReply(1);
		policyPropagandaDao.update(propaganda);
		Reply reply=policyPropaganda.getReply();
		reply.setServiceId(policyPropaganda.getId());
		reply.setServiceType(TYPE);
		reply=replyService.addReply(reply);
		replyAttachService.addReplyAttch(policyPropaganda.getAttachFileNames(), reply.getId(),TYPE);
		return policyPropaganda;
	}
	
	//判断是否为网格配置后的查询
		private boolean isGridConfigTaskSearch(PolicyPropaganda policyPropaganda){
			Long funId=policyPropaganda.getOrganization().getId();
			if(policyPropaganda.getMode()==null){
				return false;
			}
			if(policyPropaganda.getMode().equals("gridConfigService")&&
					funId.equals(ThreadVariable.getOrganization().getId())){
				return true;
			}
			if(policyPropaganda.getMode().equals("true")&&configTaskService.isHasGridTaskList(funId,Constants.TASKLIST_KEY)){
				return true;
			}
			return false;
		}
}