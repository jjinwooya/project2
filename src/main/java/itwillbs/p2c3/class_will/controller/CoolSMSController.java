package itwillbs.p2c3.class_will.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import itwillbs.p2c3.class_will.handler.GenerateRandomCode;
import itwillbs.p2c3.class_will.service.MemberService;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@RestController
public class CoolSMSController {
	
	@Autowired
	private MemberService memberService;
	
	final DefaultMessageService messageService;
	
//    @Value("${coolsms_api_key}")
//    private String apiKey;
//
//    @Value("${coolsms_secret_key}")
//    private String apiSecret;
//
//    @Value("${coolsms_url}")
//    private String apiUrl;
	
//	public CoolSMSController() {
//		this.messageService = NurigoApp.INSTANCE.initialize(apiKey, apiSecret, apiUrl);
//	}
    
	private String apiKey;
    private String apiSecret;
    private String apiUrl;

    @Autowired
    public CoolSMSController(@Value("${coolsms_api_key}") String apiKey,
                             @Value("${coolsms_secret_key}") String apiSecret,
                             @Value("${coolsms_url}") String apiUrl) {
        this.apiKey = apiKey;
        this.apiSecret = apiSecret;
        this.apiUrl = apiUrl;
        
        this.messageService = NurigoApp.INSTANCE.initialize(apiKey, apiSecret, apiUrl);

        // 초기화 로직 작성
        // apiKey, apiSecret, apiUrl 등의 초기화 작업 수행
    }

	
	
	@ResponseBody
	@PostMapping("send-one")
    public String sendOne(@RequestParam String member_tel, HttpSession session) {
		System.out.println(">>>>>>>>>>>>>>>member_tel : " + member_tel);
		session.setMaxInactiveInterval(300);
		Map<String, Object> resultMap = new HashMap<String, Object>();
    	
		   
        try {
            String db_member_tel = memberService.selectMemberTel(member_tel);
            
            if (db_member_tel != null && !db_member_tel.isEmpty()) {
                resultMap.put("already", true);
            } else {
                String auth_num = GenerateRandomCode.getAuthCode();
                
                Message message = new Message();
                // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
                message.setFrom("01073034573");
                message.setTo(member_tel);
                message.setText("[Class Will] 아래의 인증번호를 입력해 주세요.\n인증번호 : ["+ auth_num + "]");
                
                SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
                System.out.println(response);
                session.setAttribute("auth_num", auth_num);
                
                resultMap.put("success", true);
                resultMap.put("auth_num", auth_num);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("success", false);
        }
        
        JSONObject jo = new JSONObject(resultMap);
        return jo.toString();
    }
	

}
