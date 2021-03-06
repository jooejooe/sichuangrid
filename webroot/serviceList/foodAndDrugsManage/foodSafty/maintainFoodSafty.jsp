<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="pop" uri="/PopGrid-taglib" %>
<jsp:include page="/includes/baseInclude.jsp" />

<div>
    <form action="${path}/serviceList/foodSaftyManage/addFoodSafty.action?" method="post" id="maintainForm">
    <pop:token/>
    <input type="hidden" name="mode" id="mode" value="${mode}" />
	<input type="hidden" name="foodSafty.id"  value="${foodSafty.id}" />
	<input type="hidden" name="foodSafty.organization.id"  value="${foodSafty.organization.id}" />
	<input type="hidden" name="foodSafty.isSign"  value="${foodSafty.isSign}" />
	<div class="container container_24"> 
	    <div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">时间：</label>
		</div>
		<div class="grid_8 lable-left">
			<input id='inputTime' name='foodSafty.inputTime' value='<s:date name="foodSafty.inputTime" format="yyyy-MM-dd HH:mm:ss"/>' class="form-txt" readonly="readonly"  />
		</div>
	    <div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">地点：</label>
		</div>
		<div class="grid_8 lable-left">
			<input name='foodSafty.address' value='${foodSafty.address}' title="${foodSafty.address}" maxlength="40" class="form-txt {required:true,messages:{required:'地点不能为空'}}" <s:if test='"view".equals(mode)'>readonly="readonly"</s:if> />
		</div>
		<div class='clearLine'>&nbsp;</div>
		
		<div class="grid_4 lable-right">
			<em class="form-req">*</em>
			<label class="form-lbl">类别：</label>
		</div>
		<div class="grid_8">
			<select  name="foodSafty.category.id" id="category" class="form-select {required:true,messages:{required:'请选择类别'}} " <s:if test='"view".equals(mode)'>disabled="disabled"</s:if> >
	        	<pop:OptionTag name="@com.tianque.domain.property.PropertyTypes@FOOD_SAFTY_CATEGORY" defaultValue="${foodSafty.category.id}" />
	        </select>		    
		</div>
		<div id="declarationDiv">
			<div class="grid_4 lable-right">
				<em class="form-req">*</em>
				<label class="form-lbl">5桌以上申报：</label>
			</div>
			<div class="grid_8">
				<select  name="foodSafty.declaration" id="declaration" class="form-select" <s:if test='"view".equals(mode)'>disabled="disabled"</s:if> >
		        	<option value="" >请选择</option>
		        	<option value="1" <s:if test='foodSafty.declaration!=null&&foodSafty.declaration==1'>selected="selected"</s:if> >是</option>
		        	<option value="0" <s:if test='foodSafty.declaration!=null&&foodSafty.declaration==0'>selected="selected"</s:if> >否</option>
		        </select>
			</div>
		</div>
		<div class='clearLine'>&nbsp;</div>
		  <div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">情况描述：</label>
		</div>
		<div class="grid_8 ">
			<input name='foodSafty.details' value='${foodSafty.details}' title="${foodSafty.details}" maxlength="50" class="form-txt {required:true,messages:{required:'情况描述不能为空'}}" <s:if test='"view".equals(mode)'>readonly="readonly"</s:if> />
		</div>
		
		<div class="grid_4 lable-right">
			<label class="form-lbl">参与人员：</label>
		</div>
		<div class="grid_8 ">
			<input name='foodSafty.personnel' value='${foodSafty.personnel}' title="${foodSafty.personnel}" maxlength="50" class="form-txt" <s:if test='"view".equals(mode)'>readonly="readonly"</s:if> />
		</div>
		<div class='clearLine'>&nbsp;</div>
		
		<div class="grid_4 lable-right">
			<label class="form-lbl">备注：</label>
		</div>
		<div class="grid_20 heightAuto">
            <textarea rows="4" name="foodSafty.remake"  maxlength="300" cols="" class="form-txt" <s:if test='"view".equals(mode)'>disabled="disabled"</s:if> >${foodSafty.remake}</textarea>
    	</div>
		<div class='clearLine'>&nbsp;</div>
    	<select id="attachFileNames" name="foodSafty.attachFileNames" multiple="multiple" style="width:200px;display:none"></select>
    	<input type="hidden" id="deleteAttachIds" name="foodSafty.deleteAttachIds" />
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
			<input id='createUser' value='${foodSafty.createUser}'  readonly="readonly"  class="form-txt" />
		</div>
		<div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">电话：</label>
		</div>
		<div class="grid_8 lable-left">
			<input id='createUser' value='${foodSafty.telephone}'  readonly="readonly"  class="form-txt" />
		</div>
		<div class='clearLine'>&nbsp;</div>
		<div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">签收人：</label>
		</div>
		<div class="grid_8 ">
			<input name='foodSafty.signPeople' value='${foodSafty.signPeople}' readonly="readonly" class="form-txt" />
		</div>
		
		<div class="grid_4 lable-right">
	    	<em class="form-req">*</em>
			<label class="form-lbl">签收日期：</label>
		</div>
		<div class="grid_8 lable-left">
			<input id='inputTime' name="foodSafty.signDate" value='<s:date name="foodSafty.signDate" format="yyyy-MM-dd HH:mm:ss"/>' readonly="readonly"  class="form-txt" />
		</div>
		<div class='clearLine'>&nbsp;</div>
		
		<div class="grid_4 lable-right">
			<label class="form-lbl">签收意见：</label>
		</div>
		<div class="grid_20 heightAuto">
            <textarea rows="4" id="signContent" name="foodSafty.signContent"  cols="" class="form-txt" disabled="disabled" >${foodSafty.signContent}</textarea>
    	</div>
		<div class='clearLine'>&nbsp;</div>
	</div>
	</s:if>
</div>
<script type="text/javascript">
	jQuery.validator.addMethod("validateDeclaration", function(value, element){
		 var val = $("#category option:selected").text();
			if(val=="<s:property value='@com.tianque.domain.property.PropertyTypes@RURAL_FAMILY'/>"){
				if($("#declaration").val()=="" ||　$("#declaration").val()==undefined){
					return false;
				}
			}
			return true;
	});
	
function declarationDivShow(){
	var val = $("#category option:selected").text();
	if(val=="<s:property value='@com.tianque.domain.property.PropertyTypes@RURAL_FAMILY'/>"){
		$("#declarationDiv").show();
	}else{
		$("#declarationDiv").hide();
	}	
}
$(document).ready(function(){
	declarationDivShow();
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
						$("#foodSaftyList").trigger("reloadGrid");
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						alert("提交错误");
					}
			 });
		},
		rules:{
			"foodSafty.declaration":{
				validateDeclaration:true
			}

		},
		messages:{
			"foodSafty.declaration":{
				validateDeclaration:"请选择是否申报"
			}
		}
	});
	
	$("#category").change(function(){
		 var val = $("#category option:selected").text();
			if(val=="<s:property value='@com.tianque.domain.property.PropertyTypes@RURAL_FAMILY'/>"){
				$("#declarationDiv").show();
			}else{
				$("#declarationDiv").hide();
			}
	});
	
	$('#custom_file_upload').uploadFile({
		queueID : 'custom-queue',
		selectInputId : "attachFileNames"
	});
	
});
	
<s:if test='!"add".equals(mode)'>	
	<s:if test="foodSafty.photos!=null && foodSafty.photos.size > 0">
		<s:iterator value="foodSafty.photos" var="file">
		    var itemHtml = '<div id="item'+'${file.id}'
				+'" class="uploadifyQueueItem completed">';
			<s:if test='!"view".equals(mode)'>
				itemHtml=itemHtml+'<div class="cancel"><a onclick="deleteAttach(${file.id})"><img src="${path}/resource/external/uploadify/cancel.png"></a></div>';
			</s:if>
			itemHtml=itemHtml+'<a href="'+'${path}/serviceList/foodSaftyManage/downLoadAttachFile.action?attachFileId=${file.id}'
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