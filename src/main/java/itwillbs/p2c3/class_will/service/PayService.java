package itwillbs.p2c3.class_will.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import itwillbs.p2c3.class_will.handler.BankApi;
import itwillbs.p2c3.class_will.mapper.PayMapper;
import itwillbs.p2c3.class_will.vo.MemberVO;

@Service
public class PayService {
//	private static final int Map = 0;

	@Autowired
	private PayMapper payMapper;
	
	@Autowired
	private BankApi bankApi;
	
	private IamportClient client;
	
	
	public PayService() {
		String apiKey ="3531856454755108";
		String apiSecret = "ue5UeHzRddcp4PozEatgw9W9SD1To4172hH0vQZebn5ZqW95F8WDgrZ3mD7EIyhoKuaEIHZ1HiYMz1TJ";
		
		this.client = new IamportClient(apiKey, apiSecret);
	}
	
	//datetime 포멧 메서드
	public String formatDate(Date date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String payDate = dateFormat.format(date);
		return payDate;
	}
	
	//member_credit 가져오는 메서드
	public int getWillpay(Map<String, Object> map) {
		return payMapper.selectWillpay(map);
	}

	//클래스 info - select
	public Map<String, Object> getClassInfo(Map<String, Object> map) {
		return payMapper.selectClassInfo(map);
	}
	
	//스캐쥴 info
	public List<Map<String, Object>> getClassSchedule(int i) {
		return payMapper.selectSchedule(i);
	}
	
	//date로 클래스 스케쥴 타임 가져오기
	public List<Map<String, Object>> getScheduleTime(String date, int parsedClass_code) {
		return payMapper.selectScheduleTime(date, parsedClass_code);
	}
	//고객 정보 가져오기
	public Map<String, Object> getMemberInfo(MemberVO member) {
		return payMapper.selectMemberInfo(member);
	}
	
	//payment 관련 정보 모두 가져오기
	public Map<String, String> getPayInfo(Map<String, String> map) {
		return payMapper.selectPayInfo(map);
	}
	
	//나의 모든 크레딧 조회
	public Map<String, String> getCredit(Map<String, String> map) {
		return payMapper.selectCredit(map);
	}
	
	
	
	//결제 검증
	public Map<String, Object> verifyPayment(Map<String, Object> map) {
		Map<String, Object> response = new HashMap<String, Object>();
		try {
			IamportResponse<Payment> paymentResponse = client.paymentByImpUid((String)map.get("imp_uid"));
			//결제 성공 시
			if(paymentResponse.getResponse() != null && paymentResponse.getResponse().getStatus().equals("paid")) {
				//use_willpay 처리
				payMapper.updateCredit(map); //willpay 증가 메서드
				//class_schedule 테이블의 class_remain_headcount 처리
				payMapper.updateHeadcount(map);
				
				//-----------------------------------------
				//DB에 결제 데이터 저장
				Payment pr = paymentResponse.getResponse();
				//format 메서드
				String payDate = formatDate(pr.getPaidAt());
				
				map.put("pay_type", pr.getPayMethod().equals("card") ? 1 : 2);
				map.put("pay_amount", pr.getAmount());
				map.put("pay_datetime", payDate);
				map.put("class_code", map.get("class_code"));
				map.put("class_schedule_code", map.get("class_schedule_code"));
				map.put("member_code", map.get("member_code"));
				map.put("pg_provider", pr.getPgProvider());
				map.put("card_name", pr.getCardName());
				int registResult = payMapper.registPaySuccessInfo(map);
				
				if(registResult > 0) {
					response.put("pay_code", map.get("pay_code"));
					response.put("success", true);
					response.put("error", "결제 검증에 성공하였습니다");
				}
			} else {
				response.put("success", false);
				response.put("error", "결제 검증에 실패하였습니다.");
			}
		} catch (IamportResponseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return response;
	}
	
	public Map<String, Object> updateWillPayAllCase(Map<String, Object> map) {
		Map<String, Object> response = new HashMap<String, Object>();
		
		Date paidAt = new Date();
		String payDate = formatDate(paidAt);
		
		map.put("pay_type", 3);
		map.put("pay_datetime", payDate);
		int registResult = payMapper.registPaySuccessInfo(map);
		if(registResult > 0) {
			payMapper.updateCredit(map);
			payMapper.updateHeadcount(map);
			response.put("pay_code", map.get("pay_code"));
			response.put("success", true);
			response.put("error", "결제 성공!");
		} else {
			response.put("success", false);
			response.put("error", "결제 실패!");
		}
		
		return response;
	}
	
	
	
	//결제에 성공한 paySuccessInfo 가져오기
	public Map<String, String> getSuccessPayInfo(Map<String, String> map) {
		return payMapper.selectSuccessPayInfo(map);
	}
	//======================================================================
	//access_token 획득
	public Map getAccessToken(Map<String, String> authResponse) {
		Map token = bankApi.requestAccessToken(authResponse);
		System.out.println("accessTOKEN!" + token.get("access_token"));
		
		//bankUserInfo 데이터 가져오기
		Map<String, String> map = new HashMap<String, String>();
		map.put("access_token", (String)token.get("access_token"));
		map.put("user_seq_no", (String)token.get("user_seq_no"));
		
		Map userInfo = bankApi.requestUserInfo(map);
		List<Map<String, Object>> res_list = (List<Map<String, Object>>)userInfo.get("res_list");
		
		//update를 하기위한 Map객체
		Map<String, String> fintech = new HashMap<String, String>();
		fintech.put("access_token", (String)map.get("access_token"));
		
		//마지막 계좌에서 fintech_use_num 가져오기
		Map<String, Object> lastMap = res_list.get(res_list.size() - 1);
		for(Map.Entry<String, Object> entry : lastMap.entrySet()) {
			fintech.put((String)entry.getKey(), (String)entry.getValue());
		}
		//fintech_num 등록
		payMapper.updateFintechUseNum(fintech);
		
		
		return token;
	}
	
	//access_token DB 등록
	public void registAccessToken(Map<String, String> map) {
		payMapper.registAccessToken(map);
	}
	
	//token과 user_seq_no을 이용하여 bankUserInfo 가져오기
	public Map getUserInfo(Map map) {
		Map userInfo = bankApi.requestUserInfo(map);
		
//		List<Map<String, Object>> res_list = (List<Map<String, Object>>)userInfo.get("res_list");
//		
//		//update를 하기위한 Map객체
//		Map<String, String> fintech = new HashMap<String, String>();
//		fintech.put("access_token", (String)map.get("access_token"));
//		
//		//마지막 계좌에서 fintech_use_num 가져오기
//		Map<String, Object> lastMap = res_list.get(res_list.size() - 1);
//		for(Map.Entry<String, Object> entry : lastMap.entrySet()) {
//			fintech.put((String)entry.getKey(), (String)entry.getValue());
//		}
//		
//		payMapper.updateFintechUseNum(fintech);
		
		return userInfo;
	}

	public List<Map<String, Integer>> getPackageInfo() {
		return payMapper.selectPackageInfoList();
	}

	public Map withdraw(Map<String, Object> map) {
		Map withdrawResult = bankApi.requestWithdraw(map);
		
		Map<String, Object> withdrawInfo = null;
		
		if(withdrawResult.get("rsp_code").equals("A0000")) {
			//update willpay - member_credit 갱신
			updateWillPay(map);
			//날짜 formatting
			String wdDate = ((String)withdrawResult.get("api_tran_dtm")).substring(0, 14);
			DateTimeFormatter parseDate = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
			LocalDateTime ldt = LocalDateTime.parse(wdDate, parseDate);
			
			DateTimeFormatter parseStr = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String withDrawDate = ldt.format(parseStr);
			//----------------------------------------
			//will-pay 충전(결제) 후 저장할 파라미터
			Map<String, Object> withdrawParameter = new HashMap<String, Object>();
			withdrawParameter.put("will_pay_date", withDrawDate);
			withdrawParameter.put("will_pay_amount", withdrawResult.get("tran_amt"));
			withdrawParameter.put("will_pay_bank_name", withdrawResult.get("bank_name"));
			withdrawParameter.put("will_pay_get_pay", map.get("tran_amt_total"));
			withdrawParameter.put("will_pay_account", withdrawResult.get("account_num_masked"));
			withdrawParameter.put("member_code", map.get("member_code"));
			
			String chargeType = (String)map.get("will_pay_chargeType");
			if(chargeType.equals("normal")) {
				withdrawParameter.put("will_pay_chargeType", 1);
			} else {
				withdrawParameter.put("will_pay_chargeType", 2);
			}
			//충전(출금) 정보 저장 메서드
			payMapper.registWithdrawInfo(withdrawParameter);
			
			BigInteger will_pay_code = (BigInteger)withdrawParameter.get("will_pay_code");
			System.out.println("will_pay_code: " + will_pay_code);
			
			withdrawInfo = payMapper.selectWithdrawInfo(will_pay_code);
		}
		return withdrawInfo;
	}

	
	//will-pay 충전 성공 시 member_credit update
	public int updateWillPay(Map<String, Object> map) {
		int amt = 0;
		if(map.get("tran_amt_total") != "") {
			System.out.println("패키지 선택해서 얻는 돈");
			String stringTotalAmt = (String)map.get("tran_amt_total");
			amt = Integer.parseInt(stringTotalAmt);
		} else {
			System.out.println("적어서 얻는 돈");
			String stringAmt = (String)map.get("tran_amt");
			amt = Integer.parseInt(stringAmt);
		}
		map.put("member_credit", amt);
		
		payMapper.updateWillpay(map);
		//return은 크레딧을 선택하는 메서드 호출
		return getWillpay(map);
	}
	
	//결제성공 리스트 가져오기
	public List<Map<String, String>> getPayInfoList(Map<String, Object> memberCode) {
		return payMapper.selectPayInfoList(memberCode);
	}
	
	//환불금액 결정
	public int getRefundAmt(Map<String, Object> map) {
		return payMapper.selectRefundAmt(map);
	}
	
	//환불(포트원 전용 환불) 
	public boolean refundPay(Map<String, Object> map) throws Exception {
		String imp_uid = (String)map.get("imp_uid");
		boolean isSuccess = false;
		
		
		Integer value = (Integer) map.get("refund_amt");
		BigDecimal bigDecimal = BigDecimal.valueOf(value.longValue());
		System.out.println("imp_uid" + imp_uid + ", bigDecimal" + bigDecimal);
		
		CancelData cancelData = new CancelData(imp_uid, true, bigDecimal);
		
		try {
			IamportResponse<Payment> response = client.cancelPaymentByImpUid(cancelData);
			
			if(response.getResponse() != null) {
				System.out.println("Refund successful: " + response.getResponse().getImpUid());
				payMapper.updatePayStatus(map);
				payMapper.updateWillpay(map);
				payMapper.resetHeadcount(map);
				
				isSuccess = true;
			} else {
				System.out.println("Refund failed: " + response.getResponse());
			}
		} catch (IamportResponseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	//포트원 결제 시 - 전액 willpay 결제 환불
	public void refundWillPayAllCase(Map<String, Object> map) {
		payMapper.updateWillpay(map);
		payMapper.updatePayStatus(map);
		payMapper.resetHeadcount(map);
	}
	
	//충전 성공한 willpayChargeList 가져오기
	public List<Map<String, Object>> getWillpayChargeList(int member_code) {
		return payMapper.selectWillpayChargeList(member_code);
	}

	public Map getAdminAccessToken() {
		return bankApi.requestAdminAccessToken();
	}
	
	//adminAccessToken 저장
	public void registAdminToken(Map adminToken) {
		if(payMapper.selectAdminToken() == null) {
			payMapper.insertAdminToken(adminToken);
		} else {
			payMapper.updateAdminToken(adminToken);
		}
	}
	
	//willpay 환불약관 검사
	public int getWillpayDate(Map<String, Object> map) {
		return payMapper.selectWillpayDate(map);
	}

	//환불가능한 금액 가져오기
	public int getAbledWillpay(Map<String, Object> map) {
		return payMapper.selectAbledWillpay(map);
	}
	
	//충전(입금) 환불
	public boolean deposit(Map<String, Object> map) {
		//admin access_token으로 교체
		Object adminToken = payMapper.selectAdminToken();
		map.put("access_token", adminToken);
		
		
		Map depositResult = bankApi.requestDeposit(map);
		if(!depositResult.get("rsp_code").equals("A0000")) {
			return false;
		}
		//updateCredit을 위한 파라미터명 변경
		int use_willpay = Integer.parseInt((String)map.get("tran_amt"));
		map.put("use_willpay", use_willpay);
		payMapper.updateCredit(map);
		
		return true;
	}

	
	
}
