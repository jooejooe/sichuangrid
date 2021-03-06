package com.tianque.datatransfer.newExcelImport;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Iterator;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import com.tianque.baseInfo.base.domain.AttentionPopulation;
import com.tianque.baseInfo.base.domain.Countrymen;
import com.tianque.cache.PageInfoCacheThreadLocal;
import com.tianque.core.datatransfer.ExcelImportHelper;
import com.tianque.core.datatransfer.ExcelReader;
import com.tianque.core.datatransfer.data.ExcelData;
import com.tianque.core.datatransfer.util.CircularDoubleBufferedQueue;
import com.tianque.core.datatransfer.util.DataImportVo;
import com.tianque.core.util.BaseInfoTables;
import com.tianque.core.util.ConstantsProduct;
import com.tianque.core.util.StringUtil;
import com.tianque.core.util.ThreadVariable;
import com.tianque.core.validate.ValidateResult;
import com.tianque.datatransfer.DataConvert;
import com.tianque.datatransfer.DataConvertDefine;
import com.tianque.datatransfer.ErrorExcelHelper;
import com.tianque.datatransfer.ThreadPool;
import com.tianque.datatransfer.UpdateTicketInfo;
import com.tianque.datatransfer.ValidateExcelHeader;
import com.tianque.datatransfer.dataconvert.CountyDataConverterPoxy;
import com.tianque.domain.Organization;
import com.tianque.domain.Session;
import com.tianque.domain.User;
import com.tianque.plugin.datatransfer.dataconvert.AbstractTempDataConverter;
import com.tianque.service.util.PopulationType;
import com.tianque.state.TicketState;

public class NewExcelDataimportThread extends Thread {

	public final static Logger logger = LoggerFactory
			.getLogger(NewExcelDataimportThread.class);

	// private int everyThreadHandleNum = 500;// 每个线程处理的数量

	private String ticketId;// 缓存ID
	private String fileUrl;// 文件路径
	private int firstDataRow;// 第一行数据的行数
	private String templates;
	private String dataType;//
	private Session session;
	private boolean validateErrorOccur = false;// 验证是否有错误信息
	private DataConvert converter;// 数据转换类
	private ApplicationContext appContext;
	private FileInputStream file;
	private ExcelData excelDatas;// 导入的工作薄的所有数据（包含隐藏的工作表的数据）
	private int totalRow;// 表中的全部数据
	private static final int LIMIT_ROW_NUM = 10000;// 能够导入的数据的最大量

	private boolean isIntercept = false;// 是否中断

	private InputStream inputStream;
	private File storedFile;
	private String errorMessageExcelName;// 错误数据表格的名字
	private String[][] totalDatas;// 导入表格的所有数据
	private String[][] beanDatas;// 对应表字段的数据

	private Integer currentRowInErrorExcel;// 错误数据表格中数据的行数
	private Organization headerOrg;// 表头组织机构
	private Integer currentDealRow = 0;// 当前处理行数
	private int importDataNum;// 导入数据的长度
	private Integer nullRowNum = 0;// 空行的数量
	private ErrorExcelHelper errorExcel;
	private UpdateTicketInfo updateTicketInfo;// 修改缓存的信息
	private CircularDoubleBufferedQueue queue;
	/** 导入功能预留标示符 */
	private String module;
	/** 是否是为乡镇级以上的领导视图提供的导入的 */
	private int isTownLeaderImport = 0;
	// private PlatformTransactionManager jtaTransactionManager;

	private String uuid;
	private String fileName;
	private Integer errorFileCount = 1;
	private static final int ERROR_ROW_NUM = 1000;
	private static final int IMPORT_END = 2;// 导入结束标识

	public NewExcelDataimportThread(Session session,
			ApplicationContext appContext, String ticketId, String fileUrl,
			String dataType, int firstDataRow, String templates,
			CircularDoubleBufferedQueue queue, String errorExcelName,
			String fileName, String module, int isTownLeaderImport)
			throws Exception {
		this.appContext = appContext;
		this.ticketId = ticketId;
		this.fileUrl = fileUrl;
		this.dataType = dataType;
		this.firstDataRow = firstDataRow;
		this.session = session;
		this.templates = templates;
		this.currentRowInErrorExcel = firstDataRow;
		this.errorMessageExcelName = errorExcelName;
		this.uuid = errorExcelName;
		this.queue = queue;
		this.fileName = fileName;
		this.module = module;
		this.isTownLeaderImport = isTownLeaderImport;
		init();
	}

	private void init() throws Exception {

		file = openFile(fileUrl);
		excelDatas = ExcelReader.readFile(file);
		createErrorExcel(errorMessageExcelName);
		// jtaTransactionManager = (PlatformTransactionManager) appContext
		// .getBean("txManager");

		updateTicketInfo = new UpdateTicketInfo(appContext);

	}

	private void createErrorExcel(String errorExcelName) throws Exception {
		errorExcel = new ErrorExcelHelper(templates, dataType, errorExcelName);
		errorExcel.createErrorDataExcel();
		errorExcel.createExcelCite();// 创建表的引用
	}

	// // 多线程分配任务
	// private void allotTask() {
	// int threadNums = importDataNum % everyThreadHandleNum == 0 ?
	// importDataNum
	// / everyThreadHandleNum
	// : (importDataNum / everyThreadHandleNum) + 1;
	// for (int i = 0; i < threadNums; i++) {
	// if (i == threadNums - 1) {
	// ThreadPool.getInstance().execute(
	// new ExcelDatasHandleThread(getDatas(
	// everyThreadHandleNum * i + firstDataRow,
	// importDataNum - everyThreadHandleNum
	// * (threadNums - 1),
	// totalDatas[0].length)));
	// } else {
	// ThreadPool.getInstance().execute(
	// new ExcelDatasHandleThread(getDatas(
	// everyThreadHandleNum * i + firstDataRow,
	// everyThreadHandleNum, totalDatas[0].length)));
	//
	// }
	// }
	//
	// }

	// private String[][] getDatas(int startNum, int num, int colNum) {
	// if (num < 0) {
	// // fateson add 社会组织 导入空模板的时候 一致停留在 校验数据不动
	// num = 0;
	// }
	// String[][] threadData = new String[num][colNum];
	// for (int i = startNum, j = 0; j < num; i++, j++) {
	//
	// threadData[j] = totalDatas[i];
	// }
	// return threadData;
	// }

	@Override
	public void run() {
		createThreadUser();

		if (!validateParames()) {
			return;
		}

		converter = getDataConvert(dataType, appContext);

		if (isConverterNull()) {
			return;
		}
		try {
			pushToQueue();
		} catch (Exception e) {
			logger.error("用户排队时异常：" + e.getMessage());
		}
		try {
			proccessExcelDatas();
		} finally {
			ThreadPool.remove(this.getId());
		}

	}

	private void pushToQueue() throws InterruptedException {
		queue.put(ticketId);
		queue.take();
		updateUserTicketNumber();
	}

	private void updateUserTicketNumber() {
		for (Iterator it = DataImportVo.getTable().keySet().iterator(); it
				.hasNext();) {
			String key = (String) it.next();
			Integer value = DataImportVo.getTable().get(key);
			if (value.intValue() > 0) {
				DataImportVo.getTable().put(key, value - 1);
			}
		}
	}

	private void updateNextStepMsgTitle(String title) {
		updateTicketInfo.updateTicketInfo(ticketId, "{msg:'" + title + "'}",
				currentDealRow, importDataNum, currentRowInErrorExcel,
				firstDataRow, nullRowNum, TicketState.DOING);
	}

	private void proccessExcelDatas() {
		validateExcelDatas();
	}

	private void resolveAndPersistenceExcelDatas() {
		updateNextStepMsgTitle("文件已解析，准备校验数据格式");

		try {
			// 转换数据，验证并添加到数据库
			handleDomains(null);
		} catch (Exception e) {
			logger.error("");
		}

		if (!validateErrorOccur) {
			updateCompleteMsgTitle("数据已保存，处理完成");
		} else {
			if (currentDealRow == importDataNum) {
				updateNextStepMsgTitle("数据已保存，处理完成");
			}
		}

		updateExcelImportLog();
	}

	private void updateExcelImportLog() {
		updateTicketInfo.updateLogNum(uuid, importDataNum,
				currentRowInErrorExcel - firstDataRow);
		updateTicketInfo.updateLogStatus(uuid, IMPORT_END, fileName);
	}

	private void validateExcelDatas() {
		updateNextStepMsgTitle("正在解析导入的文件");
		try {
			totalDatas = excelDatas.getSheetDatas(ExcelData.FIRST);
			beanDatas = excelDatas.getSheetDatas(ExcelData.BEAN);
			if (beanDatas.length == 0) {
				updateErrorTitleAndRowMsg("导入数据时出错，程序已终止，详情参见下方错误信息列表", -1,
						"数据模板有误，请下载最新模板");
				return;
			}
		} catch (Exception e) {
			updateErrorTitleAndRowMsg("导入数据时出错，程序已终止，详情参见下方错误信息列表", -1,
					"数据模板有误，请下载最新模板");
			return;
		}
		if (validateVersion()) {
			return;
		}
		importDataNum = totalDatas.length - firstDataRow;
		errorExcel.fullUnit(totalDatas);
		ValidateExcelHeader validateExcelHeader = new ValidateExcelHeader(
				appContext, converter, ticketId, templates, dataType,
				firstDataRow, importDataNum, isTownLeaderImport);
		if (validateExcelHeader.validateExcelHeader(totalDatas)) {
			return;
		}
		headerOrg = validateExcelHeader.getHeaderOrg();
		resolveAndPersistenceExcelDatas();
	}

	private boolean validateVersion() {
		FileInputStream errorfile = openFile(errorExcel.getErrorFileUrl());
		try {
			excelDatas = ExcelReader.readFile(errorfile);
		} catch (IOException e) {
			updateErrorTitleAndRowMsg("导入数据时出错，程序已终止，详情参见下方错误信息列表", -1,
					"读表数据有误");
			return true;
		}
		String[][] errorBeanDatas = excelDatas.getSheetDatas(ExcelData.BEAN);
		if (!Arrays.equals(beanDatas[0], errorBeanDatas[0])) {
			updateErrorTitleAndRowMsg("导入数据时出错，程序已终止，详情参见下方错误信息列表", -1,
					"数据模板有误，请下载最新模板");
			return true;
		}
		return false;
	}

	/*
	 * private void handle(String[][] datas) throws Exception { for (int
	 * rowIndex = 0; rowIndex < datas.length; rowIndex++) { if (isIntercept) {
	 * return; } updateNextStepMsgTitle("正在导入数据。。。"); ValidateResult result =
	 * new ValidateResult(); String[] rowData = datas[rowIndex];
	 * 
	 * ExcelImportHelper.realRow.set(rowIndex + 1); if (!isBlankRow(rowData)) {
	 * handleValidData(rowData, result, rowIndex); } else {
	 * handleNullData(rowData); } if (isIntercept) { return; }
	 * updateTicketErrorMsg(ticketId, result, TicketState.DOING); //
	 * synchronized (ExcelDatasHandleThread.class) { // currentDealRow++; // } }
	 * }
	 */

	private void handleData(String[][] dataTemp) throws Exception {
		for (int rowIndex = 0; rowIndex < importDataNum; rowIndex++) {
			if (isIntercept) {
				return;
			}
			updateNextStepMsgTitle("正在导入数据。。。");
			ValidateResult result = new ValidateResult();
			String[] rowData = totalDatas[rowIndex + firstDataRow];

			ExcelImportHelper.realRow.set(rowIndex + 1);
			if (!isBlankRow(rowData)) {
				handleValidData(rowData, result, rowIndex);
			} else {
				handleNullData(rowData);
			}

			if (isIntercept) {
				return;
			}
			updateTicketErrorMsg(ticketId, result, TicketState.DOING);
			if (rowIndex % 100 == 0 && rowIndex > 0) {
				updateTicketInfo.updateLogNum(uuid, currentDealRow,
						currentRowInErrorExcel - firstDataRow);
			}
			PageInfoCacheThreadLocal.commit();
			currentDealRow++;
		}
	}

	// 处理数据
	private void handleDomains(String[][] datas) throws Exception {
		// TransactionStatus status = beginTransaction();
		try {
			// handle(datas);
			updateTicketInfo.addLog(uuid, fileName, dataType, importDataNum,
					templates);
			createThreadUser();
			handleData(datas);
			errorExcel.outFile(currentDealRow, importDataNum);
			createErrorExcelZip();
		} catch (Exception e) {
			logger.error("导入数据时出错，程序已终止，详情参见下方错误信息列表", e);
			PageInfoCacheThreadLocal.rollback();
			return;
			// } finally {
			// try {
			// // commitTransaction(status);
			// } catch (Exception e) {
			// try {
			// handle(datas);
			// } catch (Exception e1) {
			// logger.error("导入数据时出错，程序已终止，详情参见下方错误信息列表", e.getMessage());
			// return;
			// }
			// }
		}
	}

	// 处理空数据
	private void handleNullData(String[] rowData) {
		// synchronized (ExcelDatasHandleThread.class) {
		nullRowNum++;
		// }
	}

	// 处理有效数据
	private void handleValidData(String[] rowData, ValidateResult result,
			int rowIndex) {
		Object domain = null;
		try {
			domain = converter.convertToDomain(rowData, result, beanDatas,
					headerOrg);
		} catch (Exception e) {
			updateErrorTitleAndRowMsg("导入数据时出错，程序已终止，详情参见下方错误信息列表", -1,
					e.getMessage());
			isIntercept = true;
			return;
		}

		if (result.getMapMessages().size() > 0) {
			validateConvertData(result, rowData, domain, rowIndex);
		} else {
			// 处理数据时需要同步防止导入同步数据
			validateRowData(result, domain, rowIndex, rowData);
		}

	}

	private void validateConvertData(ValidateResult result, String[] rowData,
			Object domain, int rowIndex) {
		ValidateResult vresult = null;
		try {
			vresult = converter.validate(domain, rowIndex + 1);
		} catch (Exception e) {
			logger.error("处理数据时发生错误！");
		}
		if (vresult != null
				&& StringUtil.isStringAvaliable(vresult.getErrorMessages())) {
			result.getMapMessages().putAll(vresult.getMapMessages());
		}
		handleErrorData(result, rowData);
	}

	// 数据验证
	private void validateRowData(ValidateResult result, Object domain,
			int rowIndex, String[] rowData) {
		ValidateResult vresult = null;
		try {
			// fateson add 在验证是否是 户籍还是流动人口的时候用
			converter.setheaderOrg(headerOrg);
			vresult = converter.validate(domain, rowIndex + 1);
		} catch (Exception e) {
			logger.error("处理数据时发生错误！", e);
		}
		if (vresult == null || "".equals(vresult.getMapErrorMessages())) {
			if (handleCurrectData(domain) == null) {
				result.addErrorMessage(rowIndex + firstDataRow,
						"数据保存数据库时失败，请检查数据正确性！");
				handleErrorData(vresult, rowData);
			}
		} else {
			result.addAllErrorMessage(vresult);
			handleErrorData(result, rowData);
		}
	}

	// 处理正确数据
	private Object handleCurrectData(Object domain) {
		if (!converter.isRepeatData(domain)) {
			// fateson add 如果这里是国人对象的话那么 还需要 流动转户籍 户籍转流动操作
			if (isCountyMen(domain, converter)) {
				CountyDataConverterPoxy converterPoxy = createCountyDataConverterPoxy(converter);
				domain = converterPoxy.persistenceDomain(converter,
						(Countrymen) domain);
			} else {
				if (domain instanceof Countrymen) {
					String actualPopulationType = ((Countrymen) domain)
							.getActualPopulationType();
					((Countrymen) domain)
							.setActualPopulationType("户籍人口"
									.equals(actualPopulationType) ? PopulationType.HOUSEHOLD_STAFF
									: ("流动人口".equals(actualPopulationType) ? PopulationType.FLOATING_POPULATION
											: actualPopulationType));
				}
				domain = converter.persistenceDomain(domain);
			}
		} else {
			// fateson add 如果这里是国人对象的话那么 还需要 流动转户籍 户籍转流动操作
			if (isCountyMen(domain, converter)) {
				CountyDataConverterPoxy converterPoxy = createCountyDataConverterPoxy(converter);
				domain = converterPoxy.updateDomain(converter,
						(Countrymen) domain);
			} else {
				domain = converter.updateDomain(domain);
			}
		}
		return domain;
	}

	private CountyDataConverterPoxy createCountyDataConverterPoxy(
			DataConvert converter2) {
		CountyDataConverterPoxy converterPoxy = (CountyDataConverterPoxy) getDataConvert(
				"countyDataConverterPoxy", appContext);
		converterPoxy.setConvert(converter2);
		return converterPoxy;
	}

	private boolean isCountyMen(Object domain, DataConvert converter) {
		// 判断不是场所和房屋 既不是 流动 也不是户籍 数据管理中的人员也要排除
		if ((domain instanceof AttentionPopulation)
				&& !(converter instanceof AbstractTempDataConverter)) {
			return true;
		}
		return false;
	}

	// 处理错误数据
	private void handleErrorData(ValidateResult vresult, String[] rowData) {
		validateErrorOccur = true;
		handleErrorPersistentData(vresult, rowData);
	}

	// 处理数据库执行sql时出错的错误信息
	private void handleErrorPersistentData(ValidateResult vresult,
			String[] rowData) {
		// synchronized (ExcelDatasHandleThread.class) {

		if (ERROR_ROW_NUM * errorFileCount <= currentRowInErrorExcel
				- firstDataRow) {
			try {
				errorExcel.outFile(currentDealRow, currentDealRow);
				createErrorExcel(errorMessageExcelName + errorFileCount);
				errorExcel.fullUnit(totalDatas);
				errorFileCount++;
			} catch (Exception e) {
				logger.error("创建错误日志文件时发生错误！", e);
			}
		}

		errorExcel.addErrorMessage(vresult, rowData, currentRowInErrorExcel
				- (ERROR_ROW_NUM * (errorFileCount - 1)));
		currentRowInErrorExcel = currentRowInErrorExcel + 1;
	}

	private void createErrorExcelZip() {
		if (errorFileCount == 1) {
			return;
		}
		try {
			File outFile = errorExcel.createZipFile(uuid + ".zip");
			String fileNameTemp = outFile.getCanonicalPath();
			fileNameTemp = fileNameTemp.substring(0, fileNameTemp.length() - 4);
			ZipOutputStream out = new ZipOutputStream(new FileOutputStream(
					outFile));
			byte[] buffer = new byte[1024];
			out.setEncoding("gbk");
			for (int j = 0; j < errorFileCount; j++) {
				FileInputStream fis;
				if (j == 0) {
					fis = new FileInputStream((String) fileNameTemp + ".xls");
				} else {
					fis = new FileInputStream((String) fileNameTemp + "" + j
							+ ".xls");
				}
				out.putNextEntry(new ZipEntry(BaseInfoTables
						.getTypeDisplayNames(dataType)
						+ "错误分析登记表("
						+ j
						+ ").xls"));
				int len;
				while ((len = fis.read(buffer)) != -1) {
					out.write(buffer, 0, len);
				}
				out.closeEntry();
				fis.close();
			}
			out.close();
		} catch (FileNotFoundException e) {
			logger.error("错误日志文件没有找到错误！", e);
		} catch (IOException e) {
			logger.error("错误日志文件读写异常错误！", e);
		} catch (Exception e) {
			logger.error("压缩错误日志文件异常错误！", e);
		}
	}

	private void updateCompleteMsgTitle(String title) {
		updateTicketInfo.updateCompleteMsgTitle(ticketId, title,
				currentDealRow, importDataNum, currentRowInErrorExcel,
				firstDataRow, nullRowNum);
	}

	private static boolean isBlankRow(String[] rowData) {
		if (rowData == null)
			return true;
		for (String data : rowData) {
			if (StringUtil.isStringAvaliable(data)) {
				return false;
			}
		}
		return true;
	}

	private boolean validateParames() {
		return isDataTypeLegitimate() && isExcel()
				&& isTotalRowLesserThanLIMIT_ROW_NUM();
	}

	private boolean isConverterNull() {
		if (converter == null) {
			updateErrorTitleAndRowMsg("打开文件出错，程序已终止，详情参见下方错误信息列表", -1,
					"不能导入此格式数据,沒有找到对应的dataConverter");
			return true;
		}
		return false;
	}

	private boolean isTotalRowLesserThanLIMIT_ROW_NUM() {
		totalRow = excelDatas.getSheetDatas(ExcelData.FIRST).length
				- firstDataRow + 1;
		if (totalRow > LIMIT_ROW_NUM + 1) {
			updateErrorTitleAndRowMsg("导入数据时出错，程序已终止，详情参见下方错误信息列表", -1,
					"导入数据记录行数不能大于" + LIMIT_ROW_NUM + "行!");
			return false;
		}
		if (totalRow <= 1) {
			updateErrorTitleAndRowMsg("导入数据时出错，程序已终止，详情参见下方错误信息列表", -1,
					"您不能导入空数据, 请检查您的导入文件!");
			return false;
		}
		return true;
	}

	private void updateErrorTitleAndRowMsg(String title, int row, String msg) {
		updateTicketInfo.updateErrorTitleAndRowMsg(ticketId, title, row, msg,
				currentDealRow, importDataNum, currentRowInErrorExcel,
				firstDataRow, nullRowNum);
		validateErrorOccur = true;
	}

	private boolean isDataTypeLegitimate() {
		if (!StringUtil.isStringAvaliable(dataType)
				|| DataConvertDefine.getConvertBeanDefine(dataType) == null) {
			updateErrorTitleAndRowMsg("打开文件出错，程序已终止，详情参见下方错误信息列表", 0,
					"不能导入此格式数据,沒有找到对应的dataConverter");
			return false;
		}
		return true;
	}

	private DataConvert getDataConvert(String dataType,
			ApplicationContext appContext) {
		return (DataConvert) appContext.getBean(DataConvertDefine
				.getConvertBeanDefine(dataType));
	}

	private boolean isExcel() {
		if (!"xls".equals(fileUrl.substring(fileUrl.lastIndexOf(".") + 1))) {
			updateErrorTitleAndRowMsg("上传文件出错，程序已终止，详情参见下方错误信息列表", 0,
					"只能选择后缀为.xls格式的文件");
			return false;
		}
		return true;
	}

	private void updateTicketErrorMsg(String ticketId, ValidateResult vresult,
			Integer state) {
		updateTicketInfo.updateTicketErrorMsg(ticketId, vresult,
				currentDealRow, importDataNum, currentRowInErrorExcel,
				firstDataRow, nullRowNum, state);

	}

	private FileInputStream openFile(String url) {
		logger.info("正在打开文件:{} .....", url);
		File file = new File(url);
		if (file == null || !file.exists()) {
			logger.error("文件{}不存在!", url);
			return null;
		} else {
			try {
				return new FileInputStream(file);
			} catch (FileNotFoundException e) {
				return null;
			}
		}
	}

	class ExcelDatasHandleThread extends Thread {
		private String[][] threadDatas;// 多线程分配的数据

		public ExcelDatasHandleThread(String[][] threadDatas) {
			this.threadDatas = threadDatas;
		}

		@Override
		public void run() {
			createThreadUser();
			try {
				handleDomains(threadDatas);
			} catch (Exception e) {
				logger.error("");
			}// 转换数据，验证并添加到数据库
			if (!validateErrorOccur) {
				updateCompleteMsgTitle("数据已保存，处理完成");
			} else {
				if (currentDealRow == importDataNum) {
					updateNextStepMsgTitle("数据已保存，处理完成");
				}
			}
			updateTicketInfo.updateLogNum(uuid, importDataNum,
					currentRowInErrorExcel - firstDataRow);
			updateTicketInfo.updateLogStatus(uuid, 2, fileName);

		}

	}

	private void createThreadUser() {
		ThreadVariable.setSession(session);
		User user = new User();
		user.setId(session.getUserId());
		user.setOrganization(session.getOrganization());
		ThreadVariable.setUser(user);
		ThreadVariable.setOrganization(session.getOrganization());
		ThreadVariable.setSourcesState(ConstantsProduct.SourcesState.IMPORT);
		ThreadVariable.setModule(module);
	}

	// private DefaultTransactionDefinition createTransacationDefine() {
	// DefaultTransactionDefinition result = new DefaultTransactionDefinition();
	// result.setTimeout(12000);
	// result.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
	// return result;
	// }

	// private TransactionStatus beginTransaction() {
	// return jtaTransactionManager.getTransaction(createTransacationDefine());
	// }
	//
	// private void commitTransaction(TransactionStatus status) {
	// jtaTransactionManager.commit(status);
	// }

	public boolean isIntercept() {
		return isIntercept;
	}

	public void setIntercept(boolean isIntercept) {
		this.isIntercept = isIntercept;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public File getStoredFile() {
		return storedFile;
	}

	public void setStoredFile(File storedFile) {
		this.storedFile = storedFile;
	}

	public int getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
	}

	public int getCurrentRowInErrorExcel() {
		return currentRowInErrorExcel;
	}

	public void setCurrentRowInErrorExcel(int currentRowInErrorExcel) {
		this.currentRowInErrorExcel = currentRowInErrorExcel;
	}

	public String getErrorMessageExcelName() {
		return errorMessageExcelName;
	}

	public void setErrorMessageExcelName(String errorMessageExcelName) {
		this.errorMessageExcelName = errorMessageExcelName;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

}
