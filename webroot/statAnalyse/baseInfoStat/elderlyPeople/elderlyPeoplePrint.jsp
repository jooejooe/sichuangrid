<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/includes/baseInclude.jsp" />

<s:include value="/statAnalyse/baseInfoStat/common/commonStatisticPrint.jsp">
	<s:param  name="type">
	<s:property value="@com.tianque.service.util.PopulationType@ELDERLY_PEOPLE"/>
	</s:param>
</s:include>
