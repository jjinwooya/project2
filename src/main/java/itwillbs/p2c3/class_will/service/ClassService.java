package itwillbs.p2c3.class_will.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import itwillbs.p2c3.class_will.mapper.ClassMapper;

@Service
public class ClassService {
	
	@Autowired
	private ClassMapper mapper;
	
	// 큰 카테고리
	public List<Map<String, Object>> getBigCategoryList() {
		return mapper.selectBigCategoryList();
	}
	
	// 소 카테고리
	public List<Map<String, Object>> getSmallCategory(String big_category) {
		return mapper.selectSmallCategory(big_category);
	}
	
	// 클래스 리스트
	public List<Map<String, Object>> getClassList(){
		return mapper.selectClassList();
	}
	
	// 클래스 리스트
	public List<Map<String, Object>> selectLikeClassCode(int member_code){
		return mapper.selectLikeClassCode(member_code);
	}
	// 지역 
	public List<Map<String, Object>> getCategoryLocal(){
		return mapper.selectCategoryLocal();
	}
	
	// 해시태그
	public List<Map<String, Object>> getHashtag(){
		return mapper.selectHashtag();
	}
	
	// 카테고리바 필터링된 클래스
	public List<Map<String, Object>> getFilterClass(List<String> bigCategories, List<String> smallCategories, List<String> locals){
		return mapper.selectFilterClass(bigCategories, smallCategories, locals);
	}
	
	// 클래스 좋아요
	public int insertLikeClass(Map<String, Object> map){
		return mapper.insertLikeClass(map);
	}
	
//	// 클래스 좋아요 추가
//	public int insertLikeClass(Map<String, Object> map){
//	   mapper.insertLikeClass(map);
//	}
	
	// 클래스 좋아요 취소
	public int deleteLikeClass(Map<String, Object> map){
		return mapper.deleteLikeClass(map);
	}
	
//	// 클래스 좋아요 취소
//	public int deleteLikeClass(Map<String, Object> map){
//	    mapper.deleteLikeClass(map);
//	}
	
	// 
	public List<Map<String, Object>> getChooseBigCategory(@RequestParam("category") String category) {
		return mapper.selectChooseBigCategory(category);
	}
	public List<Map<String, Object>> getListSmallCategory() {
		
		return mapper.selectListSmallCategory();
	}
	
	// 클래스 리뷰
	public List<Map<String, Object>> getClassReview(int class_code){
		return mapper.selectClassReview(class_code);
	}
	
	// 클래스 질문
	public List<Map<String, Object>> getClassInquiry(int class_code){
		return mapper.selectClassInquiry(class_code);
	}
	
	
	
    public List<Map<String, String>> getSmallCategoriesByBigCategoryCode(String bigCategoryCode) {
        return mapper.selectSmallCategories(bigCategoryCode);
    }
    
//	public Map<String, List<Map<String, Object>>> getCategoryData() {
//		Map<String, List<Map<String, Object>>> final_list = new HashMap<String, List<Map<String,Object>>>();
//		List<Map<String, Object>> bigCategory = mapper.selectBigCategoryList();
//		List<Map<String, Object>> smallCategory = mapper.getListSmallCategory();
//		final_list.put("bigCategory", bigCategory);
//		final_list.put("smallCategory", smallCategory);
//		return final_list;
//	}
}
