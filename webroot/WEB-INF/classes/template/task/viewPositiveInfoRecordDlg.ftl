<#assign pop=JspTaglibs["/WEB-INF/taglib/pop-taglib.tld"]>
<#assign s=JspTaglibs["/WEB-INF/taglib/struts-tags.tld"]>
<@s.include value="/includes/baseInclude.jsp" />
<div id="tabList">
	<ul>
		<li><a  href="javascript:;" id="infoTab">信息</a> </li>
		<li><a  href="javascript:;" id="taskListReplyTab">回复列表</a> </li>
	</ul>
</div>
<table class="tablelist" id="infoList">
	<tr>
		<td class="title"><label>所属网格</label></td>
		<td class="content" colspan="3"><span>${(positiveInfoRecord.organization.fullOrgName)!}</span></td>
	</tr>
	<tr>
		<td class="title"><label>姓名</label></td>
		 <td class="content" colspan="3"><span>${(positiveInfoRecord.name)!}</span></td>
	</tr>
	<tr>
		 <td class="title"><label>身份证号码</label></td>
		 <td class="content" colspan="3"><span>${(positiveInfoRecord.idCard)!}</span></td>
	</tr>
	<tr>
		 <td class="title"><label>电话号码</label></td>
		 <td class="content" colspan="3"><span>${(positiveInfoRecord.phone)!}</span></td>
	</tr>
	<tr>
		<td class="title"><label>家属联系方式</label></td>
		<td class="content" colspan="3"><span>${(positiveInfoRecord.familyPhone)!}</span></td>
	</tr>
	<tr>
		<td class="title"><label>地点</label></td>
		<td class="content" colspan="3"><span>${(positiveInfoRecord.address)!}</span></td>
	</tr>
	<tr>
		<td class="title"><label>时间</label></td>
		 <td class="content" colspan="3"><span><@s.date name="positiveInfoRecord.recordDate" format="yyyy-MM-dd HH:mm:ss" /></span></td>
	</tr>
	<tr>
		 <td class="title"><label>帮扶人员</label></td>
		 <td class="content" colspan="3"><span>${(positiveInfoRecord.helpPeople)!}</span></td>
	</tr>
	<tr>
		<td class="title"><label>生活来源</label></td>
		<td class="content" colspan="3"><span><@pop.PropertyDictViewTag name="@com.tianque.domain.property.PropertyTypes@DRUGGY_LIFE_RESOURCE" defaultValue="${(positiveInfoRecord.livelihoodWay.id)!}" /></span></td>
	</tr>
	<tr>
		 <td class="title"><label>有无异常</label></td>
		 <td class="content" colspan="3"><span><#if positiveInfoRecord.hasException == 1>有<#else>无</#if></span></td>
	</tr>
	<tr>
		<td class="title"><label>异常情况</label></td>
		<td class="content" colspan="3"><span>${(positiveInfoRecord.exceptionSituationInfo)!}</span></td>
	</tr>
	
	<tr>
		<td class="title"><label>网格员联系电话</label></td>
		<td class="content" colspan="3"><span>${(positiveInfoRecord.gridMemberPhone)!}</span></td>
	</tr>
	<tr>
		<td class="title"><label>签收人</label></td>
		<td class="content" colspan="3"><span>${(positiveInfoRecord.signMemberName)!}</span></td>
	</tr>
	<tr>
		<td class="title"><label>签收时间</label></td>
		<td class="content" colspan="3"><span><@s.if test='positiveInfoRecord.status == 1'><@s.date name="positiveInfoRecord.signDate" format="yyyy-MM-dd HH:mm:ss" /></@s.if></span></td>
	</tr>
	<tr>
		<td class="title"><label>签收意见</label></td>
		<td class="content" colspan="3"><span>${(positiveInfoRecord.attitude)!}</span></td>
	</tr>
	<tr>
		<td class="title"><label>备注</label></td>
		<td class="content" colspan="3"><span>${(positiveInfoRecord.mark)!}</span></td>
	</tr>
		
 	<tr id="fatesonid">
		<td class="title"><label>附件上传：</label></td>
		<td class="content" colspan="3">
		    <div id="custom-queue"></div>
		</td>
	</tr>
</table>
<div id="showTaskListReply"></div>
<script type="text/javascript">
	$(document).ready(function(){
		var  fileNames="";
		    <@s.if test="positiveInfoRecord.taskListAttachFiles!=null && positiveInfoRecord.taskListAttachFiles.size > 0">
					<@s.iterator value="positiveInfoRecord.taskListAttachFiles" var="att">
					 fileNames += "<a href='${path}/plugin/taskListManage/common/downLoadAttachFile.action?attachFileId=${(att.id)!}'>${(att.fileName)!}</a><br/>";
					</@s.iterator>
				</@s.if>
				<@s.else>
				$("#fatesonid").hide();  
				</@s.else>
		$("#custom-queue").html(fileNames);		
		
		
		$( "#tabList" ).tabs({ selected: 0});
		$("#infoTab").click(function(){
			$("#infoList").show();
			$("#showTaskListReply").hide();
		});
		$("#taskListReplyTab").click(function(){
			$("#infoList").hide();
			$("#showTaskListReply").show();
			if($("#showTaskListReply").html()==""){
				$.get(PATH+"/plugin/taskListManage/common/taskListReplyListDlg.action",{'taskListReply.moduleKey':'reply_positiveInfoRecord','taskListReply.taskId':'${id}'},function(data){
					$("#showTaskListReply").html(data);
				});
			}
		});
	});
</script>

