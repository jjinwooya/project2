package itwillbs.p2c3.class_will.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import itwillbs.p2c3.class_will.service.MailService;
import itwillbs.p2c3.class_will.service.MemberService;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Controller
public class MemberController {
	
	
	@Autowired
	private MemberService memberService;
	
	@Autowired 
	private HttpSession session;
	
	
	
	// 회원가입 폼으로
	@GetMapping("member-join")
	public String memberJoinForm() {
		
		return "member/join_form";
		
	} // memberJoinForm()
	
	// 회원가입 비즈니스 로직 처리
	@PostMapping("member-join")
	public String memberJoinPro(MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder) {
		
		String securePasswd = passwordEncoder.encode(member.getMember_pwd());
		System.out.println("평문 : " + member.getMember_pwd()); 
		System.out.println("암호문 : " + securePasswd); 
		
		LocalDate today = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String regDate = today.format(dtf);
		
		member.setMember_pwd(securePasswd);
		member.setMember_email(member.getMember_email());
		member.setMember_name(member.getMember_name());
		member.setMember_tel(member.getMember_tel());
		member.setMember_reg_date(regDate);
		
		if(member.getMember_marketing1() == null) {
			member.setMember_marketing1("N");
		}
		if(member.getMember_marketing2() == null) {
			member.setMember_marketing2("N");
		}
		
		int insertCount = memberService.insertMember(member);
		System.out.println(member);
		
		if(insertCount < 1) {
			model.addAttribute("msg", "회원가입에 실패했습니다.");
			return "result_process/fail";
		}
		
		model.addAttribute("msg", "클래스윌 회원가입을 환영합니다.");
		model.addAttribute("targetURL", "member-login");
		return "result_process/success";
		
	} // memberJoinPro()
	
	// 회원 로그인 폼으로
	@GetMapping("member-login")
	public String memberLoginForm() {
		
		return "member/login_form";
		
	} // memberLoginForm()
	
	// 회원 로그인 비즈니스 로직 처리
	@PostMapping("member-login")
	public String memberLoginPro(MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder, 
				@RequestParam(required = false) String returnUrl, HttpServletRequest request, HttpServletResponse response) {
            
		MemberVO dbMember = memberService.selectMember(member);
		
		if(dbMember != null && dbMember.getMember_status().equals("2")) {
			model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
			return "result_process/fail";
			
		} else if(dbMember != null && dbMember.getMember_status().equals("3")) {
			model.addAttribute("msg", "휴면 회원입니다.");
			model.addAttribute("targetURL", "member-wake-up?member_email=" + member.getMember_email());
			return "result_process/success";
			
		} else if(dbMember.getMember_type().equals("3") && member.getMember_pwd().equals(dbMember.getMember_pwd()) && dbMember != null) {
			session.setAttribute("member", dbMember);
			model.addAttribute("member", dbMember);
			session.setMaxInactiveInterval(100000000);
			return "redirect:/";
			
		} else if(dbMember == null || !passwordEncoder.matches(member.getMember_pwd(), dbMember.getMember_pwd())) { // 로그인 실패
			model.addAttribute("msg", "이메일 또는 비밀번호를 확인해 주세요.");
			return "result_process/fail";
			
		} else {
			Map<String, String> bank_info = memberService.selectBankInfo(dbMember.getMember_code());
			System.out.println("bank_info : " + bank_info);
			
			session.setAttribute("member", dbMember);
			session.setAttribute("token", bank_info); 
				
			session.setMaxInactiveInterval(10000);
			
			if (returnUrl != null && !returnUrl.isEmpty()) {
	            return "redirect:" + returnUrl;
	        } 
			
			return "redirect:/";
		} 
		
		
		
	} // memberLoginPro()
	

	// 멤버 로그아웃
	@GetMapping("member-logout")
	public String memberLogout(@RequestParam(required = false) String returnUrl, HttpServletRequest request, HttpServletResponse response) {
		session.invalidate();
		if (returnUrl != null && !returnUrl.isEmpty()) {
            return "redirect:" + returnUrl;
        } 
		return "redirect:/";
	
	} // memberLogout()
	
	
	// 비밀번호 찾기 폼으로
	@GetMapping("find-passwd")
	public String findPasswdFrom() {
		return "member/find_passwd_form";
	}
	
	// 비밀번호 변경 이메일 전송
	@ResponseBody
	@PostMapping("find-passwd")
	public String findPasswdPro(MemberVO member) {
		System.out.println("findPasswdPro - member : " +member );
		
		MemberVO dbMember = memberService.selectMember(member);
		MailService mailService = new MailService();
		
		if(dbMember == null) {
			return "false";
		} 
			
		mailService.sendAuthMail(member);
		return "true";
		
	} // findPasswdPro()
	
	
	// 비밀번호 찾기 폼으로 (변경 이메일로부터 옴)
	@GetMapping("reset-passwd")
	public String resetPasswdFrom(@RequestParam String email, Model model) {
		
		model.addAttribute("member_email", email);
		return "member/reset_passwd_form";
		
	} // resetPasswdFrom()
	
	// 비밀번호 변경 비즈니스 로직
	@PostMapping("reset-passwd")
	public String resetPasswdPro(MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder) {
		
		System.out.println("resetPasswdPro - member : " + member);
		
		String securePasswd = passwordEncoder.encode(member.getMember_pwd());
		System.out.println("평문 : " + member.getMember_pwd()); 
		System.out.println("암호문 : " + securePasswd); 
		
		member.setMember_pwd(securePasswd);
		
		boolean isSuccess = memberService.updatePassword(member);
		
		if(isSuccess) {
			model.addAttribute("msg", "비밀번호 변경이 완료되었습니다.\\n로그인 후 이용해 주세요. ");
			model.addAttribute("targetURL", "member-login");
			return "result_process/success";
		}
		
		model.addAttribute("msg", "비밀번호 변경이 불가능합니다.\\n관리자에게 문의해 주세요.");
		return "result_process/fail";
	
		
		
	} // resetPasswdPro()
	
	
	// 휴면 회원 해제하기 폼으로
	@GetMapping("member-wake-up")
	public String wakeUpForm(MemberVO member, Model model) {
		
		model.addAttribute("member", member);
		return "member/wake_up_form";
		
	} // wakeUpForm()
	
	// 휴면 회원 해제하기 비즈니스 로직
	@PostMapping("member-wake-up")
	public String wakeUpPro(MemberVO member, Model model) {
		
		boolean isSuccess = memberService.updateMemberStatus(member);
		
		if(isSuccess) {
			model.addAttribute("msg", "휴면 해제 처리 완료되었습니다.\\n로그인 후 이용해 주세요.");
			model.addAttribute("targetURL", "member-login");
			return "result_process/success";
		} 
		
		model.addAttribute("msg", "휴면 해제가 불가능합니다.\\n관리자에게 문의해 주세요.");
		return "result_process/fail";
		
	} // wakeUpPro()
	 
	

	
	
	

	
	
	
	
	
} // MemberContller
