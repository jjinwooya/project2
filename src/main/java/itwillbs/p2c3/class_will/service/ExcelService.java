package itwillbs.p2c3.class_will.service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import itwillbs.p2c3.class_will.mapper.AdminMapper;


@Service
public class ExcelService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	private static final Logger logger = LoggerFactory.getLogger(ExcelService.class);
	
	private static final int MAX_CELL_LENGTH = 32767;
	
    public byte[] createExcel(String title, List<String> headers, List<Map<String, Object>> data) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet(title);

        // 헤더 행 생성
        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.size(); i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers.get(i));
        }
        
        // 데이터 행 생성
        int rowNum = 1;
        for (Map<String, Object> rowData : data) {
            Row row = sheet.createRow(rowNum++);
            int cellNum = 0;
            for (String header : headers) {
                String text = rowData.get(header) == null ? "" : rowData.get(header).toString();
                if (text.length() > MAX_CELL_LENGTH) {
                    // 텍스트를 나누어 여러 셀에 분배
                    int parts = (int) Math.ceil((double) text.length() / MAX_CELL_LENGTH);
                    for (int j = 0; j < parts; j++) {
                        int start = j * MAX_CELL_LENGTH;
                        int end = Math.min(start + MAX_CELL_LENGTH, text.length());
                        Cell cell = row.createCell(cellNum++);
                        cell.setCellValue(text.substring(start, end));
                    }
                } else {
                    Cell cell = row.createCell(cellNum++);
                    cell.setCellValue(text);
                }
            }
        }

        // 각 열의 너비를 자동으로 조정
        for (int i = 0; i < headers.size(); i++) {
            sheet.autoSizeColumn(i);
        }

        // 출력 스트림에 엑셀 파일 쓰기
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();
        return outputStream.toByteArray();
    }
    
    public byte[] createExcelForm(String title, List<String> headers) throws IOException {
    	Workbook workbook = new XSSFWorkbook();
    	Sheet sheet = workbook.createSheet(title);

    	
        // _code 컬럼을 제외한 새로운 리스트 생성
        List<String> filteredHeaders = new ArrayList<>();
        for (String header : headers) {
            if (!header.equalsIgnoreCase("_code")) {
                filteredHeaders.add(header);
            }
        }
        
    	// 첫행 삽입
        Row headerRow = sheet.createRow(0);
        Row sampleRow = sheet.createRow(1);
        for (int i = 0; i < filteredHeaders.size(); i++) {
        	String header = filteredHeaders.get(i);
            Cell headerCell  = headerRow.createCell(i);
            headerCell.setCellValue(header);
            
            Cell sampleCell = sampleRow.createCell(i);
            sampleCell.setCellValue(getSampleData(header));
            
            // 컬럼 너비 자동 조정
            sheet.autoSizeColumn(i);
            sampleCell.setCellType(CellType.STRING);
        }
        
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        
        try {
            workbook.write(bos);
        } finally {
            bos.close();
        }
        workbook.close();
        return bos.toByteArray();
        
    }
    
    
    private String getSampleData(String header) {
        if (header.toUpperCase().contains("VARCHAR")) {
            return "EX) SAMPLE";
        } else if (header.toUpperCase().contains("INT")) {
            return "EX) 123";
        } else if (header.toUpperCase().contains("DATE")) {
            return "EX) 20230101( '-' 제외 숫자만입력)";
        } else if (header.toUpperCase().contains("ACTIVE") || header.toUpperCase().contains("HIDE")){
            return "EX) 0 = 'No' , 1 = 'Yes' ";
        }else {
        	return "EX) SAMPLE";
        }
        
        
    }

    public void processExcelFile(String tableName, MultipartFile file) throws IOException {
        List<Object> rowData = null;
        List<String> columnNames = new ArrayList<>();
        List<List<Object>> rowDataList = new ArrayList<>();
        
        try (InputStream inputStream = file.getInputStream()) {
            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0); // 첫 번째 시트를 가져옴

            // 첫 번째 행에서 컬럼명을 가져옴
            Row headerRow = sheet.getRow(0);
            if (headerRow != null) {
                for (Cell cell : headerRow) {
                    if (cell != null) {
                        columnNames.add(cell.getStringCellValue());
                    }
                }
            }

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

            // 두 번째 행부터 데이터를 읽어들임
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) {
                    continue; // 비어 있는 행 무시
                }
                boolean isEmptyRow = true;
                rowData = new ArrayList<>();
                for (int j = 0; j < headerRow.getLastCellNum(); j++) {
                    Cell cell = row.getCell(j);
                    if (cell == null || cell.getCellTypeEnum() == CellType.BLANK) {
                        rowData.add(""); // 비어 있는 셀을 빈 문자열로 처리
                    } else {
                        String cellValue = getCellValueAsString(cell, dateFormat);
                        rowData.add(cellValue);
                        if (!cellValue.trim().isEmpty()) {
                            isEmptyRow = false;
                        }
                    }
                }

                if (!isEmptyRow) {
                    rowDataList.add(rowData);
                }
            }

            // 컬럼이름의 데이터타입 문자 제거
            for (int i = 0; i < columnNames.size(); i++) {
                columnNames.set(i, columnNames.get(i).split("/")[0]);
            }

            // 데이터베이스에 저장
            for (int i = 0; i < rowDataList.size(); i++) {
                adminMapper.insertExcelDatas(tableName, rowDataList.get(i), columnNames);
            }
        }
    }
    
    private String getCellValueAsString(Cell cell, SimpleDateFormat dateFormat) {
        DecimalFormat decimalFormat = new DecimalFormat("#.##########");
        switch (cell.getCellTypeEnum()) {
            case STRING:
                System.out.println("@@@@@@@@@@@@@@@@Stringcell : " + cell);
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    System.out.println("@@@@@@@@@@@@@@@@NUMcell : " + cell);
                    return dateFormat.format(cell.getDateCellValue());
                } else {
                    System.out.println("@@@@@@@@@@@@@@@@NUMcell2 : " + cell);
                    return decimalFormat.format(cell.getNumericCellValue());
                }
            case BOOLEAN:
                System.out.println("@@@@@@@@@@@@@@@@booleancell : " + cell);
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                switch (cell.getCachedFormulaResultTypeEnum()) {
                    case STRING:
                        System.out.println("@@@@@@@@@@@@@@@@Stringcell : " + cell);
                        return cell.getRichStringCellValue().getString();
                    case NUMERIC:
                        if (DateUtil.isCellDateFormatted(cell)) {
                            System.out.println("@@@@@@@@@@@@@@@@NUMcell : " + cell);
                            return dateFormat.format(cell.getDateCellValue());
                        } else {
                            System.out.println("@@@@@@@@@@@@@@@@NUMcell2 : " + cell);
                            return decimalFormat.format(cell.getNumericCellValue());
                        }
                    default:
                        System.out.println("@@@@@@@@@@@@@@@@defaultcell : " + cell);
                        return cell.getCellFormula();
                }
            default:
                return "";
        }
    }
}
