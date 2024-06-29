package itwillbs.p2c3.class_will.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import itwillbs.p2c3.class_will.handler.BankApi;
import itwillbs.p2c3.class_will.mapper.PayMapper;

@Service
public class PayService {
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
			response = new HashMap<String, Object>();
			if(paymentResponse.getResponse() != null && paymentResponse.getResponse().getStatus().equals("paid")) {
				//use_willpay 처리
				payMapper.updateCredit(map);
				//class_schedule 테이블의 class_remain_headcount 처리
				payMapper.updateHeadcount(map);
				
				//-----------------------------------------
				//DB에 결제 데이터 저장
				//class_schedule_code, member_code, class_code 가져오기
				Map<String, Object> objects = payMapper.selectObjects(map);
				
				Payment pr = paymentResponse.getResponse();
				System.out.println(paymentResponse.getResponse().getStatus());
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String payDate = sdf.format(pr.getPaidAt());
				
				map.put("pay_type", pr.getPayMethod().equals("card") ? 1 : 2);
				map.put("pay_amount", pr.getAmount());
				map.put("pay_datetime", payDate);
				map.put("class_code", objects.get("class_code"));
				map.put("class_schedule_code", objects.get("class_schedule_code"));
				map.put("member_code", objects.get("member_code"));
				map.put("pg_provider", pr.getPgProvider());
				map.put("card_name", pr.getCardName());
				payMapper.registPaySuccessInfo(map);
				
//				System.out.println("페이번호: " + map.get("pay_code"));
				
				
				response.put("pay_code", map.get("pay_code"));
				response.put("success", true);
				response.put("error", "결제 검증에 성공하였습니다");
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
	
	
	//결제에 성공한 paySuccessInfo 가져오기
	public Map<String, String> getSuccessPayInfo(Map<String, String> map) {
		return payMapper.selectSuccessPayInfo(map);
	}
	
	//access_token 획득
	public Map getAccessToken(Map<String, String> authResponse) {
		return bankApi.requestAccessToken(authResponse);
	}
	
	//access_token DB 등록
	public void registAccessToken(Map<String, String> map) {
		payMapper.registAccessToken(map);
	}
	
	//token과 user_seq_no을 이용하여 bankUserInfo 가져오기
	public Map getUserInfo(Map map) {
		Map userInfo = bankApi.requestUserInfo(map);
		
		List<Map<String, Object>> res_list = (List<Map<String, Object>>)userInfo.get("res_list");
		
		//update를 하기위한 Map객체
		Map<String, String> fintech = new HashMap<String, String>();
		fintech.put("access_token", (String)map.get("access_token"));
		
		//마지막 계좌에서 fintech_use_num 가져오기
		Map<String, Object> thirdMap = res_list.get(res_list.size() - 1);
		for(Map.Entry<String, Object> entry : thirdMap.entrySet()) {
			fintech.put((String)entry.getKey(), (String)entry.getValue());
		}
		
		payMapper.updateFintechUseNum(fintech);
		
		return userInfo;
	}

	public List<Map<String, Integer>> getPackageInfo() {
		return payMapper.selectPackageInfoList();
	}

	public Map withdraw(Map<String, Object> map) {
		return bankApi.requestWithdraw(map);
	}

	public void registPayAccountInfo(Map withdrawResult) {
		payMapper.insertPayAccountInfo(withdrawResult);
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
		System.out.println("vslfsd" + map.get("member_credit"));
		System.out.println(map);
		payMapper.updateWillpay(map);
		//return은 크레딧을 선택하는 메서드 호출
		return payMapper.selectWillpay(map);
	}

	
}
