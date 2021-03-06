<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/PopGrid-taglib" prefix="pop"%>
<%@ include file="/includes/baseInclude.jsp" %>
<input id="IsEmpValue"	type="hidden" name="" value="${location.isEmphasis }" />
<table width="200" class="tablelist">
  <tr>
    <td class="title"><label>所属网格</label></td>
    <td colspan="3" class="content" id="organizationOrgName">${location.organization.orgName}</td>
    <td class="imagesTX" rowspan="6">
    <s:if test='null!=location.imgUrl && !"".equals(location.imgUrl)'>
		<img id="img" name="location.imgUrl" src="${path }${location.imgUrl}" width="148px"/>
	</s:if>
	<s:else>
		<img id="img" name="location.imgUrl" src="${path }/resource/images/locationHead.png" width="148px"/>
	</s:else></td>
  </tr>
  <tr>
    <td class="title"><label>场所名称</label></td>
    <td colspan="3" class="content"><span>${location.placeName}</span></td>
  </tr>
  <tr>
    <td class="title"><label>场所地址</label></td>
    <td colspan="3" class="content"><span>${location.placeAddress}</span></td>
  </tr>
  <tr>
  	<td class="title"><label>负责人</label></td>
    <td class="content"><span>${location.placeName}</span></td>
    <td class="title" ><label>负责人电话</label></td>
    <td class="content"><span>${location.managerTelephone}</span></td>
  </tr>
  <tr>
  	<td class="title"><label>负责人手机</label></td> 
    <td class="content"><span>${location.managerMobile}</span></td>
    <td class="title"><label>关注程度</label></td>
	<td class="content"><span><pop:PropertyDictViewTag name="@com.tianque.domain.property.PropertyTypes@ATTENTION_EXTENT" defaultValue="${location.attentionExtent.id}"/></span></td>
  </tr>
  <tr>
  	<td class="title"><label>场所类型</label></td>    
    <td class="content"><span><pop:PropertyDictViewTag name="@com.tianque.domain.property.PropertyTypes@PUBLICCOMPLEXPLACES_TYPE" defaultValue="${location.type.id}" /></span></td>
  	<td class="title"><label>场所细类</label></td>
    <td class="content"><span><pop:PropertyDictViewTag name="@com.tianque.domain.property.PropertyTypes@PUBLICCOMPLEXPLACES_DETAILEDTYPE" defaultValue="${location.detailedType.id}" /></span></td>
  </tr>
  <s:if test='location.isEmphasis==true'>
  <tr>
    <td class="title"><label>注销时间</label></td>
    <td class="content"><span><s:date name="location.logOutTime" format="yyyy-MM-dd" /></span></td>
    <td class="title"><label>注销原因</label></td>
    <td class="content" colspan="2"><span>${location.logOutReason}</span></td>
  </tr>
  </s:if>
  <tr>		
   	 <td class="title"><label>存在隐患</label></td>
   	 <td colspan="4" class="content"><span id=""><pre>${location.hiddenCases}</pre></span></td>	 
  </tr> 
  <tr>		
   	 <td class="title"><label>隐患整改情况</label></td>
   	 <td colspan="4" class="content"><span id=""><pre>${location.hiddenRectification}</pre></span></td>	 
  </tr> 
   <tr>		
   	 <td class="title"><label>备注</label></td>
   	 <td colspan="4" class="content"><span id=""><pre>${location.remark}</pre></span></td>	 
  </tr> 
</table>

<script>
$(document).ready(function(){
	isEmpFormatter();
	//fateson add
	var img=$("#img");
	var src=img.attr("src");
	if(src){
		img.attr("src",src+"?r="+Math.random());
	} 
	
});

function isEmpFormatter(){
	var str = "";
	if($("#IsEmpValue").val()=="true"||$("#IsEmpValue").val()==true)
		str += "是";
	if($("#IsEmpValue").val() =="false"||$("#IsEmpValue").val()==false)
		str += "否";
	$("#tagIsEmp").html(str);
}
</script>
