<#assign pop=JspTaglibs["/WEB-INF/taglib/pop-taglib.tld"]>
<#assign s=JspTaglibs["/WEB-INF/taglib/struts-tags.tld"]>
<@s.include value="/includes/baseInclude.jsp" />
<@s.include value="${path }/statAnalyseNew/baseInfoStat/common/commonStatisticPie.ftl">
	<@s.param  name="type">
		<@s.property value="@com.tianque.service.util.PopulationType@DANGEROUS_GOODS_PRACTITIONER"/>
	</@s.param>
</@s.include>