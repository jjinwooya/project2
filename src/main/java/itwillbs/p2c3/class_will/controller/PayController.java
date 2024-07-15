package itwillbs.p2c3.class_will.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import itwillbs.p2c3.class_will.handler.WillUtils;
import itwillbs.p2c3.class_will.service.PayService;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Controller
public class PayController {
	
	@Autowired
	private PayService payService;
	
	private static final Logger logger = LoggerFactory.getLogger(PayController.class);
	
	
	
	//클래스 날짜 변경 ajax 호출 
	@ResponseBody
	@GetMapping("date-changed")
	public List<Map<String, Object>> dateChanged(@RequestParam String date, @RequestParam String class_code) {
		
		int parsedClass_code = Integer.parseInt(class_code);
		List<Map<String, Object>> map = payService.getScheduleTime(date, parsedClass_code);
		return map;
	}
	
	// will-pay 모두 사용 ajax 호출
	@ResponseBody
	@GetMapping("will-pay-all")
	public Map<String, String> willPayAll(@RequestParam Map<String, String> map) {
		Map<String, String> credit = payService.getCredit(map);
		return credit;
	}
	
	//popUp - agreeTerms
	@GetMapping("refund-agreeTerms")
	public String agreeTerms() {
		return "payment/refund_agreeTerms";
	}
	
	//popUp - inputRefund
	@GetMapping("refund-inputRefund")
	public String inputRefund(HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_code", member.getMember_code());
		
		//메서드 재활용
		int memberWillpay = payService.getWillpay(map);
		System.out.println("확인: " + map);
		//환불가능한 will-pay
		int abledMemberWillpay = payService.getAbledWillpay(map);
		
		
		
		model.addAttribute("member_willpay", memberWillpay);
		model.addAttribute("member_abledWillpay", abledMemberWillpay);
		return "payment/refund_inputRefund";
	}
	
	
	
	@PostMapping("payment")
	public String paymentPro(Model model, @RequestParam Map<String, String> map, HttpSession session) {
		MemberVO member= (MemberVO)session.getAttribute("member");
		String result = "";
		if(member == null) {
			result = WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용바립니다.", false);
			return result;
		}
		//고객정보 가져오기
		Map<String, Object> memberInfo = payService.getMemberInfo(member);
		
		//형변환
		Object memberCode = memberInfo.get("member_code");
		if(memberCode instanceof Integer) {
			String member_code = Integer.toString((int)memberCode);
			//payInfo에 쓰일 파라미터
			map.put("member_code", member_code);
			//memberInfo에 쓰일 파라미터
//			memberInfo.put("member_code", member_code);
		}
		model.addAttribute("memberInfo", memberInfo);
		
		
		String[] splitTime = map.get("select_time").split("~");
		map.put("class_st_time", splitTime[0]);
		map.put("class_ed_time", splitTime[1]);
		Map<String, String> payInfo = payService.getPayInfo(map);
		System.out.println("payInfo!!!!" + payInfo);
		
		
		if(payInfo == null) {
			model.addAttribute("msg", "결과가 없습니다.");
			return "result_process/fail";
		}
		//필요한 데이터 map에서 가져오기
		payInfo.put("headcount", map.get("selected_headcount"));
		
		//소계
		int price = Integer.parseInt(payInfo.get("class_price"));
		int count = Integer.parseInt(map.get("selected_headcount"));
		String subtotal = Integer.toString(price * count);
		payInfo.put("subtotal", subtotal);
		
		model.addAttribute("payInfo", payInfo);
		
		return "payment/payment";
	}
	
	//포트원 결제 - verify(검증)
	@ResponseBody
	@PostMapping("verify")
	public Map<String, Object> verify(@RequestBody Map<String, Object> map) {
		System.out.println("map");
		Map<String, Object> response = payService.verifyPayment(map);
		
		return response;
	}
	
	//카드결제 - 결제금액: 0 / willpay금액: all
	@ResponseBody
	@PostMapping("willpay-all-case")
	public Map<String, Object> willpayAllCase(@RequestBody Map<String, Object> map, HttpSession session, Model model) {
		System.out.println("map0일때: " + map);
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용바랍니다", false, "member-login");
		}
		map.put("member_code", member.getMember_code());
		Map<String, Object> response = payService.updateWillPayAllCase(map);
		return response;
	}
	
	//최종결제 페이지 메핑
	@GetMapping("payment-final")
	public String paymentFinal(@RequestParam Map<String, String> map, Model model) {
		Map<String, String> paySuccessInfo = payService.getSuccessPayInfo(map);
		System.out.println("######paySuccessInfo: " + paySuccessInfo);
		
		model.addAttribute("paySuccessInfo", paySuccessInfo);
		return "payment/payment_final";
	}
	
	@ResponseBody
	@PostMapping("refund")
	public boolean refund(@RequestBody Map<String, Object> map, HttpSession session, Model model) {
		System.out.println("refund-map값: " + map);
		boolean isSuccess = false;
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String result = "";
		if(member == null) {
			WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용바랍니다.", false);
		}
		int memberCode = member.getMember_code();
		map.put("member_code", memberCode);
		
		//결제 날짜를 비교하여 환불금액 결정
		int refund_amt = payService.getRefundAmt(map);
		map.put("refund_amt", refund_amt);
		
		//환불 요청
		try {
			isSuccess = payService.refundPay(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	@ResponseBody
	@PostMapping("refund-willpay")
	public boolean refundWillpayAllCase(@RequestBody Map<String, Object> map, HttpSession session, Model model) {
		System.out.println("refundWillpayAllCase-map값: " + map);
		boolean isSuccess = false;
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String result = "";
		if(member == null) {
			WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용바랍니다.", false);
		}
		int member_code = member.getMember_code();
		map.put("member_code", member_code);
		
		//결제 날짜를 비교하여 환불금액 결정
		int refund_amt = payService.getRefundAmt(map);
		if(refund_amt == 0) {
			payService.refundWillPayAllCase(map);
			isSuccess = true;
		}
		
		
		return isSuccess;
	}
	//====================================================================
	//윌페이 충전 페이지로 이동
	@GetMapping("will-pay-charge")
	public String willPayCharging(Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member == null) {
			WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용바랍니다", false, "member-login");
		}
		
		int member_code = member.getMember_code();
		model.addAttribute("member_code", member_code);
		
		if(session.getAttribute("token") != null) {
			Map<String, String> token = (Map<String, String>)session.getAttribute("token");
			
			//bankUserInfo 가져오기
			Map<String, String> map = new HashMap<String, String>();
			map.put("access_token", token.get("access_token"));
			map.put("user_seq_no", token.get("user_seq_no"));
			Map bankUserInfo = payService.getUserInfo(map);
			
			logger.info(">>>>>> bankUserInfo: " + bankUserInfo);
			Gson gson = new Gson();
			JsonObject jsonObject = gson.toJsonTree(bankUserInfo).getAsJsonObject();
			JsonArray jsonArray = jsonObject.getAsJsonArray("res_list");
			
			logger.info(">>>>>> jsonArray: " + jsonArray);
			
			//패키지 info
			List<Map<String, Integer>> packageInfo = payService.getPackageInfo();
			logger.info("@@@@ packageInfo:" + packageInfo);
			
			model.addAttribute("bankInfoJson", jsonArray);
			model.addAttribute("bankUserInfo", bankUserInfo);
			model.addAttribute("packageInfo", packageInfo);
		}
		
		return "payment/will_pay_charge";
	}
	
	@PostMapping("account-withdraw")
	public String accountWithdraw(@RequestParam Map<String, Object> map, HttpSession session, Model model)	{
		System.out.println("충전버튼: " + map);
		MemberVO member= (MemberVO)session.getAttribute("member");
		
		String result1 = "";
		if(member == null) {
			result1 = WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용바랍니다.", false);
			return result1;
		}
		
		//member_code 
		int member_code = member.getMember_code();
		map.put("member_code", member_code);
		
		//session에서 토큰 가져오기
		Map<String, String> token = (Map<String, String>)session.getAttribute("token");
		map.put("access_token", token.get("access_token"));
		map.put("user_seq_no", token.get("user_seq_no"));
		
		Map withdrawResult = payService.withdraw(map);
		
		String result2 = "";
		if(withdrawResult == null) {
			result2 = WillUtils.checkDeleteSuccess(false, model, "충전에 실패하였습니다", false);
			return result2;
		}
		
		model.addAttribute("withdrawResult", withdrawResult);
		
		return "payment/payment_willpay_final";	
	}
	
	@GetMapping("/callback")
	public String auth(@RequestParam Map<String, String> authResponse, Model model, HttpSession session) {
		logger.info("authResponse" + authResponse.toString());
		//----------------------------------------------------------------
		MemberVO member = (MemberVO)session.getAttribute("member");
		System.out.println("member:" + member);
		int member_code = member.getMember_code();
		
		//access_token 발급
		Map map = payService.getAccessToken(authResponse);
		logger.info("엑세스 토큰: " + map.get("access_token"));
		
		String resultSuccess = "";
		String resultFail = "";
		if(map == null || map.get("access_token") == null) {
			return resultFail = WillUtils.checkDeleteSuccess(false, model, "토큰 발급 실패! \\n다시 인증을 해주세요!", true);
		} else {
			map.put("member_code", member_code);
			
			Map<String, String> token = new HashMap<String, String>();
			token.put("access_token", (String)map.get("access_token"));
			token.put("user_seq_no", (String)map.get("user_seq_no"));
			// 세션에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
			session.setAttribute("token", token);
			
			// access_token db저장
			payService.registAccessToken(map);
			
			return resultSuccess = WillUtils.checkDeleteSuccess(true, model, "계좌 인증 완료!", true, "will-pay-charge");
		}
	}
	
	// 마이클래스
	@GetMapping("my-class")
	public String myClass(Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인이 필요한 페이지입니다", false, "member-login");
		}
		int member_code = member.getMember_code();
		Map<String, Object> memberCode = new HashMap<String, Object>();
		memberCode.put("member_code", member_code);
		//결제된 클래스 list 가져오기
		List<Map<String, String>> payInfoList = payService.getPayInfoList(memberCode);
		
		model.addAttribute("payInfoList", payInfoList);
		return "mypage/mypage-class";
	}
	
	
	
	// 크레딧관련
	@GetMapping("my-credit")
	public String myCredit(Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		String result = "";
		if (member == null) {
			result = WillUtils.checkDeleteSuccess(false, model, "로그인이 필요한 페이지입니다", false, "member-login");
			return result;
		}
		int member_code = member.getMember_code();
		List<Map<String, Object>> willpayChargeInfoList = payService.getWillpayChargeList(member_code);
		System.out.println("!willpayChargeInfoList: " + willpayChargeInfoList);
		
		model.addAttribute("willpayChargeInfoList", willpayChargeInfoList);
		return "mypage/mypage-credit";
	}
	
	@ResponseBody
	@GetMapping("refund-willpay")
	public boolean refundWillpay(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		boolean isRefund = false;
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		//금융결제원 파라미터
		int member_code = member.getMember_code();
		String user_name = member.getMember_name();
		
		map.put("member_code", member_code);
		map.put("user_name", user_name);
		
		
		Map<String, Object> token = (Map<String, Object>)session.getAttribute("token");
		//고객의 access_token, fintech_use_num 
		map.put("fintech_use_num", token.get("fintech_use_num"));
		map.put("access_token", token.get("access_token"));
		
		Object result = payService.deposit(map);
		//사용 willpay 금액이 결제 금액보다 많은 경우
		if(result instanceof Boolean) {
			isRefund = (boolean)result;
		} else {
			isRefund = (boolean)result;
		}
		
		
		
		return isRefund;
	}
	
	
	
}
