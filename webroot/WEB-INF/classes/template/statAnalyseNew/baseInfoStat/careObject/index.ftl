<#assign pop=JspTaglibs["/WEB-INF/taglib/pop-taglib.tld"]>
<#assign s=JspTaglibs["/WEB-INF/taglib/struts-tags.tld"]>
<@s.include value="/includes/baseInclude.jsp" />
<@s.include value="/common/orgSelectedComponent.jsp"/>
<div class="zt_tabs_style">
	<div id="chartsTabs">
	<ul>
		 <li><a href="${path }/statAnalyseNew/baseInfoStat/careObject/statisticTotalListColumn.ftl?type=all_civil_population">区域分布图</a></li>
		 <li><a href="${path }/statAnalyseNew/baseInfoStat/careObject/statisticTotalPie.ftl?type=all_civil_population">类型分布图</a></li>
		 <li><a href="${path }/statAnalyseNew/baseInfoStat/careObject/statisticTotalList.ftl?type=all_civil_population">列表信息</a></li>
		 <li><a href="${path }/statAnalyseNew/baseInfoStat/common/tendencyChartForPositiveinfo.ftl?tableNameKey=all_civil_population">趋势图</a></li>
	</ul>
	</div>
	<input id="isNowYear"  type="hidden"/>
		<input id="isNowMonth"  type="hidden"/>
	<div id="infoList"></div>
</div>

<script type="text/javascript">
<@pop.formatterProperty name="attentionExtent" domainName="@com.tianque.domain.property.PropertyTypes@ATTENTION_EXTENT" />
function attentionExtentColor(el,options,rowData){
	var displayName=attentionExtentFormatter(el,options,rowData);
	if(displayName=='undefined'||displayName=='')
		return '';
	else if(displayName=='严重')
		return '<span>严重：<span style="color:#ff0000;">█████</span></span>';
	else if(displayName=='中等')
		return '<span>中等：<span style="color:#ffcc00;">███</span></span>';
	else if(displayName=='一般')
		return '<span>一般：<span style="color:#99cc00;">█</span></span>';
	else
		return '';
}
var url = '';
var title = '';
var width = 900;
var height = 600;
$(document).ready(function(){
	$("#chartsTabs").tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
	$("#chartsTabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );


	// 列表信息 和 柱图 饼图   外层容器计算高度
	$.sigmaReportLayout();

	$.loadingComp("close");
});


function setOptionsWhenShowInfo(name, orgId){
	if(name.indexOf("刑释解教人员") != -1){
		title='刑释解教人员';
		url = '${path}/baseinfo/positiveInfo/positiveInfoListForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}else if(name.indexOf("社区矫正人员") != -1){
		title='社区矫正人员';
		url = '${path}/baseinfo/rectify/rectifyListForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}else if(name.indexOf("重点青少年") != -1){
		title='重点青少年';
		url = '${path}/baseinfo/idleYouth/idleYouthListForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}else if(name.indexOf("易肇事肇祸严重精神障碍患者") != -1){
		title='易肇事肇祸严重精神障碍患者';
		url = '${path}/baseinfo/mentalPatient/mentalPatientlistForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}else if(name.indexOf("吸毒人员") != -1){
		title='吸毒人员';
		url = '${path}/baseinfo/druggyManage/druggyManageListForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}else if(name.indexOf("重点上访人员") != -1){
		title='重点上访人员';
		url = '${path}/baseinfo/superiorVisit/superiorVisitListForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}else if(name.indexOf("危险品从业人员") != -1){
		title='危险品从业人员';
		url = '${path}/baseinfo/dangerousGoodsPractitioner/dangerousGoodsPractitionerListForStatistisc.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}else if(name.indexOf("其他人员") != -1){
		title='其他人员';
		url = '${path}/baseinfo/otherAttentionPersonnel/otherAttentionPersonnelListForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}else if(name.indexOf("境外人员") != -1){
		title='境外人员';
		url='${path}/baseinfo/overseaPersonnel/overseaPersonnelListForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}else if(name.indexOf("育龄妇女") != -1){
		title='育龄妇女';
		url='${path}/baseinfo/nurturesWomen/nurturesWomenStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}
	else if(name.indexOf("优抚对象") != -1){
		title='优抚对象';
		url='${path}/baseinfo/civilAdministration/optimalObject/optimalObjectStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}
	else if(name.indexOf("老年人") != -1){
		title='老年人';
		url='${path}/baseinfo/elderlyPeople/elderlyPeopleStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}
	else if(name.indexOf("需救助人员") != -1){
		title='需救助人员';
		url='${path}/baseinfo/civilAdministration/aidNeedPopulation/aidNeedPopulationListForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}
	else if(name.indexOf("残疾人") != -1){
		title='残疾人';
		url='${path}/baseinfo/handicapped/handicappedListForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}
	else if(name.indexOf("失业") != -1){
		title='失业人员';
		url='${path}/baseinfo/civilAdministration/unemployedPeople/unemployedPeopleListForStatistics.jsp?orgIdForStat='+orgId+'&searchType=advanced';
	}
}

function showInfo(url, title, width, height,year,month){
	
	if(year==$("#isNowYear").val() && month==$("#isNowMonth").val()){
		
		$("#infoList").createDialog({
			width: width,
			height: height,
			title: title+'信息',
			modal:true,
			url: url,
			buttons: {
		   		"关闭" : function(){
		        	$(this).dialog("close");
		   			}
				}
			});
	}
}
function shwoInfoInDialog(name, orgId){
	setOptionsWhenShowInfo(name, orgId);
	showInfo(url, title, width, height,$("#year").val(),$("#month").val());
}


function enableOrDisableColumn(i){
	if(isGrid()){
		$("#chartsTabs").tabs("select", i);
		$("#chartsTabs").tabs("disable", 0);
		$("#chartsTabs").tabs("disable", 2);
	}else{
		$("#chartsTabs").tabs("enable", 0);
		$("#chartsTabs").tabs("enable", 2);
	}
}
</script>