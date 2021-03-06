<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/PopGrid-taglib" prefix="pop"%>
<%@ include file="/includes/baseInclude.jsp"%>

<s:action name="ajaxOrganization" var="findById" namespace="/sysadmin/orgManage" executeResult="false">
	<s:param name="organization.id" value="@com.tianque.core.util.ThreadVariable@getOrganization().id"></s:param>
</s:action>
<input type="hidden" id="currOrgId" name="currOrgId" value="<s:property value="#findById.organization.id"/>" />
<input type="hidden" id="currOrgCode" name="currOrgCode" value="<s:property value="#findById.organization.orgInternalCode"/>" />
<input type="hidden" id="currOrgLevel" value="<s:property value="#findById.organization.orgLevel.id"/>" />
<div id="commonPopulation" class="container container_24 clearfix integrativeQuery" >
	<form id="maintainForm" method="post"
		action="/integrativeQuery/populationIntegrativeQuery/queryPopulation.action">
		<div class="Explain">
			<div class="areaName">
				<label class="form-lb1">所属区域：</label>
			</div>
			<input type="text" id="OrgName"
				value="<s:property value="#findById.organization.orgName"/>" />
		</div>
		<div class='clearLine'>&nbsp;</div>
		<pop:JugePermissionTag ename="actualPeopleIntegrativeQuery">
			<div class="Explain">
				<label class="form-lb1">实口类型：</label> <input type="radio"
					class="form-btn" name="actualPersonType" value="-1"
					checked="checked" />&nbsp;&nbsp;不限&nbsp;&nbsp;&nbsp;&nbsp;
				<%-- 				<pop:JugePermissionTag ename="householdStaffIntegrativeQuery"> --%>
<!-- 					<input type="radio" class="form-btn" name="actualPersonType" -->
<%-- 						value='<s:property value="@com.tianque.service.util.PopulationType@HOUSEHOLD_STAFF"/>' />&nbsp;&nbsp;户籍人口&nbsp;&nbsp;&nbsp;&nbsp; --%>
<%-- 		   	</pop:JugePermissionTag> --%>
<%-- 				<pop:JugePermissionTag ename="floatingPopulationIntegrativeQuery"> --%>
<!-- 					<input type="radio" class="form-btn" name="actualPersonType" -->
<%-- 						value='<s:property value="@com.tianque.service.util.PopulationType@FLOATING_POPULATION"/>' />&nbsp;&nbsp;流动人口&nbsp;&nbsp;&nbsp;&nbsp; --%>
<%-- 		   </pop:JugePermissionTag> --%>
				<pop:JugePermissionTag ename="unsettledPopulationIntegrativeQuery">
					<input type="radio" class="form-btn" name="actualPersonType"
						value='<s:property value="@com.tianque.service.util.PopulationType@UNSETTLED_POPULATION"/>' />&nbsp;&nbsp;未落户人口
			</pop:JugePermissionTag>
			</div>
		</pop:JugePermissionTag>

		<pop:JugePermissionTag ename="attentionPeopleIntegrativeQuery">
			<div class="Explain">
				<label class="form-lb1">特殊人群：</label> <input type="radio"
					class="form-radio" checked="checked" />&nbsp;&nbsp;不限&nbsp;&nbsp;&nbsp;&nbsp;
				<pop:JugePermissionTag ename="positiveInfoIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@POSITIVE_INFO'/>" />&nbsp;&nbsp;刑释人员&nbsp;&nbsp;&nbsp;&nbsp;
		   	</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="rectificativePersonIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@RECTIFICATIVE_POPULATION'/>" />&nbsp;&nbsp;社区矫正人员&nbsp;&nbsp;&nbsp;&nbsp;
		   	</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="druggyIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@DRUGGY'/>" />&nbsp;&nbsp;吸毒人员&nbsp;&nbsp;&nbsp;&nbsp;
		   </pop:JugePermissionTag>
				<pop:JugePermissionTag ename="mentalPatientIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@MENTAL_PATIENT'/>" />&nbsp;&nbsp;严重精神障碍患者&nbsp;&nbsp;&nbsp;&nbsp;
		   	</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="idleYouthIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@IDLE_YOUTH'/>" />&nbsp;&nbsp;重点青少年&nbsp;&nbsp;&nbsp;&nbsp;
		  </pop:JugePermissionTag>
				<pop:JugePermissionTag ename="superiorVisitIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@SUPERIOR_VISIT'/>" />&nbsp;&nbsp;重点上访人员&nbsp;&nbsp;&nbsp;&nbsp;
		   	</pop:JugePermissionTag>
				<pop:JugePermissionTag
					ename="dangerousGoodsPractitionerIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@DANGEROUS_GOODS_PRACTITIONER'/>" />&nbsp;&nbsp;危险品从业人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
				
				<pop:JugePermissionTag
					ename="aidsPopulationsQuery">
					<input type="checkbox" class="form-btn"
							name="attentionPopulationTypes"
							value="<s:property value='@com.tianque.service.util.PopulationType@AIDSPOPULATIONS'/>" />&nbsp;&nbsp;艾滋病人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
				<pop:JugePermissionTag
					ename="otherAttentionPersonnelIntegrativeQuery">
					<input type="checkbox" class="form-btn"
							name="attentionPopulationTypes"
							value="<s:property value='@com.tianque.service.util.PopulationType@OTHER_ATTENTION_PERSONNEL'/>" />&nbsp;&nbsp;其他人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
			</div>
		</pop:JugePermissionTag>
		<pop:JugePermissionTag ename="civilPeopleIntegrativeQuery">
			<div class="Explain">
				<label class="form-lb1">关怀对象：</label> <input type="radio"
					class="form-radio" checked="checked" />&nbsp;&nbsp;不限&nbsp;&nbsp;&nbsp;&nbsp;
				<pop:JugePermissionTag ename="elderlyPeopleIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@ELDERLY_PEOPLE'/>" />&nbsp;&nbsp;老年人&nbsp;&nbsp;&nbsp;&nbsp;
		   	</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="handicappedIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@HANDICAPPED'/>" />&nbsp;&nbsp;残疾人&nbsp;&nbsp;&nbsp;&nbsp;
		   		</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="optimalObjectIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@OPTIMAL_OBJECT'/>" />&nbsp;&nbsp;优抚对象&nbsp;&nbsp;&nbsp;&nbsp;
		   		</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="aidNeedPopulationIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@AID_NEED_POPULATION'/>" />&nbsp;&nbsp;需救助人员&nbsp;&nbsp;&nbsp;&nbsp;
		   		</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="unemployedPeopleIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@UNEMPLOYED_PEOPLE'/>" />&nbsp;&nbsp;失业人员&nbsp;&nbsp;&nbsp;&nbsp;
			</pop:JugePermissionTag>
			</div>
		</pop:JugePermissionTag>
		<pop:JugePermissionTag ename="nurturesWomenIntegrativeQuery">
			<div class="Explain">
				<label class="form-lb1">育龄妇女：</label> <input type="radio"
					class="form-radio" checked="checked" />&nbsp;&nbsp;不限&nbsp;&nbsp;&nbsp;&nbsp;
				<pop:JugePermissionTag ename="nurturesWomenIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@NURTURES_WOMEN'/>" />&nbsp;&nbsp;育龄妇女&nbsp;&nbsp;&nbsp;&nbsp;
			</pop:JugePermissionTag>
			</div>
		</pop:JugePermissionTag>
		<pop:JugePermissionTag ename="fxjPeopleIntegrativeQuery">
			<div class="Explain">
				<label class="form-lb1">FXJ人员：</label> <input type="radio"
					class="form-radio" checked="checked" />&nbsp;&nbsp;不限&nbsp;&nbsp;&nbsp;&nbsp;
				<pop:JugePermissionTag ename="fPersonnelIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@F_PERSONNEL'/>" />&nbsp;&nbsp;F人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="qPersonnelIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@Q_PERSONNEL'/>" />&nbsp;&nbsp;Q人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
				<pop:JugePermissionTag ename="mPersonnelIntegrativeQuery">
					<input type="checkbox" class="form-btn"
						name="attentionPopulationTypes"
						value="<s:property value='@com.tianque.service.util.PopulationType@M_PERSONNEL'/>" />&nbsp;&nbsp;M人员&nbsp;&nbsp;&nbsp;&nbsp;
				</pop:JugePermissionTag>
			</div>
		</pop:JugePermissionTag>
		<div class="dashline"></div>
		<div class="Explain">
			<label class="form-lb1">人员性别：</label>
			<%-- <input type="radio" class="form-btn" name="sex" value="-1" checked="checked" />&nbsp;&nbsp;不限&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" class="form-btn" name="sex" value='<s:property value="@com.tianque.domain.property.Gender@MALE" />' />&nbsp;&nbsp;男&nbsp;&nbsp;&nbsp;&nbsp;
		   	<input type="radio" class="form-btn" name="sex" value='<s:property value="@com.tianque.domain.property.Gender@FEMALE" />' />&nbsp;&nbsp;女&nbsp;&nbsp;&nbsp;&nbsp; --%>
			<!--  <div class="grid_7"> -->
			<select name="gender.id" id="gender" class="form-btn">
				<pop:OptionTag
					name="@com.tianque.domain.property.PropertyTypes@GENDER" />
			</select>
			<!-- 	</div> -->
		</div>
		<div class="Explain">
			<label class="form-lb1">出生年份：</label>
			<input type="radio"
				id="birthdayRadio" class="form-btn" checked="checked" />不限&nbsp;&nbsp;
			<select name="birthdayStrart" id="birthdayStrart" class="{endBigThanStart:true,messages:{endBigThanStart:'出生年份结束年要大于开始年'}}">
        	</select>-
        	<select name="birthdayEnd" id="birthdayEnd"  class="{endBigThanStart:true,messages:{endBigThanStart:'出生年份结束年要大于开始年'}}">
        	</select>

			<label class="form-lb1">年</label>
		</div>

		<div class="Explain">
			<label class="form-lb1">固定住所：</label> <input type="radio"
				class="form-btn" name="hasHouse"
				value="<s:property value='@com.tianque.integrativeQuery.population.domain.PopulationQueryVo@NOCHECKED'/>"
				checked="checked" />&nbsp;&nbsp;不限&nbsp;&nbsp;&nbsp;&nbsp; <input
				type="radio" class="form-btn" name="hasHouse"
				value='<s:property value="@com.tianque.integrativeQuery.population.domain.PopulationQueryVo@HASHOUSE"/>' />&nbsp;&nbsp;有&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" class="form-btn" name="hasHouse"
				value="<s:property value='@com.tianque.integrativeQuery.population.domain.PopulationQueryVo@HASNOHOUSE'/>" />&nbsp;&nbsp;无&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<div class="dashline"></div>
		<div class="Explain" id="nav">
		<s:if test="@com.tianque.core.util.ThreadVariable@getUser().getUserName().equals('longzhendong')||
		   @com.tianque.core.util.ThreadVariable@getUser().getUserName().equals('admin')">
			<a id="search" href="javascript:void(0)"><span><strong class="ui-ico-xz"></strong>查询</span></a>
			<a id="advancedSearch" href="javascript:void(0)"><span><strong	class="ui-ico-xz"></strong>高级查询</span></a>
			<a id="exportResultList" href="javascript:void(0)"><span><strong class="ui-ico-xz"></strong>导出</span></a>
		</s:if>	
		</div>
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
<pop:formatterProperty name="gender" domainName="@com.tianque.domain.property.PropertyTypes@GENDER" />
<pop:formatterProperty name="nation" domainName="@com.tianque.domain.property.PropertyTypes@NATION" />

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

function idCardNoFont(el,options,rowData){
	if(!el){return ""}
	if(rowData.isEmphasis==1||rowData.isEmphasis=='1'){
		return "<font color='#778899'>"+rowData.idCardNo+"</font>";
	}else{
		return "<font color='#000'>"+rowData.idCardNo+"</font>";
	}
}
function operateFormatter(el, options, rowData){
	return "<a href='javascript:viewPopulationInfo("+rowData.id+")'><U><font color='#6633FF'>查看</font></U></a>";
}

function actualPopulationName(el,options,rowData){
	if(el=="floatingPopulations"){
		return "流动人口";
	}
	if(el=="householdstaffs"){
		return "户籍人口";
	}
	if(el=="unsettledPopulations"){
		return "未落户人口";
	}

}

function viewPopulationInfo(dataId){
	var rowId=  $("#searchResultList").getGridParam("selrow");
	var row=$("#searchResultList").getRowData(rowId);
	var url;
	if((row.sid).indexOf("householdstaffs")>=0){
		url='${path}/baseinfo/householdStaff/dispath.action?mode=view&population.id='+row.encryptId;
	}
	if((row.sid).indexOf("floatingPopulations")>=0){
		url='${path}/baseinfo/floatingPopulationManage/dispath.action?mode=view&population.id='+row.encryptId;
	}
	if((row.sid).indexOf("unsettledPopulations")>=0){
		url='${path}/baseinfo/unsettledPopulationManage/dispatchOperate.action?mode=view&unsettledPopulation.id='+row.encryptId;
	}

	$("#searchDialog").createDialog({
		width: 800,
		height: 600,
		title:'查看人口信息',
		modal : true,
		url:url,
		buttons: {
		   "关闭" : function(){
		        $(this).dialog("close");
		   }
		}
	});

}

$(document).ready(function(){
	function buildBirthday(selectId){
		$.ajax({
			async: false,
			url: "${path }/stat/currentTime/getCurrentTimeForIntegrativeQueryYear.action",
			success:function(responseData){
				for(var i = 0;i<responseData.length;i++){
					if(responseData[i]==-1){
						$("#"+selectId).append("<option value='"+responseData[i]+"'>请选择</option>");
						}else
					$("#"+selectId).append("<option value='"+responseData[i]+"'>"+responseData[i]+"</option>");
				}

			}
		});
	}
	buildBirthday("birthdayStrart");
	buildBirthday("birthdayEnd");


	$("#birthdayStrart").change(function(){
		$("#birthdayRadio").removeAttr("checked");
	});
	$("#birthdayEnd").change(function(){
		$("#birthdayRadio").removeAttr("checked");
	});
	$("#birthdayRadio").click(function(){
		$("#birthdayStrart").val("-1");
		$("#birthdayEnd").val("-1");
		$("#birthdayRadio").attr("checked","checked");
	});

	$("#searchResultList").jqGridFunction({
		mtype:'post',
		multiselect:true,
		datatype: "local",
		height:$(".ui-layout-center").height()-$("#commonPopulation").height()-130,
   		colModel:[
			{name:"sid",index:'sid',width:50,frozen:true,hidedlg:true,sortable:false,hidden:true,key:true},
			{name:"id", index:"id", hidden:true,frozen:true,sortable:false},
			{name:"encryptId",index:"encryptId",sortable:false,hidedlg:true,frozen:true,hidden:true},
			{name:"操作",index:'sid',width:50,formatter:operateFormatter,align:"center",frozen:true,sortable:false},
			{name:"name",index:'name',label:"姓名",width:120,sortable:true,frozen:true},
			{name:"gender", label:"性别",index:"gender",width:60, formatter:genderFormatter,align:"center",sortable:true,frozen:true},
			{name:'idCardNo',index:'idCardNo', label:'身份证号码', formatter:idCardNoFont, width:130,sortable:true,frozen:true},
			{name:"birthday", index:'birthday', label:'出生日期', width:90,sortable:true},
			{name:'nation',index:"nation",label:"民族",formatter:nationFormatter,width:90,sortable:true},
			{name:'nativePoliceStation',index:"nativePoliceStation",label:"户籍地",width:200,sortable:true},
			{name:'currentAddress', sortable:true, label:'常住地址', width:150 },
			{name:'organization.orgName',sortable:false,index:'organization.orgName',label:'所属网格',width:200},
			{name:'actualPopulationType',index:'actualPopulationType',formatter:actualPopulationName, label:'实口类型', width:90,sortable:true}

		],
		ondblClickRow:function(data){
			viewPopulationInfo();
		}

	});



	//checkBox在选中时把当前div前面的 radio的选择清空
	$("input:checkbox").click(function(){
		if($(this).attr("checked")){
			$(this).parent().find("input:radio").removeAttr("checked");
		}else{
			var selectCheckbox=$(this).parent().find("input:checkbox").filter(function(){
				return $(this).attr("checked");
			})
			if(!selectCheckbox[0]){
				$(this).parent().find("input:radio").attr("checked","checked");
			}
		}
	});

	//当业务数据的人员被选中时，清空后面紧跟的checkBox
	$(".form-radio").click(function(){
		$(this).parent().find("input:checkbox").removeAttr("checked");
		$(this).attr("checked","checked");
	});




	$("#advancedSearch").click(function(event){
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
		$("#maintainForm").submit();
	});
	function search(){
		$("#searchResultList").setGridParam({
			url:"${path}/integrativeQuery/populationIntegrativeQuery/queryPopulation.action",
			mtype:"post",
			datatype: "json",
			page:1
		});


		var commJson= maintainFormData();

	//	$("#searchResultList").setPostData($.extend(dataJson));
		$("#searchResultList").setPostData($.extend({"currOrgId":$("#currOrgId").val()},commJson));

		$("#searchResultList").trigger("reloadGrid");
	}

	$("#exportResultList").click(function(event){
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

	function populationQueryFromData(){
		var data = $("#populationQueryFrom").serializeObject({
					excludeWhenNull:["populationQueryVo.searchHouseholdStaffVo.outGone",
					                 "populationQueryVo.searchFloatingPopulationVo.hasMarriedProve",
					                 "populationQueryVo.searchPositiveInfoVo.isRepeat",
					                 "populationQueryVo.searchDruggyVo.isAdanon",
					                 "populationQueryVo.searchMentalPatientVo.isTreat",]
		});

		return data;

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
