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
	
	//ajax 호출
	@ResponseBody
	@GetMapping("date-changed")
	public List<Map<String, Object>> dateChanged(@RequestParam String date, @RequestParam String class_code) {
		
		int parsedClass_code = Integer.parseInt(class_code);
		List<Map<String, Object>> map = payService.getScheduleTime(date, parsedClass_code);
		return map;
	}
	
	@ResponseBody
	@GetMapping("will-pay-all")
	public Map<String, String> willPayAll(@RequestParam Map<String, String> map) {
		Map<String, String> credit = payService.getCredit(map);
		System.out.println("크레딧!!!:" + credit.get("member_credit"));
		
		return credit;
	}
	
	
	
	@PostMapping("payment")
	public String paymentPro(Model model, @RequestParam Map<String, String> map, HttpSession session) {
		MemberVO member= (MemberVO)session.getAttribute("member");
		if(member == null) {
			model.addAttribute("msg", "로그인 후 이용바랍니다");
			return "result_process/fail";
		}
		
		
		String[] splitTime = map.get("select_time").split("~");
		map.put("class_st_time", splitTime[0]);
		map.put("class_ed_time", splitTime[1]);
		Map<String, String> payInfo = payService.getPayInfo(map);
		
		
		if(payInfo == null) {
			model.addAttribute("msg", "결과가 없습니다.");
			return "result_process/fail";
		}
		//필요한 데이터 map에서 가져오기
		payInfo.put("headcount", map.get("selected_headcount"));
		
		//고객 멤버코드 
		String member_code = Integer.toString(member.getMember_code()); 
		payInfo.put("member_code", member_code);
		
		//소계
		int price = Integer.parseInt(payInfo.get("class_price"));
		int count = Integer.parseInt(map.get("selected_headcount"));
		String subtotal = Integer.toString(price * count);
		payInfo.put("subtotal", subtotal);
		
		model.addAttribute("payInfo", payInfo);
		
		return "payment/payment";
	}
	
	@ResponseBody
	@PostMapping("verify")
	public Map<String, Object> verify(@RequestBody Map<String, Object> map) {
		
		Map<String, Object> response = payService.verifyPayment(map);
		
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
	//===============================================================
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
			
//			bankUserInfo.get("res_list");
			logger.info(">>>>>> bankUserInfo: " + bankUserInfo);
			Gson gson = new Gson();
			JsonObject jsonObject = gson.toJsonTree(bankUserInfo).getAsJsonObject();
			JsonArray jsonArray = jsonObject.getAsJsonArray("res_list");
			
			logger.info(">>>>>> jsonArray: " + jsonArray);
			
			//패키지 info
			List<Map<String, Integer>> packageInfo = payService.getPackageInfo();
			logger.info("@@@@ packageInfo:" + packageInfo);
			
			model.addAttribute("packageInfo", packageInfo);
			model.addAttribute("packageInfoJson", jsonArray);
			model.addAttribute("bankUserInfo", bankUserInfo);
		}
		
		return "payment/will_pay_charge";
	}
	
	@PostMapping("account-withdraw")
	public String accountWithdraw(@RequestParam Map<String, Object> map, HttpSession session, Model model)	{
		System.out.println("withdraw-map: " + map);
		MemberVO member= (MemberVO)session.getAttribute("member");
		
		String result1 = "";
		if(member == null) {
			result1 = WillUtils.checkDeleteSuccess(false, model, "로그인 후 이용바랍니다.", false);
			return result1;
		}
		
		//토큰 가져와서 넣기
		Map<String, String> token = (Map<String, String>)session.getAttribute("token");
		map.put("access_token", token.get("access_token"));
		map.put("user_seq_no", token.get("user_seq_no"));
		
		String stringMemberCode = Integer.toString(member.getMember_code());
		int member_code = Integer.parseInt(stringMemberCode);
		map.put("member_code", member_code);
		
		Map withdrawResult = payService.withdraw(map);
		
		String result2 = "";
		if(withdrawResult == null) {
			result2 = WillUtils.checkDeleteSuccess(false, model, "충전에 실패하였습니다", false);
			return result2;
		}
		
		//willpay 결제 성공 시 member_credit - update -> select
		int member_credit = payService.updateWillPay(map);
		
		String date = ((String)withdrawResult.get("api_tran_dtm")).substring(0, 14);
		DateTimeFormatter parsedDate = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		LocalDateTime datetime = LocalDateTime.parse(date, parsedDate);
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String payAc_date = datetime.format(dtf);
		
		
		withdrawResult.put("member_credit", member_credit);
		withdrawResult.put("payAc_amount", withdrawResult.get("tran_amt"));
		withdrawResult.put("tran_amt_total", map.get("tran_amt_total"));
		withdrawResult.put("payAc_fintech_use_num", withdrawResult.get("fintech_use_num"));
		withdrawResult.put("payAc_bank_name", withdrawResult.get("bank_name"));
		withdrawResult.put("member_code", member_code);
		withdrawResult.put("payAc_date", payAc_date);
		withdrawResult.put("payAc_product_type", map.get("payAc_type"));
		
		payService.registPayAccountInfo(withdrawResult);
		
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
		
		if(map == null || map.get("access_token") == null) {
			model.addAttribute("msg", "토큰 발급 실패! 다시 인증을 해주세요!");
			model.addAttribute("isClose", true);
			return "result_process/fail";
		}
		map.put("member_code", member_code);
		
		Map<String, String> bank_info = new HashMap<String, String>();
		bank_info.put("access_token", (String)map.get("access_token"));
		bank_info.put("user_seq_no", (String)map.get("user_seq_no"));
		// 세션에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
		session.setAttribute("token", bank_info);
		
		// access_token db저장
		payService.registAccessToken(map);
		
			
		
		//session에 저장한 redirectUrl
		String redirectUrl = (String)session.getAttribute("redirectUrl");
		
		//"success.jsp 페이지로 포워딩
		// 메세지 : "계좌 인증 완료!", isClose 값을 true, "targetURL" 값을  "FintechUserInfo" 설정
		model.addAttribute("msg", "계좌 인증 완료!");
		model.addAttribute("isClose", "true");
		model.addAttribute("targetURL", redirectUrl);
		return "result_process/success";
	}
	
	// 마이클래스
	@GetMapping("my-class")
	public String myClass(Model model, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		if (member == null) {
			return WillUtils.checkDeleteSuccess(false, model, "로그인이 필요한 페이지입니다", false, "member-login");
		}
		
		
		
		
		return "mypage/mypage-class";
	}
	
	
}
