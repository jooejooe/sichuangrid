<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/PopGrid-taglib" prefix="pop" %>
<%@ include file="/includes/baseInclude.jsp"%>
<jsp:include page="/baseinfo/commonPopulation/jsFunctionInclude.jsp">
	<jsp:param value="FloatingPopulation" name="moduleName"/>
</jsp:include>
<div class="content" >
	<div class="ui-corner-all contentNav" id="nav">
		<div class="btnbanner btnbannerData">
			<jsp:include page="/common/orgSelectedComponent.jsp"/>
            
			<div class="ui-widget autosearch">
				<input class="basic-input" type="text" value="请输入姓名或身份证号码" id="searchByCondition" maxlength="18" class="searchtxt" onblur="value=(this.value=='')?'请输入姓名或身份证号码':this.value;" onfocus="value=(this.value=='请输入姓名或身份证号码')?'':this.value;"/>
            	<button id="refreshSearchKey" class="ui-icon ui-icon-refresh searchbtnico"></button>
            </div>
		</div>
		<a href="javascript:;" id="fastSearchButton"><span>搜索</span></a>
		<pop:JugePermissionTag ename="searchFloatingPopulation">
			<a id="search" href="javascript:;" class="advancedSearchButton"><span>高级搜索</span></a>
		</pop:JugePermissionTag>
        <span class="lineBetween "></span>

		<pop:JugePermissionTag ename="addFloatingPopulation">
			<a id="add" href="javascript:;"><span>新增</span></a>
		</pop:JugePermissionTag>
		<pop:JugePermissionTag ename="deleteFloatingPopulation">
			<a id="delete"  href="javascript:;"><span>批量删除</span></a>
		</pop:JugePermissionTag>
		
		<pop:JugePermissionTag ename="importFloatingPopulation,downFloatingPopulation">
			<a href="javascript:;" class="nav-dropdownBtn"><span>导入|导出</span><b class="nav-dropdownBtn-arr"><b class="nav-ico-dArr"></b></b></a>
		</pop:JugePermissionTag>
		
		<div class="nav-sub-buttons">
			<pop:JugePermissionTag ename="importFloatingPopulation">
				<a id="import" href="javascript:;"><span>Excel导入</span></a>
			</pop:JugePermissionTag>
			<pop:JugePermissionTag ename="downFloatingPopulation">
				<a id="export" href="javascript:;"><span>导出Excel</span></a>
	   		</pop:JugePermissionTag>
		</div>
		<pop:JugePermissionTag ename="isLogOutFloatingPopulation,cancelLogOutFloatingPopulation,cancelDeathFloatingPopulation">
		<a href="javascript:;" class="nav-dropdownBtn"><span>设置状态</span><b class="nav-dropdownBtn-arr"><b class="nav-ico-dArr"></b></b></a>
		</pop:JugePermissionTag>
		<div class="nav-sub-buttons">
	   		<pop:JugePermissionTag ename="isLogOutFloatingPopulation">
	   			<a id="isLogOut" href="javascript:;"><span>注销</span></a>
	   		</pop:JugePermissionTag>
	   		<pop:JugePermissionTag ename="cancelLogOutFloatingPopulation">
	   			<a id="cancelLogOut" href="javascript:;"><span>取消注销</span></a>
	   		</pop:JugePermissionTag>
			<pop:JugePermissionTag ename="cancelDeathFloatingPopulation">
	   			<a id="cancelDeath" href="javascript:;"><span>取消死亡</span></a>
	   		</pop:JugePermissionTag>
	   	</div>
	   	
	   	<a id="reload" href="javascript:;"><span>刷新</span></a>
	   	<pop:JugePermissionTag ename="toHouseholdStaff">
   			<a id="toHouseholdStaff" href="javascript:void(0)"><span>转为户籍人口</span></a>
   		</pop:JugePermissionTag>
	   	
	   	<pop:JugePermissionTag ename="transferFloatingPopulation">
	   	 	<a id="transfer"  href="javascript:void(0)"><span>转移</span></a> 
   	 	</pop:JugePermissionTag> 	
	   	<s:if test="@com.tianque.core.util.ThreadVariable@getUser().getUserName().equals('longzhendong')||
		   @com.tianque.core.util.ThreadVariable@getUser().getUserName().equals('admin')">
			<a id="updateIdCardNo" href="javascript:void(0)"><span>修改身份证号码</span></a>
		</s:if>		
	</div>

	<div style="clear: both;"></div>
	<div style="width:100%;" class="click_load">
		<a href="javascript:;" class="click_btn">点击加载数据</a>
		<table id="floatingPopulationList"> </table>
		<div id="floatingPopulationListPager"></div>
	</div>
	<div id="floatingPopulationDialog"></div>
	<div id="helpPersonnelDialog"></div>
	<div id="helpPrecordDialog"></div>
	<div id="scanHeaderImage"></div>
	<div id="toHouseholdStaffDialog"></div>
</div>

<div style="display: none;">
	<pop:JugePermissionTag ename="floatingPopulationManagement">
		<span id="title"><s:property value="#request.name"/></span>
	</pop:JugePermissionTag>
</div>
<script type="text/javascript">
<pop:formatterProperty name="gender" domainName="@com.tianque.domain.property.PropertyTypes@GENDER" />
<pop:formatterProperty name="inflowingReason" domainName="@com.tianque.domain.property.PropertyTypes@INFLOWING_REASON" />
<pop:formatterProperty name="registrationType" domainName="@com.tianque.domain.property.PropertyTypes@REGISTRATIONTYPE" />
<pop:formatterProperty name="career" domainName="@com.tianque.domain.property.PropertyTypes@CAREER" />
<pop:formatterProperty name="politicalBackground" domainName="@com.tianque.domain.property.PropertyTypes@POLITICAL_BACKGROUND" />
<pop:formatterProperty name="maritalState" domainName="@com.tianque.domain.property.PropertyTypes@MARITAL_STATUS" />
<pop:formatterProperty name="faith" domainName="@com.tianque.domain.property.PropertyTypes@FAITH" />
<pop:formatterProperty name="residenceType" domainName="@com.tianque.domain.property.PropertyTypes@RESIDENCE_TYPE" />
<pop:formatterProperty name="schooling" domainName="@com.tianque.domain.property.PropertyTypes@SCHOOLING" />
<pop:formatterProperty name="healthState" domainName="@com.tianque.domain.property.PropertyTypes@HEALTH_STATE" />
<pop:formatterProperty name="bloodType" domainName="@com.tianque.domain.property.PropertyTypes@BLOOD_TYPE" />
<pop:formatterProperty name="nation" domainName="@com.tianque.domain.property.PropertyTypes@NATION" />

var token = "<s:property value='@com.tianque.core.util.CreateTokenUtil@getToken()'/>";
var title=$("#title").html();
var notExecute=new Array();
var dialogWidth=800;
var dialogHeight=600;
function onOrgChanged(orgId, isgrid){
	var initParam = {
		"organizationId": orgId,
		"searchFloatingPopulationVo.logOut":0,
		"searchFloatingPopulationVo.isDeath":false
	}
	$("#floatingPopulationList").setGridParam({
		url:'${path}/baseinfo/floatingPopulationManage/findFloatingPopulationsDefaultList.action',
		datatype:'json',
		page:1
	});
	$("#floatingPopulationList").setPostData(initParam);
	$("#floatingPopulationList").trigger("reloadGrid");
}
function updateOperator(event,selectedId){
	var ent =  $("#floatingPopulationList").getRowData(selectedId);
	if(ent.logOut==1||ent.logOut=='1'){
		 $.messageBox({level:'warn',message:"该"+title+"信息已经注销，不能修改!"});
		 return;
	}
	$("#floatingPopulationDialog").createTabDialog({
		width: dialogWidth,
		height: dialogHeight,
		title:"修改流动人口",
		postData:{
			id : ent.encryptId,
			mode:'edit',
			imageType:"population",
			type:"floatingPopulation"
		},
		tabs:[
			{title:'基本信息',url:'/baseinfo/floatingPopulationManage/dispathByEncrypt.action?mode=edit&dailogName=floatingPopulationDialog&population.id='+ent.encryptId},
			//{title:'住房信息',url:'/baseinfo/houseInfoForPopulation/dispathHouseInfoForPopulation.action?dailogName=floatingPopulationDialog'},
// 			{title:'流入信息',url:'/baseinfo/floatingPopulationManage/dispathInflowingInfomation.action?mode=edit&dailogName=floatingPopulationDialog'}
			<pop:JugePermissionTag ename="groupFamilyInfo">
			,{title:'家庭信息',url:'/baseinfo/familyInfo/getGroupFamilyByPopulationId.action?mode=edit&dailogName=floatingPopulationDialog&populationType=<s:property value="@com.tianque.service.util.PopulationType@FLOATING_POPULATION"/>'}	
			</pop:JugePermissionTag>
			/**
			<pop:GlobalSettingTag key="@com.tianque.core.globalSetting.util.GlobalSetting@CAN_MAINTAIN_BUSINESS_POPULATION" value="true">
			,{title:'业务信息',url:'/baseinfo/commonPopulation/populationSpecializedInfo.jsp?mode=edit&dailogName=floatingPopulationDialog&populationType=<s:property value="@com.tianque.service.util.PopulationType@FLOATING_POPULATION"/>'}
			</pop:GlobalSettingTag>
			*/
		],
		close : function(){
			$("#floatingPopulationList").trigger("reloadGrid");
		}
	});
	var evt = event || window.event;
	if(typeof evt!="object"){return false;}
	if (window.event) { 
	evt.cancelBubble=true; 
	} else { 
	evt.stopPropagation(); 
	} 
}

function deleteOperator(event,allValue){
	var encryptIds = deleteOperatorByEncrypt("floatingPopulation",allValue,"encryptId");
	$.confirm({
		title:"确认删除",
		message:"确定要删除吗?一经删除将无法恢复",
		okFunc: function(){
			$.ajax({
				async:false,
				url:PATH+"/baseinfo/floatingPopulationManage/getActualPopulationHasTypes.action",
				type:"post",
				data:{
					"population.id":encryptIds
				},
				success:function(data){
					if(data == true){
						$.confirm({
							title:"确认删除",
							message:"有关联数据，是否确认删除？",
							okFunc: function() {
								deletePopulationById(allValue);
							}
						});
					}else{
						deletePopulationById(allValue);
					}
				}
			});
	   }
 	});
	var evt = event || window.event;
	if(typeof evt!="object"){return false;}
	if (window.event) { 
	evt.cancelBubble=true; 
	} else { 
	evt.stopPropagation(); 
	} 
}

function deletePopulationById(allValue){
	var encryptIds = deleteOperatorByEncrypt("floatingPopulation",allValue,"encryptId");
	$.dialogLoading("open");
	$.ajax({
		url:PATH+"/baseinfo/floatingPopulationManage/deleteFloatingPopulation.action",
		type:"post",
		data:{
			"struts.token":token,
			"floatingPopulationIds":encryptIds
		},
		success:function(data){
			$.dialogLoading("close");
			if(data!=null&&data!=true&&data!='true'){
				  $.messageBox({message:data,level:"error"});
				  return;
			}
			try{for(var ids=0;ids<allValue.toString().split(',').length;ids++){
				$("#floatingPopulationList").delRowData(allValue.toString().split(',')[ids]);
			}}catch(e){}
			$("#floatingPopulationList").trigger("reloadGrid");
		    $.messageBox({message:"已经成功删除该"+title+"信息!"});
		    disableButtons();
			checkExport();
	    }
    });
}

function printChoose(rowid){
	$("#printOptionsDialog").createDialog({
		width: 300,
		height: 200,
		title:'选择打印内容',
		modal : true,
		url:PATH+'/baseinfo/commonPopulation/printTabChooseDlg.jsp',
		buttons: {
			"确定" : function(){
				print(rowid);
	            //$("#printOptionsDialog").dialog("close");
	   		},
		   "关闭" : function(){	
		        $(this).dialog("close");
		   }
		}
	});
}

var printTitleStr='';
function print(rowid){
	printTitleStr=title;
	if(rowid==null){
 		return;
	}
	var floatingPopulation =  $("#floatingPopulationList").getRowData(rowid);
	$("#floatingPopulationDialog").createDialog({
		width: dialogWidth,
		height: dialogHeight,
		title:'打印'+title+'信息',
		modal : true,
		url:PATH+'/baseinfo/floatingPopulationManage/dispathByEncrypt.action?mode=print&id='+floatingPopulation.encryptId,
		buttons: {
			  "打印" : function(){
				$("#printSpaceDiv").printArea();
	        	$(this).dialog("close");
	   		},
		   "关闭" : function(){
		        $(this).dialog("close");
		   }
		}
	});
}
function viewDialog(event,rowid){
	if(null == rowid){
 		return;
	}
	var floatingPopulation =  $("#floatingPopulationList").getRowData(rowid);
	$("#floatingPopulationDialog").createDialog({
		width: dialogWidth,
		height: dialogHeight,
		title:'查看'+title+'信息',
		modal : true,
		url:PATH+'/baseinfo/floatingPopulationManage/dispathByEncrypt.action?mode=view&id='+floatingPopulation.encryptId,
		buttons: {
		   "打印" : function(){
				printChoose(floatingPopulation.id);
	  	   	},
		   "关闭" : function(){
		        $(this).dialog("close");
		   }
		}
	});
	var evt = event || window.event;
	if(typeof evt!="object"){return false;}
	if (window.event) { 
	evt.cancelBubble=true; 
	} else { 
	evt.stopPropagation(); 
	} 
}
function checkExport(){
}
function disableButtons(){
}

function callback(){
    var dfop = {
       	moduleCName: '${moduleCName}',
       	hasViewFloatingPopulation: '<pop:JugePermissionTag ename="viewFloatingPopulation">true</pop:JugePermissionTag>',
       	templates: '<s:property value="@com.tianque.datatransfer.ImportTemplatesSetting@FLOATINGPOPULATION_KEY"/>',
       	actualPopulationType: '<s:property value="@com.tianque.service.util.PopulationType@FLOATING_POPULATION" />',
    	tabs:[
   				{title:'基本信息',url:'/baseinfo/floatingPopulationManage/dispath.action?mode=add&dailogName=floatingPopulationDialog'},
				//{title:'住房信息',url:'/baseinfo/houseInfoForPopulation/dispathHouseInfoForPopulation.action?dailogName=floatingPopulationDialog'},
// 				{title:'流入信息',url:'/baseinfo/floatingPopulationManage/dispathInflowingInfomation.action?mode=add&dailogName=floatingPopulationDialog'}
				<pop:JugePermissionTag ename="groupFamilyInfo">
				,{title:'家庭信息',url:'/baseinfo/familyInfo/getGroupFamilyByPopulationId.action?mode=add&dailogName=floatingPopulationDialog&populationType=<s:property value="@com.tianque.service.util.PopulationType@FLOATING_POPULATION"/>'}
				</pop:JugePermissionTag>
				<pop:GlobalSettingTag key="@com.tianque.core.globalSetting.util.GlobalSetting@CAN_MAINTAIN_BUSINESS_POPULATION" value="true">
				,{title:'业务信息',url:'/baseinfo/commonPopulation/populationSpecializedInfo.jsp?mode=add&dailogName=floatingPopulationDialog&populationType=<s:property value="@com.tianque.service.util.PopulationType@FLOATING_POPULATION"/>'}
				</pop:GlobalSettingTag>
   			]
    }
    TQ.floatingPopulationList(dfop)
}
$.cacheScript({
	url:'/resource/getScript/baseinfo/floatingPopulation/floatingPopulationList.js',
	callback: callback
})
</script>