package com.tianque.serviceList.dataConverter;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.tianque.core.datatransfer.ExcelImportHelper;
import com.tianque.core.validate.DomainValidator;
import com.tianque.core.validate.ValidateResult;
import com.tianque.datatransfer.dataconvert.AbstractDataConverter;
import com.tianque.excel.definition.SpecialGroupsContext;
import com.tianque.serviceList.domain.Reply;
import com.tianque.serviceList.domain.ServiceListEnum;
import com.tianque.serviceList.domain.UnlicensedManage;
import com.tianque.serviceList.service.ReplyService;
import com.tianque.serviceList.service.UnlicensedManageService;

@Component("unlicensedManageDataConverter")
public class UnlicensedManageDataConverter extends
		AbstractDataConverter<UnlicensedManage> {
	@Autowired
	private UnlicensedManageService unlicensedManageService;

	@Qualifier("unlicensedManageImportValidator")
	@Autowired
	private DomainValidator<UnlicensedManage> unlicensedManageImportValidator;
	@Autowired
	private ReplyService replyService;

	/** 将Excel数据转为对象 */
	@Override
	public UnlicensedManage convertToDomain(String[] cellValues, ValidateResult vr) {
		cellValues = validateHelper.cellValueTrim(cellValues);
		UnlicensedManage domain = new UnlicensedManage();

		ExcelImportHelper.procImportDate(
				SpecialGroupsContext.getCompanyplaceImportArray(), cellValues,
				getUploadOrganization(), domain, vr);
		return domain;
	}

	/** 保存数据到数据库 */
	@Override
	public UnlicensedManage persistenceDomain(UnlicensedManage domain) {
		UnlicensedManage unlicensedManage = null;
		try {
			if (checkDataExitInCache(domain)) {
				return domain;
			}
			unlicensedManage = unlicensedManageService.addUnlicensedManage(domain);
			if(domain.getIsReply()==1){
				Reply reply=new Reply();
				reply.setReplyDate(domain.getReplyDate());
				reply.setReplyPeople(domain.getReplyPeople());
				reply.setReplyContent(domain.getReplyContent());
				reply.setServiceId(domain.getId());
				reply.setServiceType(ServiceListEnum.getValue("unlicensed"));
				reply=replyService.addReply(reply);
			}
		} finally {
			cleanDataInCache(domain);
		}
		return unlicensedManage;
	}

	/** 修改数据到数据库 */
	@Override
	public UnlicensedManage updateDomain(UnlicensedManage domain) {
		return null;
	}

	/** 验证Excel数据的正确性 */
	@Override
	public ValidateResult validate(UnlicensedManage unlicensedManage, int realRow) {
		ExcelImportHelper.realRow.set(realRow);
		return unlicensedManageImportValidator.validate(unlicensedManage);
	}

	@Override
	public boolean isRepeatData(UnlicensedManage domain) {
		return false;
	}

	private boolean checkDataExitInCache(UnlicensedManage domain) {
//		if (domain != null && domain.getName() != null
//				&& !"".equals(domain.getName())
//				&& domain.getOrganization() != null
//				&& domain.getOrganization().getId() != null
//				&& domain.getClassifiCation() != null
//				&& domain.getClassifiCation().getId() != null) {
//			String key = MemCacheConstant.getUnlicensedManageKey(
//					MemCacheConstant.COMPANYPLACEKEY, domain.getName(), domain
//							.getClassifiCation().getId(), domain
//							.getOrganization().getId());
//			return !cacheService.add(MemCacheConstant.COMPANYPLACE_NAMESPACE,
//					key, 300, NewBaseInfoTables.COMPANYPLACEKEY);
//		}
		return false;
	}

	public void cleanDataInCache(UnlicensedManage domain) {
//		String key = MemCacheConstant.getUnlicensedManageKey(
//				MemCacheConstant.COMPANYPLACEKEY, domain.getName(), domain
//						.getClassifiCation().getId(), domain.getOrganization()
//						.getId());
//		cacheService.remove(MemCacheConstant.COMPANYPLACE_NAMESPACE, key);
	}
}
