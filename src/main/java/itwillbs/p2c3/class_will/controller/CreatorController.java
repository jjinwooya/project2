package itwillbs.p2c3.class_will.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import itwillbs.p2c3.class_will.handler.WillUtils;
import itwillbs.p2c3.class_will.service.CreatorService;
import itwillbs.p2c3.class_will.service.MemberService;
import itwillbs.p2c3.class_will.vo.ClassTimeVO;
import itwillbs.p2c3.class_will.vo.CurriVO;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Controller
public class CreatorController {
	
	@Autowired
	private CreatorService creatorService;
	
	// 이미지 업로드 디렉토리
	String uploadDir = "/resources/upload";

	// creator-main으로
	@GetMapping("creator-main")
	public String createrMain(HttpSession session, Model model) {
//		MemberVO dbmember = new MemberVO();
//		dbmember.setMember_email("bjm0209@naver.com");
//		MemberVO member = memberService.selectMember(dbmember);
//		session.setAttribute("member", member);
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "로그인 후 이용 가능합니다!");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		if(Integer.parseInt(member.getMember_type()) != 2 && Integer.parseInt(member.getMember_type()) != 3) {
			model.addAttribute("msg", "크리에이터 자격이 없습니다!");
			model.addAttribute("targetURL", "creator-qualify");
			return "result_process/fail";
		}
		
		session.setMaxInactiveInterval(60*60*60*60*60*60*100);
		return "creator/creator-main";
	}
	
	// creator-qualify 로
	@GetMapping("creator-qualify")
	public String creatorQualify(HttpSession session, Model model){
		MemberVO member = (MemberVO)session.getAttribute("member");
		Map<String, String> bank_info = (Map<String, String>)session.getAttribute("token");
		if(member == null) {
			model.addAttribute("msg", "로그인 후 이용 가능합니다!");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		if(Integer.parseInt(member.getMember_type()) == 2 && Integer.parseInt(member.getMember_type()) == 3) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "creator-main");
			return "result_process/fail";
		}
		System.out.println(">>>>>>>token: " + bank_info);
		model.addAttribute("token", bank_info);
		
		return "creator/creator-qualify";
	}

	// creator-regist PRO 
	@GetMapping("creator-regist")
	public String creatorRegist(HttpSession session, Model model){
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(Integer.parseInt(member.getMember_type()) == 2) {
			model.addAttribute("msg", "이미 크리에이터로 등록된 회원입니다!");
			model.addAttribute("targetURL", "creator-main");
			return "result_process/fail";
		}
		creatorService.updateMemberType(member);
		return "creator-main";
	}
	
	//=================================================================================
	// creater-class로
	@GetMapping("creator-class")
	public String createrClass(Model model, HttpSession session) {
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		List<Map<String, Object>> classList = creatorService.getClassInfo(member);
		
		List<JSONObject> cl_list = new ArrayList<JSONObject>(); 
		
		for(Map<String, Object> clas : classList) {
            JSONObject cl = new JSONObject(clas);
            cl_list.add(cl);
		}
		List<Map<String, String>> regStatus = creatorService.getStatusList(); 
		
		model.addAttribute("cl_list", cl_list);
		model.addAttribute("classList", classList);
		model.addAttribute("regStatus", regStatus);
		
		return "creator/creator-class";
	}
	
	@ResponseBody
	@GetMapping("getStatusClass")
	public List<Map<String, Object>> getStatusClass(@RequestParam(defaultValue = "0") int status, HttpSession session, Model model){
		MemberVO member = (MemberVO)session.getAttribute("member");
		List<Map<String, Object>> classList = creatorService.getClassStatusInfo(status, member);
		
		return classList;
	}
	
	// creater-classReg 페이지로
	@GetMapping("creator-classReg")
	public String createrClassReg(HttpSession session, Model model) {
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		
		List<Map<String, String>> categoryList = creatorService.getCategory();
		List<Map<String, String>> hashtagList = creatorService.getHashtag();
		List<Map<String, String>> hide = creatorService.getHide();
		
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("hashtagList", hashtagList);
		model.addAttribute("hide", hide);
		
		return "creator/creator-classReg";
	}
	
	// geocode api 코드
    @Value("${vworld.api.key}")
    private String vworldApiKey;

    private static final String VWORLD_API_URL = "https://api.vworld.kr/req/address";
    
	@ResponseBody
	@GetMapping("geocode")
	 public ResponseEntity<String> geocode(@RequestParam String address) {
        String url = String.format("%s?service=address&request=getcoord&version=2.0&crs=epsg:4326&address=%s&refine=true&simple=false&format=xml&type=road&key=%s", VWORLD_API_URL, address, vworldApiKey);

        RestTemplate restTemplate = new RestTemplate();
        String response = restTemplate.getForObject(url, String.class);

        return ResponseEntity.ok(response);
    } 
	
	//  썸머노트 이미지업로드
//	 @ResponseBody
//	 @PostMapping("creatorUploadExImage")
//	 public String uploadImage(@RequestParam("file") MultipartFile file, HttpSession session) {
//	     if (file.isEmpty()) {
//	         return "{\"url\":\"\"}";
//	     }
//	
//	     String uploadDir = "/resources/upload";
//	     String saveDir = session.getServletContext().getRealPath(uploadDir);
//	     System.out.println("실제 업로드 경로(session): " + saveDir);
//	
//	     LocalDate today = LocalDate.now();
//	     String datePattern = "yyyy/MM/dd";
//	     DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
//	     String subDir = today.format(dtf);
//	
//	     saveDir += "/" + subDir;
//	     System.out.println(saveDir);
//	     Path path = Paths.get(saveDir);
//	
//	     try {
//	         Files.createDirectories(path);
//	     } catch (IOException e) {
//	         e.printStackTrace();
//	     }
//	
//	     String fileName = UUID.randomUUID().toString().substring(0, 8) + "_" + file.getOriginalFilename();
//	     String webUrl = uploadDir + "/" + subDir + "/" + fileName;
//	
//	     try {
//	         if (!file.getOriginalFilename().equals("")) {
//	             file.transferTo(new File(saveDir, fileName));
//	         }
//	     } catch (IllegalStateException | IOException e) {
//	         e.printStackTrace();
//	     }
//	
//	     System.out.println("파일 저장 경로: " + saveDir + "/" + fileName);
//	     System.out.println("웹 접근 경로: " + webUrl);
//	
//	     JSONObject jsonResponse = new JSONObject();
//	     jsonResponse.put("url", webUrl.replace("\\", "/"));
//	     
//	     return jsonResponse.toString();
//	 }

	// creater-class 상세페이지
	@GetMapping("creator-classModify")
	public String createrClassModify(HttpSession session
									, Model model
									, @RequestParam(defaultValue = "0") int class_code) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		List<Map<String, String>> categoryList = creatorService.getCategory();
		List<Map<String, String>> hashtagList = creatorService.getHashtag();
		Map<String, Object> classDetail = creatorService.getClassDetail(class_code);
		
		String location = (String)classDetail.get("class_location");
		if(location.contains("/")) {
			String[] locationArr = location.split("/");
			classDetail.put("post_code", locationArr[0]);
			classDetail.put("address1", locationArr[1]);
			classDetail.put("address2", locationArr[2]);
		}
		
		String[] arrFileNames = {
               (String) classDetail.get("class_image"),
               (String) classDetail.get("class_image2"),
               (String) classDetail.get("class_image3"),
	    };
		String thumnailFile = (String) classDetail.get("class_thumnail");
		
	    model.addAttribute("fileNames", arrFileNames);
	    model.addAttribute("thumnailFile", thumnailFile);
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("hashtagList", hashtagList);
		model.addAttribute("classDetail", classDetail);
		
		return "creator/creator-classModify";
	}
	
	@ResponseBody
	@GetMapping("ClassDeleteFile")
	public String ClassDeleteFile(@RequestParam Map<String, Object> map, HttpSession session) {
		System.out.println(">>>map: " + map);
		int removeCount = creatorService.removeClassFile(map);
		
		if(removeCount > 0) {
			// 서버에 업로드된 파일 삭제
			String saveDir = session.getServletContext().getRealPath(uploadDir);
			if(!map.get("class_file1").equals("")) {
				Path path = Paths.get(saveDir + "/" + map.get("class_file1"));
				try {
					Files.deleteIfExists(path);
					// 삭제성공시 true 값 리턴
					return "true";
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		return "false";
	}
	
	// ajax로 카테고리 처리
	@ResponseBody
	@GetMapping("getCategoryDetail")
	public List<Map<String, Object>> getCategoryDetail(@RequestParam String big_category){
		List<Map<String, Object>> categoryDetail = creatorService.getCategoryDetail(big_category);
		System.out.println("categoryDetail: " + categoryDetail);
		return categoryDetail;
	}

	// creater-class 등록
	@PostMapping("creator-classRegPro")
	public String createrClassRegPro(@RequestParam Map<String, Object> map,  @RequestParam Map<String, MultipartFile> files, HttpSession session, HttpServletRequest request, Model model) {
		System.out.println(">>>>>>>>regPro map: " + map);
		System.out.println(">>>>>>>>regPro files: " + files);
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		map.put("member_code", member.getMember_code());
		map.put("class_location", map.get("post_code") + "/" + map.get("address1") + "/" + map.get("address2"));
		
		List<CurriVO> curriList = new ArrayList<CurriVO>();
		
		for (Map.Entry<String, Object> entry : map.entrySet()) {
			CurriVO curri = new CurriVO();
            if (entry.getKey().contains("차시")) {
            	curri.setCurri_round(entry.getKey());
            	curri.setCurri_content((String)entry.getValue());
            	curriList.add(curri);
            }
        }

        String uploadDir = "/resources/upload";
        String saveDir = request.getServletContext().getRealPath(uploadDir);

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
        
        for (Map.Entry<String, MultipartFile> entry : files.entrySet()) {
            String paramName = entry.getKey();
            MultipartFile file = entry.getValue(); // mfile
            if (file != null && !file.getOriginalFilename().equals("")) {
                String fileName = UUID.randomUUID().toString().substring(0, 8) + "_" + file.getOriginalFilename();
                try {
                    // DB에 파일 이름 저장
                    if (paramName.equals("class_thumnail")) {
                        map.put("class_thumnail", subDir + "/" + fileName);
                    } else if (paramName.equals("file1")) {
                        map.put("class_image", subDir + "/" + fileName);
                    } else if (paramName.equals("file2")) {
                        map.put("class_image2", subDir + "/" + fileName);
                    } else if (paramName.equals("file3")) {
                        map.put("class_image3", subDir + "/" + fileName);
                    }
                    file.transferTo(new File(saveDir, fileName));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        System.out.println(">>>>> map 파일저장 이후 " + map);
        creatorService.createrClassRegPro(map, curriList);
		
		return "redirect:/creator-class";
	}
	
	// creater-class 등록
	@PostMapping("ClassModifyPro")
	public String ClassModifyPro(@RequestParam Map<String, Object> map,  @RequestParam Map<String, MultipartFile> files, HttpSession session, HttpServletRequest request, Model model) {
		System.out.println(">>>>>>>modifyPro map: " + map);
		System.out.println(">>>>>>>>modifyPro files: " + files);
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		map.put("member_code", member.getMember_code());
		map.put("class_location", map.get("post_code") + "/" + map.get("address1") + "/" + map.get("address2"));
		
		List<CurriVO> curriList = new ArrayList<CurriVO>();
		
		for (Map.Entry<String, Object> entry : map.entrySet()) {
			CurriVO curri = new CurriVO();
			if (entry.getKey().contains("차시")) {
				curri.setCurri_round(entry.getKey());
				curri.setCurri_content((String)entry.getValue());
				curriList.add(curri);
			}
		}
		
//		String uploadDir = "/resources/upload";
		String saveDir = request.getServletContext().getRealPath(uploadDir);
		
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
		
		for (Map.Entry<String, MultipartFile> entry : files.entrySet()) {
			String paramName = entry.getKey();
			MultipartFile file = entry.getValue(); // mfile
			if (file != null && !file.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString().substring(0, 8) + "_" + file.getOriginalFilename();
				try {
					// DB에 파일 이름 저장
					if (paramName.equals("class_thumnail")) {
						map.put("class_thumnail", subDir + "/" + fileName);
					} else if (paramName.equals("file1")) {
						map.put("class_image", subDir + "/" + fileName);
					} else if (paramName.equals("file2")) {
						map.put("class_image2", subDir + "/" + fileName);
					} else if (paramName.equals("file3")) {
						map.put("class_image3", subDir + "/" + fileName);
					}
					file.transferTo(new File(saveDir, fileName));
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		System.out.println(">>>>> map 파일저장 이후 " + map);
		creatorService.createrClassModifyPro(map, curriList);
		
		return "redirect:/creator-class";
	}
	
	
	// creater-class 일정등록 페이지로
	@GetMapping("creator-class-plan")
	public String createrClassPlan(HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		
		List<Map<String, Object>> classList = creatorService.getCertifiedClassInfo(member);
		model.addAttribute("classList", classList);
		
		return "creator/creator-class-plan";
	}

	// creater-class-last 페이지로
	@GetMapping("creator-class-last")
	public String createrClassLast(HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		
		List<Map<String, Object>> classList = creatorService.getCertifiedClassInfo(member);
		model.addAttribute("classList", classList);
		
		return "creator/creator-class-last";
	}
	
	// 입력된 일정 데이터 처리
	@PostMapping("creatorPlanPro")
	public String creatorPlanPro(@RequestParam Map<String, Object> map
								, Model model
								, RedirectAttributes redirectAttributes, HttpSession session) {
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		
		System.out.println(">>>>>>>>>>>map : " + map);
		// 회차별 시간 데이터 가져오기
		List<ClassTimeVO> classTimeList = new ArrayList<ClassTimeVO>();
		Map<String, ClassTimeVO> tempMap = new HashMap<>();
		
		for (Map.Entry<String, Object> entry : map.entrySet()) {
            if (entry.getKey().contains("회차")) {
            	String key = entry.getKey();
            	String round = key.substring(0, key.indexOf('_'));
            	String type = key.substring(key.indexOf('_') + 1);
            	
            	 ClassTimeVO classTime;
            	    
        	    if (tempMap.containsKey(round)) {
        	        classTime = tempMap.get(round);
        	    } else {
        	        classTime = new ClassTimeVO();
        	        classTime.setRound(round);
        	        tempMap.put(round, classTime);
        	    }
        	    
        	    if ("start".equals(type)) {
        	        classTime.setStartTime((String)entry.getValue());
        	        System.out.println("classTimeStart: " + classTime);
        	    } else if ("end".equals(type)) {
        	        classTime.setEndTime((String)entry.getValue());
        	        System.out.println("classTimeEnd: " + classTime);
        	    }
            }
        }
		classTimeList.addAll(tempMap.values());
		System.out.println(">>>>>>>classTimeList" + classTimeList);
		
		// 날짜 데이터 파싱하여 List로 전달
		List<String> dateList = Arrays.stream(((String)map.get("selectedDates")).split(","))
			.map(String::trim)
			.collect(Collectors.toList());
		System.out.println(">>>>>>dateList : " + dateList);
		
		List<ClassTimeVO> classTimerList = new ArrayList<ClassTimeVO>();
		for(ClassTimeVO classTime : classTimeList) {
			for(String date : dateList) {
				ClassTimeVO classTimer = new ClassTimeVO();
				classTimer.setRound(classTime.getRound());
				classTimer.setStartTime(classTime.getStartTime());
				classTimer.setEndTime(classTime.getEndTime());
				classTimer.setDate(date);
				classTimerList.add(classTimer);
			}
		}
		
		System.out.println(">>>>>>>classTimerList" + classTimerList);
//		System.out.println(">>>>>>>classSelect" + map.get("classSelect"));
 
		int insertCount = creatorService.insertClassPlan(map, classTimerList);
		if(insertCount > 0) {
			redirectAttributes.addFlashAttribute("classCode", map.get("classSelect"));
			return "redirect:/creator-class-plan";
		}
		
		model.addAttribute("msg", "일정등록 오류");
		return "result_process/fail";
	}
	
	// ajax로 날짜 데이터 가져오기
	@ResponseBody
	@GetMapping("getSelectedDates")
	public List<Map<String, Object>> getSelectedDates(@RequestParam(defaultValue = "0") int classCode) {
		List<Map<String, Object>> scheduleList = creatorService.getSchedule(classCode);
		System.out.println(">>>>>>>>>scheduleList: " + scheduleList);
		
		return scheduleList;
	}

	// ajax로 날짜 데이터 삭제하기
	@ResponseBody
	@GetMapping("deleteSchedule")
	public Map<String, String> deleteSchedule(@RequestParam(defaultValue = "0") int classScheduleCode) {
		int deleteCount = creatorService.deleteSchedule(classScheduleCode);
		
		Map<String, String> map = new HashMap<String, String>();
		if(deleteCount > 0) {
			map.put("answer", "정상삭제 되었습니다");
			return map;
		} else {
			map.put("answer", "예약이 있는 수업은 삭제가 불가능합니다");
			return map;
		}
	}
	// ajax로 날짜 데이터 전체 삭제
	@ResponseBody
	@GetMapping("deleteAllSchedule")
	public Map<String, String> deleteAllSchedule(@RequestParam(defaultValue = "0") int classCode) {
		int deleteCount = creatorService.deleteAllSchedule(classCode);
		
		Map<String, String> map = new HashMap<String, String>();
		if(deleteCount > 0) {
			map.put("answer", "정상삭제 되었습니다");
			return map;
		} else {
			map.put("answer", "예약이 있는 수업이 있어 삭제가 불가능합니다");
			return map;
		}
	}
	
	// ajax로 날짜 데이터 가져오기
	@ResponseBody
	@GetMapping("getEndedClass")
	public List<Map<String, Object>> getEndedClass(@RequestParam(defaultValue = "0") int classCode) {
		List<Map<String, Object>> endedScheduleList = creatorService.getEndedSchedule(classCode);
		System.out.println(">>>>>>>>>endedScheduleList: " + endedScheduleList);
		
		return endedScheduleList;
	}
	
	//======================================================
	// creater-review로
	@GetMapping("creator-review")
	public String createrReview(HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		
		List<Map<String, Object>> classList = creatorService.getClassByReview(member);
		List<Map<String, Object>> classReviewList = creatorService.getReviewInfo(member);
		
		List<JSONObject> rw_list = new ArrayList<JSONObject>(); 
		
		for(Map<String, Object> clas : classReviewList) {
            JSONObject cl = new JSONObject(clas);
            rw_list.add(cl);
		}
		
		model.addAttribute("classList", classList);
		model.addAttribute("rw_list", rw_list);
		
		return "creator/creator-review";
	}
	
	@ResponseBody
	@GetMapping("getReviewByClass")
	public List<Map<String, Object>> getReviewByClass(@RequestParam(defaultValue = "0") int classCode, HttpSession session){
		MemberVO member =  (MemberVO)session.getAttribute("member");
		int member_code = member.getMember_code();
		List<Map<String, Object>> reviewListByClass = creatorService.getReviewByClass(classCode, member_code);
		return reviewListByClass;
	}

	@ResponseBody
	@GetMapping("getReviewByType")
	public List<Map<String, Object>> getReviewByType(@RequestParam(defaultValue = "0") int classCode
													, @RequestParam(defaultValue = "N") String type, HttpSession session){
		MemberVO member =  (MemberVO)session.getAttribute("member");
		int member_code = member.getMember_code();
		List<Map<String, Object>> reviewListByType = creatorService.getReviewByType(classCode, type, member_code);
		return reviewListByType;
	}
	
	// creater-review-form으로
	@GetMapping("creator-review-form")
	public String createrReviewForm(@RequestParam(defaultValue = "0") int class_review_code, Model model) {
		Map<String, Object> review = creatorService.getReviewByReviewCode(class_review_code);
		Map<String, Object> reply = creatorService.getReplyByReviewCode(class_review_code);
		model.addAttribute("review", review);
		model.addAttribute("reply", reply);
		
		return "creator/creator-review-form";
	}
	
	@ResponseBody
	@GetMapping("insertReviewReply")
	public void insertReviewReply(@RequestParam(defaultValue = "0") int reviewCode
								, @RequestParam(defaultValue = "0") String reviewReply
								, @RequestParam(defaultValue = "0") String reviewStatus) {
		
		creatorService.insertReviewReply(reviewCode, reviewReply, reviewStatus);
	}

	@ResponseBody
	@GetMapping("deleteReviewReply")
	public void deleteReviewReply(@RequestParam(defaultValue = "0") int reviewCode) {
		
		creatorService.deleteReviewReply(reviewCode);
	}
	
	//======================================================

	// 문의사항 페이지로
	@GetMapping("creator-inquiry")
	public String creatorInquiry(HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		
		List<Map<String, Object>> classList = creatorService.getClassByInquiry(member);
		
		List<Map<String, Object>> classInquiryList = creatorService.getInquiryClassInfo(member);
		List<JSONObject> iq_list = new ArrayList<JSONObject>(); 
		
		for(Map<String, Object> clas : classInquiryList) {
            JSONObject cl = new JSONObject(clas);
            iq_list.add(cl);
		}
		model.addAttribute("classList", classList);
		model.addAttribute("iq_list", iq_list);
		
		return "creator/creator-inquiry";
	}
	
	@ResponseBody
	@GetMapping("getInquiryByClass")
	public List<Map<String, Object>> getInquiryByClass(@RequestParam(defaultValue = "0") int classCode, HttpSession session){
		MemberVO member =  (MemberVO)session.getAttribute("member");
		int member_code = member.getMember_code();
		List<Map<String, Object>> inquiryListByClass = creatorService.getInquiryByClass(classCode, member_code);
		return inquiryListByClass;
	}

	@ResponseBody
	@GetMapping("getInquiryByType")
	public List<Map<String, Object>> getInquiryByType(@RequestParam(defaultValue = "0") int classCode
													, @RequestParam(defaultValue = "N") String type, HttpSession session){
		MemberVO member =  (MemberVO)session.getAttribute("member");
		int member_code = member.getMember_code();
		List<Map<String, Object>> inquiryListByType = creatorService.getInquiryByType(classCode, type, member_code);
		return inquiryListByType;
	}
	
	// creater-inquiry-form으로
	@GetMapping("creator-inquiry-form")
	public String createrInquiryForm(@RequestParam(defaultValue = "0") int class_inquiry_code, Model model) {
		Map<String, Object> inquiry = creatorService.getInquiryByInquiryCode(class_inquiry_code);
		Map<String, Object> reply = creatorService.getReplyByInquiryCode(class_inquiry_code);
		model.addAttribute("inquiry", inquiry);
		model.addAttribute("reply", reply);
		
		return "creator/creator-inquiry-form";
	}
	
	@ResponseBody
	@GetMapping("insertInquiryReply")
	public void insertInquiryReply(@RequestParam(defaultValue = "0") int inquiryCode
								, @RequestParam(defaultValue = "0") String inquiryReply
								, @RequestParam(defaultValue = "0") String inquiryStatus) {
		
		creatorService.insertInquiryReply(inquiryCode, inquiryReply, inquiryStatus);
	}

	@ResponseBody
	@GetMapping("deleteInquiryReply")
	public void deleteInquiryReply(@RequestParam(defaultValue = "0") int inquiryCode) {
		
		creatorService.deleteInquiryReply(inquiryCode);
	}
	
	
	//======================================================
	
	// creater-analyze로
	@GetMapping("creator-analyze")
	public String createrAnalyze(HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		Map<String, Object> analyzeList = creatorService.getAnalyzeList(member);
		List<Map<String, Object>> classList = creatorService.getAnalyzeClassInfo(member);
		List<Map<String, Object>> GraphDataList = creatorService.getGraphDataList(member);
		
		
		model.addAttribute("classList", classList);
		model.addAttribute("analyzeList", analyzeList.get("analyzeList"));
		model.addAttribute("analyzeReviewList", analyzeList.get("analyzeReviewList"));
		model.addAttribute("GraphDataList", GraphDataList);
		
		return "creator/creator-analyze";
	}
	
	@ResponseBody
	@GetMapping
	public String graphByClass() {
		return "";
	}
	
	
	
	//======================================================
	// creater-cost로
	@GetMapping("creator-cost")
	public String createrCost(HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		
		String settlementDate = creatorService.getsettlementDate(member);
		Map<String, String> SumSettlement = creatorService.getSumSettlement(member, settlementDate);
		model.addAttribute("settlementDate", settlementDate);
		model.addAttribute("SumSettlement", SumSettlement);
		
		return "creator/creator-cost";
	}
	
	@ResponseBody
	@GetMapping("getMonthSettlement")
	public Map<String, Object> getMonthSettlement(@RequestParam String monthPicker, HttpSession session, Model model) {
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		Map<String, Object> monthSettlement = creatorService.getMonthSettlement(monthPicker, member);
		System.out.println(">>>>>>>>>>>>monthSettlement" + monthSettlement);
		return monthSettlement;
	}
	
	@PostMapping("creator-settlement")
	public String creatorSettlement(@RequestParam(defaultValue = "0") int total_sum, HttpSession session, Model model) {
		System.out.println(">>>>>>>>>>total_sum" + total_sum);
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		creatorService.settlementPro(member, total_sum);
		
		creatorService.depositSettlement(member, total_sum);
		
		return WillUtils.checkDeleteSuccess(true, model, "정산 처리 완료", false, "creator-cost");
	}
	

}
