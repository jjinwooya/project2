package itwillbs.p2c3.class_will.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CscMapper {
	
	Map<String, String> selectBoardDetail(Map<String, Object> params);
	
	Integer searchPaging(@Param("code") int code,@Param("searchType") String searchType);
	
	List<Map<String, String>> selectBoardCategoryHide(String code);

	int selectBoardCountHide(String type);
}
