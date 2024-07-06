package itwillbs.p2c3.class_will.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ClassMapper {
	
	// 큰 카테고리
    // ajax bigCategory
	List<Map<String, Object>> selectBigCategoryList();
	
	// 소 카테고리
	// ajax smallCategory
	List<Map<String, Object>> selectSmallCategory(String big_Category);

	//
//	List<Map<String, Object>> selectChooseBigCategory(@RequestParam("category") String category);
	
	// 카테고리 지역 
	List<Map<String, Object>> selectCategoryLocal();
	
	// 해시태그
	List<Map<String, Object>> selectHashtag();
	
	// 카테고리바 필터링된 클래스
	// List<Map<String, Object>> selectFilterClass(@RequestParam("bigCategories") List<String> bigCategories, @RequestParam("smallCategories") List<String> smallCategories, @RequestParam("locals")List<String> locals);
	List<Map<String, Object>> selectFilterClass(Map<String, Object> map);
	
	// 클래스 리뷰 별점 순 정렬
	List<Map<String, Object>> selectStarList();
	
	// 클래스 좋아요 추가
	int insertLikeClass(Map<String, Object> map);
	
	// 클래스 좋아요 리스트
	List<Map<String, Object>> selectLikeClassList(Map<String, Object> map);
	
	// 클래스 좋아요 취소
	int deleteLikeClass(Map<String, Object> map);
	
	// 클래스 좋아요 취소
	List<Map<String,Object>> selectLikeClassCode(int member_coode);
	
	// 클래스 리스트
	List<Map<String, Object>> selectClassList(Map<String, Object> paramMap);
	
	// 클래스 가격순
	List<Map<String, Object>> selectPriceList(Map<String, Object> list);
	
//	// 클래스 리스트
//	List<Map<String, Object>> selectStarClassList(Map<String, Object> paramMap);
	
	// 리뷰 많은 순
	List<Map<String, Object>> selectReviewCount();
	
	// 소 카테고리
	List<Map<String, Object>> selectListSmallCategory();
	
	// 클래스 리뷰
	List<Map<String, Object>> selectClassReview(int class_code);
	
	// 클래스 질문 
	List<Map<String, Object>> selectClassInquiry(int class_code);
	
	// 클래스 커리큘럼 
	List<Map<String, Object>> selectClassCurri(int class_code);
	
	// 클래스 해시태그 
	List<Map<String, Object>> selectClassHashtag(int class_code);
	
//    List<Map<String, String>> selectSmallCategories(String bigCategoryCode);
	boolean insertClassComplain(Map<String, Object> params);
}
