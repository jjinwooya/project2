package itwillbs.p2c3.class_will.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.internal.build.AllowSysOut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import itwillbs.p2c3.class_will.handler.CommonUtils;
import itwillbs.p2c3.class_will.handler.WillUtils;
import itwillbs.p2c3.class_will.service.AdminService;
import itwillbs.p2c3.class_will.service.ClassService;
import itwillbs.p2c3.class_will.service.CreatorService;
import itwillbs.p2c3.class_will.service.MemberService;
import itwillbs.p2c3.class_will.service.MyPageService;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Controller
public class MyPageController {
	private static final Logger logger = LoggerFactory.getLogger(MyPageController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private HttpSession session;

	@Autowired
	private AdminService adminService;
	@Autowired
	private CreatorService creatorService;

	@Autowired
	private ClassService classService;

	@Autowired
	private MyPageService myPageService;

	@Autowired
	private CommonUtils cUtils;

	@GetMapping("my-page")
	public String myPage(Model model) {

		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code);
		model.addAttribute("member", member2);
		return "mypage/mypage";

	}

	// 관심 클래스
	@GetMapping("my-wish")
	public String myWish(Model model, @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {

		MemberVO member = (MemberVO) session.getAttribute("member");
		// System.out.println("리뷰쪽 시작"+member.getMember_code());

		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code);
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		model.addAttribute("member", member2);
		List<Map<String, String>> memberLike = myPageService.getMemberLike(member.getMember_code(), startRow, listLimit);
		int totalLikes = myPageService.getMemberLike(member_code);
		model.addAttribute("total_likes", totalLikes);
		//System.out.println("전체 관심클래스 수 " + totalLikes);
		
		int maxPage = (int) Math.ceil((double) totalLikes / listLimit);
		
		//System.out.println("최대 페이지수 " + maxPage);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("memberLike", memberLike);
		return "mypage/mypage-wish";

	}

	// 관심클래스 취소

//	// 마이클래스
//	@GetMapping("my-class")
//	public String myClass(Model model) {
//
//		MemberVO member = (MemberVO) session.getAttribute("member");
//		// System.out.println("리뷰쪽 시작"+member.getMember_code());
//
//		if (member == null) {
//			return WillUtils.checkDeleteSuccess(false, model, "로그인이 필요한 페이지입니다", true, "member-login");
//		} else {
//			return "mypage/mypage-class";
//		}
//
//	}

	// 내가 쓴 리뷰
	@GetMapping("my-review")
	public String myReview(Model model,@RequestParam(value = "pageNum", defaultValue = "1") int pageNum , @RequestParam(value = "pageNum2", defaultValue = "1") int pageNum2) {

		MemberVO member = (MemberVO) session.getAttribute("member");
		// System.out.println("리뷰쪽 시작"+member.getMember_code());

		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code);
		// 이건 작성 후기들
		model.addAttribute("member", member2);
		int listLimit2 = 5;
		int startRow2 = (pageNum2 - 1) * listLimit2;
		int totalPossible2 = myPageService.getMemberReviewCount(member_code);
		int maxPage2 = (int) Math.ceil((double) totalPossible2 / listLimit2);
		List<Map<String, String>> memberReviews = myPageService.getMemberReviews(member_code,startRow2, listLimit2);
		model.addAttribute("memberReviews", memberReviews);
		model.addAttribute("maxPage2", maxPage2);
		model.addAttribute("pageNum2", pageNum2);
		model.addAttribute("totalPossible2", totalPossible2);
		// System.out.println(memberReviews);

		// 이건 내가 결제를 해서 리뷰를 등록할 수 있는 후기들
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		int totalPossible = myPageService.getMemberPoss(member_code);
		int maxPage = (int) Math.ceil((double) totalPossible / listLimit);
		List<Map<String, String>> possibleReview = myPageService.getPossibleReview(member_code,startRow, listLimit);
		model.addAttribute("totalPossible", totalPossible);
		model.addAttribute("possibleReview", possibleReview);
		System.out.println("등록가능한 리뷰" + possibleReview);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("pageNum", pageNum);
		//여기까지 1번 페이징 처리완 - 페이지 상 이게 먼저 있어서 1번임.
		return "mypage/mypage-review";

	}

	// 리뷰 등록폼으로
	@GetMapping("resist-review")
	public String resistReview(@RequestParam Map<String, String> params, Model model) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		String classCode = params.get("class_code");
		String memberCode = params.get("member_code");
		String class_schedule_code = params.get("class_schedule_code");
		Integer classCode2 = Integer.parseInt(classCode);
		// 클래스 코드와 멤버 코드를 모델에 추가
		model.addAttribute("class_code", classCode);
		model.addAttribute("member_code", memberCode);
		model.addAttribute("class_schedule_code", class_schedule_code);
		Map<String, Object> classInfo = creatorService.getClassDetail(classCode2);
		model.addAttribute("classInfo", classInfo);
		System.out.println("클래스 정보임" + classInfo);
		return "mypage/mypage-review-form";

	}

	@PostMapping("insert-review")
	public String insertReview(@RequestParam Map<String, String> formData, Model model) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) { // 실패
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}

		System.out.println("데이터 확인" + formData);
		int insertCount = myPageService.insertReview(formData);
		if (insertCount > 0) {
			return "redirect:/my-review";
		} else {
			model.addAttribute("msg", "리뷰 등록 실패");
			return "result_process/fail";
		}

	}

	// 리뷰 수정
	@GetMapping("edit-review-page")
	public String editReviewPage(@RequestParam("review_code") String reviewCode, Model model) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) { // 실패
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		model.addAttribute("member", member);
		Map<String, String> review = myPageService.getReviewByCode(reviewCode);

		model.addAttribute("review", review);
		System.out.println("이건 수정할 때 데리고 오는 특정리뷰 1건" + review);
		return "mypage/mypage-review-modify"; // 리뷰 수정 페이지

	}

	@PostMapping("edit-review")
	public String editReview(Model model, @RequestParam Map<String, String> formData) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) { // 실패

			return WillUtils.checkDeleteSuccess(false, model, "권한이 없습니다.", true, "member-login");
		}
		int member_code = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code);
		model.addAttribute("member", member2);
		System.out.println("여기요 여기!formdata: " + formData);
		int updateCount = myPageService.updateReview(formData);
		if (updateCount > 0) {
			return "redirect:/my-review";
		} else {
			model.addAttribute("msg", "리뷰수정 실패");
			return "result_process/fail";
		}

	}

	// 리뷰삭제
	@PostMapping("delete-review")
	public String deleteReview(Model model, @RequestParam Map<String, String> map) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) { // 실패
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code);
		model.addAttribute("member", member2);

		String class_review_code = map.get("review_code");
		System.out.println(class_review_code);

		int deleteCount = myPageService.deleteReview(class_review_code);
		if (deleteCount > 0) {

			return "redirect:/my-review";
		} else {
			model.addAttribute("msg", "삭제 실패!");
			return "result_process/fail";
		}

	}
	//문의 삭제
	@PostMapping("delete-inquiry")
	public String deleteInquiry(Model model, @RequestParam Map<String, String> map) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) { // 실패
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code);
		model.addAttribute("member", member2);

		String class_inquiry_code = map.get("class_inquiry_code");
		//System.out.println(class_inquiry_code);

		int deleteCount = myPageService.deleteInquiry(class_inquiry_code);
		if (deleteCount > 0) {

			return "redirect:/my-inquiry";
		} else {
			model.addAttribute("msg", "삭제 실패!");
			return "result_process/fail";
		}

	}
	
	// 문의 수정
		@GetMapping("edit-inquiry-page")
		public String editinquirywPage(@RequestParam("class_inquiry_code") String class_inquiry_code, Model model) {
			MemberVO member = (MemberVO) session.getAttribute("member");

			if (member == null) { // 실패
				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("targetURL", "member-login");
				return "result_process/fail";
			}
			model.addAttribute("member", member);
			Map<String, String> inquiry = myPageService.getInquiryByCode(class_inquiry_code);

			model.addAttribute("inquiry", inquiry);
			System.out.println("이건 수정할 때 데리고 오는 특정문의 1건" + inquiry);
			return "mypage/mypage-inquiry-modify"; // 리뷰 수정 페이지

		}
		//문의수정하기 진행
		@PostMapping("edit-inquiry")
		public String editInquiry(Model model, @RequestParam Map<String, String> formData) {
			MemberVO member = (MemberVO) session.getAttribute("member");

			if (member == null) { // 실패

				return WillUtils.checkDeleteSuccess(false, model, "권한이 없습니다.", true, "member-login");
			}
			int member_code = member.getMember_code();
			MemberVO member2 = myPageService.selectMemberInfo(member_code);
			model.addAttribute("member", member2);
			System.out.println("여기요 여기!formdata: " + formData);
			int updateCount = myPageService.updateInquiry(formData);
			if (updateCount > 0) {
				return "redirect:/my-inquiry";
			} else {
				model.addAttribute("msg", "리뷰수정 실패");
				return "result_process/fail";
			}

		}
	
//	// 크레딧관련
//	@GetMapping("my-credit")
//	public String myCredit(Model model) {
//		MemberVO member = (MemberVO) session.getAttribute("member");
//
//		if (member == null) {
//			return WillUtils.checkDeleteSuccess(false, model, "로그인이 필요한 페이지입니다", true, "member-login");
//		} else {
//			int member_code = member.getMember_code();
//			MemberVO member2 = myPageService.selectMemberInfo(member_code);
//			model.addAttribute("member", member2);
//			return "mypage/mypage-credit";
//		}
//
//	}

	// 이미지 업로드 관련
	@RequestMapping("upload_image")
	public String handleFileUpload(@RequestParam("imageFile") MultipartFile file, HttpServletRequest request,
			Model model) {

		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) { // 실패
			return "error/error_404";
		} else {

			member.setMember_imageFile(file);
			String uploadDir = "/resources/upload";
			String saveDir = session.getServletContext().getRealPath(uploadDir);
			System.out.println("실제 업로드 경로(session): " + saveDir);
			// 실제 업로드 경로

			System.out.println(saveDir);

			Path path = Paths.get(saveDir);

			try {
				// Files 클래스의 createDirectories() 메서드 호출하여 실제 경로 생성
				Files.createDirectories(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
			member.setMember_img("");

			String fileName1 = UUID.randomUUID().toString().substring(0, 8) + "_" + file.getOriginalFilename();
			System.out.println("파일네임" + fileName1);

			if (!file.getOriginalFilename().equals("")) {
				member.setMember_img(fileName1);
			}
			System.out.println("저장파일" + member.getMember_img());

			System.out.println("업로드 파일명: " + member.getMember_imageFile());

			int updateCount = myPageService.updateMemberImg(member);

			if (updateCount > 0) {
				try {
					if (!file.getOriginalFilename().equals("")) {
						file.transferTo(new File(saveDir, fileName1));
					}

				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {

					e.printStackTrace();
				}

				return "redirect:/my-page";
			} else {
				return "error/fail";
			}
		}
	}

	// 이미지 삭제 관련 실제삭제는 아니고 null값을 줘서 업데이트하는 개념.
	@RequestMapping("delete_image")
	public String resetImg(Model model) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) { // 실패
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}

		member.setMember_img(null);
		int updateCount = myPageService.updateMemberImg(member);

		if (updateCount > 0) {
			return "redirect:/my-page";
		} else {
			return "result_process/fail";
		}

	}

	// 회원정보수정으로 이동
	@GetMapping("my-modify")
	public String myModify(Model model) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code);
		model.addAttribute("member", member2);
		return "mypage/mypage-modify";

	}

	// 회원수정폼 관련
	@PostMapping("member-modify")
	public String memberModify(Model model, BCryptPasswordEncoder passwordEncoder,
			@RequestParam Map<String, String> formData) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) { // 실패
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code);
		model.addAttribute("member", member2);
		// System.out.println("회원정보하는 곳임" + formData);
		// System.out.println("평문 : " + formData.get("member_pwd"));
		member.setMember_nickname(formData.get("member_nickname"));

//		String addr = formData.get("member_post_code") + "/" + formData.get("member_address1") + "/"
//				+ formData.get("member_address2");
//		member.setMember_addr(addr);
//		// System.out.println(addr);
//		String[] addrArr = member.getMember_addr().split("/");
//		member.setMember_post_code(addrArr[0]);
//		member.setMember_address1(addrArr[1]);
//		member.setMember_address2(addrArr[2]);
		// 주소 변경 여부 확인
	    String postCode = formData.get("member_post_code");
	    String address1 = formData.get("member_address1");
	    String address2 = formData.get("member_address2");

	    if (postCode != null && !postCode.isEmpty() &&
	        address1 != null && !address1.isEmpty() &&
	        address2 != null && !address2.isEmpty()) {
	        
	        String addr = postCode + "/" + address1 + "/" + address2;
	        member.setMember_addr(addr);

	        String[] addrArr = member.getMember_addr().split("/");
	        if (addrArr.length == 3) {
	            member.setMember_post_code(addrArr[0]);
	            member.setMember_address1(addrArr[1]);
	            member.setMember_address2(addrArr[2]);
	        } else {
	            model.addAttribute("msg", "주소 형식이 잘못되었습니다.");
	            model.addAttribute("targetURL", "member-modify-form");
	            return "result_process/fail";
	        }
	    }
		
		
		String plainPassword = formData.get("member_pwd");
		if (plainPassword != null && !plainPassword.isEmpty()) {
			// 비밀번호가 비어 있지 않으면 암호화하여 설정
			String securePassword = passwordEncoder.encode(plainPassword);
			member.setMember_pwd(securePassword);
		}

		int updateCount = myPageService.updateMemberInfo(member);
		if (updateCount > 0) {
			model.addAttribute("msg", "회원정보가 수정되었습니다");
			model.addAttribute("targetURL", "my-page");
			return "result_process/success";
			// return "redirect:/my-page";
		} else {
			return "result_process/fail";
		}

	}
	// 회원닉네임 중복확인관련 ajax처리함

	@GetMapping("CheckDupNickname")
	public ResponseEntity<Boolean> checkNickname(@RequestParam String member_nickname) {
		boolean isDuplicate = myPageService.nicknameDuplicate(member_nickname);
		return new ResponseEntity<>(isDuplicate, HttpStatus.OK);
	}

	// 크리에이터가 일반회원으로 전환 ajax
	@PostMapping("change-nomal")
	@ResponseBody
	public String changeNomal(Model model, @RequestParam("member_code") String member_code) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) { // 실패
			return "error/error_404";
		} else {
			try {
				// 멤버 정보 업데이트
				myPageService.updateNomal(member_code);
				int member_code2 = member.getMember_code();
				MemberVO member2 = myPageService.selectMemberInfo(member_code2);
				model.addAttribute("member", member2);
				return "success";
			} catch (Exception e) {
				e.printStackTrace();
				return "error"; // 실패했을 경우 클라이언트에게 error 반환
			}
		}
	}

	// 회원 탈퇴
	@GetMapping("my-delete")
	public String deleteMember(Model model,@RequestParam(value = "pageNum2", defaultValue = "1") int pageNum2, @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) { // 실패
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code2 = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code2);
		model.addAttribute("member", member2);

		int listLimit2 = 5;
		int startRow2 = (pageNum2 - 1) * listLimit2;
		int totalReview = myPageService.getMemberReviewCount(member_code2);
		int maxPage2 = (int) Math.ceil((double) totalReview / listLimit2);
		List<Map<String, String>> memberReviews = myPageService.getMemberReviews(member_code2,startRow2, listLimit2);
		model.addAttribute("memberReviews", memberReviews);
		model.addAttribute("maxPage2", maxPage2);
		model.addAttribute("pageNum2", pageNum2);
		model.addAttribute("totalReview", totalReview);
		
		//문의한 글 들..
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		int totalInquiry = myPageService.getMemberInquiryCount(member_code2);
		System.out.println("특정 회원이 적은 문의 수량" + totalInquiry);
		int maxPage = (int) Math.ceil((double) totalInquiry / listLimit);
		List<Map<String, String>> memberInquiry = myPageService.getMemberInquiry(member_code2,startRow, listLimit);
		model.addAttribute("memberInquiry", memberInquiry);
		System.out.println("특정회원이 적은 문의글들" + memberInquiry);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("totalInquiry", totalInquiry);
		
		
		
		return "mypage/mypage-delete";

	}

	@PostMapping("member-quit")
	public String quitMember(Model model, BCryptPasswordEncoder passwordEncoder,
			@RequestParam("member_pwd") String password) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) { // 실패
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code2 = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code2);

		if (member2 != null && passwordEncoder.matches(password, member2.getMember_pwd())) { // 비번이 같을 때

			int updateCount = myPageService.withdrawMember(member);
			// 로그인 정보 제거하기 위해 세션 초기화 후 메인페이지로 리다이렉트
			if (updateCount > 0) { // 탈퇴 성공 시
				session.invalidate();
				model.addAttribute("msg", "그 동안 클래스윌을 이용해주셔서 감사합니다.");
				model.addAttribute("targetURL", "./");
				return "result_process/fail";
			} else { // 실패시
				model.addAttribute("msg", "탈퇴에 실패했습니다");
				model.addAttribute("targetURL", "my-delete");
				return "result_process/fail";
			}
		} else { // 비번이 일치하지 않을 경우
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다");
			model.addAttribute("targetURL", "my-delete");
			return "result_process/fail";

		}

	}

	@GetMapping("my-powerup")
	public String myPower(Model model) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) { // 실패
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code2 = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code2);
		List<Map<String, String>> memberMaster = myPageService.getMemberMaster(member_code2);
		model.addAttribute("memberMaster", memberMaster);
	
		System.out.println("멤버가 마스터한 클래스" + memberMaster);
		//특정회원의 가입일을 기준으로 하여 몇 일 지났다 출력하는 것 
		Map<String, String> memberDate = myPageService.getMemberDate(member_code2);
		model.addAttribute("memberDate", memberDate);
		System.out.println("특정멤버 회원가입일로 부터 지난 날" + memberDate);
		//특정회원의 사용금액
		Map<String, String> memberMoney = myPageService.getMemberMoney(member_code2);
		model.addAttribute("memberMoney", memberMoney);
		System.out.println("특정 멤버의 여태 사용한 금액" + memberMoney);
		
		return "mypage/mypage-power";
	}
	
	@RequestMapping(value = "fetchPayData", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> fetchPayData(@RequestBody Map<String, String> request) {
        String year = request.get("year");
        String month = request.get("month");
        String member_code = request.get("member_code");

        // 여기서 payService를 사용하여 데이터를 가져오는 로직을 구현해야 합니다.
        List<Map<String, String>> payList = myPageService.getPayData(year, month, member_code);
        
        Map<String, Object> response = new HashMap<>();
        response.put("data", payList);

        return response;
    }
	//문의하기
	@GetMapping("my-inquiry")
	public String inquiry(Model model, @RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) {
			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/fail";
		}
		int member_code = member.getMember_code();
		MemberVO member2 = myPageService.selectMemberInfo(member_code);
		model.addAttribute("member", member2);
		
		int listLimit = 5;
		int startRow = (pageNum - 1) * listLimit;
		int totalInquiry = myPageService.getMemberInquiryCount(member_code);
		System.out.println("특정 회원이 적은 문의 수량" + totalInquiry);
		int maxPage = (int) Math.ceil((double) totalInquiry / listLimit);
		List<Map<String, String>> memberInquiry = myPageService.getMemberInquiry(member_code,startRow, listLimit);
		model.addAttribute("memberInquiry", memberInquiry);
		System.out.println("특정회원이 적은 문의글들" + memberInquiry);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("totalInquiry", totalInquiry);
		
		return "mypage/mypage-inquiry";
	}
	//모든 데이터 삭제
	@PostMapping("delete-all")
	@ResponseBody
	public String deleteDocu(Model model, @RequestParam("member_code") int member_code) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		//System.out.println("모든 데이터 삭제" + member_code);
		  if (member == null || member.getMember_code() != member_code) {
		        model.addAttribute("msg", "권한이 없습니다.");
		        model.addAttribute("targetURL", "member-login");
		        return "result_process/fail";
		    }

		MemberVO member2 = myPageService.selectMemberInfo(member_code);
		model.addAttribute("member", member2);
		try {
            myPageService.deleteMemberData(member_code);
            return "success";
        } catch (Exception e) {
            return "error";
        }
	}
	
	
}
