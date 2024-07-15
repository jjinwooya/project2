package itwillbs.p2c3.class_will.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import itwillbs.p2c3.class_will.handler.AdminServiceHelper;
import itwillbs.p2c3.class_will.handler.CommonUtils;
import itwillbs.p2c3.class_will.handler.WillUtils;
import itwillbs.p2c3.class_will.service.AdminService;
import itwillbs.p2c3.class_will.service.CscService;
import itwillbs.p2c3.class_will.service.ExcelService;
import itwillbs.p2c3.class_will.service.PayService;
import itwillbs.p2c3.class_will.vo.CategoryData;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Controller
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private ExcelService excelService;
	
	@Autowired
	private CommonUtils cUtils;
	
	@Autowired
	private CscService cscService;
	
	@Autowired
	private AdminServiceHelper adminServiceHelper;
	
	@Autowired
	private PayService payService;
	
	
	@GetMapping("admin")
	public String admin(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}
		
		String member_email = member.getMember_email();
		
		if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		
		// 대분류 카테고리 순위
		List<Map<String, Object>> category_list = adminService.getCategoryRanking();
		//카테고리 키값,벨류값 분류
        List<String> category_name_list = new ArrayList<>();
        List<Integer> reservation_count_list = new ArrayList<>();
        //category_name_list 요소들에 강제로 ""따옴표 삽입
        for (Map<String, Object> category : category_list) {
        	category_name_list.add("\"" + (String) category.get("code_value") + "\"");
        	reservation_count_list.add(((Long) category.get("reservation_count")).intValue());
        }
        
		// 월별 매출 서치
        List<Map<String, Object>> sales_list = adminService.getWillpayChart();
		// TODO Map으로 바꾸기
		
		// 오늘 회원가입 숫자
		Integer new_member = adminService.getNewMember();
		
		// 총 회원 수
		Integer total_member = adminService.getTotalMember();	
		
		System.out.println("월별 매출 : " + sales_list);
		System.out.println("오늘 회원가입 숫자 : " + new_member);
		System.out.println("총 회원 수 : " + total_member);
		System.out.println("카테고리 순위 : " + category_name_list);
		System.out.println("숫자 리스트 : " + reservation_count_list);
		// 오늘 방문자
		Integer daily_visit = adminService.getDailyVisit();
		if(daily_visit == null) {
			daily_visit = 0;
		}
		
		//----------------------------------------------------
		//adminToken 발급
		Map adminToken = payService.getAdminAccessToken();
		payService.registAdminToken(adminToken);
		//----------------------------------------------------
		
		//총 방문자
		Integer total_visit = adminService.getTotalVisit();
		
		model.addAttribute("category_name_list", category_name_list);
		model.addAttribute("reservation_count_list", reservation_count_list);
		model.addAttribute("sales_list", sales_list);
		model.addAttribute("new_member", new_member);
		model.addAttribute("total_member", total_member);
		model.addAttribute("daily_visit", daily_visit);
		model.addAttribute("total_visit", total_visit);
		
		return "admin/admin_main";
	}
	
	@GetMapping("admin-member")
	public String adminMain(@RequestParam(defaultValue = "일반회원") String type, Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		// 공통코드 추출을 위한 변수 선언
		String code_value = "member_type";
		String table_name = "MEMBER";
		// 파라미터로 사용될 (WHERE절 삽입) 공통코드값 추출
		String common1_code = adminService.getCommonCode(code_value);
		int common2_code = adminService.getCommon2Code(common1_code, type);
		// 컬럼명에 대한 공통코드값(JOIN절 삽입) 추출 
		Map<String, Object> params = cUtils.commonProcess(table_name, common2_code);
		// 회원리스트 추출
		List<Map<String, String>> member_list = adminService.getMemberList(params);
		// 뷰로 전달할 JSONObject 생성
		List<JSONObject> jo_list = new ArrayList<JSONObject>(); 
		// jSONObject에 회원정보 삽입
		for(Map<String, String> dbMember : member_list) {
            JSONObject jo = new JSONObject(dbMember);
            jo_list.add(jo);
		}
		
		model.addAttribute("jo_list", jo_list);
		model.addAttribute("tableName", "MEMBER");
		
		return "admin/admin_member";
	}
	
	@GetMapping("admin-class")
	public String adminClass(Model model,@RequestParam(defaultValue = "1") String type, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		// 클래스리스트 추출
		List<Map<String, Object>> class_list = adminService.getClassList(type);
		// 뷰로 전달할 JSONObject 생성
		List<JSONObject> jo_list = new ArrayList<JSONObject>(); 
		// JSONObject에 클래스 리스트 삽입
		for(Map<String, Object> class1 : class_list) {
            JSONObject jo = new JSONObject(class1);
            jo.put("class_category", class1.get("class_big_category") + "/" + class1.get("class_small_category"));
            jo_list.add(jo);
		}
		
		model.addAttribute("tableName", "class");
		model.addAttribute("jo_list", jo_list);
		return "admin/admin_class";
	}
	
    @ResponseBody
    @PostMapping("/uploadData")
    public ResponseEntity<String> uploadData(@RequestParam("tableName") String tableName
    						, @RequestParam("file") MultipartFile file) {
    	logger.info("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<join");
    	String msg = "";
    	HttpStatus status = null;
        if (file.isEmpty()) {
        	status = HttpStatus.BAD_REQUEST;
            msg = "파일이 비어있습니다";
        }else {
        	try {
                excelService.processExcelFile(tableName, file);
                status = HttpStatus.OK;
                msg = "파일 업로드 성공!";
            } catch (IOException e) {
            	status = HttpStatus.BAD_REQUEST;
                e.printStackTrace();
                msg = e.getMessage();
            }
        }
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "application/json");
		return new ResponseEntity<String>("{\"message\": \"" + msg + "\"}", headers, status);
    }
	
	@GetMapping("admin-category")
	public String adminCategory(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		
		// 최종적으로 뷰로 전달할 리스트 생성
	    List<Map<String, Object>> data = new ArrayList<>();
	    // 카테고리 테이블의 모든 정보 추출
	    Map<String, List<Map<String, Object>>> categoryData = adminService.getCategoryData();
	    // 대 카테고리 , 소 카테고리 분류
	    List<Map<String, Object>> bigCategory = categoryData.get("bigCategory");
	    List<Map<String, Object>> smallCategory = categoryData.get("smallCategory");
	    
	    // 대분류에 상속되는 소분류를 대분류 _children 배열안에 추가
	    for (Map<String, Object> bcg : bigCategory) {
	        Map<String, Object> map = new HashMap<>();
	        // Grid형식에서 사용할 값들 추출 및 삽입
	        String bigValue = (String) bcg.get("code_value");
	        Integer common2_code = (Integer) bcg.get("common2_code"); // Integer로 변환
	        map.put("id", common2_code);
	        map.put("largeCategory", bigValue);
	        map.put("hidden", bcg.get("code_hide").equals("N") ? false : true); // Toast UI 에서는 boolean을 인식하기때문에 변환
	        
	        // 소분류 데이터를 _children 배열에 추가
	        List<Map<String, Object>> children = new ArrayList<>();
	        for (Map<String, Object> scg : smallCategory) {
	            Integer parent_code = (Integer) scg.get("common2_code"); // Integer로 변환
	            // 대 카테고리 코드값과 소 카테고리 코드값을 비교하여 _children 배열에 데이터 삽입
	            if (common2_code.equals(parent_code)) {
	                Map<String, Object> map2 = new HashMap<>();
	                map2.put("id", scg.get("common3_code"));
	                map2.put("largeCategory", bigValue);
	                map2.put("smallCategory", scg.get("code_value"));
	                map2.put("hidden", scg.get("code_hide").equals("N") ? false : true);
	                children.add(map2);
	            }
	        }
	        if (!children.isEmpty()) {
	            map.put("_children", children);
	        }
	        // 최종 리스트에 계층형식의 데이터 삽입
	        data.add(map);
	    }
	    model.addAttribute("jo_list", new Gson().toJson(data)); // JSON 형식으로 변환하여 전달
	    return "admin/admin_category";
	}
	
	@GetMapping("admin-csc")
	public String adminCsc(Model model, String type, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		// type은 notice or faq
		String common2_value	 = "";
		String common2_code = "";
		String common1_code 	= "";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		
		// 고객센터(공지사항, faq) 리스트 type값에 따라 추출
		List<Map<String, Object>> data = adminService.getCscList(params);
		// 공통코드에 대한 키값 비교 및 벨류값 추출
		for (Map<String, Object> map : data) {
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                if (entry.getKey().contains("_category")) {
                	common2_code = (String)entry.getValue();
                }
            }
            switch (type) {
    		case "notice" 	: common1_code = "NTC"; break;
    		case "faq" 		: common1_code = "FQC"; break;
            }
            Integer common2_code_int = Integer.parseInt(common2_code);
            // 카테고리 테이블에 기록된 공통코드 값(숫자) 를 벨류값(공통코드 벨류값) 으로 변환
            common2_value = adminService.getCommon2Value(common1_code, common2_code_int);
            map.put(type + "_category", common2_value);
            
            // 게시글 숨김처리 값을 TOAST UI 스위치 버튼에 대한 boolean 값 으로 변환 
            map.put("hidden", map.get(type + "_hide").equals("Y") ? true : false); 
            
            
		}
		// 뷰로 전달할 JSONObject 생성 및 삽입
		List<JSONObject> jo_list = new ArrayList<JSONObject>(); 
		for(Map<String, Object> board : data) {
            JSONObject jo = new JSONObject(board);
            jo_list.add(jo);
		}
		
		model.addAttribute("jo_list", jo_list);
		
		return "admin/admin_csc";
	}
	
	
	@GetMapping("admin-csc-detail")
	public String adminCscDetail(String type,int code, Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		List<Map<String, Object>> list = null;
		String common1_code = "";
		// type에 따라 common1_code 정의
		switch (type) {
			case "notice" : common1_code = "NTC"; break;
			case "faq" : common1_code = "FQC"; break;
		}
		// 쿼리에 필요한 파라미터 정의
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("common1_code", common1_code);
		params.put("type", type);
		params.put("code", code);
		// 게시글 상세정보 조회
		Map<String, String> board = cscService.getBoardDetail(params);
		// 뷰에서 EL태그 사용을 위해 type에 따라 변수이름 다르게 저장
		switch (type) {
			case "notice" : model.addAttribute("notice", board); break;
			case "faq" : model.addAttribute("faq", board); break;
		}
		
		return "admin/admin_csc_detail";
	}
	
	@GetMapping("admin-csc-regist")
	public String adminCscRegist(String type, Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		// 동적인 뷰를 위해 type값 전달
		model.addAttribute("type", type);
		String code = "";
		// type값에 따라 common1_code값 저장
		switch (type) {
		case "notice" 	: code = "NTC"; break;
		case "faq" 		: code = "FQC"; break;
		case "event"	: break;
		}
		// type , code값에 따라 공통코드 테이블에서 카테고리 값들 추출(뷰에 노출할)
		List<Map<String, String>> category =  adminService.getBoardCategory(code);
		
		model.addAttribute("category", category);
		// 동적인 뷰를 위해 registType 저장(regist or modify)
		model.addAttribute("registType", "regist");
		return "admin/admin_csc_form";
	}
	
	@GetMapping("admin-csc-modify")
	public String adminCscModify(String type, Model model, int code, HttpSession session){
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		model.addAttribute("type", type);
		String colCat = "";
		//카테고리 데이터들고오기
		String common1_code = "";
		switch (type) {
		case "notice" 	: common1_code = "NTC"; break;
		case "faq" 		: common1_code = "FQC"; break;
		case "event"	: break;
		}
		List<Map<String, String>> category =  adminService.getBoardCategory(common1_code);
		model.addAttribute("category", category);
		
		//글 정보 들고오기
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("common1_code", common1_code);
		params.put("code", code);
		params.put("type", type);
		Map<String, String> board = cscService.getBoardDetail(params);
		
		// 동적 뷰를 위한 변수값 다르게 저장, 원래 게시글의 카테고리값 저장
		switch (type) {
			case "notice" : model.addAttribute("notice", board); colCat = board.get("notice_category");break; 
			case "faq" : model.addAttribute("faq", board); colCat = board.get("faq_category"); break; 
		}
		model.addAttribute("collectCat", colCat);
		// 동적인 뷰를 위해 registType 저장(regist or modify)
		model.addAttribute("registType", "modify");
		
		return "admin/admin_csc_form";
	}
	
	@GetMapping("admin-csc-delete")
	public String adminCscDelete(String type, int code, Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		String result = "";
		model.addAttribute("type", type);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("code", code);
		// type값에 따른 DB delete작업
		boolean deleteSuccess = adminService.deleteBoard(params);
		if(!deleteSuccess) {
			result = WillUtils.checkDeleteSuccess(false, model, "글 삭제 실패!", true);
			return result;
		}
		
		result = WillUtils.checkDeleteSuccess(true, model, "글 삭제 성공!", true);
		return result;
	}
	
	@GetMapping("admin-member-detail")
	public String adminMemberDetail(String member_code, Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		Map<String, Object> params =  cUtils.commonProcess("MEMBER", member_code);
		Map<String, String> dbMember = adminService.getMemberInfo(params);
		
		model.addAttribute("member", dbMember);
		
		return "admin/admin_member_detail";
	}
	
	@GetMapping("admin-class-detail")
	public String adminClassDetail(String class_code, Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		Map<String, String> class1 = adminService.getClassInfo(class_code);
		model.addAttribute("classInfo", class1);
		return "admin/admin_class_detail";
	}
	
    @GetMapping("/downloadExcel")
    public ResponseEntity<byte[]> downloadExcel(
            @RequestParam String tableName, 
            @RequestParam String title,
            @RequestParam(required = false) boolean currentPageOnly) throws IOException {
    	// DB에서 컬럼명을 가져옴
        List<String> columns = adminService.getColumnNames(tableName);
        
        List<Map<String, Object>> data;
        
        data = adminService.getAllData(tableName); // 전체 데이터 가져오기
        
        // excelService에 excel 생성요청
        byte[] excelBytes = excelService.createExcel(title, columns, data);
        
        HttpHeaders headers = new HttpHeaders();
        // 파일명에 확장자를 명시적으로 추가
        String encodedTitle = URLEncoder.encode(title + ".xlsx", StandardCharsets.UTF_8.toString());
        
        headers.add("Content-Disposition", "attachment; filename=\"" + encodedTitle + "\"");
        
        return new ResponseEntity<>(excelBytes, headers, HttpStatus.OK);
    }
    
    @GetMapping("/excelFormDownload")
    public ResponseEntity<byte[]> excelFormDownload(
    		@RequestParam String tableName, 
            @RequestParam String title) throws IOException  {
    	List<String> columns = adminService.getColumnNames(tableName);
    	List<String> dataTypes = adminService.getColumnDataTypes(tableName);
    	
        if(columns.size() == dataTypes.size()) { // 유효성?
            for(int i = 0; i < columns.size(); i++) {
            	String column = columns.get(i);
                columns.set(i, column + "/" + dataTypes.get(i));
            }
        }
        
        for(int i = 0; i < columns.size(); i++) {
	        if(columns.get(i).contains("_code")) {
	        	columns.remove(i);
	        }
        }
        
        byte[] excelBytes = excelService.createExcelForm(title, columns);
        
        
    	LocalDateTime now = LocalDateTime.now();
    	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("YYYYMMDD");
    	String nowt = now.format(dtf);
    	
    	HttpHeaders headers = new HttpHeaders();
    	String encodedTitle = URLEncoder.encode(tableName + "/" + title + "/" + nowt + ".xlsx", StandardCharsets.UTF_8.toString());
    	headers.add("Content-Disposition", "attachment; filename=\"" + encodedTitle + "\"");
    	
    	return new ResponseEntity<>(excelBytes, headers, HttpStatus.OK);
    }
    
    
    @ResponseBody
    @PostMapping(value = "insert", consumes = "application/json", produces = "application/json")
    public Map<String, Object> categoryInsert(@RequestBody CategoryData data) {
        try {
            // Update 작업
            adminServiceHelper.processRows(data.getUpdatedRows(), "update");

            // Insert 작업
            adminServiceHelper.processRows(data.getCreatedRows(), "insert");

            // Delete 작업
            adminServiceHelper.processRows(data.getDeletedRows(), "delete");

            return Map.of("success", true, "message", "변경 사항이 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return Map.of("success", false, "message", "변경 사항 적용 실패: " + e.getMessage());
        }
    }
    
    @ResponseBody
    @PostMapping(value = "insertReward", consumes = "application/json", produces = "application/json")
    public Map<String, Object> rewardInsert(@RequestBody Map<String, Object> params) {
    	System.out.println(params);
    	boolean isUpdateSuccess = adminService.updateRewardData(params);
    	
        Map<String, Object> response = new HashMap<>();
        if (isUpdateSuccess) {
            response.put("success", true);
            response.put("message", "변경 사항이 성공적으로 적용되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "변경 사항 적용 실패.");
        }
    	
        return response;
    }
    
    
    @PostMapping("admin-csc-pro")
    public String noticePro(@RequestParam Map<String, Object> map, Model model) {
    	boolean isInsertSuccess = false;
    	String registType = (String)map.get("registType");
    	
    	if(registType.equals("regist")) {
    		isInsertSuccess = adminService.insertBoard(map);
    	}else if(registType.equals("modify")) {
    		isInsertSuccess = adminService.updateBoard(map);
    	}
    	
    	if(!isInsertSuccess) {
    		return WillUtils.checkDeleteSuccess(false, model, "글 등록 실패!", true);
    	}
    	
    	return WillUtils.checkDeleteSuccess(true, model, "글 등록 완료!", true);    	
    }
    
  @GetMapping("admin-pay")
  public String admin_pay(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}  
	List<Map<String, Object>> pay_list = adminService.getPayList();
	
	List<JSONObject> jo_list = new ArrayList<JSONObject>(); 
	for(Map<String, Object> pay : pay_list) {
		JSONObject jo = new JSONObject(pay);
		jo_list.add(jo);
	}
			
	model.addAttribute("jo_list", jo_list);
	return "admin/admin_pay";
  }
  

  
  
  @GetMapping("admin-pay-willpay")
  public String adminPayWillpay(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
	  List<Map<String, Object>> list = adminService.getRewardData();
	  
	  List<JSONObject> jo_list = new ArrayList<JSONObject>(); 
		for(Map<String, Object> reward : list) {
			JSONObject jo = new JSONObject(reward);
			jo_list.add(jo);
		}
	  
		model.addAttribute("jo_list", jo_list);
		
	  return "admin/admin_pay_willpay";
  }
  
  @ResponseBody
  @GetMapping("willpay-chart")
  public List<Map<String, Object>> willpayChart() {
	  List<Map<String, Object>> list = adminService.getWillpayChart(); 
	  return list;
  }
  
  
  @ResponseBody
  @GetMapping("pay-chart")
  public List<Map<String, Object>> payChart() {
	  List<Map<String, Object>> list = adminService.getPayChart(); 
	  return list;
  }
		  
//     썸머노트 이미지업로드
    @ResponseBody
    @PostMapping("admin-uploadImage")
    public String uploadImage(@RequestParam("file") MultipartFile file, HttpSession session) {
        if (file.isEmpty()) {
            return "{\"url\":\"\"}";
        }
        
        String uploadDir = "resources/upload";
        String saveDir = session.getServletContext().getRealPath(uploadDir);
        System.out.println("실제 업로드 경로(session): " + saveDir);

        LocalDate today = LocalDate.now();
        String datePattern = "yyyy/MM/dd";
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
        String subDir = today.format(dtf);

        saveDir += "/" + subDir;
        Path path = Paths.get(saveDir);

        try {
            Files.createDirectories(path);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String fileName = UUID.randomUUID().toString().substring(0, 8) + "_" + file.getOriginalFilename();
        String webUrl = uploadDir + "/" + subDir + "/" + fileName;
        
        try {
            if (!file.getOriginalFilename().equals("")) {
                file.transferTo(new File(saveDir, fileName));
            }
        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
        }
        
        System.out.println("파일 저장 경로: " + saveDir + "/" + fileName);
        System.out.println("웹 접근 경로: " + webUrl);

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("url", webUrl.replace("\\", "/"));
        
        return jsonResponse.toString();
    }
    
    @ResponseBody
    @PostMapping("registClass")
    public Map<String, String> registClass(String class_code,Model model) {
    	boolean isSuccess = adminService.registClass(class_code);
    	String msg = "";
    	Map<String, String> strMap = new HashMap<String, String>();
    	if (isSuccess) {
    		msg = "클래스 등록 성공!";
    	}else {
    		msg = "클래스 등록 실패!";
    	}
    	strMap.put("msg", msg);
    	JSONObject jo = new JSONObject(strMap);
    	
    	return strMap;
    }
    
    @GetMapping("admin-report")
    public String classReport(@RequestParam(defaultValue = "처리중") String status, Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
    	List<Map<String, String>> list = adminService.getClassReportData(status);
		List<JSONObject> jo_list = new ArrayList<JSONObject>();
		
		for(Map<String, String> report : list) {
            JSONObject jo = new JSONObject(report);
            jo_list.add(jo);
		}
    	model.addAttribute("jo_list", jo_list);
    	
    	return "admin/admin_report";
    }
    
    @GetMapping("admin-class-report-detail")
    public String classReportDetail(int class_report_code, Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String category = "";
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}
		String member_email = member.getMember_email();
		if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
		
    	Map<String, String> report = adminService.getClassReportDetail(class_report_code);
    	if(report.get("class_report_small_category") == null) {
    		category = report.get("class_report_big_category");
    	}else {
    		category = report.get("class_report_big_category") + " / " + report.get("class_report_small_category");
    	}
    	
    	
    	report.put("category", category);
    	
    	model.addAttribute("report", report);
    	return "admin/admin_class_report_detail";
    }
    
    @ResponseBody
    @PostMapping("hideClass")
    public String hideClass(@RequestParam Map<String, Object> params,Model model) {
    	String class_code = (String)params.get("class_code");
    	String class_report_code = (String)params.get("class_report_code");
    	boolean isSuccess = adminService.updateClassReportStatus(class_report_code, "hide");
    	if(!isSuccess) {
    		return "false";
    	}
    	isSuccess = adminService.updateClassStatusHide(class_code);
    	if(!isSuccess) {
    		return "false";
    	}
    	
    	return "true";
    }
    
    @ResponseBody
    @PostMapping("cancelReport")
    public String cancelReport(@RequestParam Map<String, Object> params) {
    	String class_report_code = (String)params.get("class_report_code");
    	boolean isSuccess = adminService.updateClassReportStatus(class_report_code, "cancel");
    	if(!isSuccess) {
    		return "false";
    	}
    	return "true";
    }
    
//    @ResponseBody
//    @PostMapping(value = "insert", consumes = "application/json", produces = "application/json")
//    public Map<String, Object> categoryInsert(@RequestBody CategoryData data) {
//        try {
//            // Update 작업
//            adminServiceHelper.processRows(data.getUpdatedRows(), "update");
//
//            // Insert 작업
//            adminServiceHelper.processRows(data.getCreatedRows(), "insert");
//
//            // Delete 작업
//            adminServiceHelper.processRows(data.getDeletedRows(), "delete");
//
//            return Map.of("success", true, "message", "변경 사항이 성공적으로 저장되었습니다.");
//        } catch (Exception e) {
//            e.printStackTrace();
//            return Map.of("success", false, "message", "변경 사항 적용 실패: " + e.getMessage());
//        }
//    }
    
    @ResponseBody
    @PostMapping("updateCsc")
    public Map<String, Object> updateCsc(@RequestBody List<Map<String, Object>> map) {
    	boolean isSuccess = false;
    	Map<String, Object> originalMap = map.get(0);
    	String type = (String)originalMap.get("type");
    	List<Map<String, Object>> realList = (List<Map<String, Object>>)originalMap.get("updatedRows");
    	for(Map<String, Object> params : realList) {
    		switch (type) {
			case "notice": isSuccess = adminService.updateNoticeHide(params); break;
			case "faq": isSuccess = adminService.updateFaqHide(params); break;
			}
    	}
    	if(!isSuccess) {
    		return Map.of("success", false, "message", "변경 사항 적용 실패");
    	}	
    	
    	return Map.of("success", true, "message", "변경 사항이 성공적으로 저장되었습니다.");
    }
    
    @ResponseBody
    @PostMapping("update-event")
    public Map<String, Object> updateEvent(@RequestBody Map<String, Object> map) {
    	boolean isSuccess = false;
    	boolean isUpdateSuccess = false;
    	int event_code = 0;
    	String msg = "";
    	List<Map<String, Object>> updatedRows =  (List<Map<String,Object>>)map.get("updatedRows");
    	System.out.println(updatedRows);
    	if(updatedRows.isEmpty()) {
    		isSuccess = false;
    		msg = "변경 사항이 없습니다.";
    		return Map.of("success", false, "message", "변경 사항이 없습니다.");
    	}else {
    		for(Map<String, Object> updateRow : updatedRows) {
    			isUpdateSuccess = adminService.updateEventHide(updateRow);
    			
    			if(!isUpdateSuccess) {
        			isSuccess = false;
        			msg = "변경 사항 적용 실패";
            		return Map.of("success", isSuccess, "message", msg);
    			}
    		
    			isSuccess = true;
    			msg = "변경 사항이 성공적으로 저장되었습니다."; 
        	}
    	}
    	return Map.of("success", isSuccess, "message", msg);
    }
    
    @GetMapping("admin-event")
    public String adminEvent(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		String member_email = member.getMember_email();
		
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false);
		}else if(!member_email.equals("admin")) {
			return WillUtils.checkDeleteSuccess(false, model, "관리자만 이용 가능합니다", false);
		}
    	List<Map<String, Object>> list = adminService.getEventList();
    	for(Map<String, Object> event : list) {
    		event.put("event_date", event.get("event_start_date") + " ~ " + event.get("event_end_date"));
    		event.put("hidden", event.get("event_hide").equals("Y") ? true : false); 
    	}
		List<JSONObject> jo_list = new ArrayList<JSONObject>();
		
		for(Map<String, Object> event : list) {
            JSONObject jo = new JSONObject(event);
            jo_list.add(jo);
		}
    	model.addAttribute("jo_list", jo_list);
    	
    	
    	return "admin/admin_event";
    }
    
    @GetMapping("admin-event-regist")
    public String adminEventRegist() {
    	
    	return "admin/admin_event_form";
    }
    
    @GetMapping("admin-event-modify")
    public String adminEventModify(int event_code, Model model) {
    	Map<String, Object> event = adminService.getEventDetail(event_code);
    	model.addAttribute("event", event);
    	
    	return "admin/admin_event_form";
    }
    
    @PostMapping("admin-event-regist-pro")
    public String adminEventRegistPro(@RequestParam Map<String, Object> map
    		,@RequestParam MultipartFile event_thumbFile
    		,@RequestParam MultipartFile event_imageFile
    		,HttpSession session
    		,Model model) {
    	map.put("event_start_date", ((String)map.get("event_start_date")).replace("-", ""));
    	map.put("event_end_date", ((String)map.get("event_end_date")).replace("-", ""));
    	System.out.println("map : " + map);
    	
    	System.out.println("event_thumbFile : " + event_thumbFile);
    	System.out.println("event_imageFile : " + event_imageFile);
        
        String uploadDir = "resources/upload";
        String saveDir = session.getServletContext().getRealPath(uploadDir);
        System.out.println("실제 업로드 경로(session): " + saveDir);

        LocalDate today = LocalDate.now();
        String datePattern = "yyyy/MM/dd";
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
        String subDir = today.format(dtf);

        saveDir += "/" + subDir;
        Path path = Paths.get(saveDir);

        try {
            Files.createDirectories(path);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String event_thumbFile_fileName = UUID.randomUUID().toString().substring(0, 8) + "_" + event_thumbFile.getOriginalFilename();
        String event_imageFile_fileName = UUID.randomUUID().toString().substring(0, 8) + "_" + event_imageFile.getOriginalFilename();
        
        String event_thumbFile_webUrl = uploadDir + "/" + subDir + "/" + event_thumbFile_fileName;
        String event_imageFile_webUrl = uploadDir + "/" + subDir + "/" + event_imageFile_fileName;

        try {
            if (!event_thumbFile.getOriginalFilename().equals("")) {
            	event_thumbFile.transferTo(new File(saveDir, event_thumbFile_fileName));
            }
            
            if (!event_imageFile.getOriginalFilename().equals("")) {
            	event_imageFile.transferTo(new File(saveDir, event_imageFile_fileName));
            }
            
            
        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
        }
        
        System.out.println("파일 저장 경로: " + saveDir + "/" + event_thumbFile_fileName);
        System.out.println("파일 저장 경로: " + saveDir + "/" + event_imageFile_fileName);
        System.out.println("웹 접근 경로: " + event_thumbFile_webUrl);
        System.out.println("웹 접근 경로: " + event_imageFile_webUrl);
    	
        map.put("event_image", event_imageFile_webUrl);
        map.put("event_thumbnail", event_thumbFile_webUrl);
        
        boolean isSuccess = adminService.insertEvent(map);
        String result = "";
        if(!isSuccess) {
        	result = WillUtils.checkDeleteSuccess(false, model, "이벤트 등록 실패!", true);
        }
        
        result = WillUtils.checkDeleteSuccess(true, model, "이벤트 등록 성공!", true);
        
    	return result;
    }
    
}
	
