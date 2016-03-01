package com.tianque.baseInfo.primaryOrg.validator;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tianque.baseInfo.primaryOrg.domain.RedCuffTeam;
import com.tianque.baseInfo.primaryOrg.service.RedCuffTeamService;
import com.tianque.core.datatransfer.ExcelImportHelper;
import com.tianque.core.datatransfer.dataconvert.ValidateHelper;
import com.tianque.core.util.StringUtil;
import com.tianque.core.validate.DomainValidator;
import com.tianque.core.validate.ValidateResult;
import com.tianque.domain.PropertyDict;
import com.tianque.userAuth.api.PropertyDictDubboService;

@Component("redCuffTeamValidator")
public class RedCuffTeamValidator implements DomainValidator<RedCuffTeam> {
	@Autowired
	public ValidateHelper validateHelper;
	@Autowired
	private RedCuffTeamService redCuffTeamService;
	@Autowired
	private PropertyDictDubboService propertyDictDubboService;

	@Override
	public ValidateResult validate(RedCuffTeam domain) {
		ValidateResult result = new ValidateResult();

		/***
		 * 成员名称校验
		 */
		if (!StringUtil.isStringAvaliable(domain.getMemeberName())) {
			result.addErrorMessage(getColumNo("memeberName") + "成员名称必须填写");
		} else if (validateHelper.illegalStringLength(0, 10,
				domain.getMemeberName())) {
			result.addErrorMessage(getColumNo("memeberName") + "成员名称不能超过10个字符");
		}

		/***
		 * 验证联系方式
		 */
		if (!validateHelper.emptyString(domain.getPhoneNumber())) {
			if (validateHelper.illegalTelephone(domain.getPhoneNumber())) {
				result.addErrorMessage(getColumNo("phoneNumber")
						+ "联系电话输入格式不正确,只能输入数字和-");
			}
			if (validateHelper.illegalStringLength(0, 15,
					domain.getPhoneNumber())) {
				result.addErrorMessage(getColumNo("phoneNumber")
						+ "联系电话不能大于15个字符");
			}
		} else {
			result.addErrorMessage(getColumNo("phoneNumber") + "联系电话必须填写");
		}

		/***
		 * 电话号码唯一性验证
		 */
		if (domain.getId() != null) {
			/**修改验证是否是修改的同一条数据*/
			if (StringUtil.isStringAvaliable(domain.getMemeberName())
					&& !validateHelper.emptyString(domain.getPhoneNumber())
					&& redCuffTeamService.getRedCuffTeamByPhoneNumber(domain.getPhoneNumber())!=null
					&&redCuffTeamService.getRedCuffTeamByPhoneNumber(domain.getPhoneNumber())
									.getId().longValue() != domain.getId().longValue()) {
				result.addErrorMessage(getColumNo("memeberName")
						+ "成员电话号码已经存在，请重新输入");
			}
		} else {
			if (StringUtil.isStringAvaliable(domain.getMemeberName())
					&& !validateHelper.emptyString(domain.getPhoneNumber())
					&& redCuffTeamService.getRedCuffTeamByPhoneNumber(domain.getPhoneNumber()) != null) {
				result.addErrorMessage(getColumNo("memeberName")
						+ "成员电话号码已经存在，请重新输入");
			}
		}

		/***
		 * 验证民族
		 */
		if (validateHelper.nullObj(domain.getNation())) {
			result.addErrorMessage(getColumNo("nation") + "民族必须选择");
		}
		/***
		 * 验证队伍类型
		 */
		if (validateHelper.nullObj(domain.getTeamType())) {
			result.addErrorMessage(getColumNo("teamType") + "队伍类型必须选择");
		}
		/***
		 * 验证队伍类别
		 */
		if (validateHelper.nullObj(domain.getSubTeamType())) {
			result.addErrorMessage(getColumNo("subTeamType") + "队伍类别必须选择");
		} else if (!validateHelper.nullObj(domain.getTeamType())) {
			// 验证是否是根据类型选择的类别
			PropertyDict teamType = propertyDictDubboService
					.getPropertyDictById(domain.getTeamType().getId());
			PropertyDict subTeamType = propertyDictDubboService
					.getPropertyDictById(domain.getSubTeamType().getId());
			if (teamType == null || subTeamType == null) {
				result.addErrorMessage(getColumNo("subTeamType") + "队伍类别未找到");
			} else if (teamType.getInternalId() != subTeamType.getInternalId()) {
				result.addErrorMessage(getColumNo("subTeamType")
						+ "请根据队伍类型选择对应的队伍类别");
			}
		}
		/***
		 * 验证政治面貌
		 */
		if (validateHelper.nullObj(domain.getPolitical())) {
			result.addErrorMessage(getColumNo("political") + "政治面貌必须选择");
		}
		/***
		 * 验证文化程度
		 */
		if (validateHelper.nullObj(domain.getEducation())) {
			result.addErrorMessage(getColumNo("education") + "文化程度必须选择");
		}

		/***
		 * 成员身份证验证
		 */
		if (validateHelper.emptyString(domain.getIdCardNo())) {
			result.addErrorMessage(getColumNo("idCardNo") + "身份证号码必须输入");
		}
		if (!validateHelper.emptyString(domain.getIdCardNo())
				&& validateHelper.illegalExculdeParticalChar(domain
						.getIdCardNo())) {
			result.addErrorMessage(getColumNo("idCardNo") + "身份证号码不能输入非法字符");
		}
		if (!validateHelper.emptyString(domain.getIdCardNo())
				&& validateHelper.illegalIdcard(domain.getIdCardNo())) {
			result.addErrorMessage(getColumNo("idCardNo") + "身份证号码输入不正确");
		}

		/***
		 * 验证职业
		 */
		if (!validateHelper.emptyString(domain.getOccupation())
				&& validateHelper.illegalStringLength(0, 20,
						domain.getOccupation())) {
			result.addErrorMessage(getColumNo("occupation") + "职业不能超过20个字符");
		}
		/***
		 * 验证家庭住址
		 */
		if (!validateHelper.emptyString(domain.getFimalyAddress())
				&& validateHelper.illegalStringLength(0, 40,
						domain.getFimalyAddress())) {
			result.addErrorMessage(getColumNo("fimalyAddress")
					+ "家庭住址不能超过40个字符");
		}
		/***
		 * 验证备注
		 */
		if (!validateHelper.emptyString(domain.getRemark())
				&& validateHelper.illegalStringLength(0, 100,
						domain.getRemark())) {
			result.addErrorMessage(getColumNo("remark") + "备注不能超过getRemark个字符");
		}
		/**
		 * 验证登记时间
		 */
		if (validateHelper.nullObj(domain.getRegisteredDate())) {
			result.addErrorMessage(getColumNo("registeredDate") + "登记时间不能为空");
		} else if (domain.getRegisteredDate().after(new Date())) {
			result.addErrorMessage(getColumNo("registeredDate")
					+ "登记日期不能大于当前日期");
		}

		return result;
	}

	public String getColumNo(String key) {
		StringBuffer bf = new StringBuffer();
		if (!StringUtils.isEmpty(ExcelImportHelper.getDataColumMap(key))
				&& ExcelImportHelper.realRow.get() != null) {
			bf.append("第[").append(ExcelImportHelper.realRow.get())
					.append("]行");
			bf.append("第[")
					.append(Integer.valueOf(ExcelImportHelper
							.getDataColumMap(key)) + 1).append("]列");
		} else {
			bf.append("");
		}
		return bf.toString();
	}
}