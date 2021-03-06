/**
 * 
 */
package com.tianque.serviceList.controller;

import java.io.File;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.alibaba.dubbo.common.logger.Logger;
import com.alibaba.dubbo.common.logger.LoggerFactory;
import com.tianque.controller.ControllerHelper;
import com.tianque.core.base.BaseAction;
import com.tianque.core.util.FileUtil;
import com.tianque.core.util.StringUtil;
import com.tianque.core.util.ThreadVariable;
import com.tianque.core.vo.GridPage;
import com.tianque.core.vo.PageInfo;
import com.tianque.exception.base.BusinessValidationException;
import com.tianque.serviceList.domain.FoodSafty;
import com.tianque.serviceList.domain.Reply;
import com.tianque.serviceList.domain.ReplyAttch;
import com.tianque.serviceList.domain.ServiceListAttch;
import com.tianque.serviceList.domain.ServiceListEnum;
import com.tianque.serviceList.service.FoodSaftyService;
import com.tianque.serviceList.service.ReplyAttachService;
import com.tianque.serviceList.service.ReplyService;
import com.tianque.serviceList.service.ServiceListAttachService;
import com.tianque.sysadmin.service.OrganizationDubboService;

/**
 * @作者:彭乐
 * @功能: 
 * @时间:2015-11-27 上午10:55:54
 * @邮箱:pengle@hztianque.com
 */
@Scope("request")
@Namespace("/serviceList/foodSaftyManage")
@Controller("foodSaftyController")
public class FoodSaftyController extends BaseAction{
	private static Logger logger = LoggerFactory
			.getLogger(FoodSaftyController.class);
	private static final Integer TYPE=ServiceListEnum.getValue("foodSafty");
	@Autowired
	private OrganizationDubboService organizationDubboService;
	@Autowired
	private FoodSaftyService foodSaftyService;
	
	@Autowired
	private ServiceListAttachService serviceListAttachService;
	
	@Autowired
	private ReplyAttachService replyAttachService;
	
	@Autowired
	private ReplyService replyService;
	
	private Reply reply;
	
	private List<Reply> serviceListReplyList;
	
	private FoodSafty foodSafty;
	//批量删除ids
	private String ids;
	//附件Id
	private Long attachFileId;
	private String attachFile;
	private String attachFiles;
	@Action(value = "addFoodSaftyMobile", results = {
			@Result(name = "success", type = "json", params = { "root", "true", "ignoreHierarchy",
					"false", "excludeNullProperties", "true" }),
			@Result(name = "error", type = "json", params = { "root", "errorMessage",
					"ignoreHierarchy", "false" }) })
	public String addFoodSaftyMobile() throws Exception {
			if (foodSafty == null) {
				logger.error("食品安全协管新增参数错误！");
				return ERROR;
			}
			if(attachFile!=null){
				String[] filenames=attachFile.split(",");
				for(int i=0;i<filenames.length;i++){
					filenames[i]=","+filenames[i];
				}
				foodSafty.setAttachFileNames(filenames);
			}
			if(attachFiles!=null){
				String[] filenames=attachFiles.split(",");
				for(int i=0;i<filenames.length;i++){
					filenames[i]=","+filenames[i];
				}
				foodSafty.setAttachFileNames(filenames);
			}
			foodSafty = foodSaftyService.addFoodSafty(foodSafty);
			return SUCCESS;
	}
	@Action(value = "updateFoodSaftySignDetailMobile", results = {
			@Result(name = "success", type = "json", params = { "root", "true", "ignoreHierarchy",
					"false" }),
			@Result(name = "error", type = "json", params = { "root", "errorMessage",
					"ignoreHierarchy", "false" }) })
	public String updateFoodSaftySignDetailMobile() throws Exception {

		foodSaftyService.signFoodSafty(foodSafty);
		return SUCCESS;
	}
	
	@Action(value = "viewFoodSaftyMobile", results = {
			@Result(name = "success", type = "json", params = { "root", "foodSafty", "ignoreHierarchy",
					"false" }),
			@Result(name = "error", type = "json", params = { "root", "errorMessage",
					"ignoreHierarchy", "false" }) })
	public String viewFoodSaftyMobile() throws Exception {

		foodSafty=foodSaftyService.getFoodSaftyById(foodSafty.getId());
		return SUCCESS;
	}
	
	@Action(value = "listFoodSaftyMobile", results = {
			@Result(name = "success", type = "json", params = { "root", "gridPage",
					"ignoreHierarchy", "false" }),
			@Result(name = "error", type = "json", params = { "root", "errorMessage",
					"ignoreHierarchy", "false" }) })
	public String listFoodSaftyMobile() throws Exception {
		gridPage = new GridPage(ControllerHelper.processAllOrgRelativeName(foodSaftyService.getFoodSaftyListByQuery
				(foodSafty, page, rows, sidx, sord),
				organizationDubboService, new String[] { "organization" }, null));

		return SUCCESS;
	}
	
	@Action(value = "dispatchOperate", results = {
			@Result(name = "success", location = "/serviceList/foodAndDrugsManage/foodSafty/maintainFoodSafty.jsp"),
			@Result(name = "sign", location = "/serviceList/foodAndDrugsManage/foodSafty/signFoodSafty.jsp"),
			@Result(name = "reply", location = "/serviceList/foodAndDrugsManage/foodSafty/replyFoodSafty.jsp"),
			@Result(name = "error", type = "json", params = { "root", "resultResponse.resultMsg" }) })
	public String dispatchOperate() throws Exception {
		if(mode.equals("add")){
			if(foodSafty==null){
				foodSafty=new FoodSafty();
			}
			foodSafty.setInputTime(new Date());
			return SUCCESS;
		}else if(mode.equals("edit")){
			viewFoodSafty();
			return SUCCESS;
		}else if(mode.equals("sign")){
			viewFoodSafty();
			foodSafty.setSignPeople(ThreadVariable.getUser().getName());
			foodSafty.setSignDate(new Date());
			return "sign";
		}else if(mode.equals("reply")){
			if(foodSafty==null){
				logger.error("参数错误！");
				errorMessage="参数错误";
				return ERROR;
			}
			reply=new Reply();
			reply.setReplyPeople(ThreadVariable.getUser().getName());
			reply.setReplyDate(new Date());
			foodSafty.setReply(reply);
			return "reply";
		}
		logger.error("没有该请求！");
		errorMessage="没有该请求";
		return ERROR;
	}
	
	/**
	 * 查询列表
	 * 
	 * @return
	 */
	@Action(value = "getFoodSaftyList", results = {
			@Result(name = "success", type = "json", params = { "root", "gridPage",
					"ignoreHierarchy", "false", "excludeNullProperties", "true" }),
			@Result(name = "error", type = "json", params = { "root", "resultResponse.resultMsg" }) })
	public String getFoodSaftyList() throws Exception {
			PageInfo<FoodSafty> pageInfo = foodSaftyService.getFoodSaftyListByQuery(
					foodSafty, page, rows, sidx, sord);
			gridPage = new GridPage(pageInfo);
			return SUCCESS;
	}
	
	/**
	 * 查询列表
	 * 
	 * @return
	 */
	@Action(value = "getReplyList", results = {
			@Result(name = "success", location = "/serviceList/foodAndDrugsManage/foodSafty/viewFoodSaftyReply.jsp"),
			@Result(name = "error", type = "json", params = { "root", "resultResponse.resultMsg" }) })
	public String getReplyList() throws Exception {
			reply.setServiceType(TYPE);
			serviceListReplyList = replyService.getReplyList(
					reply , page, rows, sidx, sord).getResult();
			return SUCCESS;
	}
	
	/**
	 * 保存食品安全协管
	 * 
	 * @return
	 */
	@Action(value = "addFoodSafty", results = {
			@Result(name = "success", type = "json", params = { "root", "foodSafty",
					"ignoreHierarchy", "false", "excludeNullProperties", "true" }),
			@Result(name = "error", type = "json", params = { "root", "resultResponse.resultMsg" }) })
	public String addFoodSafty() throws Exception {
			if (foodSafty == null) {
				logger.error("食品安全协管新增参数错误！");
				return ERROR;
			}
			foodSafty = foodSaftyService.addFoodSafty(foodSafty);
			return SUCCESS;
	}

	/**
	 *	更新食品安全协管
	 * 
	 * @return
	 */
	@Action(value = "updateFoodSafty", results = { @Result(name = "success", type = "json", params = {
			"root", "foodSafty", "ignoreHierarchy", "false", "excludeNullProperties", "true" }) })
	public String updateFoodSafty() throws Exception {
			if (foodSafty == null) {
				logger.error("食品安全协管修改参数错误！");
				return ERROR;
			}
			foodSafty = foodSaftyService.updateFoodSafty(foodSafty);
			return SUCCESS;
	}

	/**
	 * 查询企业
	 * 
	 * @return
	 */
	@Action(value = "viewFoodSafty", results = {
			@Result(name = "success", type = "json", params = { "root", "foodSafty",
					"ignoreHierarchy", "false" }),
			@Result(name = "error", type = "json", params = { "root", "resultResponse.resultMsg" }) })
	public String viewFoodSafty() throws Exception {
			if(foodSafty==null||foodSafty.getId()==null){
				logger.error("食品安全协管单例查询参数错误:参数不正确");
				return ERROR;
			}
			foodSafty=foodSaftyService.getFoodSaftyById(foodSafty.getId());
			return SUCCESS;
	}
	
	/**
	 * 查看
	 * 
	 * @return
	 */
	@Action(value = "viewFoodSaftyDetail", results = {
			@Result(name = "success", location = "/serviceList/foodAndDrugsManage/foodSafty/viewFoodSafty.jsp"),
			@Result(name = "error", type = "json", params = { "root", "resultResponse.resultMsg" }) })
	public String viewFoodSaftyDetail() throws Exception {
			if(foodSafty==null||foodSafty.getId()==null){
				logger.error("食品安全协管单例查询参数错误:参数不正确");
				return ERROR;
			}
			foodSafty=foodSaftyService.getFoodSaftyById(foodSafty.getId());
			return SUCCESS;
	}
	
	/**
	 * 批量删除食品安全协管
	 * 
	 * @return
	 */
	@Action(value = "deleteFoodSafty", results = {
			@Result(name = "success", type = "json", params = { "root", "true" }),
			@Result(name = "error", type = "json", params = { "root", "resultResponse.resultMsg" }) })
	public String deleteFoodSafty() throws Exception {
			if (!StringUtil.isStringAvaliable(ids)) {
				logger.error("食品安全协管批量删除参数错误！");
				return ERROR;
			}
			foodSaftyService.deleteFoodSaftyByIds(ids);
			return SUCCESS;
	}
	
	/**
	 *	签收食品安全协管
	 * 
	 * @return
	 */
	@Action(value = "signFoodSafty", results = { @Result(name = "success", type = "json", params = {
			"root", "foodSafty", "ignoreHierarchy", "false", "excludeNullProperties", "true" }) })
	public String signFoodSafty() throws Exception {
			if (foodSafty == null) {
				logger.error("食品安全协管修改参数错误！");
				return ERROR;
			}
			foodSafty = foodSaftyService.signFoodSafty(foodSafty);
			return SUCCESS;
	}
	
	/**
	 *	回复食品安全协管
	 * 
	 * @return
	 */
	@Action(value = "replyFoodSafty", results = { @Result(name = "success", type = "json", params = {
			"root", "foodSafty", "ignoreHierarchy", "false", "excludeNullProperties", "true" }) })
	public String replyFoodSafty() throws Exception {
			if (foodSafty == null||foodSafty.getReply()==null) {
				logger.error("食品安全协管修改参数错误！");
				return ERROR;
			}
			foodSafty = foodSaftyService.replyFoodSafty(foodSafty);
			return SUCCESS;
	}
	
	/**
	 * 附件下载
	 * @return
	 * @throws Exception
	 */
	@Action(value = "downLoadAttachFile")
	public String downLoadActualFile() throws Exception {
		if (attachFileId == null) {
			throw new BusinessValidationException("参数为空");
		}
		ServiceListAttch attachFile = serviceListAttachService
				.getServiceListAttchById(attachFileId);
		if (attachFile == null) {
			throw new BusinessValidationException("附件不存在");
		}
			inputStream = new java.io.FileInputStream(FileUtil.getWebRoot() + File.separator
					+ attachFile.getPath());
			downloadFileName = new String(attachFile.getName().getBytes("gbk"), "ISO8859-1");
		return STREAM_SUCCESS;
	}
	
	/**
	 * 附件下载
	 * @return
	 * @throws Exception
	 */
	@Action(value = "downLoadReplyActualFile")
	public String downLoadReplyActualFile() throws Exception {
		if (attachFileId == null) {
			throw new BusinessValidationException("参数为空");
		}
		ReplyAttch replyAttch = replyAttachService
				.getReplyAttchById(attachFileId);
		if (replyAttch == null) {
			throw new BusinessValidationException("附件不存在");
		}
			inputStream = new java.io.FileInputStream(FileUtil.getWebRoot() + File.separator
					+ replyAttch.getPath());
			downloadFileName = new String(replyAttch.getName().getBytes("gbk"), "ISO8859-1");
		return STREAM_SUCCESS;
	}
	
	public FoodSafty getFoodSafty() {
		return foodSafty;
	}

	public void setFoodSafty(FoodSafty foodSafty) {
		this.foodSafty = foodSafty;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Long getAttachFileId() {
		return attachFileId;
	}

	public void setAttachFileId(Long attachFileId) {
		this.attachFileId = attachFileId;
	}

	public Reply getReply() {
		return reply;
	}

	public void setReply(Reply reply) {
		this.reply = reply;
	}
	public String getAttachFile() {
		return attachFile;
	}
	public void setAttachFile(String attachFile) {
		this.attachFile = attachFile;
	}
	public String getAttachFiles() {
		return attachFiles;
	}
	public void setAttachFiles(String attachFiles) {
		this.attachFiles = attachFiles;
	}
	public List<Reply> getServiceListReplyList() {
		return serviceListReplyList;
	}
	public void setServiceListReplyList(List<Reply> serviceListReplyList) {
		this.serviceListReplyList = serviceListReplyList;
	}
	
}
