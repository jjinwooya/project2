package itwillbs.p2c3.class_will.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

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

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import itwillbs.p2c3.class_will.handler.WillUtils;
import itwillbs.p2c3.class_will.service.AdminService;
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
	private AdminService adminService;
	
	
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
	        System.out.println(">> member_code : " + member_code);
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
	        List<Integer> likeClassCode = classService.selectLikeClassCode(member_code);
	        model.addAttribute("likeClassCode", likeClassCode);
	        System.out.println(">> likeClassCode : " + likeClassCode);
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
		public List<Map<String, Object>> getFilterClass(Model model, HttpSession session, @RequestParam(required = false) String hashtag, @RequestParam(required = false) Map<String, String> params, @RequestParam Map<String, String> requestBody) {
	    
	    // 클래스 리스트
//		String big_category = params.get("class_big_category");
//		String small_category = params.get("class_small_category");
//		String local = params.get("common2_code");
	    String big_category = (String) requestBody.get("big_category"); // Integer로 받지 않고 String으로 받음
	    String small_category = (String) requestBody.get("small_category"); // Integer로 받지 않고 String으로 받음
	    String local = (String) requestBody.get("local");
		System.out.println("filter-class big_category : " + big_category + ", small_category : " + small_category + ", local : " + local);
		
        Map<String, Object> list = new HashMap<>();
        list.put("big_category", big_category);
        list.put("small_category", small_category);
        list.put("local", local);
        list.put("hashtag", hashtag);
        model.addAttribute("list", list);
        
	    List<Map<String, Object>> filterClass = classService.getClassList(list);
	    model.addAttribute("filterClass", filterClass);
	    System.out.println(">> filter-class filterClass : " + filterClass);
	    return filterClass;
	}
	
	// 메인 카테고리에서 넘어올 때 클래스 리스트 업데이트
	@ResponseBody
	@GetMapping("update-class-list")
	public List<Map<String, Object>> updateClassList(Model model,@RequestParam Map<String, String> requestBody){
		// 클래스 리스트
	    String big_category = (String) requestBody.get("big_category"); // Integer로 받지 않고 String으로 받음
	    String small_category = (String) requestBody.get("small_category"); // Integer로 받지 않고 String으로 받음
	    String local = (String) requestBody.get("common2_code"); // Integer로 받지 않고 String으로 받음
	    
//		String big_category = params.get("class_big_category");
//		String small_category = params.get("class_small_category");
//		String local = params.get("common2_code");
		System.out.println(">> big_category : " + big_category + ", small_category : " + small_category + ", local : " + local );
		Map<String, Object> list = new HashMap<>();
		list.put("big_category", big_category);
		list.put("small_category", small_category);
		list.put("local", local);
		model.addAttribute("list", list);
		
		List<Map<String, Object>> filterClass = classService.getClassList(list);
		model.addAttribute("filterClass", filterClass);
		System.out.println(">>update-class-list :" + filterClass);
		return filterClass;
	    // filterClass는 원하는 조건에 맞게 데이터를 필터링하는 로직을 포함해야 합니다.
//	    List<Map<String, Object>> list = new ArrayList<>();
	    
	    // 예시: 데이터베이스에서 데이터를 가져와서 필터링하는 로직 추가
	    // filterClass = classService.getFilteredClasses(bigCategory, smallCategory, common2_code);

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
	
	// 클래스 별점 순 정렬
	@ResponseBody
	@GetMapping("class-star-list")
	public List<Map<String, Object>> getClassStarList(Model model, @RequestParam(required = false) String classListSelect){

	    // 별점순 조회
	    List<Map<String, Object>> starList = classService.getStarList();
	    model.addAttribute("starList", starList);
	    
	    // 클래스 코드들을 저장할 리스트
	    List<Integer> classCodes = new ArrayList<>();

	    // 별점순 클래스코드 구함
	    for (Map<String, Object> map : starList) {
	    	Integer class_code = (Integer) map.get("class_code");
	        if (class_code != null) {
	            classCodes.add(class_code);
	        }
	        System.out.println("/////class_code ??!!!" + class_code);
	        System.out.println("/////classCodes ??!!!" + classCodes);
	    }
	    
	    System.out.println(">>classCodes : " + classCodes);
	    
	    // 필터링 메소드 호출을 위한 파라미터 설정
	    Map<String, Object> list = new HashMap<>();
	    list.put("class_codes", classCodes);

	    // 필터링 메소드 호출 및 결과 받아오기
	    List<Map<String, Object>> filterClass = classService.getClassList(list);
	    System.out.println(">> filterClass : " + filterClass);
	    
	    // 결과를 classCodes 순서대로 정렬
	    Map<Integer, Map<String, Object>> filterMap = filterClass.stream()
	        .collect(Collectors.toMap(
	            item -> (Integer) item.get("class_code"),
	            item -> item
	        ));
	    
	    System.out.println("filterMap" + filterMap);
	    
	    List<Map<String, Object>> sortedFilter = classCodes.stream()
	        .map(filterMap::get)
	        .filter(Objects::nonNull)  // Null 체크 추가
	        .collect(Collectors.toList());
	    
	    System.out.println("sortedFilter" + sortedFilter);
	    // 필터링된 결과 반환
	    return filterClass;
	}
	
	// 클래스 리뷰순 정렬
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
    	
		Boolean heart_status = (Boolean) requestBody.get("heart_status");
	    Integer member_code = (Integer) requestBody.get("member_code"); // Integer로 받지 않고 String으로 받음
	    Integer class_code = (Integer) requestBody.get("class_code"); // Integer로 받지 않고 String으로 받음
        Map<String, Object> map = new HashMap<>();
        map.put("heart_status", heart_status);
        map.put("member_code", member_code);
        map.put("class_code", class_code);
		
        System.out.println("update-heart-status class_code : " + class_code + ", member_code : " + member_code + ", heart_status : " + heart_status);
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
//    @GetMapping("check-like-status")
//    @ResponseBody
//    public String checkLikeStatus(@RequestParam("member_code") String member_code, @RequestParam("class_code") String class_code) {
//    	Map<String, Object> map = new HashMap<>();
//    	map.put("member_code", member_code);
//    	map.put("class_code", class_code);
//    	
//        // like_class 테이블에서 member_code와 class_code로 조회하여 좋아요 여부를 확인하는 로직
//        boolean isLiked = classService.getLikeClassList(map);
//        return String.valueOf(isLiked);
//    	return "";
//    }
//    
    // ajax bigCategory
	@GetMapping("big-category")
	@ResponseBody
    public ResponseEntity<List<Map<String, Object>>> getBigCategories() {
        List<Map<String, Object>> bigCategoryList = classService.getBigCategoryList();
        return ResponseEntity.ok().body(bigCategoryList);
    }
	
	@GetMapping("like-class-count")
	@ResponseBody
	public ResponseEntity<Integer> getLikeClassCount(@RequestParam(name = "class_code") int class_code) {
	    int likeClassCount = classService.getLikeClassCount(class_code);
	    System.out.println(">> like-class-count : " + likeClassCount);
	    return ResponseEntity.ok(likeClassCount);
	}
	
	// 클래스 디테일
	@GetMapping("class-detail")
	public String classDetail(Model model, HttpSession session, @RequestParam(name = "class_code") int class_code,@RequestParam(defaultValue = "0") boolean fromReport) {
	    MemberVO member = (MemberVO) session.getAttribute("member");
//	    Integer member_code = null;
	    
	    Map<String, Object> map = new HashMap<>();
	    
	    Integer member_code = null;
	    if (member != null) {
	        member_code = member.getMember_code();
	    }
		
	    map.put("class_code", class_code);
		System.out.println(">> class_code :: " + map.get("class_code"));
		
		// 클래스 후기
		List<Map<String, Object>> classReview = classService.getClassReview(map); 
		model.addAttribute("classReview", classReview);
	    
		// 클래스 질문
		List<Map<String, Object>> classInquiry = classService.getClassInquiry(map); 
		model.addAttribute("classInquiry", classInquiry);
	    
		// 클래스 커리큘럼
		List<Map<String, Object>> classCurri = classService.getClassCurri(class_code);
		model.addAttribute("classCurri", classCurri);
		System.out.println(">> classCurri : " + classCurri);
		
		// 클래스 코드 별 좋아요 갯수
		int likeClassCount = classService.getLikeClassCount(class_code);
		model.addAttribute("likeClassCount", likeClassCount);
		System.out.println(">> likeClassCount : " + likeClassCount);
		
////	    List<Map<String, Object>> classList = classService.getClassList(list);
////	    model.addAttribute("classList", classList);
//	    
//	    // 클래스 리스트에 member_code 추가
//	    if (member_code != null) { // member_code가 존재하면 
////	        for (Map<String, Object> classMap : classList) {
//	    	map.put("member_code", member_code);
//	            System.out.println(">> member_code : " + member_code);
////	        }
//	        // 라이크 클래스
//	        Map<String, Object> likeClass = classService.getLikeClass(map);
//	        model.addAttribute("likeClass", likeClass);
//	        System.out.println(">> likeClass : " + likeClass);
//	    } else {
//	    	return "class/class-detail";
//	    }
//	    
	    // 사용자의 클래스 좋아요 여부 가져오기
	    boolean isLiked = false;
	    if (member_code != null) {
//	        Map<String, Object> map = new HashMap<>();
	        map.put("member_code", member_code);
	        map.put("class_code", class_code);
	        isLiked = classService.getLikeClass(map); // isLikedClass 메서드는 좋아요 여부를 확인하는 메서드라 가정
	    }
	    model.addAttribute("isLiked", isLiked);
	    
		//classInfo 클래스 데이터 가져오기
		Map<String, Object> classCode = new HashMap<>();
		classCode.put("class_code", class_code);
		
		Map<String, Object> classInfo = payService.getClassInfo(classCode);
		model.addAttribute("classInfo", classInfo);
		
		// 클래스 해시태그 
		List<Map<String, Object>> classHashtagList = classService.getClassHashtag(class_code);
//		List<String> hashtagStrings = new ArrayList<>();
		model.addAttribute("classHashtagList", classHashtagList);
		System.out.println(">>>>classHashtagList : " + classHashtagList);
		
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
        
		//클래스 신고에서 들어온 요청 처리
		if(fromReport) {
			model.addAttribute("fromReport", true);
		}
		
		return"class/class-detail";
	}
	
	// 클래스 상세 리뷰
	@GetMapping("creator-review-form2")
	public String creatorReviewForm2(Model model, @RequestParam int class_code, @RequestParam int class_review_code){
		System.out.println(">> class_review_code : " + class_review_code);
		Map<String, Object> map = new HashMap<>();
		map.put("class_review_code", class_review_code);
		map.put("class_code", class_code);
		List<Map<String, Object>> classReview = classService.getClassReview(map); 
		model.addAttribute("classReview", classReview);
		return"class/class-review-show";
	}
	
	// 클래스 상세 질문
	@GetMapping("creator-inquiry-form2")
	public String creatorInquiryForm2(Model model, @RequestParam int class_code, @RequestParam int class_inquiry_code){
	    Map<String, Object> map = new HashMap<>();
	    map.put("class_inquiry_code", class_inquiry_code);
	    map.put("class_code", class_code);
		List<Map<String, Object>> classInquiry = classService.getClassInquiry(map); 
		model.addAttribute("classInquiry", classInquiry);
		return"class/class-inquiry-show";
	}
	
	@GetMapping("class-complain")
	public String classComplain(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "잘못된 접근입니다.", true);
		}
		
		// 카테고리 검색
		List<Map<String, Object>> big_category = adminService.getBigCategoryClassComplain();
		
		model.addAttribute("big_category", big_category);
		model.addAttribute("member", member);
		
		return "class/class-complain";
	}
	
	@ResponseBody
	@GetMapping("getSubCategories")
	public List<Map<String, Object>> getSubCategory(@RequestParam(value = "categoryCode", required = false) Integer categoryCode) {
        if (categoryCode == 0) {
        	return null;
        }
		System.out.println("casdgadfsadf : " + categoryCode);
		
		List<Map<String, Object>> small_category = adminService.getSmallCategoryClassComplain(categoryCode);
		
		return small_category;
	}
	
	@PostMapping("complain-class-pro")
	public String complainClassPro(@RequestParam Map<String, Object> params, HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "잘못된 접근입니다.", true);
		}
		params.put("member_code", member.getMember_code());
		
		boolean isSuccess = classService.insertClassComplain(params);
		
		if(!isSuccess) {
			return WillUtils.checkDeleteSuccess(false, model, "신고 등록 실패", true);
		}
		
		return WillUtils.checkDeleteSuccess(true, model, "신고 등록 완료", true);
	}
}
