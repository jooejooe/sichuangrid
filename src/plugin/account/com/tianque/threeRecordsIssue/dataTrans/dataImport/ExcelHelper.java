package com.tianque.threeRecordsIssue.dataTrans.dataImport;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFComment;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Comment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.tianque.core.util.BaseInfoTables;
import com.tianque.core.util.FileUtil;
import com.tianque.core.util.GridProperties;
import com.tianque.core.validate.ValidateResult;
import com.tianque.exception.base.OperationFailedException;

/**
 * 代码库:sichuangrid1.9.1_account 作 者:liuchuanjiang@hztianque.com 日 期: 2015/3/9.
 */
public class ExcelHelper {

	private InputStream inputStream;
	private String templates;
	private String dataType;//
	private String exportExcelName;// 错误数据表格的名字
	private File storedFile;
	private HSSFPatriarch drawing;// 操作EXCEL表的容器
	private HSSFWorkbook workbook;// 工作薄
	private HSSFSheet sheet;// 表
	private HSSFCellStyle style;// 表的样式
	private FileOutputStream fOut;
	private boolean flag = true;// 标识错误的Excel是否被输出

	private String exportFileUrl;// 错误数据表路径
	public final static Logger logger = LoggerFactory
			.getLogger(ExcelHelper.class);

	public ExcelHelper(String templates, String dataType, String exportExcelName) {
		this.templates = templates;
		this.dataType = dataType;
		this.exportExcelName = exportExcelName;
	}

	public void createExportDataExcel() {
		String dir = "resource/datatemplate/";
		/*
		 * String tempName = ImportTemplatesSetting
		 * .getImportTemplatesVo(templates).getUrl();
		 */
		String tempName = dir + templates + ".xls";
		try {
			inputStream = new java.io.FileInputStream(FileUtil.getWebRoot()
					+ File.separator + tempName);
			if (tempName.lastIndexOf("/") != -1)
				tempName = tempName.substring(tempName.lastIndexOf("/") + 1,
						tempName.length());
			String extendName = "";
			if (tempName.indexOf(".") != -1) {
				extendName = tempName.substring(tempName.lastIndexOf("."),
						tempName.length());
			}
			BufferedInputStream bufferedInputStream = new BufferedInputStream(
					inputStream);

			File file = createStoreFile(extendName);

			FileOutputStream fileOutputStream = new FileOutputStream(file);
			BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(
					fileOutputStream);

			int i = -1;
			while ((i = bufferedInputStream.read()) != -1) {
				bufferedOutputStream.write(i);
			}

			bufferedInputStream.close();
			inputStream.close();

			bufferedOutputStream.close();
			fileOutputStream.close();
		} catch (FileNotFoundException e) {
			throw new OperationFailedException("文件打开失败!", e);
		} catch (UnsupportedEncodingException e) {
			throw new OperationFailedException("文件打开失败!", e);
		} catch (Exception e) {
			logger.error("文件下载错误", e);
		}
	}

	// 创建表的引用
	public void createExcelCite() throws Exception {
		this.workbook = new HSSFWorkbook(new FileInputStream(FileUtil
				.getWebRoot()
				+ File.separator
				+ GridProperties.UPLOAD_FILE_ERRORMESSAGE
				+ File.separator + exportExcelName));
		this.sheet = workbook.getSheet(BaseInfoTables
				.getTypeDisplayNames(dataType)
				+ "登记表");
		this.sheet = workbook.getSheetAt(0);
		this.style = getStyle(workbook);
		this.drawing = sheet.createDrawingPatriarch();
	}

	public File createZipFile(String fileName) throws Exception {
		File storedFile = new File(FileUtil.getWebRoot() + File.separator
				+ GridProperties.UPLOAD_FILE_ERRORMESSAGE + File.separator
				+ fileName);
		if (!storedFile.exists()) {
			storedFile.createNewFile();
		}
		return storedFile;
	}

	/**
	 * 填写单位信息到导出excel中
	 * 
	 * @param totalDatas
	 * @param unitRow
	 *            单位所在行
	 */
	public void fullUnit(String[][] totalDatas, int unitRow) {
		HSSFRow row = sheet.createRow(unitRow);
		HSSFCell cell;
		for (int i = 0; i < totalDatas[unitRow].length; i++) {
			cell = row.createCell((short) i);

			// 设置单元格的值

			if (i % 2 == 0 && i != 0 && totalDatas[1][i].length() > 0) {
				HSSFRichTextString ts = new HSSFRichTextString(totalDatas[1][i]);
				ts.applyFont(0, totalDatas[1][i].length(),
						getFontNotColorStyle(workbook));
				if (totalDatas[unitRow][i].indexOf("*") != -1) {
					ts.applyFont(totalDatas[1][i].indexOf("*"),
							totalDatas[1][i].length(),
							getFontColorStyle(workbook));
				}

				cell.setCellValue(ts);
				cell.setCellStyle(getCenterStyle(workbook));

			} else {
				cell.setCellValue(totalDatas[unitRow][i]);
				cell.setCellStyle(getFontStyle(workbook));
			}
		}
	}

	// 将单条错误信息加入到表中
	public void addErrorMessage(ValidateResult result, String[] rowData,
			int currentRow) {
		try {

			addNewErrorRow(result, rowData, workbook, sheet, style, currentRow);

		} catch (FileNotFoundException e) {
			throw new OperationFailedException("文件不存在!", e);
		} catch (IOException e) {
			throw new OperationFailedException("文件不存在!", e);
		} catch (Exception e) {
			logger.error("addErrorMessage", e);
		}
	}

	public void outFile(int currentDealRow, int importDataNum) throws Exception {
		fOut = new FileOutputStream(FileUtil.getWebRoot() + File.separator
				+ GridProperties.UPLOAD_FILE_ERRORMESSAGE + File.separator
				+ exportExcelName);
		synchronized (fOut) {
			if (currentDealRow == importDataNum && flag) {
				workbook.write(fOut);
				fOut.flush();
				fOut.close();
				flag = false;
			}
		}

	}

	private void addNewErrorRow(ValidateResult result, String[] rowData,
			HSSFWorkbook workbook, HSSFSheet sheet, HSSFCellStyle style,
			int currentRow) throws Exception {
		// validateErrorOccur = true;
		HSSFRow row = sheet.createRow((short) currentRow);
		HSSFCell cell;
		for (int i = 0; i < rowData.length; i++) {
			cell = row.createCell((short) i);
			// 设置单元格的值
			cell.setCellValue(rowData[i]);
		}
		Comment commentnew;
		Map<String, String> maps = result.getMapMessages();
		for (String key : maps.keySet()) {
			commentnew = getComment(workbook, sheet, maps.get(key));
			cell = row.createCell((short) Integer.parseInt(key) - 1);
			cell.setCellValue(rowData[Integer.parseInt(key) - 1]);
			cell.setCellStyle(style);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);// 设置单元格格式为文本格式
			cell.setCellComment(commentnew);
		}

	}

	// 添加批注
	private Comment getComment(HSSFWorkbook workbook, HSSFSheet sheet,
			String info) {

		HSSFComment comment = drawing.createComment(new HSSFClientAnchor(100,
				0, 0, 0, (short) 1, 1, (short) 6, 8));
		// 输入批注信息
		comment.setString(new HSSFRichTextString(info));
		comment.setAuthor("Apache POI");
		return comment;
	}

	// 设置表格字体颜色
	private HSSFCellStyle getFontStyle(HSSFWorkbook workbook) {
		HSSFCellStyle style = workbook.createCellStyle();
		HSSFFont font = workbook.createFont();
		font.setFontHeightInPoints((short) 12);// 字号
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 加粗
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//  居中 
		return style;
	}

	// 设置单元格字居中
	private HSSFCellStyle getCenterStyle(HSSFWorkbook workbook) {
		HSSFCellStyle style = workbook.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//  居中 
		return style;
	}

	// 设置字体颜色
	private HSSFFont getFontColorStyle(HSSFWorkbook workbook) {
		HSSFFont font = workbook.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 12);// 字号
		font.setColor(HSSFColor.RED.index);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); // 宽度
		return font;
	}

	// 设置字体不设颜色
	private HSSFFont getFontNotColorStyle(HSSFWorkbook workbook) {
		HSSFFont font = workbook.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 12);// 字号
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 加粗
		return font;
	}

	// 设置表格单元背景颜色
	private HSSFCellStyle getStyle(HSSFWorkbook workbook) {
		HSSFCellStyle style = workbook.createCellStyle();
		style.setFillForegroundColor(HSSFColor.RED.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		HSSFDataFormat format = workbook.createDataFormat();
		style.setDataFormat(format.getFormat("@"));// 设置CELL格式

		return style;
	}

	private File createStoreFile(String extendName) throws Exception {
		exportExcelName = exportExcelName + extendName;
		storedFile = new File(FileUtil.getWebRoot() + File.separator
				+ GridProperties.UPLOAD_FILE_ERRORMESSAGE + File.separator
				+ exportExcelName);
		if (!storedFile.getParentFile().isDirectory()) {
			storedFile.getParentFile().mkdirs();
		}
		if (!storedFile.exists()) {
			storedFile.createNewFile();
		}
		setExportFileUrl(FileUtil.getWebRoot() + File.separator
				+ GridProperties.UPLOAD_FILE_ERRORMESSAGE + File.separator
				+ exportExcelName);
		return storedFile;
	}

	public String getExportFileUrl() {
		return exportFileUrl;
	}

	public void setExportFileUrl(String exportFileUrl) {
		this.exportFileUrl = exportFileUrl;
	}
}