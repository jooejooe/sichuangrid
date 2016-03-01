<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pop" uri="/PopGrid-taglib"%>
<%@ include file="/includes/baseInclude.jsp"%>
<div  class="container container_24">
	<form id="maintainForm" method="post" action="">
	 <input type="hidden" id="isCloseWindow" value="true"/>
     <pop:token></pop:token>
			<input type="hidden" name="mode" value="${mode }">
		<input type="hidden" name="preciseInbox.id" value="${preciseInbox.id}"><!-- 用天存储 每条消息对应的回复记录  -->
		<input type="hidden" name="preciseInbox.createUser" value="${preciseInbox.createUser}"><!-- 存的是粉丝名，区别于系统中的ccuu字段  用于存储对应的回复消息记录列表-->
		<input type="hidden" id="weChatUserIdByInbox" name="preciseInbox.toUserName" value="${preciseInbox.toUserName}"><!-- 用于获取微信号 -->
		<input type="hidden" id="weChatUserId" name="tencentUser.weChatUserId" value="${tencentUser.weChatUserId}"/>
		<input type="hidden" name="textMessage.ToUserName" value="${preciseInbox.fromUserName}"><!-- 发送给谁 -->
		<s:if test="#request.sendOrReply=='reply'">
			<div class="grid_4 lable-right">
				<label>收件人：</label>
			</div>	
			<div class="grid_20">
				${preciseInbox.createUser}
			</div>
		</s:if>
			<s:if test="#request.sendOrReply=='retransmission'">
		
			<div class="grid_4 lable-right">
				<em class="form-req">*</em><input type="button" value="选择粉丝" class="defaultBtn" id="selectPersonBtn"/>
			</div>
			<div class="grid_20 heightAuto">
				<input type="text" name="openId" 	id="userReceivers" class="form-txt"  readonly="readonly"/>
			</div>
		</s:if>
		<div class='clearLine'>&nbsp;</div>
		<div id="content">
			<div class="grid_4 lable-right">
				<em class="form-req">*</em><label class="form-lbl">内容：</label>
			</div>
			<div class="grid_20 heightAuto">
			    <s:if test="#request.sendOrReply=='retransmission'">
			       <textarea  id="textareaContent" name="textMessage.content"  readonly style='height:70px;width: 97%' class='form-txt'>${ preciseInbox.profile}</textarea>
		    	</s:if>
		        <s:else>
		    	  <textarea  id="textareaContent" name="textMessage.content" onkeyup="charlength(value)" style='height:70px;width: 97%' class='form-txt {required:true,maxlength:140,messages:{required:"请输入回复内容",maxlength:$.format("回复内容最多可以输入{0}个字符")}}'></textarea>
			    </s:else>
			</div>
			   <s:if test="#request.sendOrReply=='reply'">
				    <div class='clearLine'>&nbsp;</div>
					<div class="grid_4 lable-right">
						<label class="form-lbl">已输入：</label>
					</div>
					<div class="grid_20 heightAuto">
						<span id="counter" style="line-height: 30px; padding-left: 5px;font-style:normal;">0</span>个字（注意：回复内容不要超过140字。)
					</div>
				</s:if>
		</div>
	</form>
	
</div>
<div id="selectPersonDialog"></div>
<script type="text/javascript">
//计算文字长度
function charlength(value){
	var a=value.length;
	document.getElementById("counter").innerText=a;
 }
$(document).ready(function(){
	    <s:if test='"replyTextMessage".equals(mode)'>
	       $("#maintainForm").attr("action","/weChat/preciseInbox/replyTextMessage.action");
		</s:if>
		<s:else>
		 $("#maintainForm").attr("action","/weChat/preciseInbox/retransmissionTextMessage.action");
	//    $("#maintainForm").attr("action","/tencentUserManage/sendTextMessage.action");
	    </s:else>

	//收件人选择窗口
	$("#selectPersonBtn").click(function(){
		$(".tip-error").remove();
		$("#selectPersonDialog").createDialog({
			width: 650,
			height: 400,
			title:'选择粉丝',
			url:'${path}/fanManage/dispatch.action?mode=selectFanOrGroup&tencentUser.weChatUserId='+$("#weChatUserIdByInbox").val(),
			buttons: {
				"确定" : function(event){
					  $(this).dialog("close");
			    },
			    "关闭" : function(){
			    	$(this).dialog("close");
			    }
			}
		});
	});
	//收件人联想补全
	$("#userReceivers").personnelComplete({
	});
	//提交
	$("#maintainForm").formValidate({
		promptPosition: "bottomLeft",
		submitHandler: function(form) {
			<s:if test='"retransmissionMsg".equals(mode)'>
				if($("#userReceivers").val()==''){
					 $.messageBox({message:"粉丝用户不能为空！",level: "warn"});
					 return ;
				}
		</s:if>
	    $(form).ajaxSubmit({
	         success: function(data){
	        	   if(data==null||data=="null"){
		        		 if($("#isCloseWindow").val()=='true'){
		        		   $("#replyMessageDlg").dialog("close");
		        		 }else{
		        				$("#textareaContent").val("");
		        				document.getElementById("counter").innerText=0;
								$("#isCloseWindow").val("true");
								
		        		  }
		        		    <s:if test='"replyTextMessage".equals(mode)'>
						  		$.messageBox({message:"回复成功!"});
							</s:if>
							<s:else>
						   		$.messageBox({message:"转发成功!"});
							</s:else>
						$("#preciseInboxList").trigger("reloadGrid"); 
	              }else{
	         			$.messageBox({message:data,level: "error"});
	         	  }
					
	  	   },
	  	   error: function(XMLHttpRequest, textStatus, errorThrown){
	  	      alert("提交错误");
	  	   }
	  	  });
		}
	});
	
});

</script>

