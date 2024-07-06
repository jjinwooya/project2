package itwillbs.p2c3.class_will.handler;

import java.net.URI;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Component
public class BankApi {
	@Autowired
	private BankValueGenerator bankValueGenerator;

	private static final Logger logger = LoggerFactory.getLogger(BankApi.class);

	@Value("${client_id}")
	private String client_id;
	@Value("${client_secret}")
	private String client_secret;
	@Value("${client_use_code}")
	private String client_use_code; //이용기관측(서버) 코드
	@Value("${cntr_account_num}")
	private String cntr_account_num; //이용기관측(서버) 계좌
	@Value("${base_url}")
	private String base_url;

	public Map requestAccessToken(Map<String, String> authResponse) {
		// 금융결제원 오픈 API의 토큰 발급 API 요청 작업 수행 및 처리
		// POST 방식 요청을 수행할 URL 정보를 URI 타입 객체로 생성
		URI uri = UriComponentsBuilder
					.fromUriString(base_url)
					.path("/oauth/2.0/token")//기본요청 주소
					.encode() // 주소 인코딩
					.build() // UriComponents 타입 객체 생성
					.toUri(); //URI 타입 객체로 변환

		LinkedMultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("code", authResponse.get("code"));
		//appdata.properties 파일 내의 값을 가져와서 전달
		parameters.add("client_id", client_id);
		parameters.add("client_secret", client_secret);
		parameters.add("redirect_uri", "http://localhost:8081/class_will/callback");
		parameters.add("grant_type", "authorization_code");
		// => 바디 정보만 설정하고, 헤더 정보는 기본적인 헤더값 사용하므로 설정 생략
		HttpEntity<LinkedMultiValueMap<String, String>> httpEntity = new HttpEntity<LinkedMultiValueMap<String,String>>(parameters);

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Map> responseEntity = 
				restTemplate.exchange(uri, HttpMethod.POST, httpEntity, Map.class);
		//응답 정보를 확인을 위해 ResponseEntity 객체의 메서드 활용
		logger.info("응답 코드: " + responseEntity.getStatusCode());
		logger.info("응답 헤더: " + responseEntity.getHeaders());
		logger.info("응답 본문: " + responseEntity.getBody());

		return responseEntity.getBody();
	}
	
	//bankUserInfo를 받아오는 메서드(GET)
	public Map requestUserInfo(Map<String, String> map) {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + map.get("access_token"));
		
		HttpEntity<String> httpEntity = new HttpEntity<String>(headers);
		
		//3. HTTP 요청에 필요한 URI 정보 생성
		// => GET 방식 요청 시 전달할 파라미터는 queryParam() 메서드로 직접 전달 가능
		URI uri = UriComponentsBuilder
				.fromUriString(base_url) //기본요청 주소
				.path("/v2.0/user/me") //작업 요청 상세 주소(세부 경로)
				.queryParam("user_seq_no", map.get("user_seq_no")) //파라미터
				.encode() // 주소 인코딩
				.build() // UriComponents 타입 객체 생성
				.toUri(); //URI 타입 객체로 변환
		
		//4.Restful API 요청을 위한 RestTemplate 객체 활용
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<Map> responseEntity = restTemplate.exchange(uri, HttpMethod.GET, httpEntity, Map.class);
		
		//6. ResponseEntity 객체의 getBody() 메서드 호출하여 응답데이터 파싱결과 객체 리턴
		return responseEntity.getBody();
	}

	public Map requestWithdraw(Map<String, Object> map) {
		//String으로 형변환 - req_client_num
		String member_code = Integer.toString((int) map.get("member_code"));
		
		HttpHeaders headers = new HttpHeaders();
		
//		headers.add("Authorization", "Bearer " + token.getAccess_token());
		headers.setBearerAuth((String)map.get("access_token"));
		
		//"application/json; charset=UTF-8" 
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		String url = base_url + "/v2.0/transfer/withdraw/fin_num";
		
		//org.json 패키지의 JSONObject 클래스 또는 com.google.code.gson.Gson 클래스 활용
//		JSONObject jo = new JSONObject();
//		jo.put("bank_tran_id", bankValueGenerator.getBankTranId());
		
		Gson gson = new Gson();
		JsonObject jsonObject = new JsonObject();
		//------- 핀테크 이용기관 정보 --------------
		jsonObject.addProperty("bank_tran_id", bankValueGenerator.getBankTranId()); // 거래고유번호
		jsonObject.addProperty("cntr_account_type", "N"); // 약정계좌 /계정구분("N" : 계좌)
		jsonObject.addProperty("cntr_account_num", cntr_account_num); // 약정 계좌 / 계정 번호
		jsonObject.addProperty("dps_print_content", (String)map.get("user_name") + "_출금"); // 입금계좌인자내역(입금되는 계좌(이용기관)에 보내는 메세지)
		
		//------- 요청 고객(출금 계좌) 정보 ---------------
		jsonObject.addProperty("fintech_use_num", (String)map.get("fintech_use_num")); // 출금계좌 핀테크이용번호 
		jsonObject.addProperty("wd_print_content", "아이티윌_입금"); // 출금계좌인좌내역(출금되는 계좌(고객: 나)에 보낼 메세지) 
		jsonObject.addProperty("tran_amt", (String)map.get("tran_amt")); //출금 금액
		jsonObject.addProperty("tran_dtime", bankValueGenerator.getTranDTime()); //요청 일시
		jsonObject.addProperty("req_client_name", (String)map.get("user_name"));  
		jsonObject.addProperty("req_client_fintech_use_num", (String)map.get("fintech_use_num"));
		//=> 요청고객 계좌번호 미사용 시 핀테크 이용번호 설정 필수!
		jsonObject.addProperty("req_client_num", member_code.toUpperCase()); //요청고객회원번호(아이디처럼 사용) 
		jsonObject.addProperty("transfer_purpose", "ST"); //이체용도(송금: TR, 결제: ST 등) 
		
		//------- 수취 고객(실제 최종 입금 대상) 정보 ---------------
		jsonObject.addProperty("recv_client_name", "아이티윌"); //최종수취 고객성명(입금대상) 
		jsonObject.addProperty("recv_client_bank_code", "002"); //최종수취고객계좌 개설기관 표시 
		jsonObject.addProperty("recv_client_account_num", "23062003999"); //최종수취고객계좌번호 
		
		logger.info(">>>>>>>>>> 출금이체 요청 JSON 데이터: " + gson.toJson(jsonObject));
		
		HttpEntity<String> httpEntity = new HttpEntity<String>(gson.toJson(jsonObject), headers);
		logger.info(">>>>>>>>>> httpEntity.getHeaders(): " + httpEntity.getHeaders());
		logger.info(">>>>>>>>>> httpEntity.getBody(): " + httpEntity.getBody());
		
		//   POST 방식 HTTP 요청 수행
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, httpEntity, Map.class);
		logger.info(">>>>>>>>>> 출금 이체 요청 결과: " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}
	
	public Map requestDeposit(Map<String, Object> map) {
		String member_code = (String)map.get("member_code");
		
		
		HttpHeaders headers = new HttpHeaders();
		headers.setBearerAuth((String)map.get("access_token"));
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		// 2. 요청에 필요한 URI 정보 생성 => 문자열로 바로 생성
		String url = base_url + "/v2.0/transfer/deposit/fin_num";
		
		Gson gson = new Gson();
		
		JsonObject joReq = new JsonObject();
		joReq.addProperty("tran_no", 1);
		joReq.addProperty("bank_tran_id", bankValueGenerator.getBankTranId());
		
		joReq.addProperty("fintech_use_num", (String)map.get("fintech_use_num"));
		joReq.addProperty("print_content", "아이티윌_입금");
		joReq.addProperty("tran_amt", (String)map.get("tran_amt"));
		
		joReq.addProperty("req_client_name", (String)map.get("user_name"));
		joReq.addProperty("req_client_fintech_use_num", (String)map.get("fintech_use_num"));
		joReq.addProperty("req_client_num", member_code);
		joReq.addProperty("transfer_purpose", "TR");
		
		JsonArray jaReqList = new JsonArray();
		jaReqList.add(joReq);
		
		//이용기관 정보
		JsonObject jo = new JsonObject();
		jo.addProperty("cntr_account_type", "N"); // 약정 계좌/계정 구분("N" : 계좌)
		jo.addProperty("cntr_account_num", cntr_account_num); // 약정 계좌/계정 번호(핀테크 서비스 기관 계좌)
		jo.addProperty("wd_pass_phrase", "NONE");
		jo.addProperty("wd_print_content", "NONE");
		jo.addProperty("name_check_option", "on"); // 거래금액
		jo.addProperty("tran_dtime", bankValueGenerator.getTranDTime()); // 요청일시
		jo.addProperty("req_cnt", 1); // 요청고객핀테크이용번호(출금계좌)
		
//		jo.addProperty("bank_tran_id", bankValueGenerator.getBankTranId()); // 거래고유번호(참가기관)
//		jo.addProperty("dps_print_content", "CLASS-WILL" + "_환불"); // 입금계좌인자내역(입금되는 계좌에 출력할 메세지)
//		
//		// ---------- 요청 고객(출금 계좌) 정보 ----------
//		jo.addProperty("fintech_use_num", (String)map.get("fintech_use_num")); // 출금계좌 핀테크이용번호 
//		jo.addProperty("wd_print_content", (String)map.get("user_name") + "_송금"); // 출금계좌인자내역(출금되는 계좌에 출력할 메세지)
//		jo.addProperty("tran_dtime", bankValueGenerator.getTranDTime()); // 요청고객성명(출금계좌)
//		jo.add("req_list", jaReqList);
//		// => 요청고객 계좌번호 미사용 시 핀테크 이용번호 설정 필수!
//		jo.addProperty("req_client_num", member_code); // 요청고객회원번호(아이디처럼 사용) => 영문자 모두 대문자 변환 
//		jo.addProperty("transfer_purpose", "ST"); // 이체 용도(송금 : TR, 결제 : ST 등) 
		
		// 최종 요청 파라미터 확인
		logger.info(">>>>>>>> 입금이체 요청 JSON 데이터 : " + gson.toJson(jo));
		
		
		HttpEntity<String> httpEntity = new HttpEntity<String>(gson.toJson(jo), headers);
		logger.info(">>>>>>>> httpEntity.getHeaders() : " + httpEntity.getHeaders());
		logger.info(">>>>>>>> httpEntity.getBody() : " + httpEntity.getBody());
		
		
		// 5. RESTful API 요청을 위한 RestTemplate 객체의 exchange() 메서드 호출하여
		//    POST 방식 HTTP 요청 수행
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, httpEntity, Map.class);
		logger.info(">>>>>>>> 입금 이체 요청 결과 : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}
	
	//adminAccessToken 발급
	public Map requestAdminAccessToken() {
		URI uri = UriComponentsBuilder
				.fromUriString("https://testapi.openbanking.or.kr/oauth/2.0/token")
				.encode() // 주소 인코딩
				.build() // UriComponents 타입 객체 생성
				.toUri(); //URI 타입 객체로 변환
		LinkedMultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
	//	parameters.add("client_id", "4066d795-aa6e-4720-9383-931d1f60d1a9");
	//	parameters.add("client_secret", "36b4a668-94ba-426d-a291-771405e498e4");
		parameters.add("client_id", client_id);
		parameters.add("client_secret", client_secret);
		parameters.add("scope", "oob");
		parameters.add("grant_type", "client_credentials");
		
		HttpEntity<LinkedMultiValueMap<String, String>> httpEntity = 
						new HttpEntity<LinkedMultiValueMap<String,String>>(parameters);
		
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Map> responseEntity = 
				restTemplate.exchange(uri, HttpMethod.POST, httpEntity, Map.class);
		//응답 정보를 확인을 위해 ResponseEntity 객체의 메서드 활용
		logger.info("응답 코드: " + responseEntity.getStatusCode());
		logger.info("응답 헤더: " + responseEntity.getHeaders());
		logger.info("응답 본문: " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}
}