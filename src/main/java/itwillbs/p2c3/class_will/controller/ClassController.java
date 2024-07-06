package itwillbs.p2c3.class_will.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import itwillbs.p2c3.class_will.service.ClassService;
import itwillbs.p2c3.class_will.service.MemberService;
import itwillbs.p2c3.class_will.service.PayService;
import itwillbs.p2c3.class_will.vo.MemberVO;


@Controller
public class ClassController {
	
	@Autowired
	private PayService payService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ClassService classService;
	
	// 클래스 리스트
	@GetMapping("class-list")
//	public String classList(Model model, HttpSession session, @RequestParam Map<String, Object> map) {
	public String classList(Model model, HttpSession session, @RequestParam(required = false) String hashtag, @RequestParam Map<String, String> params) {
		
	    MemberVO member = (MemberVO) session.getAttribute("member");
	    Integer member_code = null;
	    
	    if (member != null) {
	        member_code = member.getMember_code();
	    } else {
	        System.out.println("Member is null");
	    }

	    // =================== 카테고리바 ===================
	    // 대 카테고리
	    List<Map<String, Object>> bigCategoryList = classService.getBigCategoryList();
	    model.addAttribute("bigCategoryList", bigCategoryList);
	    
	    // 소 카테고리
	    List<Map<String, Object>> smallCategoryList = classService.getListSmallCategory();
	    model.addAttribute("smallCategoryList", smallCategoryList);
	    
	    // 지역
	    List<Map<String, Object>> localList = classService.getCategoryLocal();
	    model.addAttribute("localList", localList);
	    
//	    // 클래스 리스트
//		String big_category = params.get("big_category");
//		String small_category = params.get("small_category");
//		String local = params.get("local");
//		
        Map<String, Object> map = new HashMap<>();
        map.put("hashtag", hashtag);
	    List<Map<String, Object>> classList = classService.getClassList(map);
	    model.addAttribute("classList", classList);
	    
	    // 지도에 표시할 클래스 
		JsonArray jsonList = new JsonArray();
		
		for(Map<String, Object> class1  : classList) {
			JsonObject json = new JsonObject();
			json.addProperty("class_map_x", (String) class1.get("class_map_x"));
			json.addProperty("class_map_y", (String) class1.get("class_map_y"));
			json.addProperty("class_name", (String) class1.get("class_name"));
			jsonList.add(json);
//			System.out.println(json);
		}
		
		model.addAttribute("jsonList", jsonList);
		
	    // 해시태그
	    List<Map<String, Object>> hashtagList = classService.getHashtag();
	    model.addAttribute("hashtagList", hashtagList);
	    	
	    // 클래스 리스트에 member_code 추가
	    if (member_code != null) {
	        for (Map<String, Object> classMap : classList) {
	            classMap.put("member_code", member_code);
	        }
	        
	        // 라이크 클래스
	        List<Map<String, Object>> likeClassCode = classService.selectLikeClassCode(member_code);
	        model.addAttribute("likeClassCode", likeClassCode);
	    } else {
	        System.out.println("Member code is null, skipping likeClassCode.");
	    }
	    
	    return "class/class-list";
	}
	
	// 카테고리바 소카테고리 ajax
	// ajax smallCategory
	@ResponseBody
	@GetMapping("small-category")
	public List<Map<String, Object>> getCategoryDetail(@RequestParam String big_category){
		List<Map<String, Object>> smallCategory = classService.getSmallCategory(big_category);
		return smallCategory;
	}
	
	// 카테고리 필터링 ajax
	@ResponseBody
	@GetMapping("filter-class")
		public List<Map<String, Object>> getFilterClass(Model model, HttpSession session, @RequestParam(required = false) String hashtag, @RequestParam Map<String, String> params) {
	    
	    // 클래스 리스트
		String big_category = params.get("big_category");
		String small_category = params.get("small_category");
		String local = params.get("local");
		
        Map<String, Object> list = new HashMap<>();
        list.put("big_category", big_category);
        list.put("small_category", small_category);
        list.put("local", local);
        list.put("hashtag", hashtag);
        model.addAttribute("list", list);
        
	    List<Map<String, Object>> filterClass = classService.getClassList(list);
	    model.addAttribute("filterClass", filterClass);
	    return filterClass;
	}
	
	// 클래스 낮은가격 순 정렬
	@ResponseBody
	@GetMapping("class-low-price")
	public List<Map<String, Object>> getClassLowPrice(Model model,@RequestParam(required = false) String classListSelect){

        Map<String, Object> list = new HashMap<>();
        list.put("classListSelect", "lowPrice");
	    List<Map<String, Object>> listSelect = classService.getPriceList(list);
	    model.addAttribute("listSelect", listSelect);
	    return listSelect;
	}
	
	// 클래스 높은가격 순 정렬
	@ResponseBody
	@GetMapping("class-high-price")
	public List<Map<String, Object>> getClassHighPrice(Model model,@RequestParam(required = false) String classListSelect){
		
		Map<String, Object> list = new HashMap<>();
		list.put("classListSelect", "highPrice");
		List<Map<String, Object>> listSelect = classService.getPriceList(list);
		model.addAttribute("listSelect", listSelect);
		return listSelect;
	}
	
	@ResponseBody
	@GetMapping("class-star-list")
	public List<Map<String, Object>> getClassStarList(@RequestParam(required = false) String classListSelect){

	    // 별점순 조회
	    List<Map<String, Object>> starList = classService.getStarList();

	    // 클래스 코드들을 저장할 리스트
	    List<Integer> classCodes = new ArrayList<>();

	    // 각 클래스의 정보에 대해 클래스 코드 수집
	    for (Map<String, Object> map : starList) {
	        Integer class_code = (Integer) map.get("class_code");
	        if (class_code != null) {
	            classCodes.add(class_code);
	        }
	    }
	    System.out.println("/////classCodes ??!!!" + classCodes);

	    // 필터링 메소드 호출을 위한 파라미터 설정
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("class_codes", classCodes);

	    // 필터링 메소드 호출 및 결과 받아오기
	    List<Map<String, Object>> filter = classService.getClassList(paramMap);

	    // 필터링된 결과 반환
	    return filter;
	}
	
	// 리뷰많은 순
	@ResponseBody
	@GetMapping("class-review-list")
	public List<Map<String, Object>> getClassReviewlist(Model model,@RequestParam(required = false) String classListSelect){
		
		List<Map<String, Object>> listSelect = classService.getReviewCount();
		model.addAttribute("listSelect", listSelect);
		
		return listSelect;
	}
	
	// like_class 상태변경 
    @PostMapping("update-heart-status")
    @ResponseBody
    public String updateHeartStatus(@RequestBody Map<String, Object> requestBody, HttpSession session, Model model) {
    	
//		MemberVO member = (MemberVO)session.getAttribute("member");

		Boolean heart_status = (Boolean) requestBody.get("heart_status");
	    String member_code = (String) requestBody.get("member_code"); // Integer로 받지 않고 String으로 받음
	    String class_code = (String) requestBody.get("class_code"); // Integer로 받지 않고 String으로 받음

        Map<String, Object> map = new HashMap<>();
        map.put("heart_status", heart_status);
        map.put("member_code", member_code);
        map.put("class_code", class_code);
		
	    // heart_status가 true이면 좋아요를 추가, false이면 좋아요를 제거
	    if (heart_status != null && member_code != null && class_code != null) {
	        if (heart_status) {
	            // 클래스 좋아요 추가
	            int insertLikeClass  = classService.insertLikeClass(map);
		            if (insertLikeClass > 0) {
		            	List<Map<String, Object>> likeClassList = classService.getLikeClassList(map);
		            	model.addAttribute("likeClassList", likeClassList);
		            }
	        } else {
	            // 클래스 좋아요 제거
	            classService.deleteLikeClass(map);
	        }
	        return "success";
	    } else {
	        return "fail";
	    }
    }
    
    // ajax bigCategory
	@GetMapping("big-category")
	@ResponseBody
    public ResponseEntity<List<Map<String, Object>>> getBigCategories() {
        List<Map<String, Object>> bigCategoryList = classService.getBigCategoryList();
        return ResponseEntity.ok().body(bigCategoryList);
    }
	
	
	// 클래스 디테일
	@GetMapping("class-detail")
	public String classDetail(Model model, @RequestParam(name = "class_code") int class_code) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("class_code", class_code);
		
		// 클래스 후기
		List<Map<String, Object>> classReview = classService.getClassReview(class_code); 
		model.addAttribute("classReview", classReview);
	    
		// 클래스 질문
		List<Map<String, Object>> classInquiry = classService.getClassInquiry(class_code); 
		model.addAttribute("classInquiry", classInquiry);
	    
		// 클래스 커리큘럼
		List<Map<String, Object>> classCurri = classService.getClassCurri(class_code);
		model.addAttribute("classCurri", classCurri);

		//classInfo 클래스 데이터 가져오기
		Map<String, Object> classCode = new HashMap<>();
		classCode.put("class_code", class_code);
		
		Map<String, Object> classInfo = payService.getClassInfo(classCode);
		model.addAttribute("classInfo", classInfo);
		
		// 클래스 해시태그 
		List<Map<String, Object>> classHashtagList = classService.getClassHashtag(class_code);
		List<String> hashtagStrings = new ArrayList<>();
		model.addAttribute("hashtagStrings", hashtagStrings);
		System.out.println(">>>>hashtagStrings : " + hashtagStrings);
		//========================================================================
		//스케쥴 select -- 파라미터: 클래스 코드 (임시)
		List<Map<String, Object>> scheduleInfo = payService.getClassSchedule(class_code);
		System.out.println(">>>>>>>>> scheduleInfo : " + scheduleInfo);
		// JSONArray를 생성하고 리스트의 각 맵을 JSONObject로 변환하여 추가합니다.
        JSONArray jsonArray = new JSONArray();
        for(Map<String, Object> maps : scheduleInfo) {
            JSONObject jsonObject = new JSONObject(maps);
            jsonArray.put(jsonObject);
        }
        // JSONArray를 JSON 문자열로 변환합니다.
        String jsonString = jsonArray.toString();
        model.addAttribute("class_schedule", scheduleInfo);
        
		//클래스 스케쥴
		model.addAttribute("class_schedule_date", jsonString);
        //========================================================================
        
		return"class/class-detail";
	}
	
	// 클래스 상세 리뷰
	@GetMapping("creator-review-form2")
	public String creatorReviewForm2(Model model, @RequestParam int class_code){
		List<Map<String, Object>> classReview = classService.getClassReview(class_code); 
		model.addAttribute("classReview", classReview);
		return"creator/creator-review-show";
		
	}
	
	// 클래스 상세 질문
	@GetMapping("creator-inquiry-form2")
	public String creatorInquiryForm2(Model model, @RequestParam int class_code){
		List<Map<String, Object>> classInquiry = classService.getClassInquiry( class_code ); 
		model.addAttribute("classInquiry", classInquiry);
		return"creator/creator-inquiry-show";
	}
	
	// 신고하기
//	@GetMapping("class-complain")
//	public String classComplain(Model model, @RequestParam int class_code) {
//		System.out.println("class-complain class-code @@@@@@%^%^%^% :" + class_code);
//		return "class/class-complain";
//	}
}
