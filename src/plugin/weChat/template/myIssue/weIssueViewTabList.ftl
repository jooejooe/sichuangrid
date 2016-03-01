<#assign pop=JspTaglibs["/WEB-INF/taglib/pop-taglib.tld"]>
<#assign s=JspTaglibs["/WEB-INF/taglib/struts-tags.tld"]>
<@s.include value="/includes/baseInclude.jsp"/>
<style>
#myAuditDelayCount {border-radius: 5px;cursor: pointer;position: absolute;color: #fff;font: bold 11px/1.5em '';top: 6px;right: 9px;background: #F68300;padding: 0 5px;z-index: 1;
}
</style>
<input type="hidden" id="isMyIssue" />
<div id="tabList">
	<ul>
		<li><a href="${path}/issue/issueManage/issueForViewList.jsp?viewType=need&orgLevel=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().orgLevel.internalId'/>&keyId=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().id'/>&functionalOrgType=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().functionalOrgType.id'/>&sourceType=<@s.property value='@com.tianque.domain.property.IssueSourceType@WECHAT_INPUT'/>">待办</a> </li>
		<li><a href="${path}/issue/issueManage/issueForViewList.jsp?viewType=done&orgLevel=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().orgLevel.internalId'/>&keyId=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().id'/>&functionalOrgType=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().functionalOrgType.id'/>&sourceType=<@s.property value='@com.tianque.domain.property.IssueSourceType@WECHAT_INPUT'/>">已办</a></li>
		<li><a href="${path}/issue/issueManage/issueForViewList.jsp?viewType=completed&orgLevel=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().orgLevel.internalId'/>&keyId=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().id'/>&functionalOrgType=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().functionalOrgType.id'/>&sourceType=<@s.property value='@com.tianque.domain.property.IssueSourceType@WECHAT_INPUT'/>">已办结</a></li>
<!--		<li><a href="${path}/issue/issueManage/issueForViewList.jsp?viewType=submit&orgLevel=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().orgLevel.internalId'/>&keyId=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().id'/>&functionalOrgType=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().functionalOrgType.id'/>&sourceType=<@s.property value='@com.tianque.domain.property.IssueSourceType@WECHAT_INPUT'/>">上报</a></li>-->
<!--		<li><a href="${path}/issue/issueManage/issueForViewList.jsp?viewType=assign&orgLevel=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().orgLevel.internalId'/>&keyId=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().id'/>&functionalOrgType=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().functionalOrgType.id'/>&sourceType=<@s.property value='@com.tianque.domain.property.IssueSourceType@WECHAT_INPUT'/>">上级交办</a></li>-->
<!--		<li><a href="${path}/issue/issueManage/issueForViewList.jsp?viewType=skip&orgLevel=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().orgLevel.internalId'/>&keyId=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().id'/>&functionalOrgType=<@s.property value='@com.tianque.core.util.ThreadVariable@getOrganization().functionalOrgType.id'/>&sourceType=<@s.property value='@com.tianque.domain.property.IssueSourceType@WECHAT_INPUT'/>">越级</a></li>-->
	</ul>
 	</div>
<script>
$(function() {
	var isMyIssue = true;
	$("#isMyIssue").val(isMyIssue);
	if(!isMyIssue){
		$("#checkPending").hide();
	}
	$( "#tabList" ).tabs({ selected: 0 ,beforeLoad:function(){
			$( "#tabList" ).find(".ui-tabs-panel").empty();
		}});
});
</script>