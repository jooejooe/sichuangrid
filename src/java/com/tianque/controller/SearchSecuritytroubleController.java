package com.tianque.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.tianque.core.base.BaseAction;
import com.tianque.core.vo.GridPage;
import com.tianque.core.vo.PageInfo;
import com.tianque.dao.SearchServiceDaoNew;
import com.tianque.domain.Organization;
import com.tianque.domain.vo.SearchIssueVo;
import com.tianque.issue.domain.IssueNew;
import com.tianque.sysadmin.service.OrganizationDubboService;

@Controller("searchSecuritytroubleController")
@Scope("prototype")
@Transactional
public class SearchSecuritytroubleController extends BaseAction {

	@Autowired
	private OrganizationDubboService organizationDubboService;

	@Autowired
	private SearchServiceDaoNew searchServiceDaoNew;

	private SearchIssueVo searchSecuritytroubleVo = new SearchIssueVo();

	private Long orgId;

	public String searchSecuritytrouble() {
		if (null == searchSecuritytroubleVo) {
			gridPage = new GridPage(emptyIssuePage(rows));
			return SUCCESS;
		} else {
			if (null != orgId) {
				Organization org = organizationDubboService.getSimpleOrgById(orgId);
				if (null != org) {
					org.setId(null);
					searchSecuritytroubleVo.setOrganization(org);
				} else {
					searchSecuritytroubleVo.setOrganization(null);
				}
			} else {
				searchSecuritytroubleVo.setOrganization(null);
			}
			gridPage = new GridPage(ControllerHelper.processAllOrgRelativeName(searchServiceDaoNew
					.searchSecuritytroubleByOrgInternalCode(searchSecuritytroubleVo, page, rows,
							sidx, sord), organizationDubboService, new String[] { "occurOrg" }, orgId));
		}
		return SUCCESS;
	}

	private PageInfo<IssueNew> emptyIssuePage(int pageSize) {
		PageInfo<IssueNew> pageInfo = new PageInfo<IssueNew>();
		pageInfo.setTotalRowSize(0);
		pageInfo.setCurrentPage(0);
		pageInfo.setPerPageSize(pageSize);
		pageInfo.setResult(new ArrayList<IssueNew>());
		return pageInfo;
	}

	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}

	public SearchIssueVo getSearchSecuritytroubleVo() {
		return searchSecuritytroubleVo;
	}

	public void setSearchSecuritytroubleVo(SearchIssueVo searchSecuritytroubleVo) {
		this.searchSecuritytroubleVo = searchSecuritytroubleVo;
	}
}
