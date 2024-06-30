package itwillbs.p2c3.class_will.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import itwillbs.p2c3.class_will.handler.CommonUtils;
import itwillbs.p2c3.class_will.handler.WillUtils;
import itwillbs.p2c3.class_will.service.AdminService;
import itwillbs.p2c3.class_will.service.ClassService;
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
	private ClassService classService;
	
	@Autowired
	private MyPageService myPageService;

	@Autowired
	private CommonUtils cUtils;

	@GetMapping("my-page")
	public String myPage(Model model) {

		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인이 필요한 페이지입니다", true, "member-login");
		} else {
			return "mypage/mypage";
		}
	}

	// 관심 클래스
	@GetMapping("my-wish")
	public String myWish(Model model) {

		MemberVO member = (MemberVO) session.getAttribute("member");
		// System.out.println("리뷰쪽 시작"+member.getMember_code());

		if (member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인이 필요한 페이지입니다", true, "member-login");
		} else {
			int member_code = member.getMember_code();
			MemberVO member2 = myPageService.selectMemberInfo(member_code);
			List<Map<String, String>> memberLike = myPageService.getMemberLike(member.getMember_code());
			int totalLikes = memberLike.size();
			model.addAttribute("member", member2);
			model.addAttribute("memberLike", memberLike);
			model.addAttribute("total_likes", totalLikes);
			return "mypage/mypage-wish";
		}

	}
	
	//관심클래스 취소
	

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
	public String myReview(Model model) {

		MemberVO member = (MemberVO) session.getAttribute("member");
		// System.out.println("리뷰쪽 시작"+member.getMember_code());

		if (member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인이 필요한 페이지입니다", true, "member-login");
		} else {
			List<Map<String, String>> memberReviews = myPageService.getMemberReviews(member.getMember_code());

			model.addAttribute("member", member);
			model.addAttribute("memberReviews", memberReviews);
			// System.out.println(memberReviews);

			return "mypage/mypage-review";
		}

	}

	// 리뷰 등록
	@GetMapping("resist-review")
	public String resistReview() {

		return "mypage/mypage-review-form";
	}

	// 리뷰 수정
	@GetMapping("edit-review-page")
	public String editReviewPage(@RequestParam("review_code") String reviewCode, Model model) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) { // 실패

			return "error/error_404";
		} else {
			model.addAttribute("member", member);
			Map<String, String> review = myPageService.getReviewByCode(reviewCode);

			// 리뷰 작성자 검증
//	    if (!member_code.equals(String.valueOf(review.get("member_code")))) {
//	        throw new SecurityException("리뷰를 수정할 권한이 없습니다.");
//	    }

			model.addAttribute("review", review);
			System.out.println("이건 수정할 때 데리고 오는 특정리뷰 1건" + review);
			return "mypage/mypage-review-modify"; // 리뷰 수정 페이지
		}
	}

	@PostMapping("edit-review")
	public String editReview(Model model, @RequestParam Map<String, String> formData) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) { // 실패

			return "error/error_404";
		} else {
			model.addAttribute("member", member);
			System.out.println("여기요 여기!formdata: " + formData);
			int updateCount = myPageService.updateReview(formData);
			if (updateCount > 0) {
				return "redirect:/my-review";
			} else {
				model.addAttribute("msg", "리뷰수정 실패");
				return "result_process/fail";
			}
		}
	}

	// 리뷰삭제
	@PostMapping("delete-review")
	public String deleteReview(Model model, @RequestParam Map<String, String> map) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) { // 실패

			return "error/error_404";
		} else {

			model.addAttribute("member", member);

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
	}

	// 크레딧관련
	@GetMapping("my-credit")
	public String myCredit(Model model) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인이 필요한 페이지입니다", true, "member-login");
		} else {
			return "mypage/mypage-credit";
		}

	}

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
		} else {

			member.setMember_img(null);
			int updateCount = myPageService.updateMemberImg(member);

			if (updateCount > 0) {
				return "redirect:/my-page";
			} else {
				return "result_process/fail";
			}
		}
	}

	// 회원정보수정으로 이동
	@GetMapping("my-modify")
	public String myModify(Model model) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		if (member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인이 필요한 페이지입니다", true, "member-login");
		} else {
			int member_code = member.getMember_code();
			MemberVO member2 = myPageService.selectMemberInfo(member_code);
			model.addAttribute("member", member2);
			return "mypage/mypage-modify";
		}

	}

	// 회원수정폼 관련
	@PostMapping("member-modify")
	public String memberModify(Model model, BCryptPasswordEncoder passwordEncoder,
			@RequestParam Map<String, String> formData) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) { // 실패
			return "error/error_404";
		} else {
			model.addAttribute("member", member);
			// System.out.println("회원정보하는 곳임" + formData);
			// System.out.println("평문 : " + formData.get("member_pwd"));

			String addr = formData.get("member_post_code") + "/" + formData.get("member_address1") + "/"
					+ formData.get("member_address2");
			member.setMember_addr(addr);
			// System.out.println(addr);
			member.setMember_nickname(formData.get("member_nickname"));
			String[] addrArr = member.getMember_addr().split("/");
			member.setMember_post_code(addrArr[0]);
			member.setMember_address1(addrArr[1]);
			member.setMember_address2(addrArr[2]);

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
		try {
			// 멤버 정보 업데이트
			myPageService.updateNomal(member_code);

			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "error"; // 실패했을 경우 클라이언트에게 error 반환
		}
	}

}
