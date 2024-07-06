package itwillbs.p2c3.class_will.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.json.HTTP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import itwillbs.p2c3.class_will.handler.GenerateRandomCode;
import itwillbs.p2c3.class_will.handler.WillUtils;
import itwillbs.p2c3.class_will.service.AdminService;
import itwillbs.p2c3.class_will.service.ClassService;
import itwillbs.p2c3.class_will.service.CscService;
import itwillbs.p2c3.class_will.service.MailService;
import itwillbs.p2c3.class_will.service.MemberService;
import itwillbs.p2c3.class_will.vo.MemberVO;
import retrofit2.http.POST;

@Controller
public class EventController {
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private CscService cscService;
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ClassService classService;
	
	@GetMapping("event")
	public String eventMain(Model model) {
		List<Map<String, String>> list = adminService.getEventList();
		model.addAttribute("list", list);
		
		
		
		return "event/event_main";
	}
	
	@GetMapping("eventDetail")
	public String eventDetail(int event_code, Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용해주세요", false, "member-login");
		}
		int member_code = member.getMember_code();
		//친구초대 이벤트
		if(event_code == 0) {
			Map<String, Object> map = cscService.getInviteFriendInfo(member_code);
			if(map == null) {
				String invite_code = GenerateRandomCode.getRandomCode(24);
				cscService.insertInviteCode(member_code, invite_code);
				map = new HashedMap<String, Object>();
				map.put("invite_code", invite_code);
			}
			if(map.get("friend_code") != null) {
				MemberVO friend = new MemberVO();
				friend.setMember_code((int)map.get("friend_code"));
				friend = cscService.selectMemberByCode(friend);
				map.put("friend_email", friend.getMember_email());
				model.addAttribute("invite_info", map);
				System.out.println("dddddddddd최종 : " + map);
			}
			
			model.addAttribute("invite_code", map.get("invite_code"));
			return "event/event_invite_friend";
		}
		Map<String, String> event = cscService.getEventDetail(event_code);
		
		model.addAttribute("event", event);
		
		return "event/event_detail";
	}
	
	@ResponseBody
	@PostMapping("SendingEmail")
	public ResponseEntity<String> sendingEmail(@RequestParam Map<String, Object> map, Model model) {
		String responseMessage = "";
		String friend_email = (String)map.get("friend_email");
		String invite_code = (String)map.get("invite_code");
		MemberVO member = new MemberVO();
		member.setMember_email(friend_email);
		MemberVO dbMember =  memberService.selectMember(member);
		if(dbMember == null) {
			responseMessage = "존재하지 않는 회원입니다.";
		}
		
		mailService.sendInviteFriendMail(friend_email, invite_code);
		
		Map<String, Object> mail_info = cscService.getInviteMailInfo(invite_code, friend_email);
		// 등록되어있는 정보가 없다면 INSERT
		if(mail_info == null) {
			cscService.insertInviteMailInfo(invite_code, friend_email);
			responseMessage = "true";
			// 등록되어있는 정보가 있다면 UPDATE
		}else if(mail_info.get("invite_code").equals(map.get("invite_code"))) {
			cscService.updateInviteMailInfo(invite_code, friend_email);	
			responseMessage = "true";
		}
		
		HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/plain; charset=UTF-8");
	    
	    return new ResponseEntity<>(responseMessage, headers, HttpStatus.OK);
	}
	
	@GetMapping("InviteFriend")
	public String inviteFriend(String friend_email, String invite_code, Model model, HttpSession session, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");
		Map<String, Object> mail_info = cscService.getInviteMailInfo(invite_code, friend_email);
		if(mail_info == null) {
			return WillUtils.checkDeleteSuccess(false, model, "잘못된 링크입니다", false);
		}
		if(session.getAttribute("member") == null) {
			MemberVO member = new MemberVO();
			member.setMember_email(friend_email);
			MemberVO dbMember = memberService.selectMember(member);
			session.setAttribute("member", dbMember);
		}
		
		model.addAttribute("invite_code", invite_code);
		model.addAttribute("friend_email", friend_email);
		model.addAttribute("tab", "code");
		
		return "event/event_invite_friend";
	}
	
	@ResponseBody
	@PostMapping("RequestInvite")
	public ResponseEntity<String> requestInvite(String invite_code, HttpSession session) {
		String responseMessage = "";
		// invite_code 로 invite_friend 테이블 검색
		Map<String, Object> result = cscService.getInviteFriendInfoByCode(invite_code);
		// 세션 값 조회 및 로그인 여부
		MemberVO member = (MemberVO)session.getAttribute("member");
		// 테이블 검색 null값 나오면 잘못된 정보
		if(result == null) {
			responseMessage = "잘못된 정보입니다.";
		}
		Integer friend_code = (Integer)result.get("friend_code");
		// friend_code 에 값이 있으면 이미 등록 된 코드
		if(friend_code != null) {
			responseMessage = "이미 등록된 코드입니다.";
		}else {
			// friend_code 에 값이 없으므로 update 후 포인트올려주기
			cscService.updateFriendCode(invite_code, member.getMember_code());
			cscService.updateMemberCredit(member.getMember_code());
			cscService.updateMemberCredit((int)result.get("member_code"));
			responseMessage = "true";
		}
		
		HttpHeaders headers = new HttpHeaders();
	    headers.add("Content-Type", "text/plain; charset=UTF-8");
	    
	    return new ResponseEntity<>(responseMessage, headers, HttpStatus.OK);
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
