<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="pop" uri="/PopGrid-taglib" %>
<jsp:include page="/includes/baseInclude.jsp" />

<div>
    <form action="${path}/serviceList/unlicensedManageManage/addUnlicensedManage.action?" method="post" id="maintainForm">
    <pop:token/>
    <input type="hidden" name="mode" id="mode" value="${mode}" />
	<input type="hidden" name="unlicensedManage.id"  value="${unlicensedManage.id}" />
	<input type="hidden" name="unlicensedManage.organization.id"  value="${unlicensedManage.organization.id}" />
	<input type="hidden" name="unlicensedManage.isSign"  value="${unlicensedManage.isSign}" />
	<div class="container container_24"> 
	    <div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">时间：</label>
		</div>
		<div class="grid_8 lable-left">
			<input id='inputTime' name='unlicensedManage.inputTime' value='<s:date name="unlicensedManage.inputTime" format="yyyy-MM-dd HH:mm:ss"/>' class="form-txt" readonly="readonly" />
		</div>
	    <div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">地点：</label>
		</div>
		<div class="grid_8 lable-left">
			<input name='unlicensedManage.address' value='${unlicensedManage.address}' title="${unlicensedManage.address}" maxlength="40" class="form-txt {required:true,messages:{required:'地点不能为空'}}" <s:if test='"view".equals(mode)'>readonly="readonly"</s:if> />
		</div>
		<div class='clearLine'>&nbsp;</div>
		
		<div class="grid_4 lable-right">
			<em class="form-req">*</em>
			<label class="form-lbl">类别：</label>
		</div>
		<div class="grid_8">
			<select  name="unlicensedManage.category.id" id="category"  class="form-select {required:true,messages:{required:'请选择类别'}} " <s:if test='"view".equals(mode)'>disabled="disabled"</s:if> >
	        	<pop:OptionTag name="@com.tianque.domain.property.PropertyTypes@UNLICENSED_CATEGORY" defaultValue="${unlicensedManage.category.id}" />
	        </select>		    
			
		</div>
	    <div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">详细情况：</label>
		</div>
		<div class="grid_8 ">
			<input name='unlicensedManage.details' value='${unlicensedManage.details}' title="${unlicensedManage.details}" maxlength="50" class="form-txt {required:true,messages:{required:'详细情况不能为空'}}" <s:if test='"view".equals(mode)'>readonly="readonly"</s:if> />
		</div>
		<div class='clearLine'>&nbsp;</div>
		 <div class="grid_4 lable-right">
			<label class="form-lbl">参与人：</label>
		</div>
		<div class="grid_8 ">
			<input name='unlicensedManage.personnel' value='${unlicensedManage.personnel}' title="${unlicensedManage.personnel}" maxlength="100" class="form-txt" <s:if test='"view".equals(mode)'>readonly="readonly"</s:if> />
		</div>
		<div class='clearLine'>&nbsp;</div>
		<div class="grid_4 lable-right">
			<label class="form-lbl">备注：</label>
		</div>
		<div class="grid_20 heightAuto">
            <textarea rows="4" name="unlicensedManage.remake" maxlength="300"  cols="" class="form-txt" <s:if test='"view".equals(mode)'>disabled="disabled"</s:if> >${unlicensedManage.remake}</textarea>
    	</div>
		<div class='clearLine'>&nbsp;</div>
    	<select id="attachFileNames" name="unlicensedManage.attachFileNames" multiple="multiple" style="width:200px;display:none"></select>
    	<input type="hidden" id="deleteAttachIds" name="unlicensedManage.deleteAttachIds" />
    	<input name="isSubmit" id="isSubmit" type="hidden" value="">
    </div>
    </form>
    <div class="container container_24 filePanel">
    		<br/>
			<div class="grid_4 lable-right">
				<label class="form-lbl">附件上传：</label>
			</div>
			<div id="attachFilesDiv" class="grid_19 heightAuto">
				<s:if test='!"view".equals(mode)'>
				<input id="custom_file_upload" name="uploadFile" type="file" />
				</s:if>
				<div id="custom-queue" style="clear:both;border:1px solid #ccc;overflow-x:hidden;height:100px;"></div>
			</div>
			<div class='clearLine'>&nbsp;</div>
	</div>
	<br/>
	<s:if test='"view".equals(mode)'>
	<div class="container container_24"> 
		<div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">网格员姓名：</label>
		</div>
		<div class="grid_8 lable-left">
			<input id='createUser' value='${unlicensedManage.createUser}'  readonly="readonly"  class="form-txt"/>
		</div>
		<div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">电话：</label>
		</div>
		<div class="grid_8 lable-left">
			<input id='createUser' value='${unlicensedManage.telephone}'  readonly="readonly"  class="form-txt"/>
		</div>
		<div class='clearLine'>&nbsp;</div>
		<div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">签收人：</label>
		</div>
		<div class="grid_8 ">
			<input name='unlicensedManage.signPeople' value='${unlicensedManage.signPeople}' readonly="readonly"  class="form-txt"/>
		</div>
		
		<div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">签收日期：</label>
		</div>
		<div class="grid_8 lable-left">
			<input id='inputTime' name="unlicensedManage.signDate" value='<s:date name="unlicensedManage.signDate" format="yyyy-MM-dd HH:mm:ss"/>' readonly="readonly"  class="form-txt"/>
		</div>
		<div class='clearLine'>&nbsp;</div>
		
		<div class="grid_4 lable-right">
			<label class="form-lbl">签收意见：</label>
		</div>
		<div class="grid_20 heightAuto">
            <textarea rows="4" id="signContent" name="unlicensedManage.signContent"  cols="" class="form-txt" disabled="disabled" >${unlicensedManage.signContent}</textarea>
    	</div>
		<div class='clearLine'>&nbsp;</div>
	</div>
	</s:if>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$("#maintainForm").formValidate({
		submitHandler: function(form){
			 $("#maintainForm").ajaxSubmit({
					success : function(data) {
						if(!data.id){
	           	 			$.messageBox({ 
								level: "error",
								message:data
				 			});
	            			return;
						}
						if("add"=="${mode}"){
							$.messageBox({message:"新增成功！"});
						}
						$("#serviceListDialog").dialog('close');
						$("#unlicensedManageList").trigger("reloadGrid");
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert("提交错误");
					}
			 });
		},
	});
	
	$('#custom_file_upload').uploadFile({
		queueID : 'custom-queue',
		selectInputId : "attachFileNames"
	});
	
});
	
<s:if test='!"add".equals(mode)'>	
	<s:if test="unlicensedManage.photos!=null && unlicensedManage.photos.size > 0">
		<s:iterator value="unlicensedManage.photos" var="file">
		    var itemHtml = '<div id="item'+'${file.id}'
				+'" class="uploadifyQueueItem completed">';
			<s:if test='!"view".equals(mode)'>
				itemHtml=itemHtml+'<div class="cancel"><a onclick="deleteAttach(${file.id})"><img src="${path}/resource/external/uploadify/cancel.png"></a></div>';
			</s:if>
			itemHtml=itemHtml+'<a href="'+'${path}/serviceList/unlicensedManageManage/downLoadAttachFile.action?attachFileId=${file.id}'
			+'" target="_blank"><span class="fileName">'+'${file.name}'+'</span></a></div>';
			$("#custom-queue").append($(itemHtml));
		</s:iterator>
	</s:if>	
</s:if>
function deleteAttach(attachId){
	$("#item"+attachId).remove();
	var str=$("#deleteAttachIds").val()+","+attachId;
	$("#deleteAttachIds").val(str);
}
</script>