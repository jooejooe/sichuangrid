<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/PopGrid-taglib" prefix="pop"%>
<%@ include file="/includes/baseInclude.jsp"%>

<s:action name="ajaxOrganization" var="findById" namespace="/sysadmin/orgManage" executeResult="false">
	<s:param name="organization.id" value="@com.tianque.core.util.ThreadVariable@getOrganization().id"></s:param>
</s:action>
<style>
.integrativeQuery .form-lb1{float:left;}
.integrativeQuery .areaName_1{float: left;display: inline;margin-right:10px;}
.container_24 .input-text-bg{background:#fff;}
</style>
<input type="hidden" id="currOrgId" name="currOrgId" value="<s:property value="#findById.organization.id"/>" />
<input type="hidden" id="currOrgCode" name="currOrgCode" value="<s:property value="#findById.organization.orgInternalCode"/>" />
<input type="hidden" id="currOrgLevel" value="<s:property value="#findById.organization.orgLevel.id"/>" />
<div id="commonPopulation" class="container container_24 clearfix integrativeQuery" >
	<form id="maintainForm" method="post">
		<div class="Explain">
			<div class="areaName_1">
				<label class="form-lb1">所属区域：</label>
				<input type="text" id="OrgName"
				value="<s:property value="#findById.organization.orgName"/>" />
			</div>
			<div class="areaName_1">
				<label class="form-lb1">开始时间：</label>
				<input type="text" id="createDateStart" name="recoverDatasVo.createDateStart" class="input-text-bg" />
			</div>
			<div class="areaName_1">
				<label class="form-lb1">结束时间：</label>
				<input type="text" id="createDateEnd" name="recoverDatasVo.createDateEnd" class="input-text-bg" />
			</div>
			<div class="areaName_1">
				<label class="form-lb1">操作账户：</label>
				<input type="text" id="recoverDatasVo.createUser" name="recoverDatasVo.createUser"  class="input-text-bg" />
			</div>
		</div>
		<div class='clearLine'>&nbsp;</div>
		<div class="Explain">
			<div class="areaName">
				<label class="form-lb1">所属模块：</label>
			</div>
			&nbsp;&nbsp;&nbsp;<select name="recoverDatasVo.moduleType" id="moduleNames" class="form-btn" onchange="moduleNameChange(this.value);">
				<s:iterator id="moduleList" value="@com.tianque.core.util.NewBaseInfoTables@getModuleLists()">
					<s:iterator value="moduleList">
						<option value='<s:property value="key" />' <s:if test="key=='people'">selected="selected"</s:if>><s:property value="value" /></option>
					</s:iterator>
				</s:iterator>
			</select>
			<div style="display: none;">
				<select id="populationNames" >
				<s:iterator id="populationList" value="@com.tianque.core.util.NewBaseInfoTables@getPopulationLists()">
					<s:iterator value="populationList">
						<option value='<s:property value="key" />'><s:property value="value" /></option>
					</s:iterator>
				</s:iterator>
			</select>
			</div>
		</div>
		<div class='clearLine'>&nbsp;</div>
		<div id="peopleSelectDiv">
		<%-- 		<pop:JugePermissionTag ename="actualPeopleIntegrativeQuery"> --%>
<!-- 			<div class="Explain"> -->
<!-- 				<label class="form-lb1">实口类型：</label>  -->
<%-- 				<pop:JugePermissionTag ename="householdStaffIntegrativeQuery"> --%>
<!-- 					<input type="radio" class="form-btn" name="attentionPopulationTypes" -->
<%-- 						value='<s:property value="@com.tianque.service.util.PopulationType@HOUSEHOLD_STAFF"/>' />&nbsp;&nbsp;户籍人口&nbsp;&nbsp;&nbsp;&nbsp; --%>
<%-- 		   	</pop:JugePermissionTag> --%>
<%-- 				<pop:JugePermissionTag ename="floatingPopulationIntegrativeQuery"> --%>
<!-- 					<input type="radio" class="form-btn" name="attentionPopulationTypes" -->
<%-- 						value='<s:property value="@com.tianque.service.util.PopulationType@FLOATING_POPULATION"/>' />&nbsp;&nbsp;流动人口&nbsp;&nbsp;&nbsp;&nbsp; --%>
<%-- 		   </pop:JugePermissionTag> --%>
<!-- 			</div> -->
<%-- 		</pop:JugePermissionTag> --%>

		<pop:JugePermissionTag ename="attentionPeopleIntegrativeQuery">
			<div class="Explain">
				<label class="form-lb1">特殊人群：</label>
				<pop:JugePermissionTag ename="positiveInfoIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@POSITIVE_INFO'/>" />&nbsp;&nbsp;刑释人员&nbsp;&nbsp;&nbsp;&nbsp;
		   	</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="rectificativePersonIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@RECTIFICATIVE_POPULATION'/>" />&nbsp;&nbsp;社区矫正人员&nbsp;&nbsp;&nbsp;&nbsp;
		   	</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="druggyIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@DRUGGY'/>" />&nbsp;&nbsp;吸毒人员&nbsp;&nbsp;&nbsp;&nbsp;
		   </pop:JugePermissionTag>
				<pop:JugePermissionTag ename="mentalPatientIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@MENTAL_PATIENT'/>" />&nbsp;&nbsp;严重精神障碍患者&nbsp;&nbsp;&nbsp;&nbsp;
		   	</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="idleYouthIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@IDLE_YOUTH'/>" />&nbsp;&nbsp;重点青少年&nbsp;&nbsp;&nbsp;&nbsp;
		  </pop:JugePermissionTag>
				<pop:JugePermissionTag ename="superiorVisitIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@SUPERIOR_VISIT'/>" />&nbsp;&nbsp;重点上访人员&nbsp;&nbsp;&nbsp;&nbsp;
		   	</pop:JugePermissionTag>
				<pop:JugePermissionTag
					ename="dangerousGoodsPractitionerIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@DANGEROUS_GOODS_PRACTITIONER'/>" />&nbsp;&nbsp;危险品从业人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
				<input type="radio" class="form-btn" name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@AIDSPOPULATIONS'/>" />&nbsp;&nbsp;艾滋病人员&nbsp;&nbsp;&nbsp;&nbsp;
				<pop:JugePermissionTag
					ename="otherAttentionPersonnelIntegrativeQuery">
					<input type="radio" class="form-btn"
							name="attentionPopulationTypes"
							value="<s:property value='@com.tianque.service.util.PopulationType@OTHER_ATTENTION_PERSONNEL'/>" />&nbsp;&nbsp;其他人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
			</div>
		</pop:JugePermissionTag>
		<pop:JugePermissionTag ename="civilPeopleIntegrativeQuery">
			<div class="Explain">
				<label class="form-lb1">关怀对象：</label>
				<pop:JugePermissionTag ename="elderlyPeopleIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@ELDERLY_PEOPLE'/>" />&nbsp;&nbsp;老年人&nbsp;&nbsp;&nbsp;&nbsp;
		   	</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="handicappedIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@HANDICAPPED'/>" />&nbsp;&nbsp;残疾人&nbsp;&nbsp;&nbsp;&nbsp;
		   		</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="optimalObjectIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@OPTIMAL_OBJECT'/>" />&nbsp;&nbsp;优抚对象&nbsp;&nbsp;&nbsp;&nbsp;
		   		</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="aidNeedPopulationIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@AID_NEED_POPULATION'/>" />&nbsp;&nbsp;需救助人员&nbsp;&nbsp;&nbsp;&nbsp;
		   		</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="unemployedPeopleIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@UNEMPLOYED_PEOPLE'/>" />&nbsp;&nbsp;失业人员&nbsp;&nbsp;&nbsp;&nbsp;
			</pop:JugePermissionTag>
			</div>
		</pop:JugePermissionTag>
		<pop:JugePermissionTag ename="nurturesWomenIntegrativeQuery">
			<div class="Explain">
				<label class="form-lb1">育龄妇女：</label> 
				<pop:JugePermissionTag ename="nurturesWomenIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@NURTURES_WOMEN'/>" />&nbsp;&nbsp;育龄妇女&nbsp;&nbsp;&nbsp;&nbsp;
			</pop:JugePermissionTag>
			</div>
		</pop:JugePermissionTag>
		<pop:JugePermissionTag ename="fxjPeopleIntegrativeQuery">
			<div class="Explain">
				<label class="form-lb1">FXJ人员：</label> 
				<pop:JugePermissionTag ename="fPersonnelIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@F_PERSONNEL'/>" />&nbsp;&nbsp;F人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="qPersonnelIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@Q_PERSONNEL'/>" />&nbsp;&nbsp;Q人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="mPersonnelIntegrativeQuery">
					<input type="radio" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@M_PERSONNEL'/>" />&nbsp;&nbsp;M人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
			</div>
		</pop:JugePermissionTag>
		<div class="dashline"></div>
		<div class="Explain">
			<label class="form-lb1">姓名：</label>
			<input type="text" id="name" name="recoverDatasVo.name" class="input-text-bg" />&nbsp;&nbsp;
		</div>
		<div class="Explain">
			<label class="form-lb1">身份证：</label>
			<input type="text" id="idCardNo" name="recoverDatasVo.idCardNo" class="input-text-bg" />&nbsp;&nbsp;
		</div>
	</div>
	
	<div id ="companyPlaceSelectDiv">
		<label class="form-lb1">场所：</label>
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@PublicPlaceKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@PublicPlace'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@TrafficPlaceKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@TrafficPlace'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@EntertainmentPlaceKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@EntertainmentPlace'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@TradePlaceKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@TradePlace'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@InternetServicesPlaceKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@InternetServicesPlace'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@AccommodationServicesPlaceKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@AccommodationServicesPlace'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@FoodServicesPlaceKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@FoodServicesPlace'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@TravelingPlaceKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@TravelingPlace'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@ConstructionPlaceKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@ConstructionPlace'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@OtherPlaceKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@OtherPlace'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<div class="dashline"></div>
		<label class="form-lb1">单位：</label> 
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@PartyGovernmentOrganCompanyKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@PartyGovernmentOrganCompany'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@EducationCompanyKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@EducationCompany'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@MedicalHygieneCompanyKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@MedicalHygieneCompany'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@DangerousStoreCompanyKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@DangerousStoreCompany'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@OtherCompanyKey'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.baseInfo.companyPlace.constacts.ModulTypes@OtherCompany'/>&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<div id ="houseSelectDiv">
		<label class="form-lb1">房屋类型：</label>
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.core.util.NewBaseInfoTables@ACTUALHOUSE_KEY'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.core.util.NewBaseInfoTables@ACTUALHOUSE_DISPLAYNAME'/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="<s:property value='@com.tianque.core.util.NewBaseInfoTables@RENTALHOUSE_KEY'/>" />&nbsp;&nbsp;<s:property value='@com.tianque.core.util.NewBaseInfoTables@RENTALHOUSE_DISPLAYNAME'/>&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	
		<div class="dashline"></div>
		<div class="Explain" id="nav">
			<a id="search" href="javascript:void(0)"><span><strong class="ui-ico-xz"></strong>查询</span></a>
			<a id="advancedSearch" href="javascript:void(0)" style="display: none;"><span><strong	class="ui-ico-xz"></strong>高级查询</span></a>
			<a id="recoverData" href="javascript:void(0)" style="display: none;"><span><strong class="ui-ico-xz"></strong>恢 复</span></a>
		</div>
		<input type="radio" class="form-btn" name="attentionPopulationTypes" value="" id="default_types" style="display: none;"/>
	</form>
</div>
<div style="position:relative;" id="contractCommonPopulation">
	<a href="javascript:;" class="search-contract" hidefocus="true">收缩</a>
</div>
<div class='clearLine'></div>
<div style="width: 100%;" >
	<table id="searchResultList" ></table>
	<div id="searchResultListPager"></div>
</div>
<div><div id="searchDialog"></div></div>
<script type="text/javascript">
$(function(){
	$("#contractCommonPopulation").toggle(
		function(){
			$(this).addClass("contract-cur");
			$("#commonPopulation").hide();
			$(window).trigger("resize");
		},
		function(){
			$(this).removeClass("contract-cur");
			$("#commonPopulation").show();
			$(window).trigger("resize");
		}
	)
	var tree=$("#OrgName").treeSelect({
		inputName:"currOrgId",
		listWidth:260,
		maxHeight:300,
		rootId:'<s:if test="#findById.organization.orgType.internalId==@com.tianque.domain.property.OrganizationType@FUNCTIONAL_ORG"><s:property value="#findById.organization.parentOrg.id"/></s:if><s:else><s:property value="@com.tianque.core.util.ThreadVariable@getOrganization().id"/></s:else>',
		onSelect:function(){
			if(typeof(onOrgChanged) != 'undefined'){
				onOrgChanged.call(null,$("#currOrgId").attr("value"));
			}
		}
	});
});


function moduleNameChange(moduleValue){
	$("#contractCommonPopulation").removeClass("contract-cur");
	$("#commonPopulation").show();
	$(window).trigger("resize");
	$("#search").click();
	var peopleValue = '<s:property value="@com.tianque.core.util.NewBaseInfoTables@PEOPLE_KEY"/>';
	var complaceValue =  '<s:property value="@com.tianque.core.util.NewBaseInfoTables@COMPANYPLACEKEY"/>';
	var houseValue =  '<s:property value="@com.tianque.core.util.NewBaseInfoTables@HOUSE_KEY"/>';
	resetForm();
	switch (moduleValue) {
	case peopleValue:
		//jQuery("#searchResultList").setGridParam().showCol("ope").showCol("name").showCol("idCardNo").trigger("reloadGrid");
		$("#jqgh_searchResultList_name").text("姓名");
		$("#jqgh_searchResultList_idCardNo").text("身份证号码");
		$("#peopleSelectDiv").show();
		$("#companyPlaceSelectDiv").hide();
		$("#houseSelectDiv").hide();
		break;
	case complaceValue:
		//jQuery("#searchResultList").setGridParam().hideCol("ope").hideCol("name").hideCol("idCardNo").trigger("reloadGrid");
		//$("#jqgh_searchResultList_ope").hide();
		$("#jqgh_searchResultList_name").text("单位场所名称");
		$("#jqgh_searchResultList_idCardNo").text("编号");
		$("#peopleSelectDiv").hide();
		$("#houseSelectDiv").hide();
		$("#companyPlaceSelectDiv").show();	
		$(".recover_div").hide();
		break;
	case houseValue:
		//jQuery("#searchResultList").setGridParam().hideCol("ope").hideCol("name").hideCol("idCardNo").trigger("reloadGrid");
		$("#jqgh_searchResultList_name").text("房屋名称");
		$("#jqgh_searchResultList_idCardNo").text("编号");
		$("#peopleSelectDiv").hide();
		$("#houseSelectDiv").show();
		$("#companyPlaceSelectDiv").hide();	
		$(".recover_div").hide();
		break;
	default:
		break;
	}

}

function resetForm(){
	$("#default_types").attr("checked","checked");
	$("#name").val("");
	$("#idCardNo").val("");
	$("#createDateStart").val("");
	$("#createDateEnd").val("");
	
}

function idCardNoFont(el,options,rowData){
	if(!el){return ""}
	if(rowData.isEmphasis==1||rowData.isEmphasis=='1'){
		return "<font color='#778899'>"+rowData.idCardNo+"</font>";
	}else{
		return "<font color='#000'>"+rowData.idCardNo+"</font>";
	}
}

function recoverPopulationInfo(id) {
	if(id == null) {
		$.messageBox({message:"请先选择一条需要恢复的数据!"});
		return;
	}
	$.confirm({
		title:"确认恢复",
		message:"确认恢复该数据的信息吗？",
		okFunc: function() {
			$.ajax({
				url:"${path}/sysadmin/recoverDatasManage/recoverDatasById.action?recoverDatasVo.id="+id,
				success:function(data){
					if(true != data) {
						$.messageBox({message:data,level:"error"});
						return;
					}
				    $.messageBox({message:"已经成功恢复该信息!"});
					$("#searchResultList").trigger("reloadGrid");
				},
				error:function(data){
					$.messageBox({message:data});
				}
			});
		}
	});
};

function deletePopulationInfo(id) {
	var str="确定要删除吗?一经删除将永久删除!";
	$.confirm({
		title:"确认删除",
		message:str,
		okFunc: function() {
			$.ajax({
				url:"${path}/sysadmin/recoverDatasManage/deleteRecoverDataByIds.action?ids="+id,
				success:function(data){
				    $.messageBox({message:"已经成功删除该信息!"});
					$("#searchResultList").trigger("reloadGrid");
				}
			});
		}
	});
	var evt = event || window.event;
	if (window.event) { 
	evt.cancelBubble=true; 
	} else { 
	evt.stopPropagation(); 
	} 
}

function operateFormatter(el, options, rowData){
	if($("#moduleNames").val() != 'CompanyPlace'){
		return "<span class='recover_div'><pop:JugePermissionTag ename='recoverDatas'><s:if test='"admin".equals(@com.tianque.core.util.ThreadVariable@getUser().getUserName())'><a href='javascript:recoverPopulationInfo("+rowData.id+")'><span>恢复</span></a> | </s:if></pop:JugePermissionTag><pop:JugePermissionTag ename='deleteRecoverDatas'><a href='javascript:;' onclick='deletePopulationInfo("+rowData.id+")'><span>删除</span></a></pop:JugePermissionTag></span>";
	}else{
		return "<span class='recover_div'><pop:JugePermissionTag ename='deleteRecoverDatas'><a href='javascript:;' onclick='deletePopulationInfo("+rowData.id+")'><span>删除</span></a></pop:JugePermissionTag></span>";
	}
}
function setTypeNames(){
	actualPopulationMap();
	moduleNameMap();
}
var moduleName="";
function moduleNameMap(){
	if(moduleName==""){
		moduleName = new Object()
		var obj = document.getElementById('moduleNames');
		var options = obj.options;
		for(var i=0,len=options.length;i<len;i++){
		    var opt = options[i];
		    moduleName[opt.value]=opt.text;
		}
	}
}
var populationName="";
function actualPopulationMap(){
	if(populationName==""){
		populationName = new Object()
		var obj = document.getElementById('populationNames');
		var options = obj.options;
		for(var i=0,len=options.length;i<len;i++){
		    var opt = options[i];
		    populationName[opt.value]=opt.text;
		}
	}
}

function actualPopulationName(el,options,rowData){
	return moduleName[el];
}
function populationTypeName(el,options,rowData){
	return populationName[el];
}

$(document).ready(function(){
	
	$('#createDateStart').datePicker({
		yearRange: '1900:2030',
		dateFormat:'yy-mm-dd',
        maxDate:'+0d',
        onSelect: function(dateText, inst) {
		if(dateText!=null&&dateText!=''){
			var dateUnit=dateText.split('-');
			var date=new Date(dateUnit[0],dateUnit[1]-1,dateUnit[2]);
			$("#createDateEnd").datepicker("option", "minDate",date);
			}
		}
	});
	$('#createDateEnd').datePicker({
        onSelect: function(dateText, inst) {
		if(dateText!=null&&dateText!=''){
			var dateUnit=dateText.split('-');
			var date=new Date(dateUnit[0],dateUnit[1]-1,dateUnit[2]);
			$("#createDateStart").datepicker("option", "maxDate",date);
			}
		}
	});

	$("#searchResultList").jqGridFunction({
		mtype:'post',
		//multiselect:true,
		datatype: "local",
		height:$(".ui-layout-center").height()-$("#commonPopulation").height()-130,
   		colModel:[
			{name:"sid",index:'sid',width:50,frozen:true,hidedlg:true,sortable:false,hidden:true,key:true},
			{name:"id", index:"id", hidden:true,frozen:true,sortable:false},
			{name:"ope",index:'sid',label:"操作",width:80,formatter:operateFormatter,align:"center",frozen:true,sortable:false},
			{name:"createDate",index:"createDate",label:"删除时间",width:140,sortable:true},
			{name:'organization.orgName',sortable:false,index:'organization.orgName',label:'所属网格',width:250},
			{name:"moduleType",index:"moduleType",label:"所属模块",width:120,sortable:true,formatter:actualPopulationName},
			{name:"businessType",index:"businessType",label:"所属类型",width:120,sortable:true,formatter:populationTypeName},
			{name:"name",index:"name",label:"姓名",frozen:true,width:120,sortable:true},
			{name:"idCardNo",index:"idCardNo", label:"身份证号码",frozen:true,formatter:idCardNoFont, width:150,sortable:true},
			{name:"createUser",index:"createUser", label:"操作账号", width:130}
		],
		ondblClickRow:function(data){
			//viewPopulationInfo();
		},
		loadComplete:moduleNameChange($("#moduleNames").val())

	});

	$("#advancedSearch").click(function(event){
		return false;
		if($("input[name='attentionPopulationTypes']:checked").size()==0&&$("input[name='actualPersonType']:checked").val()=='-1'){
			$.messageBox({level:'warn',message:"请至少选择一类人口进行高级查询"});
			return ;
		}
		$("#searchDialog").createDialog({
			width:650,
			height:550,
			title:'高级查询-请输入查询条件',
			url:'${path}/integrativeQuery/populationIntegrativeQuery/dispatchOperate.action',
			postData:$("#maintainForm").serializeArray(),
			buttons: {
		   		"查询" : function(event){
				$("#populationQueryFrom").submit();
		        	$(this).dialog("close");
	   			},
		   		"关闭" : function(){
		        	$(this).dialog("close");
		   		}
			}
		});
	});
	$("#maintainForm").formValidate({
		submitHandler: function(form) {
			search();
		},
		rules:{},
		messages:{},
		ignore:':hidden'
	});
	$("#search").click(function(){
		setTypeNames();
		$("#maintainForm").submit();
	});
	function search(){
		setTypeNames();
		$("#searchResultList").setGridParam({
			url:"${path}/sysadmin/recoverDatasManage/fastSearch.action",
			mtype:"post",
			datatype: "json",
			page:1
		});
		var commJson= maintainFormData();
		if($("input[name='attentionPopulationTypes']:checked").size()==0||$("input[name='attentionPopulationTypes']:checked").val()=='-1'){
		}else{
			commJson = ($.extend({"recoverDatasVo.businessType":$("input[name='attentionPopulationTypes']:checked").val()},commJson))
		}
		$("#searchResultList").setPostData($.extend({"recoverDatasVo.organization.id":$("#currOrgId").val()},commJson));
		$("#searchResultList").trigger("reloadGrid");
	}

	$("#recoverData").click(function(event){
		if($("#searchResultList").getGridParam("records")>0){
			var postData = $("#searchResultList").getPostData();

			$("#searchResultList").setPostData(postData);

			$("#searchDialog").createDialog({
				width: 250,
				height: 200,
				title:"导出人口信息",
				url:'/common/exportExcel.jsp',
				postData:{
					gridName:'searchResultList',
					downloadUrl:'${path}/integrativeQuery/populationIntegrativeQuery/downloadQueryPopulation.action'
				},
				buttons: {
		   			"导出" : function(event){
		   				exceldownloadSubmitForm()
		        		$(this).dialog("close");
	   				},
		   			"关闭" : function(){
		        		$(this).dialog("close");
		   			}
				},
				shouldEmptyHtml:false
			});
		}else{
			$.messageBox({level:'warn', message:'没有数据可以导出!'});
			return;
		}
	});


	function maintainFormData(){
		return serializeObjectNew("maintainForm");
	}


	function serializeObjectNew(id){

		 var o = {};
		    var a = $("#"+id+"").serializeArray();
		    $.each(a, function() {
		        if (o[this.name]) {
		            if (!o[this.name].push) {
		                o[this.name] = [ o[this.name] ];
		            }
		            o[this.name]=o[this.name]+","+this.value;
		        } else {
		            o[this.name] = this.value || '';
		        }
		    });
		    return o;
	}

	jQuery.validator.addMethod("endBigThanStart", function(value, element){
		var flag = true;

		var start = $("#birthdayStrart").val();
		var end = $("#birthdayEnd").val();

		if(end!=null&&start!=null&&start!=-1&&end!=-1){
			if(end-start<0){
				flag = false;
				}
		}

		return flag;
	});


});


</script>