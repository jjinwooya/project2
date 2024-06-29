package itwillbs.p2c3.class_will.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminMapper {

	List<Map<String, String>> selectMemberList(@Param("params") Map<String, Object> params);

	Map<String, String> selectMemberInfo(@Param("params") Map<String, Object> params);

	List<String> selectColumnNames(String tableName);
	
	List<Map<String, Object>> selectTable(String tableName);

	List<String> selectColumnDataTypes(String tableName);
	
	String selectMaxCode(@Param("tableName") String tableName);

	void insertExcelDatas(@Param("tableName") String tableName
						,@Param("rowDataList") List<Object> list
						,@Param("columnNames") List<String> columnNames
	);

	List<Map<String, Object>> selectClassList();

	Map<String, String> selectClassInfo(String class_code);

	String selectCommonCode(String code_value);

	int selectCommon2Code(@Param("common1_code") String common1_code
						,@Param("type") String type);

	List<Map<String, Object>> selectBigCategory();

	List<Map<String, Object>> selectSmallCategory();

	void updatedCategoryData(Map<String, Object> rowMap);

	void insertCategoryData(@Param("rowMap") Map<String, Object> rowMap);

	int selectMaxCommon3Code(Integer common2_code);

	void deleteCategoryData(@Param("rowMap") Map<String, Object> rowMap);

	List<Map<String, Object>> selectClassTable();

	List<Map<String, Object>> selectCscList(Map<String, Object> params);

	String selectCommon2Value(@Param("common1_code") String common1_code,@Param("common2_code") Integer common2_code);

	int insertBoard(@Param("map") Map<String, Object> map);
	
	List<Map<String, String>> selectBoardCategory(String code);

	int selectCscCount(String type);

	List<Map<String, Object>> selectPayList();
	
	List<Map<String, Object>> getMonthlySalesByMember(String month);
	
	void insertSettlement(int memberCode, String month, double totalSales);

	List<Integer> selectWillpayChart();

	List<Map<String, Object>> selectRewardData();

	int updateRewardData(@Param("params") Map<String, Object> params);

	List<Map<String, Object>> selectCategoryRanking();

	int updateBoard(Map<String, Object> map);

	int deleteBoard(Map<String, Object> params);

	List<Map<String, Object>> selectClassListType(String type);

	int registClass(String class_code);

	List<Map<String, String>> selectClassReportData(String status);

	Map<String, String> selectClssReportDetail(int class_report_code);

	int updateClassReportStatus(@Param("class_report_code") String class_report_code,@Param("status") String status);

	int updateClassStatusHide(String class_code);

	Integer selectTotalMember();
	
	Integer selectNewMemberCount();

	Integer selectDailyVisit();

	Integer selectTotalVisit();

	boolean updateNoticeHide(@Param("params") Map<String, Object> params);

	boolean updateFaqHide(@Param("params") Map<String, Object> params);

	int insertEvent(@Param("params") Map<String, Object> map);


	

}
