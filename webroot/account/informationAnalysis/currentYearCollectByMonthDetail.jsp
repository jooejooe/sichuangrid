<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="com.tianque.domain.property.OrganizationType,com.tianque.domain.Organization,com.tianque.domain.property.OrganizationLevel,
         com.tianque.core.util.ThreadVariable,com.tianque.domain.User" %>
<%@ taglib prefix="pop" uri="/PopGrid-taglib"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/includes/baseInclude.jsp" />

<s:action name="getLoginInfo" var="loginAction" executeResult="false" namespace="/sessionManage" />
<s:action name="getFullOrgById" var="getFullOrgById" executeResult="false" namespace="/sysadmin/orgManage" >
	<s:param name="organization.id" value="#loginAction.user.organization.id"></s:param>
</s:action>
<%
	request.setAttribute("orgType",request.getParameter("orgType"));

    Organization userOrg = ThreadVariable.getUser().getOrganization();
    if (userOrg.getOrgType().getDisplayName().equals(OrganizationType.getInternalProperties().get(OrganizationType.FUNCTIONAL_ORG).getDisplayName())) {
        request.setAttribute("isFun", true);
    } else {
        request.setAttribute("isFun", false);
    }
%>
<input type="hidden" id="reportType" value="2"/>
<input type="hidden" id="orgLevel" value="${getFullOrgById.organization.orgLevel.internalId }"/>
<input type="hidden" id="keyId" value="${getFullOrgById.organization.id}"/>
<input type="hidden" id="functionalOrgType" value="${getFullOrgById.organization.functionalOrgType.id}"/>
<input type="hidden" id="isHideOrgSearchOrg" value="${isFun}"/>
<input type="hidden" id="orgType" value="<s:property value='#parameters.orgType'/>"/>

 <div>
	<div class="ui-corner-all nav-buttons" id="nav" style="float: left" >
	   <div>
		    <c:if test="${orgType==1 }">
		     	<jsp:include page="/common/orgSelectedComponent.jsp"/>
		     </c:if>
	    	<div style="float: right;padding-bottom: 10px;margin-left: 5px;">
       			<select name="year" id="year" class="form-txt" style="width: 80px;"></select>
			</div>	 
	   </div>
	</div>
   </div>
   <br/><br/><br/><br/>
   <jsp:include page="/account/informationAnalysis/mould/currentYearCollectByMonthMould.jsp"  flush="true"/>

<script type="text/javascript">
$(function(){
	$.ajax({
		async : false,
		url : "${path }/stat/currentTime/getCurrentTimeForYear.action",
		success : function(responseData) {
			var dataLength = responseData.length;
			for (var i = 0; i < dataLength; i++) {
				if (i == 0)
					$("#year").append("<option selected='selected' value='"+responseData[i]+"'>" + responseData[i] + "年</option>");
				else
					if (responseData[i] > 2012)
						$("#year").append("<option value='"+responseData[i]+"'>" + responseData[i] + "年</option>");
			}
		}
	});
	$("#year").change(function() {
		initYearCollect();
	});
	initYearCollect();
})

function initYearCollect(){
	var statGridCollect = initCurrentYearCollectGridCollect("当年分月建账情况分析表详细",false);
	getPrimaryOrgStat(statGridCollect);
}

function getPrimaryOrgStat(statGridCollect){
	$.ajax({
		url:'${path}/threeRecordsIssue/ledgerAccountReportManage/findYearCollectByMonthReportVo.action',
		data:{
			"accountReport.organization.id":getCurrentOrgId(),
			"accountReport.accountType":${orgType},
			"accountReport.reportType":<s:property value="@com.tianque.plugin.account.constants.LedgerReportType@YEAR_COLLECT_MONTH_DETAIL"/>,
			"accountReport.orgLevelInternalId":$("#currentOrgId").attr("orgLevelInternalId"),
			"accountReport.reportYear":$("#year").val()
		},
		success:function(data){
			var dataObj = $.parseJSON(data);
			if(data == null || dataObj != null){
				var message = (data == null) ? '获取报表失败' : dataObj.message;
				$.messageBox({
					message: message,
					level: "error"
				});
			}
			
			statGridCollect.bindData(data);
		}
	})
}
</script>