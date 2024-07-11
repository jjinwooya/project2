package itwillbs.p2c3.class_will.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import itwillbs.p2c3.class_will.vo.MemberVO;

@Mapper
public interface MainMapper {


	List<Map<String, Object>> selectBigCategory();

	List<Map<String, Object>> selectSmallCategory();

	List<Map<String, Object>> selectLocalCate();

	boolean insertKeyword(@Param("keyword") String keyword, @Param("searchDateTime") String searchDateTime);

	List<Map<String, String>> selectKeyword(@Param("keyword") String keyword);

	void insertVisitIp(@Param("ip")String ip, @Param("visitDate") String visitDate);

	Map<String, String> selectVisitIp(@Param("ip")String ip, @Param("visitDate") String visitDate);

	List<Map<String, Object>> selectTop10Class();
	
	List<Map<String, Object>> selectTop10Local();

	List<Map<String, Object>> selectNewClass();

	List<Map<String, Object>> selectNewLocal();

	Map<String, Object> selectToday(@Param("visitDate")String visitDate);

	void insertDailyVisit(@Param("visitDate")String visitDate);

	void updateDailyVisit(Map<String, Object> dbVisitDate);

	List<Map<String, Object>> selectLikeClass(MemberVO sMember);

	List<String> selectRecommend();
	
	
	
	
	

}
