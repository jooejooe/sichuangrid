<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<jsp:include page="/includes/baseInclude.jsp" />
<s:if test="@com.tianque.core.util.ThreadVariable@getOrganization().getOrgLevel().internalId!=@com.tianque.domain.property.OrganizationLevel@GRID || @com.tianque.core.util.ThreadVariable@getUser().admin">
	<div class="btnbanner">
		<a href="javascript:;" class="globalOrgBtnMod" id="globalOrgBtnMod"><span id="globalOrgBtn"></span></a>
	</div>
	<script>
		$(function(){
			 var plateName='<%=request.getParameter("plateName")%>';
			 var selectType = '<%=request.getParameter("selectType")%>';
			 var url = '';
			 if(selectType!=null && selectType=='account'){
				 saveCurrentAccountOrg(false);
				 url = '${path}/sysadmin/orgManage/getOrgSelectForThreeAccount.action?selectType='+selectType;
			 }else{
				 url='${path}/sysadmin/orgManage/orgSelectComponent.action?&plateName='+plateName;
			 }
			//将#globalOrgBtnMod 修正为 #globalOrgBtnMod.globalOrgBtnMod 写法仅为了解决在数字网格系统下id冲突的问题
			$("#globalOrgBtnMod.globalOrgBtnMod").click(function(){
				var _url = url+'&id='+$.getCurrentOrgId();
				$("#globalOrgBox").createDialog({
					url:_url,
					width:550,
					height:'auto',
					title:'辖区选择',
					buttons: {
						"确定" : function(event){
							var selectInput=$("#orgSelectInput");
							var orgLevelInternalId=selectInput.attr("orgLevelInternalId");
							var text=selectInput.attr("text");
							$("#currentOrgId").attr({
								"orgLevelInternalId":orgLevelInternalId,
								text:text,
								value:selectInput.val()
							});
							 if(selectType!=null && selectType=='account'){//防止台账首页组织受其他页面影响
								 saveCurrentAccountOrg(true);
							 }
							$("#globalOrgBtnMod.globalOrgBtnMod").html(text);
							if('familyAndHouse'==plateName && $("#currentOrgId").attr("orgLevelInternalId") >'<s:property value="@com.tianque.domain.property.OrganizationLevel@CITY"/>'){
								$.messageBox({level:"warn",
									message:'请选择市或市以下的层级！'});
								return ;
							}
							var curMenu=$("#accordion a.cur");
							var baseUrl=curMenu.attr("baseUrl");
							var leaderUrl=curMenu.attr("leaderUrl");
							var gridUrl=curMenu.attr("gridurl");
							if($("#tabList")[0]){
								var tabIndex=$("#tabList .ui-tabs-nav li.ui-tabs-active").index();
								if(tabIndex != -1){
									$("#tabList").tabs("load",tabIndex);
								} else {
									onOrgChanged();
								}	
								$(this).dialog("close");
							}else{
								baseLoad(curMenu,baseUrl,leaderUrl,gridUrl);
							}
							if(typeof afterOrgChanged =='function'){
								afterOrgChanged();
							}
						},
						"取消" : function(){
							$(this).dialog("close");
						}
					}
				});
			});
			setOrgSelect();
		})
		//防止台账首页组织受其他页面影响-保存和初始化还原
		function saveCurrentAccountOrg(isSave){
			var $currentOrgId = $("#currentOrgId");
			if(isSave|| !$currentOrgId.attr("data-account-value")){
				$currentOrgId.attr({
					"data-account-orgLevelInternalId":$currentOrgId.attr("orgLevelInternalId"),
					"data-account-text":$currentOrgId.attr("text"),
					"data-account-value":$currentOrgId.val()
				});
			}else{
				$currentOrgId.attr({
					"orgLevelInternalId":$currentOrgId.attr("data-account-orgLevelInternalId"),
					"text":$currentOrgId.attr("data-account-text"),
					"value":$currentOrgId.attr("data-account-value")
				});
			}
		}
	</script>
</s:if>