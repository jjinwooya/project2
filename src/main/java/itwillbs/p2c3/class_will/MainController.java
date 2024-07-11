package itwillbs.p2c3.class_will;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import itwillbs.p2c3.class_will.service.MainService;

@Controller
public class MainController {
	
	@Autowired
	private MainService mainService;
	
	// 메인으로
//	@GetMapping("main")
//	public String main(HttpServletRequest request) {
//		
//		return "main";
//	}
	
	// top-분야 카테고리
	@ResponseBody
	@GetMapping("top-field-category")
	public String fieldCategory() {
		
	    Map<String, List<Map<String, Object>>> fieldCateMap = mainService.selectFieldCate();
	    List<Map<String, Object>> bigCategory = fieldCateMap.get("bigCategory");
	    List<Map<String, Object>> smallCategory = fieldCateMap.get("smallCategory");
	    
	    JsonArray fieldCateList = new JsonArray();
	    
	    // 대분류에 소분류를 추가
	    for (Map<String, Object> bcg : bigCategory) {
	    	
	    	JsonObject json = new JsonObject();
	        String bigValue = (String) bcg.get("code_value");
	        Integer common2_code = (Integer) bcg.get("common2_code"); // Integer로 변환
	        json.addProperty("id", common2_code);
	        json.addProperty("largeCategory", bigValue);
	        System.out.println("json : " + json);
	        
	        // 소분류 데이터를 _children 배열에 추가
	        JsonArray children = new JsonArray();
//	        List<Map<String, Object>> children = new ArrayList<>();
	        
	        for (Map<String, Object> scg : smallCategory) {
	            Integer parent_code = (Integer) scg.get("common2_code"); // Integer로 변환
	            
	            if (common2_code.equals(parent_code)) {
	            	JsonObject json2 = new JsonObject();
	            	json2.addProperty("id", (Integer)scg.get("common3_code"));
	            	json2.addProperty("largeCategory", bigValue);
	            	json2.addProperty("smallCategory", (String) scg.get("code_value"));
	                children.add(json2);
	                System.out.println("children : " + children);
	            }
	        }
	        if (!children.isEmpty()) {
	        	json.add("children", children);
	        	System.out.println("json : " + json);
	        }
	        
	        fieldCateList.add(json);
	        System.out.println("fieldCateList : " + fieldCateList);
	    }
		
		return fieldCateList.toString();
	}
	
	
	// top-지역 카테고리 
	@ResponseBody
	@GetMapping("top-local-category")
	public String localCategory() {
		
		List<Map<String, Object>> localCateMap = mainService.selectLocalCate();
		
		JsonArray localCateList = new JsonArray();
		
		
		for(Map<String, Object> lcm : localCateMap) {
			Integer common2_code_obj = (Integer) lcm.get("common2_code");
			int common2_code = (common2_code_obj != null) ? common2_code_obj.intValue() : 0;
			JsonObject jo = new JsonObject();
			jo.addProperty("local_name", (String) lcm.get("code_value"));
			jo.addProperty("local_code", common2_code);
			
			System.out.println("jo : " + jo);
			localCateList.add(jo);
		}
		System.out.println("localCateList : " + localCateList );
		
		
		return localCateList.toString();
		
		
	} // localCategory()
	
	
	// top & bottom 검색창
	@PostMapping("class-list")
	public String searchKeyword(@RequestParam String keyword, Model model) {
		
		System.out.println("keyword : " + keyword);
		
		LocalDateTime currentDateTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String searchDateTime = currentDateTime.format(formatter);
		
		List<Map<String, String>> searchClassList = mainService.retrieveKeyword(keyword, searchDateTime);
		System.out.println("searchClassList : " + searchClassList);
		if(searchClassList != null) {
			model.addAttribute("searchClassList", searchClassList);
			
		} else {
			model.addAttribute("msg", "검색 결과가 존재하지 않습니다.");
			return "result_process/fail";
		}
		
		return "class/class-list";
		
	} // searchKeyword()
	
	
	// 검색창 추천어 
	@ResponseBody
	@GetMapping("recommend-keyword")
	public String recommendKeyword() {
		
		List<String> recommendList = mainService.selectRecommend();
		System.out.println("============ recommendList : " + recommendList);
		
		JsonArray list = new JsonArray();
		
		for(String keyword : recommendList) {
			list.add(keyword);
		}
		
		return list.toString();
		
	}
	
	
	
	
	

}
