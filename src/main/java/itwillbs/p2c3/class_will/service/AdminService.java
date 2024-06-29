package itwillbs.p2c3.class_will.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.class_will.mapper.AdminMapper;

@Service
public class AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	public List<Map<String, String>> getMemberList(Map<String, Object> params) {
		return adminMapper.selectMemberList(params);
	}

	public Map<String, String> getMemberInfo(Map<String, Object> params) {
		return adminMapper.selectMemberInfo(params);
	}
	
	
	 public List<String> getColumnNames(String tableName) {
	      return adminMapper.selectColumnNames(tableName);
	    }

//    public List<Map<String, Object>> getCurrentPageData(String tableName) {
//        String sql = "SELECT * FROM " + tableName + " LIMIT 10"; // 예시로 현재 페이지 데이터 가져오기
//        return jdbcTemplate.queryForList(sql);
//    }

    public List<Map<String, Object>> getAllData(String tableName) {
    	List<Map<String, Object>> result = null;
    	switch (tableName) {
			case "MEMBER" 	: result = adminMapper.selectTable(tableName); break;
			case "class" 	: result = adminMapper.selectClassList(); break;
			case "pay"		: result = adminMapper.selectPayList(); break;
		}
    	return result;
    }

	public List<String> getColumnDataTypes(String tableName) {
		return adminMapper.selectColumnDataTypes(tableName);
	}

	public List<Map<String, Object>> getClassList(String type) {
		return adminMapper.selectClassListType(type);
	}

	public Map<String, String> getClassInfo(String class_code) {
		return adminMapper.selectClassInfo(class_code);
	}

	public String getCommonCode(String code_value) {
		return adminMapper.selectCommonCode(code_value);
	}

	public int getCommon2Code(String common1_code, String type) {
		return adminMapper.selectCommon2Code(common1_code, type);
	}

	public Map<String, List<Map<String, Object>>> getCategoryData() {
		Map<String, List<Map<String, Object>>> final_list = new HashMap<String, List<Map<String,Object>>>();
		List<Map<String, Object>> bigCategory = adminMapper.selectBigCategory();
		List<Map<String, Object>> smallCategory = adminMapper.selectSmallCategory();
		final_list.put("bigCategory", bigCategory);
		final_list.put("smallCategory", smallCategory);
		return final_list;
	}

	public void updateCategoryData(Map<String, Object> rowMap) {
		adminMapper.updatedCategoryData(rowMap);
	}

	public void insertCategoryData(Map<String, Object> rowMap) {
		adminMapper.insertCategoryData(rowMap);
	}

	public int getMaxCommon3Code(Integer common2_code) {
		return adminMapper.selectMaxCommon3Code(common2_code);
	}

	public void deleteCategoryData(Map<String, Object> rowMap) {
		adminMapper.deleteCategoryData(rowMap);
	}


	public List<Map<String, Object>> getCscList(Map<String, Object> params) {
		return adminMapper.selectCscList(params);
	}

	public String getCommon2Value(String common1_code, Integer common2_code) {
		return adminMapper.selectCommon2Value(common1_code, common2_code);
	}

	public boolean insertBoard(Map<String, Object> map) {
		return adminMapper.insertBoard(map) > 0 ? true : false;
	}

	public List<Map<String, String>> getBoardCategory(String common_code) {
		return adminMapper.selectBoardCategory(common_code);
	}
	
	public int getBoardCount(String type) {
		return adminMapper.selectCscCount(type);
	}

	public List<Map<String, Object>> getPayList() {
		return adminMapper.selectPayList();
	}
	
    public void performMonthlySettlement() {
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        String currentMonth = now.format(formatter);

        List<Map<String, Object>> monthlySales = adminMapper.getMonthlySalesByMember(currentMonth);

        for (Map<String, Object> sales : monthlySales) {
            // 실제 입금 작업을 수행하는 로직을 추가합니다.
        }
    }

	public List<Integer> getWillpayChart() {
		return adminMapper.selectWillpayChart();
	}

	public List<Map<String, Object>> getRewardData() {
		return adminMapper.selectRewardData();
	}

	public boolean updateRewardData(Map<String, Object> params) {
		return adminMapper.updateRewardData(params) > 0 ? true : false;
	}

	public List<Map<String, Object>> getCategoryRanking() {
		return adminMapper.selectCategoryRanking();
	}

	public boolean updateBoard(Map<String, Object> map) {
		return adminMapper.updateBoard(map) > 0 ? true : false;
	}

	public boolean deleteBoard(Map<String, Object> params) {
		return adminMapper.deleteBoard(params) > 0 ? true : false;
	}

	public boolean registClass(String class_code) {
		return adminMapper.registClass(class_code) > 0 ? true : false;
	}

	public List<Map<String, String>> getClassReportData(String status) {
		return adminMapper.selectClassReportData(status);
	}

	public Map<String, String> getClassReportDetail(int class_report_code) {
		return adminMapper.selectClssReportDetail(class_report_code);
	}


	public boolean updateClassReportStatus(String class_report_code, String status) {
		return adminMapper.updateClassReportStatus(class_report_code, status) > 0 ? true : false;
	}

	public boolean updateClassStatusHide(String class_code) {
		return adminMapper.updateClassStatusHide(class_code) > 0 ? true : false;
	}

	public Integer getTotalMember() {
		return adminMapper.selectTotalMember();
	}

	public Integer getNewMember() {
		return adminMapper.selectNewMemberCount();
	}

	public Integer getDailyVisit() {
		return adminMapper.selectDailyVisit();
	}

	public Integer getTotalVisit() {
		return adminMapper.selectTotalVisit();
	}


	public boolean updateNoticeHide(Map<String, Object> params) {
		return adminMapper.updateNoticeHide(params);
	}

	public boolean updateFaqHide(Map<String, Object> params) {
		return adminMapper.updateFaqHide(params);
	}

	public boolean insertEvent(Map<String, Object> map) {
		return adminMapper.insertEvent(map) > 0 ? true : false;
	}

	
	
}
