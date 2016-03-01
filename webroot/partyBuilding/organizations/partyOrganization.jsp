<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/PopGrid-taglib" prefix="pop"%>
<%@ include file="/includes/baseInclude.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<form id="editOrganizationform" method="post" action="${path}/baseinfo/partyOrgInfoManage/addPartyOrgInfo.action">
	<input type="hidden" name="orgId" class="form-txt" id="orgId" value="${orgId}" />
	<input type="hidden" class="form-txt" name="partyOrgInfo.id" id="partyOrgInfoId" value="${partyOrgInfo.id}" />
 	<table class="tablelist">
 		<tbody>
 			<tr>
 				<td colspan="6"><div class="table_head"><b class="ui-widget-color">党组织信息</b><a href="javascript:void(0)" id="saveOrganization" class="exitBtn">保存</a><a href="javascript:void(0)" id="editOrganization" class="exitBtn">编辑</a></div></td>
 			</tr>
 			<tr>
	 			<td class="title"><em class="form-req">*</em>所属区域</td>
	 			<td class="t_ctt"><div class="grid_24"><input type="text"  id="commonPopulationOrgName"  name="partyOrgInfo.organization.orgName"  disabled="disabled" value="${partyOrgInfo.organization.orgName}" class="form-txt" /></div></td>
	 			<td class="title"><em class="form-req">*</em>党组织名称</td> 			
	 			<td class="t_ctt"><div class="grid_24"><input type="text" name="partyOrgInfo.partyBranchName" id="partyBranchName" disabled="disabled"  class="form-txt" value="${partyOrgInfo.partyBranchName}" maxlength="50" /></div></td>
	 			<td class="title"><em class="form-req">*</em>党支部成立时间</td>
	 			<td class="t_ctt">
	 			<div class="grid_24">
	 			<input type="text" name="partyOrgInfo.establishedDate" id="establishedDate" disabled="disabled" readonly="readonly" maxlength="50"  value="<fmt:formatDate value="${partyOrgInfo.establishedDate}" type="date" pattern="yyyy-MM-dd" />" class="form-txt" />
	 			</div></td>
 			</tr>
 			<tr>
 				<td class="title"><em class="form-req">*</em>党支部书记</td>
	 			<td class="t_ctt"><div class="grid_24"><input type="text" name="partyOrgInfo.partyBranchSecretary" id="partyBranchSecretary" disabled="disabled"  class="form-txt" value="${partyOrgInfo.partyBranchSecretary}" maxlength="20"/></div></td>
	 			<td class="title">身份证号码</td>
	 			<td class="t_ctt"><div class="grid_24"><input type="text" name="partyOrgInfo.idCardNo" id="partyIdCardNo" disabled="disabled" maxlength="18" value="${partyOrgInfo.idCardNo}" title="请输入15或18位由数字或字母X组成的身份证号码"  class="  form-txt" /></div></td>
	 			<td class="title">联系手机</td>
	 			<td class="t_ctt"><div class="grid_24"><input type="text" name="partyOrgInfo.mobileNumber" id="mobileNumber" disabled="disabled" maxlength="11" value="${partyOrgInfo.mobileNumber}" title="请输入11位以1开头的联系手机  例如：13988888888" class="form-txt" /></div></td>
 			</tr>
 			<tr>
	 			<td class="title">联系电话</td>
	 			<td class="t_ctt"><div class="grid_24"><input type="text" name="partyOrgInfo.telephone" id="telephone" disabled="disabled" maxlength="20"  value="${partyOrgInfo.telephone}" title="请输入由数字和-组成的联系电话,例如：0577-88888888" class=" form-txt" /></div></td>
	 			<td class="title">区域党委成员数</td>
	 			<td class="t_ctt"><div class="grid_24"><input type="text" name="partyOrgInfo.partyNumbers" id="partyNumbers" disabled="disabled" class="form-txt" value="${partyOrgInfo.partyNumbers}" maxlength="9" /></div></td>
	 			<td class="title">党组织地址</td>
	 			<td class="t_ctt"><div class="grid_24"><input type="text" name="partyOrgInfo.partyBranchAddr" id="partyBranchAddr"  disabled="disabled" class="form-txt" value="${partyOrgInfo.partyBranchAddr}" maxlength="50"  /></div></td>
 			</tr>
 		</tbody>
 	</table>
	<input name="isSubmit" id="isSubmit" type="hidden" value="">
</form>
<script type="text/javascript">
$(document).ready(function(){
	$("#saveOrganization").hide();
	$("#orgId").val(getCurrentOrgId());
	$("#saveOrganization").click(function() {
		$("#editOrganizationform").submit();
	});
	onOrgChangedPartyOrgInfo($("#orgId").val());
	$("#editOrganizationform").formValidate({
		submitHandler: function(form){
			$(form).ajaxSubmit({
				success:function(data){
					if(!data.id){
           	 			$.messageBox({
							evel: "error",
							message:data
			 			});
            			return;
					}
	                $.messageBox({message:"保存党组织信息成功！"});
	                loadData(data);
	                $("#editPartyOrgDialog").dialog("close");
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
  	      			alert("提交数据时发生错误");
	   		    }
			});
		},
		rules:{
			"partyOrgInfo.partyBranchName":{
				required:true,
				exculdeParticalChar:true,
				minlength:2,
				maxlength:50
			},
			"partyOrgInfo.partyBranchSecretary":{
				required:true,
				exculdeParticalChar:true,
				minlength:2,
				maxlength:20
			},
			"partyOrgInfo.establishedDate":{
				required:true
			},
			"partyOrgInfo.idCardNo":{
				idCard:true
			},
			"partyOrgInfo.mobileNumber":{
				mobile:true
			},
			"partyOrgInfo.telephone":{
				telephone:true
			},
			"partyOrgInfo.partyNumbers":{
				positiveInteger:true
			},
			"partyOrgInfo.partyBranchAddr":{
				minlength:2,
				maxlength:50
			}
		},
		messages:{
			"partyOrgInfo.partyBranchName":{
				required:"请先输入党支部名称!",
				exculdeParticalChar:"不能输入非法字符",
				minlength:$.format("党支部名称至少需要输入{0}个字符"),
				maxlength:$.format("党支部名称最多需要输入{0}个字符")
			},
			"partyOrgInfo.partyBranchSecretary":{
				required:"请先输入党支部书记!",
				exculdeParticalChar:"不能输入非法字符",
				minlength:$.format("党支部书记名称至少需要输入{0}个字符"),
				maxlength:$.format("党支部书记名称最多需要输入{0}个字符")
			},
			"partyOrgInfo.establishedDate":{
				required:"请先输入党支部成立时间!"
			},
			"partyOrgInfo.idCardNo":{
				idCard:$.format("请输入一个合法的身份证号码")
			},
			"partyOrgInfo.mobileNumber":{
				mobile:"手机号码输入只能是以1开头的11位数字"
			},
			"partyOrgInfo.telephone":{
				telephone:$.format("固定电话不合法，只能输数字和横杠(-)")
			},
			"partyOrgInfo.partyNumbers":{
				positiveInteger:"党员人数为正整数"
			},
			"partyOrgInfo.partyBranchAddr":{
				minlength:$.format("党组织地址至少需要输入{0}个字符"),
				maxlength:$.format("党组织地址最多需要输入{0}个字符")
			}
		}
	});

	$('#editOrganization').click(function(){
		changeAllElementEnabled();
	});
	
	$('#establishedDate').datePicker({
		yearRange:'1900:2030',
		dateFormat:'yy-mm-dd',
    	maxDate:'+0d',
       	onSelect:function(dateText, inst) {
			if(dateText!=null&&dateText!=''){
				var dateUnit=dateText.split('-');
				var date=new Date(dateUnit[0],dateUnit[1]-1,dateUnit[2]);
				//$("#establishedDate").datepicker("option", "minDate",date);
			}
		}
	});
});

function changeAllElementEnabled(){
	$("#editOrganization").hide();
	$("#saveOrganization").show();
	$(".tablelist input").each(function(index){
		if($(this).attr("id")!='commonPopulationOrgName')
			$(this).attr("disabled",false);
	});
} 

function changeAllElementUnEnabled(){
	$("#saveOrganization").hide();
	$("#editOrganization").show();
	$(".tablelist input").each(function(index){
			$(this).attr("disabled",true);
	});
} 
function onOrgChangedPartyOrgInfo(orgId){
	$.ajax({
		url:"${path}/baseinfo/partyOrgInfoManage/searchPartyOrgInfoById.action?orgId="+orgId,
		async : false,
		success:function(data){
			if(data){
				$.each(data, function(key, value) {
					if(null != value) {
						$("input[name='partyOrgInfo."+key+"']").val(value);
					} else {
						$("input[name='partyOrgInfo."+key+"']").val("");
					}
				});
			}
			$("#commonPopulationOrgName").val(data.organization.orgName);
		}
	});
	if(getCurrentOrgId() != USER_ORG_ID) {
		$("#editOrganization").hide();
		return;
	} else {
		$("#editOrganization").show();
	}
}

function loadData(data) {
	$("#partyOrgInfoId").val(data.id);
	$("#partyBranchName").val(data.partyBranchName);
	$("#establishedDate").val(data.establishedDate);
	$("#partyBranchSecretary").val(data.partyBranchSecretary);
	$("#partyIdCardNo").val(data.idCardNo==null ? "" :data.idCardNo);
	$("#mobileNumber").val(data.mobileNumber==null ? "" : data.mobileNumber);
	$("#telephone").val(data.telephone==null ? "" :data.telephone);
	$("#partyNumbers").val(data.partyNumbers==null ? "" :data.partyNumbers);
	$("#partyBranchAddr").val(data.partyBranchAddr==null ? "" : data.partyBranchAddr);
	var selectedIndex=0;
	$("#regionalTabList>ul>li").each(function(index){
		if(index==0){
			//$(this).find("a").attr("href","${path}/partyBuilding/members/memberForTownList.jsp?partyOrgType=<s:property value='@com.tianque.partyBuilding.members.constant.MemberType@REGION_PARTY_ORG'/>"+"&partyOrg="+$("#partyBranchName").val()+"&partyModule=regionalParty");
			$(this).find("a").attr("href","${path}/partyBuilding/organizations/regionalPartyMemberManage/regionalPartyMemberList.jsp?partyOrg="+$("#partyBranchName").val());
		}else if(index==1){
			$(this).find("a").attr("href","${path}/partyBuilding/activityRecords/activityRecordsList.jsp?partyOrganizationType=<s:property value='@com.tianque.partyBuilding.activityRecords.constant.OrganizationType@PARTY_ORGANIZATION'/>&orgId="+
					getCurrentOrgId()+"&partyOrganizationId="+$("#partyOrgInfoId").val()+"&partyOrganizationName="+$("#partyBranchName").val()+"&partyModule=regionalParty");
		}
		if($(this).attr("aria-selected")=="true"){
			selectedIndex=index;
		}	
	});
	$("#regionalTabList").tabs('load', selectedIndex) ; 
	
	changeAllElementUnEnabled();
}

</script>