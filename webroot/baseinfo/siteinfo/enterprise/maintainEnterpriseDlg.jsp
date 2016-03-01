<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pop" uri="/PopGrid-taglib"%>
<%@ include file="/includes/baseInclude.jsp"%>
		<div id="enterpriseInfo" class="container container_24">
			<form name="maintainForm" id="maintainForm" method="post" action="">
			<s:if test='"add".equals(mode)'>
				<pop:token/>
			</s:if>
			<div id="perUuid"></div>
			<input id="modeType" type="hidden" name="modeType" value="${modeType}" />
			<input id="mode" type="hidden" name="mode" value="${mode}" />
			<input id="organizationId" type="hidden" name="ownerOrg.id" value="${ownerOrg.id}" />
			<input id="enterpriseId" type="hidden" name="enterprise.id" value="${enterprise.id}" />
			<input id="_imgUrl" type="hidden" name="enterprise.imgUrl" value="${enterprise.imgUrl}"/>
			<input id="keyType" type="hidden" class="keyType" name="enterprise.keyType" value="${keyType}" />
			<input id="placeTypeName" type="hidden" name="placeTypeName" value="${placeTypeName}">
			<input name="isSubmit" id="isSubmit" type="hidden" value="">
			<div class="grid_4 lable-right">
			<s:if test='!"view".equals(mode)'><em class="form-req">*</em></s:if>
				<label class="form-lbl">所属网格：</label>
			</div>
			<div class="grid_19">
		    	<input type="text" name="orgName" id="orgName" value="" readonly
		    	<s:if test='"view".equals(mode)'>disabled='true'</s:if> class="form-txt" style="width: 99%" />
			</div>
			<div class="grid_1"></div>
			<div class='clearLine'>&nbsp;</div>

			<div class="grid_4 lable-right">
			<s:if test='!"view".equals(mode)'>
					<em class="form-req">*</em>
				</s:if>
				<label class="form-lbl">企业名称：</label>
			</div>
			<div class="grid_19">
				<input type="text" name="enterprise.name" id="name"
					value="${enterprise.name}" maxlength="50"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					class="form-txt {required:true,exculdeParticalChar:true,exsistedCompanyName:true,messages:{required:'请输入企业名称',exculdeParticalChar:'不能输入非法字符',exsistedCompanyName:'企业名称在该网格下已经存在，请重新输入'}}" style="width: 99%" />
			</div>
			<div class="grid_1"></div>
			<div class='clearLine'>&nbsp;</div>
			
			<div class="grid_4 lable-right">
			<s:if test='!"view".equals(mode)'>
					<em class="form-req">*</em>
				</s:if>
				<label class="form-lbl">企业地址： </label>
			</div>
			<div class="grid_19">
				<input type="text" name="enterprise.address" id="enterprise-address"
					value="${enterprise.address }" maxlength="50"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					class="form-txt" style="width: 99%" />
			</div>
			<div class="grid_1"></div>
			<div class='clearLine'>&nbsp;</div>
			
			<div class="grid_4 lable-right">
			<s:if test='!"view".equals(mode)'>
					<em class="form-req">*</em>
				</s:if>
				<label class="form-lbl">法人代表：</label>
			</div>
			<div class="grid_7">
				<input type="text" name="enterprise.legalPerson" class="form-txt" id="enterprise-legalPerson"
					value="${enterprise.legalPerson }" maxlength="20"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if> />
			</div>
			<div class="grid_1"></div>
			<s:if test="'safetyProductionKey'.equals(keyType) ">
				<div class="grid_4 lable-right">
				<s:if test='!"view".equals(mode)'>
						<em class="form-req">*</em>
					</s:if>
					<label class="form-lbl">企业类型： </label>
				</div>
				<div class="grid_7">
					<select name="enterprise.type.id" class="form-txt dialogtip" id="enterprise-type-id"
						title="规上企业：注册资金500万以上，企业职工人数超过200人的企业。规下企业：注册资金500万以下，企业职工人数少于200人的企业。"
						<s:if test='"view".equals(mode)'>disabled='true'</s:if>>
						<pop:OptionTag
							name="@com.tianque.domain.property.PropertyTypes@ENTERPRISE_TYPE"
							defaultValue="${enterprise.type.id}" />
					</select>
				</div>
			</s:if>	
			<div class='clearLine'>&nbsp;</div>

			<div class="grid_4 lable-right">
				<label class="form-lbl">关注程度：</label>
			</div>
			<div class="grid_7">
				<select name="enterprise.attentionExtent.id" id="enterprise-attentionExtent" class="form-txt"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if> >
					<pop:OptionTag name="@com.tianque.domain.property.PropertyTypes@ATTENTION_EXTENT" defaultValue="${enterprise.attentionExtent.id}" />
				</select>
			</div>
			<div class="grid_5 lable-right">
				<label class="form-lbl">注册资金：</label>
			</div>
			<div class="grid_5">
				<input type="text" name="enterprise.registeredCapital" id="enterprise-registeredCapital"
					maxlength="11" class="form-txt"
					value="${enterprise.registeredCapital }"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if> />
			</div>
			<div class="grid_2 lable-right" >
				<label class="form-lbl">(万元)</label>
			</div>
			<div class='clearLine'>&nbsp;</div>
			<div class="grid_4 lable-right">
				<label class="form-lbl">所属行业：</label>
			</div>
			<div class="grid_7">
				<select name="enterprise.industry.id" class="form-txt" id="enterprise-industry-id"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>>
					<pop:OptionTag
						name="@com.tianque.domain.property.PropertyTypes@BUSINESSTYPE"
						defaultValue="${enterprise.industry.id}" />
				</select>
			</div>

			<div class="grid_5 lable-right">
				<label class="form-lbl">面积：</label>
			</div>
			<div class="grid_6 heightAuto">
				<input type="text" name="enterprise.area" maxlength="11" id="enterprise-area"
					class="form-txt" <s:if test='"view".equals(mode)'>disabled='true'</s:if>value="${enterprise.areaString}" />
			</div>
			<div class="grid_1 lable-right">
				<font size="1">M</font><font size="1"><sup>2</sup></font>
			</div>
			<div class='clearLine'>&nbsp;</div>
			<div class="grid_4 lable-right">
				<label class="form-lbl">员工数：</label>
			</div>
			<div class="grid_7">
				<input type="text" name="enterprise.employeeAmount" id="employeeAmount"
					value="${enterprise.employeeAmount }" maxlength="9"
					class="form-txt"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if> />
			</div>
			<div class="grid_5 lable-right">
				<label class="form-lbl">党员数：</label>
			</div>
			<div class="grid_7">
				<input type="text" name="enterprise.partyMemberAmount" id="partyMemberAmount"
					value="${enterprise.partyMemberAmount}" maxlength="9"
					class="form-txt"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if> />
			</div>
			<div class='clearLine'>&nbsp;</div>

			<div class="grid_4 lable-right">
				<label class="form-lbl">企业联系电话：</label>
			</div>
			<div class="grid_7">
				<input type="text" name="enterprise.enterpriseTelephone" id="enterprise-enterpriseTelephone"
					value="${enterprise.enterpriseTelephone }" maxlength="15"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					class="form-txt  dialogtip"
					title="请输入由数字和-组成的联系电话!例如：0577-88888888" />
			</div>
			<div class="grid_5 lable-right">
				<label class="form-lbl">企业传真号码：</label>
			</div>
			<div class="grid_7">
				<input type="text" name="enterprise.fax" value="${enterprise.fax }" id="enterprise-fax"
					maxlength="15" class="form-txt dialogtip"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					title="请输入由数字和-组成的传真号码!例如：0577-88888888" />
			</div>
			<div class='clearLine'>&nbsp;</div>

			<div class="grid_4 lable-right">
				<label class="form-lbl">法人联系电话：</label>
			</div>
			<div class="grid_7">
				<input type="text" name="enterprise.telephone" maxlength="15" id="enterprise-telephone"
					value="${enterprise.telephone }" class="form-txt  dialogtip"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					title="请输入由数字和-组成的联系电话!例如：0577-88888888" />
			</div>
			<div class="grid_5 lable-right">
				<label class="form-lbl">法人手机号码：</label>
			</div>
			<div class="grid_7">
				<input type="text" name="enterprise.mobileNumber"
					value="${enterprise.mobileNumber }" maxlength="11" id="enterprise-mobileNumber"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					class="form-txt  dialogtip" title="请输入11位以1开头的手机号码!例如:13988888888" />
			</div>
			<div class='clearLine'>&nbsp;</div>

			<div class="grid_4"></div>
			<div class="grid_7">
				<input id="isRiskEnterprise" type="checkbox"
					name="enterprise.riskEnterprise" value="true" class="dialogtip"
					<s:if test="enterprise.riskEnterprise" >checked="checked"</s:if>
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					title="指依法设立且取得企业法人营业执照的，从事危险化学品生产的企业，包括最终产品或中间产品列入《危险化学品名录》的危险化学品的生产企业。" />
				<label class="form-check-text" for="isRiskEnterprise">是否为危化企业</label>
			</div>
			<div class="grid_5 lable-right">
				<label class="form-lbl">工商执照号码：</label>
			</div>
			<div class="grid_7">
				<input type="text" name="enterprise.businessLicense" maxlength="20" id="enterprise-businessLicense"
					class="form-txt dialogtip" value="${enterprise.businessLicense }"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					title="营业执照号是工商行政管理机关发给工商企业、个体经营者的准许从事某项生产经营活动的凭证号码!" />
			</div>
			<div class='clearLine'>&nbsp;</div>

			<div class="grid_4 lable-right">
				<label class="form-lbl">隐患情况：</label>
			</div>
			<div class="grid_19">
				<input type="text" name="enterprise.hiddenCases" id="enterprise-hiddenCases"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					class="form-txt" value="${enterprise.hiddenCases }"
					style="width: 99%" maxlength="100" />
			</div>
			<div class='clearLine'>&nbsp;</div>

			<div class="grid_4 lable-right">
				<label class="form-lbl">隐患整改情况：</label>
			</div>
			<div class="grid_19">
				<input type="text" name="enterprise.hiddenRectification" id="enterprise-hiddenRectification"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					class="form-txt" value="${enterprise.hiddenRectification }"
					style="width: 99%" maxlength="100" />
			</div>
			<div class='clearLine'>&nbsp;</div>

			<div class="grid_4 lable-right">
				<label class="form-lbl">备注：</label>
			</div>
			<div class="grid_19">
				<textarea name="enterprise.remark" id="enterprise-remark"
					<s:if test='"view".equals(mode)'>disabled='true'</s:if>
					class="form-txt" style="height: 3em; width: 99%">${enterprise.remark }</textarea>
			</div>
			<div class='clearLine'>&nbsp;</div>
			<br />
		 </form>
	</div>

<script type="text/javascript">
var enterpriseOrgTree="";
function isGridForTreeSelect(){
	if(enterpriseOrgTree != ""){
		return $.getSelectedNode(enterpriseOrgTree).attributes.orgLevelInternalId == <s:property value="@com.tianque.domain.property.OrganizationLevel@GRID"/>;
	}else{
		return true;
	}
}

if(null!=$("#_imgUrl").val() && $("#_imgUrl").val()!=""){
	$("#headerImg").attr("src",$("#_imgUrl").val()+"?r="+Math.random());
	$(".shadow").show();
}

var keyType='';
var keyTypeName='';

	function keyTypeValue(){
		if($("#keyType") != null && $("#keyType")[0] != null && $("#keyType")[0].value != ''){
			keyType = $("#keyType")[0].value;
		}
	}

	function getKeyTypeName(){
		keyTypeValue();
		if(keyType == 'enterpriseKey'){
			keyTypeName ='规上企业';
		}else if(keyType == 'protectionKey'){
			keyTypeName ='重点保障';
		}else if(keyType == 'safetyProductionKey'){
			keyTypeName ='安全生产重点';
		}else if(keyType == 'fireSafetyKey'){
			keyTypeName ='消防安全重点';
		}else if(keyType == 'securityKey'){
			keyTypeName ='治安重点';
		}
	}

	function initTabText(){
		getKeyTypeName();
		$("#tabInfoA").text(keyTypeName+"信息");
	}
	
	$(document).ready(function(){
		$.ajax({
			async: false,
			url: "${path }/sysadmin/orgManage/getOrgRelativePath.action",
			data:{
				"organization.id":$("#organizationId").val()
			},
			success:function(responseData){
				$("#orgName").val(responseData);
			}
		})
		$("#tabs").tabFunction({ cache: true });
		initTabText();
		<s:if test='"add".equals(mode)'>
			$("#maintainForm").attr("action", "${path}/baseinfo/safetyProductionKeyManage/addEnterprise.action");
		</s:if>
		<s:if test='"edit".equals(mode)'>
			$("#maintainForm").attr("action", "${path}/baseinfo/safetyProductionKeyManage/updateEnterprise.action");
		</s:if>

		//验证企业名称唯一性
		jQuery.validator.addMethod("exsistedCompanyName", function(value, element){
			var flag =true;
			if(value==null||value==undefined||value==""){return true}
			$.ajax({
				async:false,
				url:'/baseinfo/safetyProductionKeyManage/hasDuplicateEnterpriseNameAndKeyType.action',
			   	data:{
			   		"ownerOrg.id":$('#organizationId').val(),
					"enterprise.name":$('#name').val(),
					"enterprise.id":$('#enterpriseId').val(),
					"enterprise.keyType":$(".keyType").val()
		        },
				success:function(responseData){
					flag = !eval(responseData);
				}
			});
			return flag;
		});
		
		jQuery.validator.addMethod("partyMemberAmountLessThanEmployeeAmount", function(value, element){
			if($("#partyMemberAmount").val() != null
					&& $("#employeeAmount").val() != null
					&& $("#partyMemberAmount").val() != ""
					&& $("#employeeAmount").val() != ""
					&& parseInt($("#partyMemberAmount").val()) > parseInt($("#employeeAmount").val())){
				return false;
			}
			return true;
		});

		jQuery.validator.addMethod("isGridOrganization", function(value, element){
			if(value==null||value==undefined||value==""){return true}
			if(isGridForTreeSelect()){
				return true;
			}else{
				return false;
			}
		});

		if(""!=$("#_imgUrl").val() && typeof($("#_imgUrl").val())!="undefined"){
			$("#img").attr("src","${path }/"+$("#_imgUrl").val());
		};

		$("#maintainForm").formValidate({
			promptPosition: "bottomLeft",
			submitHandler: function(form){
				$("#_imgUrl").val($("#imgUrl").val());
				$(form).ajaxSubmit({
					async : false,
					success:function(data){
						if(!data.id){
							$.messageBox({
								message: data,
								level: "error"
							});
							return;
						}
						 $("#<s:property value='#parameters.dailogName[0]'/>").proccessSuccess(data.id,data);
					}
				});
			},
			rules:{
				"orgName":{
					isGridOrganization:true
				},
				"enterprise.name":{
					required:true,
					exculdeParticalChar:true,
					minlength:2,
					maxlength:50
				},
				"enterprise.type.id":{
					required:true
				},
				"enterprise.legalPerson":{
					required:true,
					exculdeParticalChar:true,
					minlength:2,
					maxlength:20
				},
				"enterprise.businessLicense":{
					minlength:6,
					maxlength:20
				},
				"enterprise.registeredCapital":{
					number:true,
					min:0,
					max:999999999
				},
				"enterprise.area":{
					number:true,
					min:0,
					max:999999999
				},
				"enterprise.employeeAmount":{
					digits:true,
					min:0,
					max:999999999
				},
				"enterprise.partyMemberAmount":{
					digits:true,
					min:0,
					max:999999999,
					partyMemberAmountLessThanEmployeeAmount:true
				},
				"enterprise.enterpriseTelephone":{
					telephone:true
				},
				"enterprise.fax":{
					telephone:true
				},
				"enterprise.telephone":{
					telephone:true
				},
				"enterprise.mobileNumber":{
					mobile:true
				},
				"enterprise.address":{
					required:true,
					minlength:2,
					maxlength:50
				},
				"enterprise.hiddenCases":{
					maxlength:200
				},
				"enterprise.hiddenRectification":{
					maxlength:200
				},
				"enterprise.remark":{
					maxlength:200
				}
			},
			messages:{
				"orgName":{
					isGridOrganization:"网格只能属于片组片格"
				},
				"enterprise.name":{
					required:"请输入企业名称",
					exculdeParticalChar:"不能输入非法字符",
					minlength:$.format("企业名称至少需要输入{0}个字符"),
					maxlength:$.format("企业名称最多需要输入{0}个字符")

				},
				"enterprise.type.id":{
					required:"请选择企业类型"
				},
				"enterprise.legalPerson":{
					required:"请输入法人代表",
					exculdeParticalChar:"不能输入非法字符",
					minlength:$.format("法人代表至少需要输入{0}个字符"),
					maxlength:$.format("法人代表最多需要输入{0}个字符")
				},
				"enterprise.businessLicense":{
					minlength:$.format("工商执照至少需要输入{0}个字符"),
					maxlength:$.format("工商执照最多需要输入{0}个字符")
				},
				"enterprise.registeredCapital":{
					number: "注册资金需要输入正数",
					min: "注册资金需要输入正数",
					max: "注册资金最大输入999999999"
				},
				"enterprise.area":{
					number: "面积需要输入正数",
					min: "面积需要输入正数",
					max: "面积最大输入999999999"
				},
				"enterprise.employeeAmount":{
					digits: "员工数量需要输入正整数",
					min: "员工数量需要输入正整数",
					max: "员工数量最大输入999999999"
				},
				"enterprise.partyMemberAmount":{
					digits: "党员数量需要输入正整数",
					min: "党员数量需要输入正整数",
					max: "员工数量最大输入999999999",
					partyMemberAmountLessThanEmployeeAmount: "党员数不能大于员工数"
				},
				"enterprise.enterpriseTelephone":{
					telephone:$.format("企业联系电话不合法，只能输数字和横杠(-)")
				},
				"enterprise.fax":{
					telephone:$.format("企业传真不合法，只能输数字和横杠(-)")
				},
				"enterprise.telephone":{
					telephone:$.format("法人联系电话不合法，只能输数字和横杠(-)")
				},
				"enterprise.mobileNumber":{
					mobile:"手机号码输入只能是以1开头的11位数字"
				},
				"enterprise.address":{
					required:"请输入企业地址",
					minlength:$.format("企业地址至少需要输入{0}个字符"),
					maxlength:$.format("企业地址最多需要输入{0}个字符")
				},
				"enterprise.hiddenCases":{
					maxlength: "隐患情况最多输入200个字符"
				},
				"enterprise.hiddenRectification":{
					maxlength: "隐患整改情况最多输入200个字符"
				},
				"enterprise.remark":{
					maxlength: "备注最多输入200个字符"
				}
			}
		});

		<s:if test='"add_path".equals(modeType)'>
		$("#orgName").click(function(event){
			$("#noticeDialog").createDialog({
				width: 300,
				height: 350,
				title:'请选择一个部门',
				url:'${path}/common/organizationSelector.jsp',
				buttons: {
					"确定" : function(){
						closeDialog();
					},
					"取消" : function(){
						$("#noticeDialog").dialog("close");
					}
				}
			});
		});
	</s:if>

	<s:if test='#parameters.dialog != null'>
		enterpriseOrgTree = $("#orgName").treeSelect({
		url:"/sysadmin/orgManage/loadTownForExtTree.action",
		inputName:"ownerOrg.id"
	});
		//$.setTreeValue($("#orgId").val(),tree);
		var bol = false;
		$.ajax({
			async:false,
			url:"${path}/issue/issueManage/checkOccurOrgId.action",
			data:{
				"issueNew.occurOrg.id":${USER_ORG_ID}
			},
			success:function(responseData){
				bol = responseData;
			}
		});
		var url = "";
		if(bol){
			url = PATH+"/sysadmin/orgManage/ajaxSearchParentNodeIdsWhenRootIsTown.action?organization.id="+$("#organizationId").val()
		}else{
			url = PATH+"/sysadmin/orgManage/ajaxSearchParentNodeIds.action?organization.id="+$("#organizationId").val()
		}
		$.ajax({
			url:url,
			success:function(data){
				$.searchChild(enterpriseOrgTree,data);
			}
		});
	</s:if>

	});
	<s:if test='"add_path".equals(modeType)'>
	function setZone(selectOrgId,selectOrgName){
			$("#organizationId").val(selectOrgId);
			$("#orgName").val(selectOrgName);
		}
	</s:if>

	function ispersonInCharge(){
		var flag=false;
		$.ajax({
			async:false,
			url: "${path }/baseinfo/personInCharegeManage/getPersonInCharegeByIdAndPlace.action",
			data:{
				"placeId":$("#enterpriseId").val(),
				"placeType":$("#keyType").val()
			},
			success:function(responseData){
				if(responseData.length>0){
					flag=true;
				}
			}
		});
		return flag;
	}

	function setIsReadonly(index){
		$("#telephone"+index).attr("readonly", "readonly");
		$("#mobileNumber"+index).attr("readonly", "readonly");
	}

	function setUnReadonly(index){
		$("#telephone"+index).removeAttr("readonly");
		$("#mobileNumber"+index).removeAttr("readonly");
	}

	function emptyObject(){
				$("#enterpriseId").val("");
				$("#name").val("");
				$("#enterprise-businessLicense").val("");
				$("#enterprise-legalPerson").val("");
				$("#enterprise-registeredCapital").val("");
				$("#enterprise-industry-id").val("");
				$("#enterprise-area").val("");
				$("#employeeAmount").val("");
				$("#partyMemberAmount").val("");
				$("#enterprise-enterpriseTelephone").val("");
				$("#enterprise-fax").val("");
				$("#enterprise-telephone").val("");
				$("#enterprise-mobileNumber").val("");
				$("#enterprise-address").val("");
				$("#isRiskEnterprise").attr("checked",false);
				$("#enterprise-hiddenCases").val("");
				$("#enterprise-hiddenRectification").val("");
				$("#enterprise-remark").val("");
	}
</script>